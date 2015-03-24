package cn.chinuy.display.uicomponents.model {
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class ScrollBarModel extends SliderModel {
		
		private var _contentSize : Number = 0;
		private var _viewSize : Number = 0;
		
		public function ScrollBarModel() {
			super();
			begin = 0;
		}
		
		public function down() : void {
			value += viewSize;
		}
		
		public function up() : void {
			value -= viewSize;
		}
		
		public function get max() : Number {
			return contentSize - viewSize;
		}
		
		public function get viewSize() : Number {
			return _viewSize;
		}
		
		public function set viewSize( value : Number ) : void {
			_viewSize = value;
			update();
		}
		
		public function get contentSize() : Number {
			return _contentSize;
		}
		
		public function set contentSize( value : Number ) : void {
			_contentSize = value;
			update();
		}
		
		private function update() : void {
			if( contentSize < viewSize ) {
				contentSize = viewSize;
			}
			end = max;
		}
	
	}
}
