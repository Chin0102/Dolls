package cn.chinuy.display {
	import cn.chinuy.display.graphics.GraphicsRenderer;
	
	/**
	 * @author chin
	 */
	public class GraphicsSprite extends UISprite {
		
		private var renderer : GraphicsRenderer;
		
		public function GraphicsSprite() {
			super();
			renderer = new GraphicsRenderer();
		}
		
		public function set graphicsData( value : Array ) : void {
			graphicsRenderer.init.apply( null, value );
		}
		
		public function get graphicsRenderer() : GraphicsRenderer {
			return renderer;
		}
		
		public function set graphicsStyle( styleString : String ) : void {
			var style : Array = styleString.split( ",", 3 );
			graphicsRenderer.init.apply( null, style );
		}
		
		override protected function sizeRender() : void {
			renderer.render( graphics, 0, 0, width, height );
		}
	
	}
}
