package cn.chinuy.display.uicore {
	
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class SkinManager extends EventDispatcher {
		
		private static var _instance : SkinManager;
		
		public static function get instance() : SkinManager {
			if( _instance == null ) {
				_instance = new SkinManager();
			}
			return _instance;
		}
		
		private var map : Object = {};
		private var skinPackage : SkinPackage;
		
		public function SkinManager() {
			super();
		}
		
		public function create( name : String ) : IUIView {
			if( currentPackage ) {
				return currentPackage.createView( name );
			}
			return null;
		}
		
		public function hasPackage( name : String ) : Boolean {
			return map[ name ] != null;
		}
		
		public function addPackage( skinPackage : SkinPackage ) : void {
			map[ skinPackage.name ] = skinPackage;
		}
		
		public function usePackage( name : String ) : void {
			var skinPackage : SkinPackage = map[ name ];
			if( skinPackage ) {
				this.skinPackage = skinPackage;
				dispatchEvent( SkinEvent.AllSkinChangedEvent());
			}
		}
		
		public function get currentPackage() : SkinPackage {
			if( skinPackage == null ) {
				skinPackage = map[ SkinPackage.DEFAULT ];
			}
			return skinPackage;
		}
	}
}
