package cn.chinuy.display.uicore {
	import cn.chinuy.display.UISprite;
	
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class UIBuilder extends EventDispatcher {
		
		private var loader : ISkinLoader;
		private var skinPackage : SkinPackage;
		
		private var _loading : Boolean;
		
		public function UIBuilder( skinPackage : SkinPackage = null ) {
			super();
			if( skinPackage == null ) {
				skinPackage = new SkinPackage();
			}
			this.skinPackage = skinPackage;
		}
		
		public function skin( name : String ) : ISkin {
			return skinPackage.skin( name );
		}
		
		public function addSkin( skin : ISkin ) : void {
			skinPackage.addSkin( skin );
		}
		
		public function createView( name : String ) : IUIView {
			return skinPackage.createView( name );
		}
		
		public function source( name : String ) : IDisplaySource {
			return skinPackage.source( name );
		}
		
		public function addSource( source : IDisplaySource ) : void {
			skinPackage.addSource( source );
		}
		
		public function createDisplay( name : String ) : UISprite {
			return skinPackage.createDisplay( name );
		}
		
		public function addUI( name : String, ui : UISprite ) : void {
			skinPackage.addUI( name, ui );
		}
		
		public function removeUI( name : String ) : void {
			skinPackage.removeUI( name );
		}
		
		public function ui( name : String ) : UISprite {
			return skinPackage.ui( name );
		}
		
		public function registerUIClass( name : String, ComponentRef : Class ) : void {
			skinPackage.registerUIClass( name, ComponentRef );
		}
		
		public function removeUIClass( name : String ) : void {
			skinPackage.removeUIClass( name );
		}
		
		public function createUI( name : String ) : UISprite {
			return skinPackage.createUI( name );
		}
		
		public function get loading() : Boolean {
			return _loading;
		}
		
		public function loadSkin( skinLoader : ISkinLoader, source : * ) : void {
			if( loader ) {
				removeLoaderEvent();
				loader.unload();
			}
			_loading = true;
			loader = skinLoader;
			loader.addEventListener( SkinLoadEvent.Complete, onComplete );
			loader.addEventListener( SkinLoadEvent.Error, onError );
			loader.load( skinPackage, source );
		}
		
		private function removeLoaderEvent() : void {
			loader.removeEventListener( SkinLoadEvent.Complete, onComplete );
			loader.removeEventListener( SkinLoadEvent.Error, onError );
		}
		
		private function onComplete( e : SkinLoadEvent ) : void {
			_loading = false;
			removeLoaderEvent();
			dispatchEvent( e );
		}
		
		private function onError( e : SkinLoadEvent ) : void {
			_loading = false;
			dispatchEvent( e );
		}
	
	}
}
