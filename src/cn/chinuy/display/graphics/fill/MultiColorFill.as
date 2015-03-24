package cn.chinuy.display.graphics.fill {
	import flash.display.Graphics;
	
	/**
	 * @author chin
	 */
	public class MultiColorFill implements IFill {
		
		private var _colors : Array;
		private var _alphas : Array;
		private var _ratios : Array;
		
		public function MultiColorFill( colors : Array = null, alpha : Array = null, ratios : Array = null ) {
			if( colors != null )
				setColorsHandle( colors );
			if( alpha != null )
				setAlphasHandle( alpha );
			if( ratios != null )
				setRatiosHandle( ratios );
		}
		
		public function apply( graphics : Graphics, width : Number, height : Number ) : void {
		}
		
		public function get colors() : Array {
			return _colors;
		}
		
		public function get alphas() : Array {
			return _alphas;
		}
		
		public function get ratios() : Array {
			return _ratios;
		}
		
		private function setColorsHandle( colors : Array ) : void {
			_colors = colors;
			_alphas = [];
			_ratios = [];
			var len : int = colors.length;
			var i : int = 0;
			while( i < len ) {
				_alphas[ i ] = 1;
				_ratios[ i ] = int( i / ( len - 1 ) * 0xFF );
				i++;
			}
		}
		
		private function setAlphasHandle( alpha : Array ) : void {
			if( _colors.length == alpha.length ) {
				_alphas = alpha;
			}
		}
		
		private function setRatiosHandle( ratios : Array ) : void {
			if( _colors.length == ratios.length ) {
				_ratios = ratios;
			}
		}
	}
}
