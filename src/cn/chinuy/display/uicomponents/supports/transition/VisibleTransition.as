package cn.chinuy.display.uicomponents.supports.transition {
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class VisibleTransition extends EventDispatcher implements ITransition {
		
		public function VisibleTransition() {
			super();
		}
		
		public function start( target : ITransitable, positive : Boolean ) : void {
			dispatchEvent( new TransitionEvent( TransitionEvent.Start, positive ));
			target.displayObject.visible = positive;
			dispatchEvent( new TransitionEvent( TransitionEvent.End, positive ));
		}
	}
}
