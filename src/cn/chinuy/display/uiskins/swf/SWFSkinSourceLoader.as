package cn.chinuy.display.uiskins.swf {
	import cn.chinuy.display.uicore.ISkinLoader;
	import cn.chinuy.display.uicore.SkinLoadEvent;
	import cn.chinuy.display.uicore.SkinPackage;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	
	/**
	 * @author chin
	 */
	public class SWFSkinSourceLoader extends EventDispatcher implements ISkinLoader {
		
		private var parser : SWFSkinParser;
		private var loaderInfo : LoaderInfo;
		
		public function SWFSkinSourceLoader() {
			super();
		}
		
		public function unload() : void {
			removeLoaderEvent();
		}
		
		public function load( target : SkinPackage, source : * ) : void {
			parser = new SWFSkinParser( target );
			if( loaderInfo ) {
				removeLoaderEvent();
			}
			var swf : DisplayObjectContainer = new source() as DisplayObjectContainer;
			if( swf != null ) {
				var loader : Loader = swf.getChildAt( 0 ) as Loader;
				loaderInfo = loader.contentLoaderInfo;
				loaderInfo.addEventListener( Event.COMPLETE, onComplete );
				loaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onError );
			} else {
				onError( new IOErrorEvent( IOErrorEvent.IO_ERROR ));
			}
		}
		
		private function removeLoaderEvent() : void {
			loaderInfo.removeEventListener( Event.COMPLETE, onComplete );
			loaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
		}
		
		private function onError( e : Event ) : void {
			removeLoaderEvent();
			dispatchEvent( new SkinLoadEvent( SkinLoadEvent.Error ));
		}
		
		private function onComplete( e : Event ) : void {
			removeLoaderEvent();
			parser.parse( loaderInfo );
			dispatchEvent( new SkinLoadEvent( SkinLoadEvent.Complete ));
		}
	
	}
}
