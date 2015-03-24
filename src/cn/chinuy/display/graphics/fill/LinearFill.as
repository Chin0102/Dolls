package cn.chinuy.display.graphics.fill {
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	/**
	 * @author chin
	 */
	public class LinearFill extends MultiColorFill implements IFill {
		
		private var _angle : int;
		
		public function LinearFill( angle : int = 0, colors : Array = null, alphas : Array = null, ratios : Array = null ) {
			super( colors, alphas, ratios );
			_angle = angle;
		}
		
		override public function apply( graphics : Graphics, width : Number, height : Number ) : void {
			if( colors.length > 1 ) {
				graphics.beginGradientFill( GradientType.LINEAR, colors, alphas, ratios, getMatrix( width, height ));
			} else if( colors.length == 1 ) {
				graphics.beginFill( colors[ 0 ], alphas[ 0 ]);
			}
		}
		
		private function getMatrix( w : Number, h : Number ) : Matrix {
			var m : Matrix = new Matrix();
			m.createGradientBox( w, h, _angle * Math.PI / 180 );
			return m;
		}
	
	}
}
