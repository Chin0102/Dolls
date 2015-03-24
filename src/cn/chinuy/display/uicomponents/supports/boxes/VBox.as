package cn.chinuy.display.uicomponents.supports.boxes {
	import flash.display.DisplayObject;
	
	/**
	 * @author chin
	 */
	public class VBox extends Box {
		
		public function VBox() {
			super();
		}
		
		override protected function updateChildren() : void {
			var num : int = numChildren;
			var y : int = 0;
			for( var i : int; i < num; i++ ) {
				var child : DisplayObject = getChildAt( i );
				child.y = y;
				y += child.height + vGap;
				
			}
		}
	}
}
