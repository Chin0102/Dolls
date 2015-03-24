package cn.chinuy.display.uicore {
	import flash.events.IEventDispatcher;
	
	/**
	 * @author chin
	 */
	public interface ISkinLoader extends IEventDispatcher {
		
		function load( target : SkinPackage, source : * ) : void;
		
		function unload() : void;
	
	}
}
