package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.uicore.UIComponent;
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	/**
	 * @author chin
	 */
	public class Image extends UIComponent {
		
		//------------------------------------------------------------
		
		public static const Left : int = 0;
		public static const CenterH : int = 1;
		public static const Right : int = 2;
		
		public static const Top : int = 0;
		public static const CenterV : int = 3;
		public static const Bottom : int = 6;
		
		//------------------------------------------------------------
		//从不调整图片的尺寸
		public static const OriginalSize : String = "originalSize";
		
		//拉伸平铺
		public static const Tile : String = "tile";
		
		//保持宽高比例,充满范围 (范围内不会有空白)
		public static const CeilSizeAlwaysScale : String = "ceilSize_alwaysScale";
		
		//保持宽高比例,尽量不调整尺寸在范围内自适应 (当宽或高都不超过范围时,等同于OriginalSize; 否则等同于AlwaysScale)
		public static const FloorSizeAlwaysScale : String = "floorSize_alwaysScale";
		
		//保持宽高比例,完整显示在范围内
		public static const AlwaysScale : String = "alwaysScale";
		//------------------------------------------------------------
		
		public static const Skin : String = "Image";
		
		public static const Setting_Box : String = "BoxSetting";
		public static const Setting_Box_Default : Object = { margin:[ 0, 0, 0, 0 ]};
		
		private var _boxContainer : UIContainer;
		private var _url : String;
		
		private var _hAlign : int = CenterH;
		private var _vAlign : int = CenterV;
		private var _scaleMode : String = AlwaysScale;
		private var _zscale : Number = 1;
		
		protected var loadLoader : Loader;
		protected var showLoader : Loader;
		
		public function Image( url : String = null ) {
			super();
			initSkin();
			this.url = url;
		}
		
		public function get zscale() : Number {
			return _zscale;
		}
		
		public function set zscale( value : Number ) : void {
			_zscale = value;
			updateShowLoader();
		}
		
		public function get align() : int {
			return hAlign + vAlign;
		}
		
		public function get hAlign() : int {
			return _hAlign;
		}
		
		public function get vAlign() : int {
			return _vAlign;
		}
		
		public function set align( value : int ) : void {
			if( value >= 0 && value <= 8 ) {
				_hAlign = value % 3;
				_vAlign = int( value / 3 ) * 3;
				updateShowLoader();
			}
		}
		
		public function set hAlign( value : int ) : void {
			_hAlign = value;
			updateShowLoader();
		}
		
		public function set vAlign( value : int ) : void {
			_vAlign = value;
			updateShowLoader();
		}
		
		public function get scaleMode() : String {
			return _scaleMode;
		}
		
		public function set scaleMode( value : String ) : void {
			_scaleMode = value;
			updateShowLoader();
		}
		
		override protected function get defaultWidth() : Number {
			return 100;
		}
		
		override protected function get defaultHeight() : Number {
			return 100;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		protected function get defaultBoxSetting() : Object {
			return Setting_Box_Default;
		}
		
		public function get url() : String {
			return _url;
		}
		
		public function set url( value : String ) : void {
			var changed : Boolean = _url != value;
			if( changed ) {
				_url = value;
				removeLoadLoader( true );
				removeShowLoader();
				if( url && url.indexOf( "http" ) == 0 ) {
					loadLoader = new Loader();
					loadLoader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, onError );
					loadLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, onLoadComplete );
					loadLoader.load( new URLRequest( url ));
				}
			}
		}
		
		public function get imgReady() : Boolean {
			return showLoader != null;
		}
		
		public function get imgWidth() : Number {
			if( imgReady ) {
				return showLoader.contentLoaderInfo.width;
			}
			return -1;
		}
		
		public function get imgHeight() : Number {
			if( imgReady ) {
				return showLoader.contentLoaderInfo.height;
			}
			return -1;
		}
		
		public function set loader( value : Loader ) : void {
			if( value ) {
				removeLoadLoader( value != loadLoader );
				removeShowLoader();
				showLoader = value;
				_url = showLoader.contentLoaderInfo.url;
				if( scaleMode == OriginalSize ) {
					width = imgWidth;
					height = imgHeight;
				} else {
					updateShowLoader();
				}
				boxContainer.addChild( showLoader );
			}
		}
		
		public function get boxContainer() : UIContainer {
			if( _boxContainer == null ) {
				_boxContainer = new UIContainer();
				_boxContainer.addEventListener( Event.RESIZE, onBoxContainerResize );
				addChild( _boxContainer );
			}
			return _boxContainer;
		}
		
		private function onBoxContainerResize( event : Event ) : void {
			updateShowLoader();
		}
		
		protected function updateShowLoader() : void {
			if( imgReady && scaleMode != OriginalSize ) {
				
				var tw : Number = boxContainer.width;
				var th : Number = boxContainer.height;
				
				//应用zscale之后的range宽高
				var rw : Number = tw * zscale;
				var rh : Number = th * zscale;
				
				var w : Number;
				var h : Number;
				
				var m : String = scaleMode;
				
				if( m == FloorSizeAlwaysScale ) {
					m = ( imgWidth < rw && imgHeight < rh ) ? OriginalSize : AlwaysScale;
				}
				
				switch( m ) {
					
					case Tile:
						w = rw;
						h = rh;
						break;
					
					case OriginalSize:
						w = imgWidth;
						h = imgHeight;
						break;
					
					case CeilSizeAlwaysScale:
					case AlwaysScale:
					default:
						var rs : Number = rw / rh;
						var os : Number = imgWidth / imgHeight;
						var condition : Boolean = ( m == CeilSizeAlwaysScale ) ? ( os < rs ) : ( os > rs );
						if( condition ) {
							w = rw;
							h = w / os;
						} else {
							h = rh;
							w = h * os;
						}
						break;
				}
				
				showLoader.width = w;
				showLoader.height = h;
				
				switch( hAlign ) {
					case Left:
						showLoader.x = 0;
						break;
					case Right:
						showLoader.x = tw - w;
						break;
					case CenterH:
					default:
						showLoader.x = ( tw - w ) / 2;
						break;
				}
				switch( vAlign ) {
					case Top:
						showLoader.y = 0;
						break;
					case Bottom:
						showLoader.y = th - h;
						break;
					case CenterV:
					default:
						showLoader.y = ( th - h ) / 2;
						break;
				}
				
			}
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.applySetting( boxContainer, Setting_Box, defaultBoxSetting );
		}
		
		protected function removeShowLoader() : void {
			if( showLoader ) {
				showLoader.unloadAndStop( true );
				boxContainer.removeChild( showLoader );
				showLoader = null;
			}
		}
		
		protected function removeLoadLoader( unload : Boolean = true ) : void {
			if( loadLoader ) {
				loadLoader.contentLoaderInfo.removeEventListener( IOErrorEvent.IO_ERROR, onError );
				loadLoader.contentLoaderInfo.removeEventListener( Event.COMPLETE, onLoadComplete );
				if( unload ) {
					try {
						loadLoader.unloadAndStop( true );
					} catch( e : Error ) {
					}
				}
				loadLoader = null;
			}
		}
		
		private function onLoadComplete( e : Event ) : void {
			this.loader = loadLoader;
			dispatchEvent( e );
		}
		
		private function onError( e : Event ) : void {
			dispatchEvent( new IOErrorEvent( IOErrorEvent.IO_ERROR ));
		}
	
	}
}
