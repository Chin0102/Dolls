package cn.chinuy.display.uicomponents.text {
	import cn.chinuy.display.uicore.UIComponent;
	
	/**
	 * @author chin
	 */
	public class TextInput extends UIComponent {
		
		public static const Skin : String = "TextInput";
		
		public static const Setting_Text : String = "TextSetting";
		public static const Setting_Text_Value : Object = { left:0, right:0, vcenter:0, height:20, size:13, color:0x999999 };
		
		public static const Setting_Text_Active : String = "TextActiveSetting";
		public static const Setting_Text_Active_Value : Object = { left:0, right:0, vcenter:0, height:20, size:13, color:0xCCCCCC };
		
		protected var _text : Text = new Text();
		
		public function TextInput( multiline : Boolean = false ) {
			super();
			addChild( text );
			text.input = true;
			text.multiline = multiline;
			initSkin();
		}
		
		override protected function get defaultWidth() : Number {
			return 150;
		}
		
		override protected function get defaultHeight() : Number {
			return 20;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		public function get text() : Text {
			return _text;
		}
		
		public function get input() : Boolean {
			return text.input;
		}
		
		public function set input( value : Boolean ) : void {
			text.input = value;
		}
		
		public function get textValue() : String {
			return text.value;
		}
		
		public function set textValue( value : String ) : void {
			if( value == null )
				value = "";
			text.value = value;
		}
		
		public function get password() : Boolean {
			return text.password;
		}
		
		public function set password( value : Boolean ) : void {
			text.password = value;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.applySetting( text, Setting_Text, Setting_Text_Value );
		}
		
		override protected function activeVisible( visible : Boolean ) : void {
			super.activeVisible( visible );
			if( visible ) {
				view.applySetting( text, Setting_Text_Active, Setting_Text_Active_Value );
			} else {
				view.applySetting( text, Setting_Text, Setting_Text_Value );
			}
		}
		
		override protected function onFocusState() : void {
			super.onFocusState();
			text.selectable = inFocus;
			if( !inFocus ) {
				text.setSelection( 0, 0 );
			}
		}
	}
}
