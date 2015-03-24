package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.uicomponents.supports.boxes.HBox;
	
	/**
	 * @author chin
	 */
	public class HGroup extends BaseGroup {
		
		public static const Skin : String = "HGroup";
		
		public function HGroup() {
			super();
		}
		
		override protected function initBox() : void {
			box = new HBox();
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
			box.appointH = height;
			box.measure();
		}
	
	}
}
