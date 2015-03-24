package cn.chinuy.display.graphics {
	import cn.chinuy.display.graphics.pen.IPen;
	
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsStroke;
	
	/**
	 * @author chin
	 */
	public class GraphicsAssetsLibrary {
		
		public static const DEFAULT : String = "Default.GraphicsAssetsLibrary";
		private static const libMap : Object = {};
		
		public static function getInstance( name : String = "" ) : GraphicsAssetsLibrary {
			if( name == "" ) {
				name = DEFAULT;
			}
			var lib : GraphicsAssetsLibrary = libMap[ name ];
			if( lib == null ) {
				libMap[ name ] = lib = new GraphicsAssetsLibrary( name );
			}
			return lib;
		}
		
		public function GraphicsAssetsLibrary( name : String ) {
			libMap[ name ] = this;
		}
		
		//
		private var strokeMap : Object = {};
		
		public function addStroke( name : String, stroke : IGraphicsStroke ) : void {
			strokeMap[ name ] = stroke;
		}
		
		public function getStroke( name : String ) : IGraphicsStroke {
			return strokeMap[ name ];
		}
		
		public function removeStroke( name : String ) : void {
			delete strokeMap[ name ];
		}
		
		//
		private var fillMap : Object = {};
		
		public function addFill( name : String, fill : IGraphicsFill ) : void {
			fillMap[ name ] = fill;
		}
		
		public function getFill( name : String ) : IGraphicsFill {
			return fillMap[ name ];
		}
		
		public function removeFill( name : String ) : void {
			delete fillMap[ name ];
		}
		
		//
		private var penMap : Object = {};
		
		public function addPen( name : String, pen : IPen ) : void {
			penMap[ name ] = pen;
		}
		
		public function getPen( name : String ) : IPen {
			return penMap[ name ];
		}
		
		public function removePen( name : String ) : void {
			delete penMap[ name ];
		}
	}
}
