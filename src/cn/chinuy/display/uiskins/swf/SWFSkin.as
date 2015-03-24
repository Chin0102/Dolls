package cn.chinuy.display.uiskins.swf {
	import cn.chinuy.display.GraphicsSprite;
	import cn.chinuy.display.uicore.ISkin;
	import cn.chinuy.display.uicore.IUIView;
	import cn.chinuy.display.uicore.UIView;
	
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	/**
	 * @author chin
	 */
	public class SWFSkin implements ISkin {
		
		private var parser : SWFSkinParser;
		private var info : Object;
		
		private var targetMap : Dictionary = new Dictionary();
		
		public function SWFSkin( skinInfo : Object, parser : SWFSkinParser ) {
			info = skinInfo;
			this.parser = parser;
		}
		
		public function get name() : String {
			return info[ "name" ];
		}
		
		public function create() : IUIView {
			var view : UIView = new UIView();
			var elements : Array = info[ "elements" ];
			var len : int = elements.length;
			for( var i : int = 0; i < len; i++ ) {
				var element : Object = elements[ i ];
				var type : String = element[ "type" ];
				var name : String = element[ "name" ];
				var properties : Object = element[ "properties" ];
				switch( type ) {
					case "Element":
						view.addElement( name, applyProperties( parser.createSprite( element[ "source" ]), properties ));
						break;
					case "State":
						view.addState( name, applyProperties( parser.createSprite( element[ "source" ]), properties ));
						break;
					case "Component":
						view.addComponentPlaceHolder( name, properties );
						break;
				}
			}
			for( var obj : * in targetMap ) {
				var map : Object = targetMap[ obj ];
				for( var property : String in map ) {
					var target : DisplayObject = view.element( map[ property ]);
					if( target ) {
						obj[ property ] = target;
					}
				}
				delete targetMap[ obj ];
			}
			var settings : Object = info[ "settings" ];
			if( settings ) {
				for( var setting : String in settings ) {
					view.addSetting( setting, settings[ setting ]);
				}
			}
			return view;
		}
		
		protected function applyProperties( obj : *, properties : Object ) : * {
			for( var p : String in properties ) {
				var value : * = properties[ p ];
				if( obj.hasOwnProperty( p )) {
					switch( p ) {
						case "leftTarget":
						case "rightTarget":
						case "topTarget":
						case "bottomTarget":
						case "mask":
							var map : Object = targetMap[ obj ];
							if( map == null ) {
								map = targetMap[ obj ] = {};
							}
							map[ p ] = value;
							break;
						default:
							obj[ p ] = value;
							break;
					}
				}
			}
			return obj;
		}
	}
}
