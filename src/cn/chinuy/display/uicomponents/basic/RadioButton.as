package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.uicomponents.model.RadioButtonGroup;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class RadioButton extends Button {
		
		public static const Skin : String = "RadioButton";
		
		public static const Setting_Label_Default : Object = { color:0, size:12 };
		
		private var _group : RadioButtonGroup;
		
		public function RadioButton( label : String = "", groupName : String = "DefaultRadioButtonGroup", selected : Boolean = false ) {
			super( label );
			this.groupName = groupName;
			this.selected = selected;
			addEventListener( MouseEvent.CLICK, onClick );
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		override protected function get defaultLabelSetting() : Object {
			return Setting_Label_Default;
		}
		
		protected function onClick( event : MouseEvent ) : void {
			selected = true;
		}
		
		protected function onChange( event : Event ) : void {
			if( this != group.selected ) {
				this.selected = false;
			}
		}
		
		public function set groupName( value : String ) : void {
			if( _group ) {
				_group.removeEventListener( Event.CHANGE, onChange );
				_group.removeRadioButton( this );
				_group = null;
			}
			if( value != null ) {
				_group = RadioButtonGroup.getInstance( value );
				_group.addRadioButton( this );
				_group.addEventListener( Event.CHANGE, onChange );
			}
		}
		
		public function get groupName() : String {
			if( group ) {
				return group.name;
			}
			return null;
		}
		
		public function get group() : RadioButtonGroup {
			return _group;
		}
		
		override public function set selected( value : Boolean ) : void {
			super.selected = value;
			if( value && group ) {
				group.selected = this;
			}
		}
	}
}
