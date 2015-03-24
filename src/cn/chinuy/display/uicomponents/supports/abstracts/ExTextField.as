package cn.chinuy.display.uicomponents.supports.abstracts {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * @author chin
	 */
	public class ExTextField extends TextField {
		
		private var _format : TextFormat;
		
		public function ExTextField() {
			super();
			defaultTextFormat = new TextFormat( null, 12, 0, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, null, 0 );
		}
		
		public function get input() : Boolean {
			return type == TextFieldType.INPUT;
		}
		
		public function set input( value : Boolean ) : void {
			type = value ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		}
		
		override public function set text( value : String ) : void {
			super.text = value;
			updateTextField();
		}
		
		override public function set htmlText( value : String ) : void {
			super.htmlText = value;
			updateTextField();
		}
		
		override public function appendText( newText : String ) : void {
			super.appendText( newText );
			updateTextField();
		}
		
		override public function set defaultTextFormat( value : TextFormat ) : void {
			_format = value;
			updateTextFormat();
		}
		
		override public function setTextFormat( format : TextFormat, beginIndex : int = -1, endIndex : int = -1 ) : void {
			defaultTextFormat = format;
		}
		
		public function get format() : TextFormat {
			return _format;
		}
		
		public function get underline() : Boolean {
			return format.underline;
		}
		
		public function set underline( value : Boolean ) : void {
			format.underline = value;
			updateTextFormat();
		}
		
		public function get letterSpacing() : int {
			return toNumber( format.letterSpacing );
		}
		
		public function set letterSpacing( value : int ) : void {
			format.letterSpacing = value;
			updateTextFormat();
		}
		
		public function get leading() : int {
			return toNumber( format.leading );
		}
		
		public function set leading( value : int ) : void {
			format.leading = value;
			updateTextFormat();
		}
		
		public function get italic() : Boolean {
			return format.italic;
		}
		
		public function set italic( value : Boolean ) : void {
			format.italic = value;
			updateTextFormat();
		}
		
		public function get font() : String {
			return format.font;
		}
		
		public function set font( value : String ) : void {
			format.font = value;
			updateTextFormat();
		}
		
		public function get color() : int {
			return toNumber( format.color );
		}
		
		public function set color( value : int ) : void {
			format.color = value;
			updateTextFormat();
		}
		
		public function get align() : String {
			return format.align;
		}
		
		public function set align( value : String ) : void {
			format.align = value;
			updateTextFormat();
		}
		
		public function get bold() : Boolean {
			return format.bold;
		}
		
		public function set bold( value : Boolean ) : void {
			format.bold = value;
			updateTextFormat();
		}
		
		public function get size() : int {
			return toNumber( format.size );
		}
		
		public function set size( value : int ) : void {
			format.size = value;
			updateTextFormat();
		}
		
		protected function updateTextFormat() : void {
			super.defaultTextFormat = format;
			super.setTextFormat( format );
			updateTextField();
		}
		
		protected function updateTextField() : void {
			dispatchEvent( new Event( Event.RESIZE ));
			addEventListener( Event.ENTER_FRAME, updateAtNextFrame );
		}
		
		private function updateAtNextFrame( e : Event ) : void {
			removeEventListener( Event.ENTER_FRAME, updateAtNextFrame );
			dispatchEvent( new Event( Event.RESIZE ));
		}
		
		private static function toNumber( value : Object, defaultValue : Number = 0 ) : Number {
			if( value == null ) {
				return defaultValue;
			} else {
				return parseInt( String( value ));
			}
		}
	}
}
