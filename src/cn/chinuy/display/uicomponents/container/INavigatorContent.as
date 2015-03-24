package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.uicomponents.supports.transition.ITransitable;
	
	import flash.display.DisplayObject;
	
	/**
	 * @author chin
	 */
	public interface INavigatorContent extends IContainer, ITransitable {
		
		function get label() : String;
		
		function set label( value : String ) : void;
	}
}
