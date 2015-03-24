package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.UISprite;
	import cn.chinuy.display.layout.AutoSizeModel;
	import cn.chinuy.display.uicomponents.text.Label;
	import cn.chinuy.display.uicore.UIComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
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
		
		private var _followMouse : Boolean = true;
		private var _hOffset : Number = 1;
		private var _vOffset : Number = 1;
		private var _anchorPoint : uint = 0;
		
		private var _arrow : UISprite;
		
		private var stageEventPengding : Boolean;
		
		public function ToolTip() {
			super();
			mouseEnabled = false;
			addChild( _label );
			initSkin();
			autoSizeModel.sizeBy( _label );
			followMouse = true;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.applySetting( _label, Setting_Label, Setting_Label_Default );
			_arrow = view.element( "TooltipArrow" ) as UISprite;
		}
		
		public function set label( value : String ) : void {
			_label.value = value;
			updatePosition();
		}
		
		public function get label() : String {
			return _label.value;
		}
		
		public function get vOffset() : Number {
			return _vOffset;
		}
		
		public function set vOffset( value : Number ) : void {
			_vOffset = value;
			updatePosition();
		}
		
		public function get hOffset() : Number {
			return _hOffset;
		}
		
		public function set hOffset( value : Number ) : void {
			_hOffset = value;
			updatePosition();
		}
		
		/**
		 *	0|1|2<br>
		 *	7|X|3<br>
		 *	6|5|4<br>
		 **/
		public function get anchorPoint() : uint {
			return _anchorPoint;
		}
		
		public function set anchorPoint( value : uint ) : void {
			_anchorPoint = value;
		}
		
		protected function updatePosition() : void {
			if( parent ) {
				var halfWidth : Number = width / 2;
				var halfHeight : Number = height / 2;
				var anchorPointX : Number = parent.mouseX;
				var anchorPointY : Number = parent.mouseY;
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
				var posX : Number = anchorPointX + hOffset;
				var posY : Number = anchorPointY + vOffset;
				x = Math.max( 0, Math.min( posX, stage.stageWidth - width ));
				y = Math.max( 0, Math.min( posY, stage.stageHeight - height ));
				if( _arrow ) {
					var hw : Number = _arrow.width / 2;
					_arrow.hcenter = Math.max( hw - halfWidth, Math.min( posX - x, halfWidth - hw ));
				}
			}
		}
		
		public function get followMouse() : Boolean {
			return _followMouse;
		}
		
		public function set followMouse( value : Boolean ) : void {
			_followMouse = value;
			if( value ) {
				if( stage ) {
					addStageEvent();
				} else {
					stageEventPengding = true;
					addEventListener( Event.ADDED_TO_STAGE, onAdded );
				}
			} else {
				stageEventPengding = false;
				removeEventListener( Event.ADDED_TO_STAGE, onAdded );
			}
		}
		
		private function onAdded( event : Event ) : void {
			if( stageEventPengding && stage ) {
				stageEventPengding = false;
				removeEventListener( Event.ADDED_TO_STAGE, onAdded );
				addStageEvent();
			}
		}
		
		private function addStageEvent() : void {
			updatePosition();
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
		}
		
		private function onMouseMove( event : MouseEvent ) : void {
			updatePosition();
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
