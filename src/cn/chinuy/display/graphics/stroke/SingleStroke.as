package cn.chinuy.display.graphics.stroke {
	import cn.chinuy.display.graphics.pen.IPen;
	
	import flash.display.Graphics;
	import flash.display.JointStyle;
	
	/**
	 * @author chin
	 */
	public class SingleStroke extends BaseStroke implements IStroke {
		
		public var thickness : Number = 0;
		public var color : uint = 0;
		public var alpha : Number = 1;
		public var pixelHinting : Boolean = true;
		public var scaleMode : String = "normal";
		public var caps : String = "none";
		public var joints : String = JointStyle.MITER;
		public var miterLimit : Number = 3;
		
		public function SingleStroke( thickness : Number, color : uint = 0, alpha : Number = 1, pixelHinting : Boolean = true, scaleMode : String = "normal", caps : String = "none", joints : String = "miter", miterLimit : Number = 3 ) {
			this.thickness = thickness;
			this.color = color;
			this.alpha = alpha;
			this.pixelHinting = pixelHinting;
			this.scaleMode = scaleMode;
			this.caps = caps;
			this.joints = joints;
			this.miterLimit = miterLimit;
		}
		
		override public function apply( graphics : Graphics, width : Number, height : Number, pen : IPen, x : Number = 0, y : Number = 0 ) : void {
			super.apply( graphics, width, height, pen, x, y );
			graphics.lineStyle( thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit );
		}
	
	}
}
