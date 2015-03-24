package cn.chinuy.display.graphics.pen {
	import cn.chinuy.display.graphics.fill.IFill;
	import cn.chinuy.display.graphics.stroke.IStroke;
	
	import flash.display.Graphics;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	
	/**
	 * @author chin
	 */
	public class BasePen implements IPen {
		
		public function BasePen() {
		}
		
		public function draw( graphics : Graphics, stroke : IGraphicsStroke, fill : IGraphicsFill, width : Number, height : Number, x : Number = 0, y : Number = 0, applyStyle : Boolean = true, endFill : Boolean = true ) : void {
		}
		
		protected function applyGraphicsStyle( graphics : Graphics, stroke : IGraphicsStroke, fill : IGraphicsFill, width : Number, height : Number, x : Number = 0, y : Number = 0 ) : Boolean {
			var cs : IStroke = stroke as IStroke;
			var cf : IFill = fill as IFill;
			if( cf ) {
				if( cs ) {
					cs.apply( graphics, width, height, this, x, y );
					x = cs.fillX;
					y = cs.fillY;
					width = cs.fillWidth;
					height = cs.fillHeight;
				}
				cf.apply( graphics, width, height );
				return true;
			}
			return false;
		}
		
		protected function isDefaultStyle( stroke : IGraphicsStroke, fill : IGraphicsFill ) : Boolean {
			var cs : IStroke = stroke as IStroke;
			var cf : IFill = fill as IFill;
			return ( cs || cs == null ) && cf;
		}
	}
}
