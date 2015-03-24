package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.uicomponents.text.Label;
	
	/**
	 * @author chin
	 */
	public class Button extends BaseButton {
		
		public static const Skin : String = "Button";
		
		public static const Setting_Label : String = "LabelSetting";
		public static const Setting_Label_Default : Object = { size:12, color:0x333333, vcenter:0, hcenter:0 };
		
		protected var buttonLabel : Label = createLabel();
		private var _value : *;
		
		public function Button( label : String = "", value : * = null ) {
			super();
			addChild( buttonLabel );
			this.label = label;
			this.value = value;
			initSkin();
		}
		
		protected function createLabel() : Label {
			return Label.create();
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		protected function get defaultLabelSetting() : Object {
			return Setting_Label_Default;
		}
		
		public function set label( value : String ) : void {
			buttonLabel.value = value;
		}
		
		public function get label() : String {
			return buttonLabel.value;
		}
		
		public function get value() : * {
			return _value;
		}
		
		public function set value( value : * ) : void {
			_value = value;
		}
		
		protected function get labelText() : Label {
			return buttonLabel;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.applySetting( buttonLabel, Setting_Label, defaultLabelSetting );
		}
		
		override protected function updateState() : void {
			super.updateState();
			updateLabelState( Setting_Label, buttonLabel );
		}
		
		protected function updateLabelState( settingName : String, label : Label ) : void {
			var len : int = stateOrder.length;
			for( var i : int = 0; i < len; i++ ) {
				var labelState : String = settingName + stateOrder[ i ];
				if( view.hasSetting( labelState )) {
					view.applySetting( label, labelState );
					return;
				}
			}
			view.applySetting( label, settingName, defaultLabelSetting );
		}
	}
}
