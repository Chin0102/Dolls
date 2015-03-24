package cn.chinuy.display.graphics {
	import cn.chinuy.display.graphics.pen.IPen;
	
	import flash.display.Graphics;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	
	/**
	 * @author chin
	 */
	public class GraphicsRenderer {
		
		private var _styleLib : String;
		
		private var lib : GraphicsAssetsLibrary;
		
		public var pen : IPen;
		public var fill : IGraphicsFill;
		public var stroke : IGraphicsStroke;
		
		public function GraphicsRenderer( style : String = GraphicsAssetsLibrary.DEFAULT ) {
			styleLib = style;
		}
		
		public function get styleLib() : String {
			return _styleLib;
		}
		
		public function set styleLib( value : String ) : void {
			_styleLib = value;
			lib = GraphicsAssetsLibrary.getInstance( _styleLib );
		}
		
		public function init( penName : String, fillName : String, strokeName : String = null ) : void {
			setPen( penName );
			setFill( fillName );
			setStroke( strokeName );
		}
		
		public function setPen( name : String ) : void {
			pen = lib.getPen( name );
		}
		
		public function setFill( name : String ) : void {
			fill = lib.getFill( name );
		}
		
		public function setStroke( name : String ) : void {
			stroke = lib.getStroke( name );
		}
		
		public function render( graphics : Graphics, x : Number, y : Number, width : Number, height : Number, clear : Boolean = true ) : void {
			if( graphics ) {
				if( width <= 0 || height <= 0 ) {
					graphics.clear();
				} else if( pen && fill ) {
					if( clear ) {
						graphics.clear();
					}
					pen.draw( graphics, stroke, fill, width, height, x, y );
				}
			}
		}
	
	}
}
