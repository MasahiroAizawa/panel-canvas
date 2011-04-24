package panelcanvas.base
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import mx.containers.TitleWindow;
	import mx.core.UIComponent;
	import mx.events.CloseEvent;

	import panelcanvas.panelbase.PanelCanvas;

	public class BasePanel extends TitleWindow
	{
		public function BasePanel()
		{
			super();
			isPopUp = true;

			this.addEventListener(MouseEvent.MOUSE_DOWN, componentDisplayTop);
			this.addEventListener(CloseEvent.CLOSE, closeHandler);
		}

		private function componentDisplayTop(mEvent:MouseEvent):void{
			(this.parent as PanelCanvas).setPanelTop(this);
		}

		private function closeHandler(cEvent:CloseEvent):void{
			(this.parent as PanelCanvas).removeChild(this);
			dispose();
		}

		public function dispose():void{
			removeAllEventListener(this);

			function removeAllEventListener(component:UIComponent):void{
				component.removeEventListener(MouseEvent.MOUSE_DOWN, componentDisplayTop);
				component.removeEventListener(CloseEvent.CLOSE, closeHandler);
			}
		}

		//現在未使用
		private function isTitleBar(event:MouseEvent):Boolean{
			var titleBarArea:Rectangle = new Rectangle(0, 0, titleBar.width, titleBar.height);

			var catchPointX:int = event.localX;
			var catchPointY:int = event.localY;

			return titleBarArea.contains(catchPointX, catchPointY);
		}
	}
}