package cn.chinuy.display.uicomponents.colorpicker {
	import cn.chinuy.data.color.toColorString;
	import cn.chinuy.display.uicore.UIComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.DropShadowFilter;
	
	/**
	 * @author chin
	 */
	public class ColorPicker extends UIComponent {
		
		public static const Skin : String = "ColorPicker";
		
		public static const Component_ColorButton : String = "ColorButton";
		public static const Component_ColorPanel : String = "ColorPanel";
		
		private var _colorButton : ColorButton;
		private var _colorPanel : ColorPanel;
		
		public function ColorPicker( defaultColor : uint = 0 ) {
			super();
			initSkin();
		}
		
		override protected function get defaultWidth() : Number {
			return 15;
		}
		
		override protected function get defaultHeight() : Number {
			return 15;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		override protected function onFocusState() : void {
			super.onFocusState();
			if( !inFocus ) {
				if( colorPanel.parent != null ) {
					colorPanel.parent.removeChild( colorPanel );
				}
			}
		}
		
		public function get colorButton() : ColorButton {
			if( _colorButton == null ) {
				_colorButton = new ColorButton();
				_colorButton.skin = skin + "." + Component_ColorButton;
				_colorButton.addEventListener( MouseEvent.CLICK, onClick );
			}
			return _colorButton;
		}
		
		protected function onClick( event : MouseEvent ) : void {
			if( colorPanel.parent == null ) {
//				var point : Point = new Point( 0, height );
//				point = localToGlobal( point );
//				colorPanel.x = point.x;
//				colorPanel.y = point.y;
				colorPanel.y = colorButton.height;
				this.addChild( colorPanel );
			} else {
				colorPanel.parent.removeChild( colorPanel );
			}
		}
		
		public function get colorPanel() : ColorPanel {
			if( _colorPanel == null ) {
				_colorPanel = new ColorPanel();
				_colorPanel.filters = [ new DropShadowFilter( 0, 0, 0, .5, 10, 10 )];
//				_colorPanel.skin = skin + "." + Component_ColorPanel;
				_colorPanel.addEventListener( Event.SELECT, onSelected );
			}
			return _colorPanel;
		}
		
		protected function onSelected( event : Event ) : void {
			value = colorPanel.color;
			dispatchEvent( new Event( Event.SELECT ));
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.addComponent( Component_ColorButton, colorButton );
		}
		
		public function set value( value : uint ) : void {
			if( value <= 0xFFFFFF ) {
				colorButton.color = value;
			}
		}
		
		public function get value() : uint {
			return colorButton.color;
		}
		
		public function get hexValue() : String {
			return toColorString( value );
		}
		
		public function set hexValue( value : String ) : void {
			this.value = parseInt( value );
		}
	
	}
}
