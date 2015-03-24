package cn.chinuy.display.uicomponents.events {
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class PanelEvent extends Event {
		
		public static const ClickToMin : String = "Panel.ClickToMin";
		public static const ClickToMax : String = "Panel.ClickToMax";
		public static const ClickToClose : String = "Panel.ClickToClose";
		
		public function PanelEvent( type : String, bubbles : Boolean = false, cancelable : Boolean = false ) {
			super( type, bubbles, cancelable );
		}
		
		override public function clone() : Event {
			return new ContainerEvent( type, bubbles, cancelable );
		}
	}
}
