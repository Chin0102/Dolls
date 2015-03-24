package cn.chinuy.display.uicomponents.colorpicker {
	import cn.chinuy.data.color.toColorString;
	import cn.chinuy.display.uicomponents.text.TextInput;
	import cn.chinuy.display.uicore.UIComponent;
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class ColorPanel extends UIComponent implements IColorPanel {
		
		public static const Skin : String = "ColorPanel";
		
		public static const Component_Text : String = "Text";
		public static const Component_SelectColorPreview : String = "SelectColorPreview";
		public static const Component_TempColorPreview : String = "TempColorPreview";
		public static const Setting_Box : String = "BoxSetting";
		public static const Setting_Box_Default : Object = { left:0, right:0, top:20, bottom:0 };
		
		private var _color : int;
		private var _tempColor : int;
		
		private var _textInput : TextInput;
		private var _selectColorPreview : ColorButton;
		private var _tempColorPreview : ColorButton;
		private var _box : UIContainer;
		
		private var _panel : IColorPanel;
		
		public function ColorPanel() {
			super();
			initSkin();
		}
		
		public function get textInput() : TextInput {
			if( _textInput == null ) {
				_textInput = new TextInput();
			}
			return _textInput;
		}
		
		public function get selectColorPreview() : ColorButton {
			if( _selectColorPreview == null ) {
				_selectColorPreview = new ColorButton();
			}
			return _selectColorPreview;
		}
		
		public function get tempColorPreview() : ColorButton {
			if( _tempColorPreview == null ) {
				_tempColorPreview = new ColorButton();
				_tempColorPreview.visible = false;
			}
			return _tempColorPreview;
		}
		
		public function get box() : UIContainer {
			if( _box == null ) {
				_box = new UIContainer();
				addChild( _box );
			}
			return _box;
		}
		
		override protected function get defaultWidth() : Number {
			return 245;
		}
		
		override protected function get defaultHeight() : Number {
			return 187;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		protected function get defaultBoxSetting() : Object {
			return Setting_Box_Default;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.addComponent( Component_Text, textInput );
			view.addComponent( Component_SelectColorPreview, selectColorPreview );
			view.addComponent( Component_TempColorPreview, tempColorPreview );
			view.applySetting( box, Setting_Box, defaultBoxSetting );
		}
		
		public function addPanel( colorPanel : IColorPanel ) : void {
			removePanel();
			_panel = colorPanel;
			_panel.left = _panel.right = _panel.top = _panel.bottom = 0;
			_panel.addEventListener( Event.CHANGE, onPanelTempColorChanged );
			_panel.addEventListener( Event.SELECT, onPanelColorSelected );
			box.addChild( _panel.displayObject );
		}
		
		private function onPanelColorSelected( event : Event ) : void {
			color = selectColorPreview.color = panel.color;
			textInput.textValue = toColorString( color );
		}
		
		private function onPanelTempColorChanged( event : Event ) : void {
			tempColor = tempColorPreview.color = panel.tempColor;
		}
		
		public function removePanel() : void {
			if( _panel ) {
				_panel.removeEventListener( Event.CHANGE, onPanelTempColorChanged );
				_panel.removeEventListener( Event.SELECT, onPanelColorSelected );
				box.removeChild( _panel.displayObject );
				_panel = null;
			}
		}
		
		protected function get panel() : IColorPanel {
			return _panel;
		}
		
		public function get color() : int {
			return _color;
		}
		
		public function set color( value : int ) : void {
			var changed : Boolean = _color != value;
			if( changed ) {
				_color = value;
				dispatchEvent( new Event( Event.SELECT ));
				if( panel ) {
					panel.color = color;
				}
			}
		}
		
		public function get tempColor() : int {
			return _tempColor;
		}
		
		public function set tempColor( value : int ) : void {
			var changed : Boolean = _color != value;
			if( changed ) {
				_tempColor = value;
				dispatchEvent( new Event( Event.CHANGE ));
				if( panel ) {
					panel.tempColor = tempColor;
					tempColorPreview.visible = tempColor >= 0;
				}
			}
		}
	}
}
