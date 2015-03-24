package cn.chinuy.display.uicore {
	import cn.chinuy.display.UISprite;
	
	/**
	 * @author chin
	 */
	public class SkinPackage {
		
		public static const DEFAULT : String = "SkinPackage.Default";
		
		private var _name : String;
		private var sourceMap : Object = {};
		private var skinMap : Object = {};
		private var uiMap : Object = {};
		private var uiRefMap : Object = {};
		
		public function SkinPackage( name : String = "" ) {
			super();
			if( name == "" ) {
				name = DEFAULT;
			}
			_name = name;
			SkinManager.instance.addPackage( this );
		}
		
		public function get name() : String {
			return _name;
		}
		
		public function skin( name : String ) : ISkin {
			return skinMap[ name ];
		}
		
		public function addSkin( skin : ISkin ) : void {
			var name : String = skin.name;
			skinMap[ name ] = skin;
			if( SkinManager.instance.currentPackage == this ) {
				var e : SkinEvent = SkinEvent.SkinChangedEvent( skin );
				SkinManager.instance.dispatchEvent( e );
			}
		}
		
		public function createView( name : String ) : IUIView {
			var s : ISkin = skin( name );
			if( s ) {
				return s.create();
			}
			return null;
		}
		
		public function source( name : String ) : IDisplaySource {
			return sourceMap[ name ];
		}
		
		public function addSource( source : IDisplaySource ) : void {
			var name : String = source.name;
			sourceMap[ name ] = source;
		}
		
		public function createDisplay( name : String ) : UISprite {
			var s : IDisplaySource = source( name );
			if( s ) {
				return s.create();
			}
			return null;
		}
		
		public function addUI( name : String, ui : UISprite ) : void {
			uiMap[ name ] = ui;
		}
		
		public function removeUI( name : String ) : void {
			delete uiMap[ name ];
		}
		
		public function ui( name : String ) : UISprite {
			return uiMap[ name ];
		}
		
		public function registerUIClass( name : String, ComponentRef : Class ) : void {
			uiRefMap[ name ] = ComponentRef;
		}
		
		public function removeUIClass( name : String ) : void {
			delete uiRefMap[ name ];
		}
		
		public function createUI( name : String ) : UISprite {
			var ui : UISprite;
			var UIRef : Class = uiRefMap[ name ];
			if( UIRef ) {
				ui = new UIRef() as UISprite;
			}
			return ui;
		}
	}
}
