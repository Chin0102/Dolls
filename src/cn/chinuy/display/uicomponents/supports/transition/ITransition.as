package cn.chinuy.display.uicomponents.supports.transition {
	import flash.events.IEventDispatcher;
	
	/**
	 * @author chin
	 */
	public interface ITransition extends IEventDispatcher {
		
		function start( target : ITransitable, positive : Boolean ) : void;
	
	}
}
