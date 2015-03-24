package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.uicomponents.supports.boxes.VBox;
	
	/**
	 * @author chin
	 */
	public class VGroup extends BaseGroup {
		
		public static const Skin : String = "VGroup";
		
		public function VGroup() {
			super();
			initSkin();
		}
		
		override protected function initBox() : void {
			box = new VBox();
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
//		override protected function get defaultWidth() : Number {
//			return 300;
//		}
//		
//		override protected function get defaultHeight() : Number {
//			return 200;
//		}
		
		override protected function sizeRender() : void {
			box.appointW = width;
			box.measure();
		}
	
	}
}
