package cn.chinuy.display.graphics.pen {
	import cn.chinuy.display.graphics.path.PathPoint;
	import cn.chinuy.display.graphics.stroke.IStroke;
	
	import flash.display.Graphics;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * @author chin
	 */
	public class PathPen extends BasePen {
		
		public static const MOVETO : int = 0;
		public static const LINETO : int = 1;
		public static const CURVETO : int = 2;
		
		private var minPoint : Point = new Point();
		private var maxPoint : Point = new Point();
		private var centerPoint : Point = new Point();
		
		private var opath : Array = [];
		private var cpath : Array;
		
		public function PathPen() {
			super();
		}
		
		public function moveTo( x : Number, y : Number ) : void {
			updateRange( x, y );
			opath.push( new PathPoint( x, y, MOVETO ));
		}
		
		public function lineTo( x : Number, y : Number ) : void {
			updateRange( x, y );
			opath.push( new PathPoint( x, y, LINETO ));
		}
		
		public function curveTo( x : Number, y : Number, cx : Number, cy : Number ) : void {
			updateRange( x, y );
			opath.push( new PathPoint( x, y, CURVETO, new Point( cx, cy )));
		}
		
		protected function updateRange( x : Number, y : Number ) : void {
			if( minPoint.x > x ) {
				minPoint.x = x;
			}
			if( minPoint.y > y ) {
				minPoint.y = y;
			}
			if( maxPoint.x < x ) {
				maxPoint.x = x;
			}
			if( maxPoint.y < y ) {
				maxPoint.y = y;
			}
			centerPoint = Point.interpolate( minPoint, maxPoint, 0.5 );
		}
		
		protected function calcPoints( x : Number, y : Number, width : Number, height : Number ) : void {
			var c : Point = new Point( width / 2, height / 2 );
			var sx : Number = c.x / centerPoint.x;
			var sy : Number = c.y / centerPoint.y;
			cpath = [];
			var len : int = opath.length;
			for( var i : int = 0; i < len; i++ ) {
				var pp : PathPoint = opath[ i ];
				var ppx : Number = pp.x;
				var ppy : Number = pp.y;
				var m : Matrix = new Matrix( 1, 0, 0, 1, ppx, ppy );
				m.scale( sx, sy );
				var ppp : Point = pp.controlPoint;
				if( ppp ) {
					var mm : Matrix = new Matrix( 1, 0, 0, 1, ppp.x, ppp.y );
					mm.scale( sx, sy );
					ppp = new Point( mm.tx + x, mm.ty + y );
				}
				var cpp : PathPoint = new PathPoint( m.tx + x, m.ty + y, pp.type, ppp );
				cpath.push( cpp );
			}
		}
		
		override public function draw( graphics : Graphics, stroke : IGraphicsStroke, fill : IGraphicsFill, width : Number, height : Number, x : Number = 0, y : Number = 0, applyStyle : Boolean = true, endFill : Boolean = true ) : void {
			var defaultMode : Boolean;
			if( applyStyle ) {
				defaultMode = applyGraphicsStyle( graphics, stroke, fill, width, height );
			} else {
				defaultMode = isDefaultStyle( stroke, fill );
			}
			if( defaultMode ) {
				var cs : IStroke = stroke as IStroke;
				if( cs ) {
					x = cs.fillX;
					y = cs.fillY;
					width = cs.fillWidth;
					height = cs.fillHeight;
				}
				calcPoints( x, y, width, height );
				var len : int = cpath.length;
				for( var i : int = 0; i < len; i++ ) {
					var pp : PathPoint = cpath[ i ];
					switch( pp.type ) {
						case MOVETO:
							graphics.moveTo( pp.x, pp.y );
							break;
						case LINETO:
							graphics.lineTo( pp.x, pp.y );
							break;
						case CURVETO:
							graphics.curveTo( pp.controlPoint.x, pp.controlPoint.y, pp.x, pp.y );
							break;
					}
				}
				if( endFill ) {
					graphics.endFill();
				}
			}
		}
	}
}
