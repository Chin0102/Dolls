package cn.chinuy.display.layout {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * @author chin
	 */
	public interface ILayoutElement extends ILayoutModel {
		
		function get viewWidth() : Number;
		function get viewHeight() : Number;
		function get parent() : DisplayObjectContainer;
		function get displayObject() : DisplayObject;
	
	}
}
