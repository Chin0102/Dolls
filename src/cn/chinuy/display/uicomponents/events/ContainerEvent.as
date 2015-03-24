package cn.chinuy.display.uicomponents.events {
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class ContainerEvent extends Event {
		
		public static const PreDisplay : String = "Container.PreDisplay";
		public static const Display : String = "Container.Display";
		
		public static const PreClose : String = "Container.PreClose";
		public static const Close : String = "Container.Close";
		
		public function ContainerEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false ) {
			super( type, bubbles, cancelable );
		}
		
		override public function clone() : Event {
			return new ContainerEvent( type, bubbles, cancelable );
		}
	}
}
