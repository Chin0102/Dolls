package cn.chinuy.display.uiskins.graphics {
	import cn.chinuy.display.uicore.ISkinLoader;
	import cn.chinuy.display.uicore.SkinLoadEvent;
	import cn.chinuy.display.uicore.SkinPackage;
	
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class GraphicsSkinLoader extends EventDispatcher implements ISkinLoader {
		
		private var parser : GraphicsSkinParser;
		
		public function GraphicsSkinLoader() {
			super();
		}
		
		public function load( target : SkinPackage, source : * ) : void {
			parser = new GraphicsSkinParser( target );
			try {
				parser.parse( source );
				dispatchEvent( new SkinLoadEvent( SkinLoadEvent.Complete ));
			} catch( e : Error ) {
				dispatchEvent( new SkinLoadEvent( SkinLoadEvent.Error ));
			}
		}
		
		public function unload() : void {
		}
	
	}
}
