package cn.chinuy.display.uicomponents.supports.transition {
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class TransitionEvent extends Event {
		
		public static const Start : String = "Transition.Start";
		public static const End : String = "Transition.End";
		
		private var _positive : Boolean;
		
		public function TransitionEvent( type : String, positive : Boolean, bubbles : Boolean = false, cancelable : Boolean = false ) {
			super( type, bubbles, cancelable );
			_positive = positive;
		}
		
		public function get positive() : Boolean {
			return _positive;
		}
		
		override public function clone() : Event {
			return new TransitionEvent( type, positive, bubbles, cancelable );
		}
	}
}
