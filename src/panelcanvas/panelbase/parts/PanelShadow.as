package panelcanvas.panelbase.parts
{
	import mx.containers.Panel;

	/**
	 * when BasePanel moving, show present size<br>
	 *
	 * @author masahiro.A
	 */
	public class PanelShadow extends Panel
	{
		public function PanelShadow()
		{
			this.visible = false;
			this.setStyle("borderStyle", "solid");
			this.setStyle("backgroundColor", 0xA0A0A0);
			this.alpha = 0.4;
		}
	}
}