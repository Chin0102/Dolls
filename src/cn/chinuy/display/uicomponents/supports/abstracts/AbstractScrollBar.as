package cn.chinuy.display.uicomponents.supports.abstracts {
	import cn.chinuy.display.uicomponents.basic.BaseButton;
	import cn.chinuy.display.uicomponents.model.ScrollBarModel;
	import cn.chinuy.display.uicore.UIComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class AbstractScrollBar extends UIComponent {
		
		public static const Component_UpBtn : String = "UpBtn";
		public static const Component_DownBtn : String = "DownBtn";
		public static const Component_Slider : String = "Slider";
		
		private var _upBtn : BaseButton;
		private var _downBtn : BaseButton;
		private var _slider : AbstractSlider;
		private var scrollBarModel : ScrollBarModel;
		
		public function AbstractScrollBar() {
			super();
		}
		
		public function get model() : ScrollBarModel {
			if( !scrollBarModel ) {
				this.model = new ScrollBarModel();
			}
			return scrollBarModel;
		}
		
		public function set model( value : ScrollBarModel ) : void {
			scrollBarModel = value;
		}
		
		public function get value() : Number {
			return model.value;
		}
		
		public function set value( value : Number ) : void {
			model.value = value;
		}
		
		public function get positive() : Boolean {
			return slider.positive;
		}
		
		public function set positive( value : Boolean ) : void {
			slider.positive = value;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.addComponent( Component_UpBtn, upBtn );
			view.addComponent( Component_DownBtn, downBtn );
			view.addComponent( Component_Slider, slider );
		}
		
		protected function newUpBtn() : BaseButton {
			return new BaseButton();
		}
		
		protected function newDownBtn() : BaseButton {
			return new BaseButton();
		}
		
		protected function newSlider() : AbstractSlider {
			return null;
		}
		
		public function get upBtn() : BaseButton {
			if( !_upBtn ) {
				_upBtn = newUpBtn();
				_upBtn.addEventListener( MouseEvent.CLICK, upHandler );
			}
			return _upBtn;
		}
		
		public function get downBtn() : BaseButton {
			if( !_downBtn ) {
				_downBtn = newDownBtn();
				_downBtn.addEventListener( MouseEvent.CLICK, downHandler );
			}
			return _downBtn;
		}
		
		public function get slider() : AbstractSlider {
			if( !_slider ) {
				_slider = newSlider();
				_slider.model = model;
				_slider.addEventListener( Event.RESIZE, onSliderResize );
				_slider.addEventListener( Event.CHANGE, onModelChangedHandler );
			}
			return _slider;
		}
		
		protected function downHandler( event : Event ) : void {
			if( positive ) {
				model.down();
			} else {
				model.up();
			}
		}
		
		protected function upHandler( event : Event ) : void {
			if( positive ) {
				model.up();
			} else {
				model.down();
			}
		}
		
		protected function onSliderResize( event : Event ) : void {
			updateDisplay();
		}
		
		protected function onModelChangedHandler( event : Event ) : void {
			updateDisplay();
			dispatchEvent( event );
		}
		
		override protected function updateDisplay() : void {
			slider.btnSizePercent = model.viewSize / model.contentSize;
			var visible : Boolean = model.viewSize > 0 && model.contentSize > 0 && model.viewSize < model.contentSize;
//			slider.view.elementVisible( AbstractSlider.Element_Btn, visible );
			slider.visible = visible;
		}
	}
}
