package cn.chinuy.display.uiskins.swf {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.ColorTransform;
	
	/**
	 * @author chin
	 */
	public class ColorableManager extends EventDispatcher {
		
		private static var _instance : ColorableManager;
		
		private var _colors : Object = {};
		
		public static const BackgroundColor : String = "background";
		public static const ForegroundColor : String = "foreground";
		
		public static function get instance() : ColorableManager {
			if( _instance == null ) {
				_instance = new ColorableManager();
			}
			return _instance;
		}
		
		public static function setDisplayObjectColor( colorable : DisplayObject, color : int ) : void {
			if( colorable ) {
				var colorTransform : ColorTransform = new ColorTransform();
				if( color >= 0 ) {
					colorTransform.color = color;
				}
				colorable.transform.colorTransform = colorTransform;
			}
		}
		
		public function ColorableManager() {
			super();
		}
		
		public function setColor( name : String, value : int ) : void {
			if( value >= 0 ) {
				_colors[ name ] = value;
			} else if( value == -1 ) {
				delete _colors[ name ];
			}
			dispatchEvent( new Event( name + Event.CHANGE ));
		}
		
		public function getColor( name : String ) : int {
			if( _colors[ name ] != null ) {
				return _colors[ name ];
			}
			return -1;
		}
		
		public function get backgroundColor() : int {
			return getColor( BackgroundColor );
		}
		
		public function set backgroundColor( value : int ) : void {
			setColor( BackgroundColor, value );
		}
		
		public function get foregroundColor() : int {
			return getColor( ForegroundColor );
		}
		
		public function set foregroundColor( value : int ) : void {
			setColor( ForegroundColor, value );
		}
	}
}
