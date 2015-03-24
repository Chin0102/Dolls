package cn.chinuy.display.uiskins.swf {
	import cn.chinuy.display.uicore.ISkinLoader;
	import cn.chinuy.display.uicore.SkinLoadEvent;
	import cn.chinuy.display.uicore.SkinPackage;
	import cn.chinuy.net.loader.SWFLoader;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	
	/**
	 * @author chin
	 */
	public class SWFSkinNetLoader extends EventDispatcher implements ISkinLoader {
		
		private var skinLoader : SWFLoader = new SWFLoader();
		private var parser : SWFSkinParser;
		private var source : String;
		
		public function SWFSkinNetLoader() {
			super();
			skinLoader.addEventListener( Event.COMPLETE, onComplete );
			skinLoader.addEventListener( IOErrorEvent.IO_ERROR, onError );
			skinLoader.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onError );
			skinLoader.addEventListener( TimerEvent.TIMER_COMPLETE, onError );
		}
		
		public function unload() : void {
			skinLoader.unload();
		}
		
		public function load( target : SkinPackage, source : * ) : void {
			if( !skinLoader.loading || this.source != source ) {
				parser = new SWFSkinParser( target );
				skinLoader.url = this.source = source;
				skinLoader.load();
			}
		}
		
		private function onError( e : Event ) : void {
			dispatchEvent( new SkinLoadEvent( SkinLoadEvent.Error ));
		}
		
		private function onComplete( e : Event ) : void {
			parser.parse( skinLoader.info );
			dispatchEvent( new SkinLoadEvent( SkinLoadEvent.Complete ));
		}
	
	}
}
