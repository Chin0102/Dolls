package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.layout.ILayoutElement;
	
	import flash.display.DisplayObject;
	
	/**
	 * @author chin
	 */
	public interface IContainer extends ILayoutElement {
		
		function addChild( child : DisplayObject ) : DisplayObject;
		function addChildAt( child : DisplayObject, index : int ) : DisplayObject;
		
		function removeChild( child : DisplayObject ) : DisplayObject;
		function removeChildAt( index : int ) : DisplayObject;
		
		function getChildAt( index : int ) : DisplayObject;
		function getChildByName( name : String ) : DisplayObject;
		function get numChildren() : int;
		
		/**
		 * 内部容器宽
		 **/
		function get containerWidth() : Number;
		/**
		 * 内部容器高
		 **/
		function get containerHeight() : Number;
		
		function get bPadding() : Number;
		function set bPadding( value : Number ) : void;
		
		function get tPadding() : Number;
		function set tPadding( value : Number ) : void;
		
		function get rPadding() : Number;
		function set rPadding( value : Number ) : void;
		
		function get lPadding() : Number;
		function set lPadding( value : Number ) : void;
	}
}
