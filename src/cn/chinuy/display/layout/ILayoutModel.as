package cn.chinuy.display.layout {
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	/**
	 * @author chin
	 */
	public interface ILayoutModel extends IEventDispatcher {
		
		function get left() : *;
		function set left( value : * ) : void;
		
		function get right() : *;
		function set right( value : * ) : void;
		
		function get top() : *;
		function set top( value : * ) : void;
		
		function get bottom() : *;
		function set bottom( value : * ) : void;
		
		function get leftTarget() : DisplayObject;
		function set leftTarget( value : DisplayObject ) : void;
		
		function get rightTarget() : DisplayObject;
		function set rightTarget( value : DisplayObject ) : void;
		
		function get topTarget() : DisplayObject;
		function set topTarget( value : DisplayObject ) : void;
		
		function get bottomTarget() : DisplayObject;
		function set bottomTarget( value : DisplayObject ) : void;
		
		function get hcenter() : *;
		function set hcenter( value : * ) : void;
		
		function set vcenter( value : * ) : void;
		function get vcenter() : *;
		
		function get renderEnable() : Boolean;
		function set renderEnable( value : Boolean ) : void;
		
		//重定义的宽的最终结果
		function get width() : Number;
		function set width( value : Number ) : void;
		
		//重定义的高的最终结果
		function get height() : Number;
		function set height( value : Number ) : void;
		
		function get x() : Number;
		function set x( value : Number ) : void;
		
		function get y() : Number;
		function set y( value : Number ) : void;
	
	}
}
