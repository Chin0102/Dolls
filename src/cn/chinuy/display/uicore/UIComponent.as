package cn.chinuy.display.uicore {
	import cn.chinuy.display.uicomponents.basic.ToolTip;
	
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class UIComponent extends UIContainer {
		
		public static const State_Disabled : String = "Disabled";
		public static const Element_Icon : String = "Icon";
		public static const Element_Active : String = "Active";
		public static const Element_Background : String = "Background";
		public static const Setting_Self : String = "Self";
		
		protected static var skinManager : SkinManager = SkinManager.instance;
		
		protected var _mouseDown : Boolean;
		protected var _mouseOver : Boolean;
		protected var inFocus : Boolean;
		
		private var uiView : IUIView;
		private var skinName : String;
		private var focusEnabledValue : Boolean = true;
		private var enabledValue : Boolean = true;
		
		private var _toolTip : ToolTip;
		private var _tipEnabled : Boolean = true;
		private var _tipValue : String = "";
		private var _tipFollowMouseX : Boolean = true;
		private var _tipFollowMouseY : Boolean = true;
		private var _tipHOffset : Number = 10;
		private var _tipVOffset : Number = 10;
		private var _tipAnchorPoint : uint = 0;
		
		public function UIComponent() {
			super();
			addEventListener( MouseEvent.MOUSE_DOWN, onMouseDownHandler );
			addEventListener( MouseEvent.ROLL_OVER, onRollOverStateHandler );
			addEventListener( MouseEvent.ROLL_OUT, onRollOverStateHandler );
			addEventListener( Event.ADDED_TO_STAGE, onAdd2Stage );
			tabChildren = false;
			enabled = true;
		}
		
		protected function get defaultWidth() : Number {
			return 0;
		}
		
		protected function get defaultHeight() : Number {
			return 0;
		}
		
		protected function get defaultSkin() : String {
			return "";
		}
		
		protected function get defaultMouseChildren() : Boolean {
			return true;
		}
		
		final protected function initSkin() : void {
			width = defaultWidth;
			height = defaultHeight;
			skin = defaultSkin;
		}
		
		public function get tipEnabled() : Boolean {
			return _tipEnabled;
		}
		
		public function set tipEnabled( value : Boolean ) : void {
			_tipEnabled = value;
		}
		
		public function get tip() : String {
			return _tipValue;
		}
		
		public function set tip( value : String ) : void {
			_tipValue = value;
			updateTip();
		}
		
		public function get tipAnchorPoint() : uint {
			return _tipAnchorPoint;
		}
		
		public function set tipAnchorPoint( value : uint ) : void {
			_tipAnchorPoint = value;
			updateTip();
		}
		
		public function get tipVOffset() : Number {
			return _tipVOffset;
		}
		
		public function set tipVOffset( value : Number ) : void {
			_tipVOffset = value;
			updateTip();
		}
		
		public function get tipHOffset() : Number {
			return _tipHOffset;
		}
		
		public function set tipHOffset( value : Number ) : void {
			_tipHOffset = value;
			updateTip();
		}
		
		public function get tipFollowMouseY() : Boolean {
			return _tipFollowMouseY;
		}
		
		public function set tipFollowMouseY( value : Boolean ) : void {
			_tipFollowMouseY = value;
			updateTip();
		}
		
		public function get tipFollowMouseX() : Boolean {
			return _tipFollowMouseX;
		}
		
		public function set tipFollowMouseX( value : Boolean ) : void {
			_tipFollowMouseX = value;
			updateTip();
		}
		
		public function get mouseOver() : Boolean {
			return _mouseOver;
		}
		
		public function get mouseDown() : Boolean {
			return _mouseDown;
		}
		
		public function get enabled() : Boolean {
			return enabledValue;
		}
		
		public function set enabled( value : Boolean ) : void {
			mouseChildren = value ? defaultMouseChildren : false;
			mouseEnabled = enabledValue = value;
			this.focusRect = false;
			focusEnabled = value;
		}
		
		public function get focusEnabled() : Boolean {
			return focusEnabledValue;
		}
		
		public function set focusEnabled( value : Boolean ) : void {
			focusEnabledValue = value;
			if( !value && stage && stage.focus == this ) {
				stage.focus = null;
			}
			enabledFocusEvent( value );
		}
		
		public function get hasFocus() : Boolean {
			if( stage ) {
				var obj : InteractiveObject = stage.focus;
				while( obj ) {
					if( obj == this ) {
						return true;
					}
					obj = obj.parent;
				}
			}
			return false;
		}
		
		public function get skin() : String {
			return skinName;
		}
		
		public function set skin( value : String ) : void {
			if( skin != null ) {
				skinManager.removeEventListener( SkinEvent.CHANGED + skin, onSkinChanged );
				skinManager.removeEventListener( SkinEvent.ALLCHANGED, onSkinChanged );
			}
			skinName = value;
			if( skin != null ) {
				skinManager.addEventListener( SkinEvent.CHANGED + skin, onSkinChanged );
				skinManager.addEventListener( SkinEvent.ALLCHANGED, onSkinChanged );
			}
			initViewHandler();
		}
		
		private function onFocusEvent( e : FocusEvent ) : void {
			var current : Boolean = e.type == FocusEvent.FOCUS_IN;
			var changed : Boolean = inFocus != current;
			if( changed ) {
				inFocus = current;
				removeEventListener( Event.ENTER_FRAME, updateFocusStateAtNextFrame );
				addEventListener( Event.ENTER_FRAME, updateFocusStateAtNextFrame );
			}
		}
		
		private function updateFocusStateAtNextFrame( event : Event ) : void {
			removeEventListener( Event.ENTER_FRAME, updateFocusStateAtNextFrame );
			onFocusState();
		}
		
		private function enabledFocusEvent( enabled : Boolean ) : void {
			if( enabled ) {
				addEventListener( FocusEvent.FOCUS_IN, onFocusEvent );
				addEventListener( FocusEvent.FOCUS_OUT, onFocusEvent );
			} else {
				removeEventListener( FocusEvent.FOCUS_IN, onFocusEvent );
				removeEventListener( FocusEvent.FOCUS_OUT, onFocusEvent );
			}
		}
		
		private function onAdd2Stage( e : Event ) : void {
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUpHandler );
			stage.addEventListener( Event.FULLSCREEN, onFullHandler );
		}
		
		private function onFullHandler( e : Event ) : void {
			onFullStageState();
		}
		
		protected function onFullStageState() : void {
			_mouseOver = false;
			_mouseDown = false;
			updateTip();
		}
		
		private function onMouseUpHandler( event : MouseEvent ) : void {
			if( mouseDown ) {
				_mouseDown = false;
				onMouseDownState();
			}
		}
		
		private function onMouseDownHandler( event : MouseEvent ) : void {
			if( focusEnabled && !hasFocus ) {
				stage.focus = this;
			}
			_mouseDown = true;
			onMouseDownState();
		}
		
		private function onRollOverStateHandler( event : MouseEvent ) : void {
			var over : Boolean = event.type == MouseEvent.ROLL_OVER;
			if( over != _mouseOver ) {
				_mouseOver = over;
				onMouseOverState();
			}
		}
		
		private function onSkinChanged( e : SkinEvent ) : void {
			initViewHandler();
		}
		
		private function initViewHandler() : void {
			if( view ) {
				onViewRemoved();
				superRemoveChild( view.container );
			}
			uiView = skinManager.create( skin );
			if( view ) {
				superAddChildAt( view.container, 0 );
				onViewChanged();
				updateDisplay();
			}
		}
		
		public function get view() : IUIView {
			if( uiView == null ) {
				uiView = new UIView();
				superAddChildAt( view.container, 0 );
			}
			return uiView;
		}
		
		protected function activeVisible( visible : Boolean ) : void {
			if( view ) {
				view.elementVisible( Element_Active, visible );
			}
		}
		
		protected function iconVisible( visible : Boolean ) : void {
			if( view ) {
				view.elementVisible( Element_Icon, visible );
			}
		}
		
		protected function onFocusState() : void {
			activeVisible( inFocus );
		}
		
		protected function onViewRemoved() : void {
		}
		
		protected function onViewChanged() : void {
			view.applySetting( this, Setting_Self );
			activeVisible( inFocus );
		}
		
		protected function onMouseDownState() : void {
		}
		
		protected function onMouseOverState() : void {
			updateTip();
		}
		
		protected function updateDisplay() : void {
		}
		
		public function set tooltip( tip : ToolTip ) : void {
			_toolTip = tip;
		}
		
		public function get tooltip() : ToolTip {
			if( _toolTip == null ) {
				_toolTip = ToolTip.defaultInstance;
			}
			return _toolTip;
		}
		
		private function updateTip() : void {
			if( tipEnabled && stage && tooltip ) {
				if( tip != "" && mouseOver ) {
					tooltip.target = this;
					if( tooltip.parent != stage )
						stage.addChild( tooltip );
				} else {
					if( tooltip.parent ) {
						tooltip.parent.removeChild( tooltip );
					}
					tooltip.target = null;
				}
			}
		}
	}
}
