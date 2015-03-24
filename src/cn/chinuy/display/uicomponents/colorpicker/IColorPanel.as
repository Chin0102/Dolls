package cn.chinuy.display.uicomponents.colorpicker {
	import cn.chinuy.display.layout.ILayoutElement;
	
	/**
	 * @author chin
	 */
	public interface IColorPanel extends ILayoutElement {
		
		function get color() : int;
		function set color( value : int ) : void;
		
		function get tempColor() : int;
		function set tempColor( value : int ) : void;
	}
}
