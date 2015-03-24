package cn.chinuy.display.uicomponents.model {
	import cn.chinuy.display.uicomponents.basic.CheckBox;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class CheckBoxGroup extends EventDispatcher {
		
		private static var map : Object = {};
		
		public function get lastChanged() : CheckBox {
			return _lastChanged;
		}
		
		public static function getInstance( name : String ) : CheckBoxGroup {
			var group : CheckBoxGroup = map[ name ];
			if( group == null ) {
				group = map[ name ] = new CheckBoxGroup( name );
			}
			return group;
		}
		
		private var btnMap : Array = [];
		
		private var _name : String;
		private var _selected : Array = [];
		private var _lastChanged : CheckBox;
		
		public function CheckBoxGroup( name : String ) {
			super();
			_name = name;
		}
		
		public function get name() : String {
			return _name;
		}
		
		public function addCheckBox( button : CheckBox ) : void {
			btnMap.push( button );
		}
		
		public function removeCheckBox( button : CheckBox ) : void {
			var i : int = btnMap.indexOf( button );
			if( i >= 0 ) {
				btnMap.splice( i, 1 );
			}
		}
		
		public function get mapSelected() : Array {
			return _selected;
		}
		
		public function setSelected( button : CheckBox, selected : Boolean ) : void {
			var i : int = btnMap.indexOf( button );
			if( i >= 0 ) {
				if( selected ) {
					_selected.push( button );
				} else {
					var j : int = _selected.indexOf( button );
					if( j >= 0 ) {
						btnMap.splice( j, 1 );
					}
				}
				dispatchEvent( new Event( Event.CHANGE ));
			}
		}
	}
}
