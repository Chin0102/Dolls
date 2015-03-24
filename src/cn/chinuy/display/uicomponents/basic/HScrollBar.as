package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.uicomponents.supports.abstracts.AbstractScrollBar;
	import cn.chinuy.display.uicomponents.supports.abstracts.AbstractSlider;
	
	/**
	 * @author chin
	 */
	public class HScrollBar extends AbstractScrollBar {
		
		public static const Skin : String = "HScrollBar";
		
		public function HScrollBar() {
			super();
			initSkin();
		}
		
		override protected function get defaultWidth() : Number {
			return 150;
		}
		
		override protected function get defaultHeight() : Number {
			return 10;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		override protected function newSlider() : AbstractSlider {
			return new HSlider();
		}
	}
}
