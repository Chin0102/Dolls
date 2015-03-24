package cn.chinuy.display.uicomponents.supports.abstracts {
	import cn.chinuy.display.uicomponents.model.SliderModel;
	import cn.chinuy.display.uicore.UIComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class AbstractSlider extends UIComponent {
		
		public static const Element_BgDisabled : String = "SliderBgBarDisabled";
		public static const Element_Bg : String = "SliderBgBar";
		public static const Element_Bar : String = "SliderBar";
		public static const Element_Btn : String = "SliderBtn";
		
		private var _positive : Boolean = true;
		private var _inputEnabled : Boolean = true;
		protected var _btnSize : Number;
		protected var _btnSizePercent : Number;
		protected var mousePositionOffset : Number;
		protected var sliderModel : SliderModel;
		
		public function AbstractSlider() {
			super();
		}
		
		public function get model() : SliderModel {
			if( !sliderModel ) {
				this.model = new SliderModel();
			}
			return sliderModel;
		}
		
		public function set model( value : SliderModel ) : void {
			if( sliderModel ) {
				sliderModel.removeEventListener( Event.CHANGE, onModelChangedHandler );
			}
			sliderModel = value;
			sliderModel.addEventListener( Event.CHANGE, onModelChangedHandler );
		}
		
		public function get mousePositionValue() : Number {
			return 0;
		}
		
		public function get value() : Number {
			return model.value;
		}
		
		public function set value( value : Number ) : void {
			model.value = value;
		}
		
		public function get positive() : Boolean {
			return _positive;
		}
		
		public function set positive( value : Boolean ) : void {
			_positive = value;
			updateDisplay();
		}
		
		public function set btnSize( value : Number ) : void {
			_btnSize = value;
			updateDisplay();
		}
		
		public function get btnSize() : Number {
			return _btnSize;
		}
		
		public function set btnSizePercent( value : Number ) : void {
			_btnSizePercent = value;
			removeEventListener( Event.ENTER_FRAME, updateBtnSizeAtNextFrame );
			addEventListener( Event.ENTER_FRAME, updateBtnSizeAtNextFrame );
		}
		
		public function get btnSizePercent() : Number {
			return _btnSizePercent;
		}
		
		private function updateBtnSizeAtNextFrame( event : Event ) : void {
			removeEventListener( Event.ENTER_FRAME, updateBtnSizeAtNextFrame );
			btnSize = bgLength * btnSizePercent;
		}
		
		override protected function onViewRemoved() : void {
			view.elementListener( Element_Bg, Event.RESIZE, onBgBarResize, false );
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.elementListener( Element_Bg, Event.RESIZE, onBgBarResize, true );
			view.elementProperty( Element_Btn, "mouseChildren", false );
			view.elementProperty( Element_Bar, "mouseChildren", false );
			view.elementProperty( Element_BgDisabled, "mouseChildren", false );
		}
		
		override public function set enabled( value : Boolean ) : void {
			super.enabled = value;
			view.elementVisible( Element_Bar, value );
			view.elementVisible( Element_Btn, value );
			view.elementVisible( Element_BgDisabled, !value );
		}
		
		public function get inputEnabled() : Boolean {
			return _inputEnabled;
		}
		
		public function set inputEnabled( value : Boolean ) : void {
			_inputEnabled = value;
		}
		
		private function onBgBarResize( event : Event ) : void {
			updateDisplay();
		}
		
		override protected function onMouseDownState() : void {
			if( inputEnabled ) {
				if( mouseDown ) {
					onMouseMoveStart();
					onMouseMove();
					stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
				} else {
					stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
					onMouseMove();
					onMouseMoveFinish();
				}
			}
		}
		
		protected function get btnMousePosition() : Number {
			return 0;
		}
		
		protected function get bgLength() : Number {
			return 0;
		}
		
		protected function onMouseMoveStart() : void {
			mousePositionOffset = getMousePositionOffset();
		}
		
		protected function getMousePositionOffset() : Number {
			var offset : Number;
			var mp : Number = btnMousePosition;
			var overBtn : Boolean = mp > 0 && mp < _btnSize;
			if( overBtn ) {
				if( positive ) {
					offset = mp;
				} else {
					offset = _btnSize - mp;
				}
			} else {
				offset = _btnSize / 2;
			}
			return offset;
		}
		
		protected function onMouseMove( event : MouseEvent = null ) : void {
		}
		
		protected function onMouseMoveFinish() : void {
			updateDisplay();
		}
		
		protected function onModelChangedHandler( event : Event ) : void {
			updateDisplay();
			dispatchEvent( event );
		}
	
	}
}
