package cn.chinuy.display.uicomponents.container {
	
	/**
	 * @author chin
	 */
	public class BaseGroup extends Viewport {
		
		public function BaseGroup() {
			super();
//			innerContainer.addEventListener( Event.RESIZE, onViewportResize );
		}
		
		public function get hGap() : Number {
			return box.hGap;
		}
		
		public function set hGap( value : Number ) : void {
			box.hGap = value;
		}
		
		public function get vGap() : Number {
			return box.vGap;
		}
		
		public function set vGap( value : Number ) : void {
			box.vGap = value;
		}
	}
}
