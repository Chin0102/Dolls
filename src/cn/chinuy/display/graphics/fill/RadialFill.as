package cn.chinuy.display.graphics.fill {
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	/**
	 * @author chin
	 */
	public class RadialFill extends MultiColorFill implements IFill {
		
		private var _offsetx : String;
		private var _offsety : String;
		
		public function RadialFill( offsetx : String = "0", offsety : String = "0", colors : Array = null, alphas : Array = null, ratios : Array = null ) {
			super( colors, alphas, ratios );
			_offsetx = offsetx;
			_offsety = offsety;
		}
		
		override public function apply( graphics : Graphics, width : Number, height : Number ) : void {
			graphics.beginGradientFill( GradientType.RADIAL, colors, alphas, ratios, getMatrix( width, height ));
		}
		
		private function getMatrix( w : Number, h : Number ) : Matrix {
			var m : Matrix = new Matrix();
			m.createGradientBox( w, h, 0, getNum( _offsetx, w ), getNum( _offsety, h ));
			return m;
		}
		
		private function getNum( str : String, def : Number ) : Number {
			var num : int = parseInt( str );
			return str.indexOf( "%" ) != -1 ? num * def / 100 : num;
		}
	}
}
