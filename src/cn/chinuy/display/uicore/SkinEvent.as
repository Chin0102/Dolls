package cn.chinuy.display.uicore {
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class SkinEvent extends Event {
		
		public static const CHANGED : String = "Skin.Changed:::";
		public static const ALLCHANGED : String = CHANGED + "ALL";
		
		public static function AllSkinChangedEvent() : SkinEvent {
			return new SkinEvent( ALLCHANGED );
		}
		
		public static function SkinChangedEvent( skin : ISkin ) : SkinEvent {
			return new SkinEvent( CHANGED + skin.name, skin );
		}
		
		private var _skin : ISkin;
		
		public function SkinEvent( type : String, skin : ISkin = null ) {
			super( type );
			this.skin = skin;
		}
		
		public function get skin() : ISkin {
			return _skin;
		}
		
		public function set skin( value : ISkin ) : void {
			_skin = value;
		}
		
		override public function clone() : Event {
			return new SkinEvent( type, skin );
		}
	}
}
