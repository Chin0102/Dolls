package cn.chinuy.display.graphics.fill {
	import flash.display.Graphics;
	
	/**
	 * @author chin
	 */
	public class SingleFill implements IFill {
		
		public var color : uint;
		public var alpha : Number;
		
		public function SingleFill( color : uint, alpha : Number = 1 ) {
			this.color = color;
			this.alpha = alpha;
		}
		
		public function apply( graphics : Graphics, width : Number, height : Number ) : void {
			graphics.beginFill( color, alpha );
		}
	}
}
