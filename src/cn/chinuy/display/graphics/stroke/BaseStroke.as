package cn.chinuy.display.graphics.stroke {
	import cn.chinuy.display.graphics.pen.IPen;
	
	import flash.display.Graphics;
	
	/**
	 * @author chin
	 */
	public class BaseStroke implements IStroke {
		
		protected var x : Number;
		protected var y : Number;
		protected var width : Number;
		protected var height : Number;
		
		public function BaseStroke() {
		}
		
		public function apply( graphics : Graphics, width : Number, height : Number, pen : IPen, x : Number = 0, y : Number = 0 ) : void {
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
		
		public function get fillX() : Number {
			return x;
		}
		
		public function get fillY() : Number {
			return y;
		}
		
		public function get fillWidth() : Number {
			return width;
		}
		
		public function get fillHeight() : Number {
			return height;
		}
	}
}
