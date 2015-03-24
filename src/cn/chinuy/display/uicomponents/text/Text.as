package cn.chinuy.display.uicomponents.text {
	import cn.chinuy.display.uicomponents.supports.abstracts.AbstractText;
	
	import flash.events.Event;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	/**
	 * @author chin
	 */
	public class Text extends AbstractText {
		
		public static const FieldHAlign_Left : String = TextFormatAlign.LEFT;
		public static const FieldHAlign_Right : String = TextFormatAlign.RIGHT;
		public static const FieldHAlign_Center : String = TextFormatAlign.CENTER;
		public static const FieldVAlign_Top : String = "top";
		public static const FieldVAlign_Center : String = TextFormatAlign.CENTER;
		public static const FieldVAlign_Bottom : String = "bottom";
		public static const FieldVAlign_None : String = "none";
		
		private var _autoSize : Boolean;
		
		public function Text() {
			super();
			autoSize = false;
			field.addEventListener( Event.RESIZE, onFieldResize );
		}
		
		public function get autoSize() : Boolean {
			return _autoSize;
		}
		
		public function set autoSize( value : Boolean ) : void {
			_autoSize = value;
			if( autoSize ) {
				field.autoSize = TextFieldAutoSize.LEFT;
				multiline = wordWrap = false;
				updateSize();
			} else {
				field.autoSize = TextFieldAutoSize.NONE;
				multiline = wordWrap = true;
				updateDisplay();
			}
		}
		
		protected function onFieldResize( event : Event ) : void {
			if( autoSize ) {
				updateSize();
			} else {
				updateDisplay();
			}
		}
		
		protected function updateSize() : void {
			super.width = field.width;
			super.height = field.height;
		}
		
		override public function set width( value : Number ) : void {
			if( !autoSize ) {
				super.width = value;
			}
		}
		
		override public function set height( value : Number ) : void {
			if( !autoSize ) {
				super.height = value;
			}
		}
		
		override protected function updateDisplay() : void {
			if( !autoSize ) {
				field.width = width;
				field.height = height;
				if( vAlign != FieldVAlign_None ) {
					field.autoSize = TextFieldAutoSize.LEFT;
					switch( hAlign ) {
						case FieldHAlign_Left:
							field.x = 0;
							break;
						case FieldHAlign_Right:
							field.x = width - field.width;
							break;
						case FieldHAlign_Center:
						default:
							field.x = ( width - field.width ) / 2;
							break;
					}
					switch( vAlign ) {
						case FieldVAlign_Top:
							field.y = 0;
							break;
						case FieldVAlign_Bottom:
							field.y = height - field.height;
							break;
						case FieldHAlign_Center:
						default:
							field.y = ( height - field.height ) / 2;
							break;
					}
				}
			}
		}
	
	}
}
