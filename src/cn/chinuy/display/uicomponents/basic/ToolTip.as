package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.UISprite;
	import cn.chinuy.display.layout.AutoSizeModel;
	import cn.chinuy.display.uicomponents.text.Label;
	import cn.chinuy.display.uicore.UIComponent;
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * @author chin
	 */
	public class ToolTip extends UIComponent {
		
		public static const DefaultTooltip : String = "ToolTip.DefaultInstance";
		
		private static var instances : Object = {};
		
		public static function getInstance( name : String ) : ToolTip {
			var tip : ToolTip = instances[ name ];
			if( tip == null ) {
				tip = instances[ name ] = new ToolTip();
			}
			return tip;
		}
		
		public static function get defaultInstance() : ToolTip {
			return getInstance( DefaultTooltip );
		}
		
		public static const Skin : String = "ToolTip";
		public static const Setting_Label : String = "LabelSetting";
		public static const Setting_Label_Default : Object = { size:12, color:0xCCCCCC };
		
		protected var _label : Label = Label.create();
		protected var _autoSizeModel : AutoSizeModel;
		
		private var _arrow : UISprite;
		private var _target : UIComponent;
		private var _stage : Stage;
		
		public function ToolTip() {
			super();
			mouseEnabled = false;
			addChild( _label );
			initSkin();
			autoSizeModel.sizeBy( _label );
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.applySetting( _label, Setting_Label, Setting_Label_Default );
			_arrow = view.element( "TooltipArrow" ) as UISprite;
		}
		
		public function get target() : UIComponent {
			return _target;
		}
		
		public function set target( value : UIComponent ) : void {
			_target = value;
			if( target ) {
				_label.value = target.tip;
				checkAnchorPoint();
				if( stage ) {
					updatePosition();
				} else {
					addEventListener( Event.ADDED_TO_STAGE, onAdded );
				}
			} else {
				_label.value = "";
				removeEventListener( Event.ADDED_TO_STAGE, onAdded );
				if( _stage ) {
					_stage.removeEventListener( MouseEvent.MOUSE_MOVE, updatePosition );
					_stage = null;
				}
			}
		}
		
		/**
		 *	0|1|2<br>
		 *	7|X|3<br>
		 *	6|5|4<br>
		 **/
		private var anchorPoint : int = -1;
		private var anchorPointX : Number;
		private var anchorPointY : Number;
		
		private var targetLocalPoint : Point = new Point();
		private var targetGlobalPoint : Point;
		private var lastTipWidth : int;
		
		private function checkAnchorPoint() : void {
			var apChanged : Boolean = ( anchorPoint != target.tipAnchorPoint || lastTipWidth != width );
			if( apChanged ) {
				lastTipWidth = width;
				var halfWidth : Number = width / 2;
				var halfHeight : Number = height / 2;
				anchorPoint = target.tipAnchorPoint;
				anchorPointX = anchorPointY = 0;
				switch( anchorPoint ) {
					case 1:
						anchorPointX -= halfWidth;
						break;
					case 2:
						anchorPointX -= width;
						break;
					case 3:
						anchorPointX -= width;
						anchorPointY -= halfHeight;
						break;
					case 4:
						anchorPointX -= width;
						anchorPointY -= height;
						break;
					case 5:
						anchorPointX -= halfWidth;
						anchorPointY -= height;
						break;
					case 6:
						anchorPointY -= height;
						break;
					case 7:
						anchorPointY -= halfHeight;
						break;
					case 0:
					default:
						break;
				}
			}
		}
		
		private function updatePosition( event : Event = null ) : void {
			
			if( parent ) {
				
				targetLocalPoint.x = target.x;
				targetLocalPoint.y = target.y;
				targetGlobalPoint = target.localToGlobal( targetLocalPoint );
				
				var posX : Number = anchorPointX + target.tipHOffset;
				if( target.tipFollowMouseX ) {
					posX += stage.mouseX;
				} else {
					posX += targetGlobalPoint.x;
				}
				
				var posY : Number = anchorPointY + target.tipVOffset;
				if( target.tipFollowMouseY ) {
					posY += stage.mouseY;
				} else {
					posY += targetGlobalPoint.y;
				}
				
				x = Math.max( 0, Math.min( posX, stage.stageWidth - width ));
				y = Math.max( 0, Math.min( posY, stage.stageHeight - height ));
				
				if( _arrow ) {
					if( target.tipFollowMouseX ) {
						var halfWidth : Number = width / 2;
						var hw : Number = _arrow.width / 2;
						_arrow.hcenter = Math.max( hw - halfWidth, Math.min( posX - x, halfWidth - hw ));
					} else {
						_arrow.hcenter = 0;
					}
				}
			}
		}
		
		private function onAdded( event : Event ) : void {
			removeEventListener( Event.ADDED_TO_STAGE, onAdded );
			if( _stage == null && stage ) {
				_stage = stage;
				updatePosition();
				if( target.tipFollowMouseX || target.tipFollowMouseY ) {
					stage.addEventListener( MouseEvent.MOUSE_MOVE, updatePosition );
				}
			}
		}
		
		override public function set tip( value : String ) : void {
			//do nothing
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		protected function get autoSizeModel() : AutoSizeModel {
			if( _autoSizeModel == null ) {
				_autoSizeModel = new AutoSizeModel();
				_autoSizeModel.target( this );
			}
			return _autoSizeModel;
		}
		
		public function get autoSize() : Boolean {
			return autoSizeModel.enable;
		}
		
		public function set autoSize( value : Boolean ) : void {
			autoSizeModel.enable = value;
		}
		
		public function set padding( value : Number ) : void {
			autoSizeModel.padding = value;
		}
		
		public function get bPadding() : Number {
			return autoSizeModel.bPadding;
		}
		
		public function set bPadding( value : Number ) : void {
			autoSizeModel.bPadding = value;
		}
		
		public function get tPadding() : Number {
			return autoSizeModel.tPadding;
		}
		
		public function set tPadding( value : Number ) : void {
			autoSizeModel.tPadding = value;
		}
		
		public function get rPadding() : Number {
			return autoSizeModel.rPadding;
		}
		
		public function set rPadding( value : Number ) : void {
			autoSizeModel.rPadding = value;
		}
		
		public function get lPadding() : Number {
			return autoSizeModel.lPadding;
		}
		
		public function set lPadding( value : Number ) : void {
			autoSizeModel.lPadding = value;
		}
	
	}
}
