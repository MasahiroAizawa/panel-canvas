package panelcanvas.base
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import mx.containers.TitleWindow;
	import mx.core.EventPriority;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;
	import mx.events.FlexEvent;

	import panelcanvas.panelbase.PanelCanvas;

	/**
	 * Base Class for your Panel<br>
	 * @author masahiro.A
	 */
	public class BasePanel extends TitleWindow
	{
		public function BasePanel()
		{
			super();
			isPopUp = true;

			this.addEventListener(FlexEvent.CREATION_COMPLETE, init);
			this.addEventListener(MouseEvent.MOUSE_DOWN, componentDisplayTop);
			this.addEventListener(CloseEvent.CLOSE, closeHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, resizePanel);
		}

		private static const MIN_SIZE_X:Number = 50;
		private static const MIN_SIZE_Y:Number = 70;

		private var beforeResizeFramePoint:Point;

		/**
		 * initialize this panel<br>
		 * @param fEvent
		 */
		private function init(fEvent:FlexEvent):void{
				titleBar.addEventListener(MouseEvent.MOUSE_DOWN, controlDragging, false, EventPriority.DEFAULT + 1);
		}

		/**
		 * default TitleWindow can move if click on outside top title bar<br>
		 * this function stop outside move<br>
		 * @param mEvent
		 */
		private function controlDragging(mEvent:MouseEvent):void{
			if(isPanelFrame(mEvent)){
				isPopUp = false;
				titleBar.addEventListener(MouseEvent.MOUSE_DOWN, resetStatus);
			}
			function resetStatus(event:MouseEvent):void{
				isPopUp = true;
				titleBar.removeEventListener(MouseEvent.MOUSE_DOWN, resetStatus);
			}
		}

		/**
		 * move this panel to canvas's top<br>
		 * @param mEvent
		 */
		private function componentDisplayTop(mEvent:MouseEvent):void{
			(this.parent as PanelCanvas).setPanelTop(this);
		}

		/**
		 * this function called when close this panel<br>
		 * @param cEvent
		 */
		private function closeHandler(cEvent:CloseEvent):void{
			(this.parent as PanelCanvas).removeChild(this);
			dispose();
		}

		/**
		 * resize this panel<br>
		 * @param cEvent
		 */
		private function resizePanel(mEvent:MouseEvent):void{
			if(!isPanelFrame(mEvent)) return;

			beforeResizeFramePoint = new Point(this.width, this.height);

			addEventListener(MouseEvent.MOUSE_UP, resizePanelComplete);
		}

		/**
		 * size decide and change size<br>
		 * @param mUpEvent
		 */
		private function resizePanelComplete(mEvent:MouseEvent):void{
			removeEventListener(MouseEvent.MOUSE_UP, resizePanelComplete);
			var afterX:Number = mEvent.localX;
			var afterY:Number = mEvent.localY;
			if(afterX <= MIN_SIZE_X){
				afterX = MIN_SIZE_X;
			}
			if(afterY <= MIN_SIZE_Y){
				afterY = MIN_SIZE_Y;
			}
			this.width = afterX;
			this.height = afterY;
		}

		/**
		 * dispose of this<br>
		 */
		public function dispose():void{
			removeAllEventListener(this);

			function removeAllEventListener(component:UIComponent):void{
				component.removeEventListener(MouseEvent.MOUSE_DOWN, componentDisplayTop);
				component.removeEventListener(CloseEvent.CLOSE, closeHandler);
			}
		}

		/**
		 * Is mouse pointer in panel frame<br>
		 * @param event
		 * @return mouse pointer in panel frame area
		 */
		private function isPanelFrame(event:MouseEvent):Boolean{
			var notFrameX:Number = width - 10;
			var notFrameY:Number = height - 10;
			var notFrameArea:Rectangle = new Rectangle(0, 0, notFrameX, notFrameY);

			return !notFrameArea.contains(event.localX, event.localY);
		}

	}
}