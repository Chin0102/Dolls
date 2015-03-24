package cn.chinuy.display.uicomponents.text {
	import cn.chinuy.display.uicore.UIComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import cn.chinuy.display.uicomponents.basic.HScrollBar;
	import cn.chinuy.display.uicomponents.basic.VScrollBar;
	
	/**
	 * @author chin
	 */
	public class TextArea extends UIComponent {
		
		public static const Skin : String = "TextArea";
		
		public static const Component_HScrollBar : String = "HScrollBar";
		public static const Component_VScrollBar : String = "VScrollBar";
		
		public static const Setting_Text : String = "TextSetting";
		public static const Setting_Text_Default : Object = { left:0, right:15, top:0, bottom:0 };
		
		protected var baseText : Text = new Text();
		private var _hscrollBar : HScrollBar;
		private var _vscrollBar : VScrollBar;
		
		public function TextArea() {
			super();
			addChild( baseText );
			baseText.input = true;
			baseText.multiline = true;
			baseText.addEventListener( Event.SCROLL, onTextScroll );
			baseText.addEventListener( MouseEvent.MOUSE_WHEEL, onMouseWheel );
			initSkin();
		}
		
		override protected function get defaultWidth() : Number {
			return 200;
		}
		
		override protected function get defaultHeight() : Number {
			return 150;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		public function get text() : String {
			return baseText.value;
		}
		
		public function set text( value : String ) : void {
			baseText.value = value;
		}
		
		public function get htmlText() : String {
			return baseText.htmlValue;
		}
		
		public function set htmlText( value : String ) : void {
			baseText.htmlValue = value;
		}
		
		public function get input() : Boolean {
			return baseText.input;
		}
		
		public function set input( value : Boolean ) : void {
			baseText.input = value;
		}
		
		public function get hscrollBar() : HScrollBar {
			if( !_hscrollBar ) {
				_hscrollBar = new HScrollBar();
				_hscrollBar.skin = skin + "." + Component_HScrollBar;
				_hscrollBar.model.stepSize = 1;
				_hscrollBar.addEventListener( Event.CHANGE, onHScrollBarChanged );
			}
			return _hscrollBar;
		}
		
		public function get vscrollBar() : VScrollBar {
			if( !_vscrollBar ) {
				_vscrollBar = new VScrollBar();
				_vscrollBar.skin = skin + "." + Component_VScrollBar;
				_vscrollBar.model.stepSize = 1;
				_vscrollBar.addEventListener( Event.CHANGE, onVScrollBarChanged );
			}
			return _vscrollBar;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.applySetting( baseText, Setting_Text, Setting_Text_Default );
			view.addComponent( Component_HScrollBar, hscrollBar );
			view.addComponent( Component_VScrollBar, vscrollBar );
		}
		
		override protected function sizeRender() : void {
			setScrollBarValue();
//			baseText.addEventListener( Event.ENTER_FRAME, updateAtNextFrame );
		}
		
//		private function updateAtNextFrame( e : Event ) : void {
//			baseText.removeEventListener( Event.ENTER_FRAME, updateAtNextFrame );
//			setScrollBarValue();
//		}
		
		override protected function onFocusState() : void {
			super.onFocusState();
			baseText.selectable = inFocus;
			if( !inFocus ) {
				baseText.setSelection( 0, 0 );
			}
		}
		
		public function get maxScrollV() : int {
			return baseText.maxScrollV;
		}
		
		public function get scrollV() : int {
			return baseText.scrollV;
		}
		
		public function set scrollV( value : int ) : void {
			baseText.scrollV = value;
		}
		
		public function get maxScrollH() : int {
			return baseText.maxScrollH;
		}
		
		public function get scrollH() : int {
			return baseText.scrollH;
		}
		
		public function set scrollH( value : int ) : void {
			baseText.scrollH = value;
		}
		
		private function onTextScroll( event : Event ) : void {
			vscrollBar.value = scrollV;
			setScrollBarValue();
		}
		
		private function onMouseWheel( event : MouseEvent ) : void {
			vscrollBar.value -= event.delta;
		}
		
		private function onHScrollBarChanged( e : Event ) : void {
			var scrollH : Number = Math.round( hscrollBar.value );
			if( baseText.scrollH != scrollH ) {
				baseText.scrollH = scrollH;
			}
		}
		
		private function onVScrollBarChanged( e : Event ) : void {
			scrollV = Math.round( vscrollBar.value );
		}
		
		private function setScrollBarValue() : void {
			if( _hscrollBar ) {
				var hvs : Number;
				var hcs : Number;
				if( baseText.maxScrollH == 0 ) {
					hvs = hcs = 0;
				} else {
					hvs = baseText.width;
					hcs = hvs + baseText.maxScrollH;
				}
				hscrollBar.model.viewSize = hvs;
				hscrollBar.model.contentSize = hcs;
			}
			
			if( _vscrollBar ) {
				var vvs : Number;
				var vcs : Number;
				if( baseText.maxScrollV == 1 ) {
					vvs = vcs = 0;
				} else {
					vcs = baseText.numLines;
					vvs = vcs - baseText.maxScrollV - 1;
				}
				vscrollBar.model.viewSize = vvs;
				vscrollBar.model.contentSize = vcs;
			}
		}
	}
}
