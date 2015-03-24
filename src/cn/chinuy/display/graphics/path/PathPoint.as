package cn.chinuy.display.graphics.path {
	import flash.geom.Point;
	
	/**
	 * @author chin
	 */
	public class PathPoint extends Point {
		
		private var _type : int;
		private var _p : Point;
		
		public function PathPoint( x : Number = 0, y : Number = 0, type : int = 0, p : Point = null ) {
			super( x, y );
			_type = type;
			_p = p;
		}
		
		public function get controlPoint() : Point {
			return _p;
		}
		
		public function get type() : int {
			return _type;
		}
	
	}
}
