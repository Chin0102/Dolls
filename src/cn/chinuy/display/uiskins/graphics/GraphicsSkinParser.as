package cn.chinuy.display.uiskins.graphics {
	import cn.chinuy.data.string.toNumber;
	import cn.chinuy.display.GraphicsSprite;
	import cn.chinuy.display.UISprite;
	import cn.chinuy.display.graphics.GraphicsAssetsLibrary;
	import cn.chinuy.display.graphics.fill.IFill;
	import cn.chinuy.display.graphics.fill.LinearFill;
	import cn.chinuy.display.graphics.fill.RadialFill;
	import cn.chinuy.display.graphics.pen.EllipsePen;
	import cn.chinuy.display.graphics.pen.IPen;
	import cn.chinuy.display.graphics.pen.RectPen;
	import cn.chinuy.display.graphics.stroke.MultiStroke;
	import cn.chinuy.display.uicore.SkinPackage;
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	
	/**
	 * @author chin
	 */
	public class GraphicsSkinParser {
		
		private var skinPackage : SkinPackage;
		
		private var targetMap : Dictionary = new Dictionary();
		
		public function GraphicsSkinParser( skinPackage : SkinPackage ) {
			this.skinPackage = skinPackage;
		}
		
		public function get graphicsAssetsLib() : GraphicsAssetsLibrary {
			return GraphicsAssetsLibrary.getInstance();
		}
		
		public function parse( skinData : Object ) : void {
			//graphicsAssets
			var graphicsAssets : Object = skinData[ "graphicsAssets" ];
			if( graphicsAssets ) {
				var fillAssets : Object = graphicsAssets[ "fills" ];
				if( fillAssets ) {
					for( var fillName : String in fillAssets ) {
						var fillData : Object = fillAssets[ fillName ];
						var fill : IFill;
						var style : String = fillData[ "style" ];
						var colors : Array = fillData[ "colors" ];
						var alphas : Array = fillData[ "alphas" ];
						var ratios : Array = fillData[ "ratios" ];
						switch( style ) {
							case "Radial":
								fill = new RadialFill( fillData[ "offsetx" ], fillData[ "offsety" ], colors, alphas, ratios );
								break;
							default:
								fill = new LinearFill( toNumber( fillData[ "angle" ], 0 ), colors, alphas, ratios );
								break;
						}
						graphicsAssetsLib.addFill( fillName, fill );
					}
				}
				var strokeAssets : Object = graphicsAssets[ "strokes" ];
				if( strokeAssets ) {
					for( var strokeName : String in strokeAssets ) {
						var strokeData : Object = strokeAssets[ strokeName ];
						var fillNames : Array = strokeData[ "fills" ];
						var strokeFills : Array = [];
						for( var fn : int = 0; fn < fillNames.length; fn++ ) {
							strokeFills.push( graphicsAssetsLib.getFill( fillNames[ fn ]));
						}
						var stroke : MultiStroke = new MultiStroke( strokeData[ "thicknesss" ], strokeFills );
						graphicsAssetsLib.addStroke( strokeName, stroke );
					}
				}
				var penAssets : Object = graphicsAssets[ "pens" ];
				if( penAssets ) {
					for( var penName : String in penAssets ) {
						var penData : Object = penAssets[ penName ];
						var pen : IPen;
						switch( penData[ "style" ]) {
							case "Ellipse":
								pen = new EllipsePen();
								break;
							case "Rect":
							default:
								pen = new RectPen();
								RectPen( pen ).setRadius.apply( null, penData[ "radius" ]);
						}
						graphicsAssetsLib.addPen( penName, pen );
					}
				}
			}
			//sources
//			var sources : Array = source.getProperty( "sources" );
//			if( sources ) {
//				var sourceNum : int = sources.length;
//				for( var i : int = 0; i < sourceNum; i++ ) {
//					skinPackage.addSource( new SWFDisplaySource( sources[ i ], this ));
//				}
//			}
			//skins
			var skins : Array = skinData[ "skins" ];
			if( skins ) {
				var skinNum : int = skins.length;
				for( var j : int = 0; j < skinNum; j++ ) {
					skinPackage.addSkin( new GraphicsSkin( skins[ j ], this ));
				}
			}
			//build
			build( skinData[ "build" ]);
		}
		
		protected function build( uis : Array ) : void {
			if( uis == null )
				return;
			var len : int = uis.length;
			for( var i : int = 0; i < len; i++ ) {
				var uiData : Object = uis[ i ];
				skinPackage.addUI( uiData[ "name" ], buildUI( uis[ i ]));
			}
			for( var container : * in targetMap ) {
				var c : UISprite = container;
				var obj : Object = targetMap[ c ];
				for( var property : String in obj ) {
					setTargetProperty( c, property, obj[ property ]);
				}
				delete targetMap[ c ];
			}
		}
		
		protected function setTargetProperty( container : UISprite, property : String, targetName : String ) : void {
			var target : DisplayObject = container.parent.getChildByName( targetName );
			if( target ) {
				container[ property ] = target;
			}
		}
		
		protected function buildUI( uiData : Object ) : UISprite {
			var type : String = uiData[ "type" ];
			var c : UISprite;
			if( type == "Sprite" ) {
				c = new GraphicsSprite();
			} else if( type == "UIContainer" ) {
				c = new UIContainer();
			} else {
				c = skinPackage.createUI( type );
			}
			if( c ) {
				c.name = uiData[ "name" ];
				var properties : Object = uiData[ "properties" ];
				if( properties ) {
					for( var p : String in properties ) {
						switch( p ) {
							case "leftTarget":
							case "rightTarget":
							case "topTarget":
							case "bottomTarget":
							case "mask":
								var obj : Object = targetMap[ c ];
								if( obj == null ) {
									obj = targetMap[ c ] = {};
								}
								obj[ p ] = properties[ p ];
								break;
							default:
								if( c.hasOwnProperty( p )) {
									c[ p ] = properties[ p ];
								}
								break;
						}
					}
				}
				var childs : Array = uiData[ "childs" ];
				if( childs ) {
					var len : int = childs.length;
					for( var i : int = 0; i < len; i++ ) {
						var ui : UISprite = buildUI( childs[ i ]);
						if( ui ) {
							c.addChild( ui );
						}
					}
				}
			}
			return c;
		}
	}
}
