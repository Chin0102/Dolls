package cn.chinuy.display.uicomponents.model {
	import cn.chinuy.display.uicomponents.basic.RadioButton;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class RadioButtonGroup extends EventDispatcher {
		
		private static var map : Object = {};
		
		public static function getInstance( name : String ) : RadioButtonGroup {
			var group : RadioButtonGroup = map[ name ];
			if( group == null ) {
				group = map[ name ] = new RadioButtonGroup( name );
			}
			return group;
		}
		
		private var btnMap : Array = [];
		
		private var _name : String;
		private var _selected : RadioButton;
		
		public function RadioButtonGroup( name : String ) {
			super();
			_name = name;
		}
		
		public function get name() : String {
			return _name;
		}
		
		public function getRadioButton( id : int ) : RadioButton {
			return btnMap[ id ];
		}
		
		public function findRadioButton( key : String, value : * ) : RadioButton {
			for( var i : int = 0; i < btnMap.length; i++ ) {
				var rb : RadioButton = getRadioButton( i );
				if( rb.hasOwnProperty( key )) {
					if( rb[ key ] == value ) {
						return rb;
					}
				} else {
					return null;
				}
			}
			return null;
		}
		
		public function addRadioButton( button : RadioButton ) : void {
			btnMap.push( button );
		}
		
		public function removeRadioButton( button : RadioButton ) : void {
			var i : int = btnMap.indexOf( button );
			if( i >= 0 ) {
				btnMap.splice( i, 1 );
				button.groupName = null;
			}
		}
		
		public function removeAll() : void {
			while( btnMap.length > 0 ) {
				removeRadioButton( btnMap[ 0 ]);
			}
		}
		
		public function get selected() : RadioButton {
			return _selected;
		}
		
		public function set selected( button : RadioButton ) : void {
			if( button == null ) {
				_selected = null;
				dispatchEvent( new Event( Event.CHANGE ));
			} else if( selected != button ) {
				var i : int = btnMap.indexOf( button );
				if( i >= 0 ) {
					_selected = button;
					dispatchEvent( new Event( Event.CHANGE ));
				}
			}
		}
	}
}
