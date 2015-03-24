package cn.chinuy.display.uicomponents.list {
	import flash.display.DisplayObject;
	
	/**
	 * @author chin
	 */
	public interface IItem {
		
		function set label( value : String ) : void;
		
		function get label() : String;
		
		function set value( value : * ) : void;
		
		function get value() : *;
		
		function set list( list : IList ) : void;
		
		function get list() : IList;
		
		function get index() : int;
		
		function get displayObject() : DisplayObject;
		
		function remove() : void;
		
		function toString() : String;
	}
}
