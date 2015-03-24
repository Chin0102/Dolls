package cn.chinuy.display.uicore {
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class SkinLoadEvent extends Event {
		
		public static const Complete : String = "SkinLoadComplete";
		public static const Error : String = "SkinLoadError";
		
		public function SkinLoadEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false ) {
			super( type, bubbles, cancelable );
		}
		
		override public function clone() : Event {
			return new SkinLoadEvent( type, bubbles, cancelable );
		}
	}
}
