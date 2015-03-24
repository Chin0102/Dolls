package cn.chinuy.display.uicomponents.text {
	
	/**
	 * @author chin
	 */
	public class Label extends Text {
		
		public static var SrcClass : Class = Label;
		
		public static function create( text : String = "", autoSize : Boolean = true ) : Label {
			var label : Label = new SrcClass( text, autoSize ) as Label;
			return label;
		}
		
		public static const Skin : String = "Label";
		
		public function Label( text : String = "", autoSize : Boolean = true ) {
			super();
			field.mouseEnabled = selectable = false;
			this.autoSize = autoSize;
			this.value = text;
			initSkin();
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
	}
}
