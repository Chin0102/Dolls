package cn.chinuy.display.graphics.pen {
	import cn.chinuy.display.graphics.stroke.IStroke;
	
	import flash.display.Graphics;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	
	/**
	 * @author chin
	 */
	public class RectPen extends BasePen {
		
		private var _tlRadius : Number;
		private var _trRadius : Number;
		private var _blRadius : Number;
		private var _brRadius : Number;
		
		public function RectPen( radius : Number = 0, topRightRadius : Number = -1, bottomLeftRadius : Number = -1, bottomRightRadius : Number = -1 ) {
			setRadius( radius, topRightRadius, bottomLeftRadius, bottomRightRadius );
		}
		
		public function setRadius( radius : Number = 0, topRightRadius : Number = -1, bottomLeftRadius : Number = -1, bottomRightRadius : Number = -1 ) : void {
			if( topRightRadius == -1 || bottomLeftRadius == -1 || bottomRightRadius == -1 ) {
				topRightRadius = bottomLeftRadius = bottomRightRadius = radius;
			}
			_tlRadius = radius;
			_trRadius = topRightRadius;
			_blRadius = bottomLeftRadius;
			_brRadius = bottomRightRadius;
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
				graphics.drawRoundRectComplex( x, y, width, height, _tlRadius, _trRadius, _blRadius, _brRadius );
				if( endFill ) {
					graphics.endFill();
				}
			}
		}
	}
}
