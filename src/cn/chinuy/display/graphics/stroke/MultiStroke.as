package cn.chinuy.display.graphics.stroke {
	import cn.chinuy.display.graphics.pen.IPen;
	
	import flash.display.Graphics;
	
	/**
	 * @author chin
	 */
	public class MultiStroke extends BaseStroke {
		
		private var _fills : Array;
		private var _thicknesss : Array;
		
		public function MultiStroke( thicknesss : Array, fills : Array = null ) {
			super();
			setThicknesssHandle( thicknesss );
			if( fills != null ) {
				setFillsHandle( fills );
			}
		}
		
		public function getTotalThickness() : Number {
			var len : int = _thicknesss.length;
			var t : Number = 0;
			var i : int = 0;
			while( i < len ) {
				t += _thicknesss[ i ];
				i++;
			}
			return t;
		}
		
		public function getFills() : Array {
			return _fills;
		}
		
		public function getThicknesss() : Array {
			return _thicknesss;
		}
		
		private function setThicknesssHandle( thicknesss : Array ) : void {
			_thicknesss = thicknesss;
		}
		
		private function setFillsHandle( fills : Array ) : void {
			if( _thicknesss.length == fills.length ) {
				_fills = fills;
			}
		}
		
		override public function apply( graphics : Graphics, width : Number, height : Number, pen : IPen, x : Number = 0, y : Number = 0 ) : void {
			super.apply( graphics, width, height, pen, x, y );
			var thicknesss : Array = getThicknesss();
			var fills : Array = getFills();
			var vv : Boolean = x < 0 && y < 0;
			for( var i : int = 0; i < thicknesss.length; i++ ) {
				pen.draw( graphics, null, fills[ i ], width, height, x, y, true, false );
				x += thicknesss[ i ];
				y += thicknesss[ i ];
				width -= thicknesss[ i ] * 2;
				height -= thicknesss[ i ] * 2;
				pen.draw( graphics, null, fills[ i ], width, height, x, y, false, true );
			}
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
		}
	}
}
