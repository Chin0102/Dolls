package cn.chinuy.display.uicore {
	import cn.chinuy.data.object.shallowCopy;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * @author chin
	 */
	public class UIView extends UIContainer implements IUIView {
		
		private var states : Object = {};
		private var elements : Object = {};
		private var components : Object = {};
		private var settings : Object = {};
		
		private var currentState : DisplayObject;
		
		public function UIView( w : Number = 100, h : Number = 100 ) {
			super();
			width = w;
			height = h;
			top = bottom = left = right = 0;
		}
		
		public function get container() : DisplayObjectContainer {
			return this;
		}
		
		//Element
		public function addElement( name : String, element : DisplayObject, add : Boolean = true, hide : Boolean = false ) : void {
			if( hide ) {
				element.visible = false;
			}
			elements[ name ] = element;
			if( add ) {
				addChild( element );
			}
		}
		
		public function hasElement( name : String ) : Boolean {
			return elements[ name ] != null;
		}
		
		public function element( name : String ) : DisplayObject {
			return elements[ name ];
		}
		
		public function elementProperty( name : String, propertyName : String, value : * ) : void {
			var obj : DisplayObject = element( name );
			if( obj ) {
				if( obj.hasOwnProperty( propertyName )) {
					obj[ propertyName ] = value;
				}
			}
		}
		
		public function elementVisible( name : String, visible : Boolean, defaultName : String = null ) : void {
			var obj : DisplayObject = element( name );
			if( obj == null && defaultName != null ) {
				obj = element( defaultName );
			}
			if( obj ) {
				obj.visible = visible;
			}
		}
		
		public function elementListener( name : String, type : String, listener : Function, enabled : Boolean ) : void {
			var obj : DisplayObject = element( name );
			if( obj ) {
				if( enabled ) {
					obj.addEventListener( type, listener );
				} else {
					obj.removeEventListener( type, listener );
				}
			}
		}
		
		//State
		public function addState( name : String, state : DisplayObject ) : void {
			states[ name ] = state;
			addChild( state );
			setState( name );
		}
		
		public function state( name : String ) : DisplayObject {
			return states[ name ];
		}
		
		public function setState( ... stateOrder ) : void {
			var obj : DisplayObject;
			var len : int = stateOrder.length;
			for( var i : int = 0; i < len; i++ ) {
				obj = state( stateOrder[ i ]);
				if( obj != null ) {
					break;
				}
			}
			if( obj && obj != currentState ) {
				if( currentState ) {
					currentState.visible = false;
				}
				obj.visible = true;
				currentState = obj;
			}
		}
		
		//Component
		public function addComponentPlaceHolder( name : String, properties : Object ) : void {
			var obj : SkinUIPlaceHolder = new SkinUIPlaceHolder( properties );
			components[ name ] = obj;
			addChild( obj );
		}
		
		public function addComponent( name : String, component : UIComponent ) : void {
			var obj : SkinUIPlaceHolder = components[ name ] as SkinUIPlaceHolder;
			if( obj ) {
				obj.replace( component );
				components[ name ] = component;
			}
		}
		
		//Setting
		public function addSetting( key : String, value : * ) : void {
			settings[ key ] = value;
		}
		
		public function hasSetting( key : String ) : Boolean {
			return settings[ key ] != null;
		}
		
		public function setting( key : String ) : * {
			return shallowCopy( settings[ key ]);
		}
		
		public function applySetting( obj : Object, settingKey : String, defaultSetting : Object = null ) : void {
			var settingValue : Object = setting( settingKey );
			if( defaultSetting ) {
				for( var i : String in defaultSetting ) {
					if( obj.hasOwnProperty( i )) {
						obj[ i ] = getValueAndDelete( settingValue, i, defaultSetting[ i ]);
					}
				}
			}
			if( settingValue ) {
				for( var j : String in settingValue ) {
					if( obj.hasOwnProperty( j )) {
						obj[ j ] = settingValue[ j ];
					}
				}
			}
		}
		
		private static function getValueAndDelete( obj : Object, key : String, defaultValue : * ) : * {
			var value : *;
			if( obj && obj.hasOwnProperty( key )) {
				value = obj[ key ];
				delete obj[ key ];
			} else {
				value = defaultValue;
			}
			return value;
		}
	
	}
}
