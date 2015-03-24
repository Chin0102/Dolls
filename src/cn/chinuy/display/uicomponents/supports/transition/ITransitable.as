package cn.chinuy.display.uicomponents.supports.transition {
	import flash.display.DisplayObject;
	
	/**
	 * @author chin
	 */
	public interface ITransitable {
		
		function get displayObject() : DisplayObject;
		
		function get transition() : ITransition;
		function set transition( value : ITransition ) : void;
		
		function display() : void;
		function close() : void;
	}
}
