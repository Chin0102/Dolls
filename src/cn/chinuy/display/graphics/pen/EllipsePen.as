package cn.chinuy.display.graphics.pen {
	import cn.chinuy.display.graphics.stroke.IStroke;
	
	import flash.display.Graphics;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	
	/**
	 * @author chin
	 */
	public class EllipsePen extends BasePen {
		
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
				graphics.drawEllipse( x, y, width, height );
				if( endFill ) {
					graphics.endFill();
				}
			}
		}
	}
}
