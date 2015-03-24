package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.uicomponents.model.CheckBoxGroup;
	
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class CheckBox extends Button {
		
		public static const Skin : String = "CheckBox";
		
		public static const Setting_Label_Default : Object = { color:0, size:12 };
		
		private var _group : CheckBoxGroup;
		
		public function CheckBox( label : String = "", groupName : String = "DefaultCheckBoxGroup", selected : Boolean = false ) {
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
			selected = !selected;
		}
		
		public function set groupName( value : String ) : void {
			if( _group ) {
				_group.removeCheckBox( this );
			}
			_group = CheckBoxGroup.getInstance( value );
			_group.addCheckBox( this );
		}
		
		public function get groupName() : String {
			if( group ) {
				return group.name;
			}
			return null;
		}
		
		public function get group() : CheckBoxGroup {
			return _group;
		}
		
		override public function set selected( value : Boolean ) : void {
			super.selected = value;
			group.setSelected( this, value );
		}
	}
}
