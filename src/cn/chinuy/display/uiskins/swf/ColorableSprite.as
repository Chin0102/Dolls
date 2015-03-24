package cn.chinuy.display.uiskins.swf {
	import cn.chinuy.display.UISprite;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class ColorableSprite extends UISprite {
		
		private static var manager : ColorableManager = ColorableManager.instance;
		
		private var source : DisplayObjectContainer;
		private var _managerMap : Object = {};
		
		public function ColorableSprite( target : DisplayObjectContainer, applyManager : Boolean = true ) {
			super();
			source = target;
			width = source.width;
			height = source.height;
			addChild( source );
			
			if( applyManager ) {
				manageColor( ColorableManager.BackgroundColor );
				manageColor( ColorableManager.ForegroundColor );
			}
		}
		
		public function manageColor( name : String, enable : Boolean = true, defaultColor : int = -1 ) : void {
			var inMap : Boolean = _managerMap[ name ];
			if( enable ) {
				if( !inMap ) {
					_managerMap[ name ] = true;
					setColor( name, manager.getColor( name ));
					manager.addEventListener( name + Event.CHANGE, onColorChange );
				}
			} else {
				if( inMap ) {
					manager.removeEventListener( name + Event.CHANGE, onColorChange );
					setColor( name, defaultColor );
					delete _managerMap[ name ];
				}
			}
		}
		
		public function setColor( name : String, color : int ) : void {
			var colorable : DisplayObject = source.getChildByName( name );
			ColorableManager.setDisplayObjectColor( colorable, color );
		}
		
		protected function onColorChange( event : Event ) : void {
			var name : String = event.type.split( Event.CHANGE )[ 0 ];
			setColor( name, manager.getColor( name ));
		}
	}
}
