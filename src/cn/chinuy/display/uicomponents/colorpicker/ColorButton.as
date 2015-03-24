package cn.chinuy.display.uicomponents.colorpicker {
	import cn.chinuy.display.uicomponents.basic.BaseButton;
	
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	
	/**
	 * @author chin
	 */
	public class ColorButton extends BaseButton {
		
		public static const Skin : String = "ColorButton";
		
		public static const Element_ColorView : String = "ColorView";
		
		private var _color : uint;
		
		public function ColorButton() {
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
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			updateColorView();
		}
		
		protected function updateColorView() : void {
			if( view && view.hasElement( Element_ColorView )) {
				var cv : DisplayObject = view.element( Element_ColorView );
				var colorTransform : ColorTransform = new ColorTransform();
				colorTransform.color = color;
				cv.transform.colorTransform = colorTransform;
			}
		}
		
		public function get color() : uint {
			return _color;
		}
		
		public function set color( value : uint ) : void {
			var changed : Boolean = _color != value;
			if( changed ) {
				_color = value;
				updateColorView();
			}
		}
	
	}
}
