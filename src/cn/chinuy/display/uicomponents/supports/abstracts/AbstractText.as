package cn.chinuy.display.uicomponents.supports.abstracts {
	
	import cn.chinuy.display.uicore.UIComponent;
	
	import flash.display.Shape;
	import flash.filters.DropShadowFilter;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * @author chin
	 */
	public class AbstractText extends UIComponent {
		
		public static const FieldHAlign_Left : String = TextFormatAlign.LEFT;
		public static const FieldHAlign_Right : String = TextFormatAlign.RIGHT;
		public static const FieldHAlign_Center : String = TextFormatAlign.CENTER;
		public static const FieldVAlign_Top : String = "top";
		public static const FieldVAlign_Center : String = TextFormatAlign.CENTER;
		public static const FieldVAlign_Bottom : String = "bottom";
		public static const FieldVAlign_None : String = "none";
		
		private var _field : ExTextField = new ExTextField();
		private var _hAlign : String = FieldHAlign_Left;
		private var _vAlign : String = FieldVAlign_None;
		
		private var fieldMask : Shape = new Shape();
		
		private var dropShadowFilter : DropShadowFilter = new DropShadowFilter( 0, 0, 0, 0, 2, 2 );
		
		public function AbstractText() {
			super();
//			field.addEventListener( Event.SCROLL, dispatchEvent );
//			field.addEventListener( TextEvent.LINK, dispatchEvent );
//			field.addEventListener( TextEvent.TEXT_INPUT, dispatchEvent );
//			field.addEventListener( MouseEvent.MOUSE_WHEEL, dispatchEvent );
			addChild( field );
			fieldMask.graphics.beginFill( 0, 0 );
			fieldMask.graphics.drawRect( 0, 0, 10, 10 );
			fieldMask.graphics.endFill();
			addChild( fieldMask );
			field.mask = fieldMask;
		}
		
		public function get filterBlurY() : Number {
			return dropShadowFilter.blurY;
		}
		
		public function set filterBlurY( value : Number ) : void {
			dropShadowFilter.blurY = value;
			field.filters = [ dropShadowFilter ];
		}
		
		public function get filterBlurX() : Number {
			return dropShadowFilter.blurX;
		}
		
		public function set filterBlurX( value : Number ) : void {
			dropShadowFilter.blurX = value;
			field.filters = [ dropShadowFilter ];
		}
		
		public function get filterAlpha() : Number {
			return dropShadowFilter.alpha;
		}
		
		public function set filterAlpha( value : Number ) : void {
			dropShadowFilter.alpha = value;
			field.filters = [ dropShadowFilter ];
		}
		
		public function get filterColor() : uint {
			return dropShadowFilter.color;
		}
		
		public function set filterColor( value : uint ) : void {
			dropShadowFilter.color = value;
			field.filters = [ dropShadowFilter ];
		}
		
		public function get filterAngle() : Number {
			return dropShadowFilter.angle;
		}
		
		public function set filterAngle( value : Number ) : void {
			dropShadowFilter.angle = value;
			field.filters = [ dropShadowFilter ];
		}
		
		public function get filterDistance() : Number {
			return dropShadowFilter.distance;
		}
		
		public function set filterDistance( value : Number ) : void {
			dropShadowFilter.distance = value;
			field.filters = [ dropShadowFilter ];
		}
		
		override protected function get defaultWidth() : Number {
			return 60;
		}
		
		override protected function get defaultHeight() : Number {
			return 20;
		}
		
		public function get field() : ExTextField {
			return _field;
		}
		
		//TextFormat------------------------------------------------------------------
		public function get format() : TextFormat {
			return field.format;
		}
		
		public function set format( value : TextFormat ) : void {
			field.defaultTextFormat = value;
		}
		
		public function get underline() : Boolean {
			return field.underline;
		}
		
		public function set underline( value : Boolean ) : void {
			field.underline = value;
		}
		
		public function get letterSpacing() : int {
			return field.letterSpacing;
		}
		
		public function set letterSpacing( value : int ) : void {
			field.letterSpacing = value;
		}
		
		public function get leading() : int {
			return field.leading;
		}
		
		public function set leading( value : int ) : void {
			field.leading = value;
		}
		
		public function get italic() : Boolean {
			return field.italic;
		}
		
		public function set italic( value : Boolean ) : void {
			field.italic = value;
		}
		
		public function get font() : String {
			return field.font;
		}
		
		public function set font( value : String ) : void {
			field.font = value;
		}
		
		public function get color() : int {
			return field.color;
		}
		
		public function set color( value : int ) : void {
			field.color = value;
		}
		
		public function get bold() : Boolean {
			return field.bold;
		}
		
		public function set bold( value : Boolean ) : void {
			field.bold = value;
		}
		
		public function get size() : int {
			return field.size;
		}
		
		public function set size( value : int ) : void {
			field.size = value;
		}
		
		public function get value() : String {
			return field.text;
		}
		
		public function set value( value : String ) : void {
			field.text = value;
		}
		
		public function get htmlValue() : String {
			return field.htmlText;
		}
		
		public function set htmlValue( value : String ) : void {
			field.htmlText = value;
		}
		
		public function get length() : int {
			return field.length;
		}
		
		public function get input() : Boolean {
			return field.type == TextFieldType.INPUT;
		}
		
		public function set input( value : Boolean ) : void {
			field.type = value ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		}
		
		public function get wordWrap() : Boolean {
			return field.wordWrap;
		}
		
		public function set wordWrap( value : Boolean ) : void {
			field.wordWrap = value;
		}
		
		public function get multiline() : Boolean {
			return field.multiline;
		}
		
		public function set multiline( value : Boolean ) : void {
			field.multiline = value;
		}
		
		public function get password() : Boolean {
			return field.displayAsPassword;
		}
		
		public function set password( value : Boolean ) : void {
			field.displayAsPassword = value;
		}
		
		public function get selectable() : Boolean {
			return field.selectable;
		}
		
		public function set selectable( value : Boolean ) : void {
			field.selectable = value;
		}
		
		public function setSelection( beginIndex : int, endIndex : int ) : void {
			field.setSelection( beginIndex, endIndex );
		}
		
		public function get numLines() : int {
			return field.numLines;
		}
		
		public function get maxScrollV() : int {
			return field.maxScrollV;
		}
		
		public function get scrollV() : int {
			return field.scrollV;
		}
		
		public function set scrollV( value : int ) : void {
			field.scrollV = value;
		}
		
		public function get maxScrollH() : int {
			return field.maxScrollH;
		}
		
		public function get scrollH() : int {
			return field.scrollH;
		}
		
		public function set scrollH( value : int ) : void {
			field.scrollH = value;
		}
		
		public function get hAlign() : String {
			return _hAlign;
		}
		
		public function set hAlign( value : String ) : void {
			_hAlign = value;
			field.align = hAlign;
			updateDisplay();
		}
		
		public function get vAlign() : String {
			return _vAlign;
		}
		
		public function set vAlign( value : String ) : void {
			_vAlign = value;
			updateDisplay();
		}
		
		override protected function updateDisplay() : void {
		}
		
		override protected function sizeRender() : void {
			fieldMask.width = width;
			fieldMask.height = height;
			updateDisplay();
		}
	}
}
