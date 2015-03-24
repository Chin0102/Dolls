package cn.chinuy.display.uicomponents.supports.boxes {
	import flash.display.DisplayObject;
	
	/**
	 * @author chin
	 */
	public class HBox extends Box {
		
		public function HBox() {
			super();
		}
		
		override protected function updateChildren() : void {
			var num : int = numChildren;
			var x : int = 0;
			for( var i : int; i < num; i++ ) {
				var child : DisplayObject = getChildAt( i );
				child.x = x;
				x += child.width + hGap;
			}
		}
	}
}
