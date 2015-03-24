package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.uicomponents.basic.HScrollBar;
	import cn.chinuy.display.uicomponents.basic.VScrollBar;
	import cn.chinuy.display.uicore.UIComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class Scroller extends UIComponent {
		
		public static const DisableMouseWheel : int = 0;
		public static const MouseWheelV : int = 1;
		public static const MouseWheelH : int = 2;
		
		private var _mouseWheelMode : int = 1;
		
		private var _viewport : IViewport;
		private var _hscrollBar : HScrollBar;
		private var _vscrollBar : VScrollBar;
		
		public function Scroller() {
			super();
			_hscrollBar = new HScrollBar();
			_hscrollBar.model.stepSize = 1;
			_hscrollBar.addEventListener( Event.CHANGE, onHScrollBarChanged );
			
			_vscrollBar = new VScrollBar();
			_vscrollBar.model.stepSize = 1;
			_vscrollBar.top = _vscrollBar.bottom = _vscrollBar.right = 0;
			_vscrollBar.addEventListener( Event.CHANGE, onVScrollBarChanged );
			
			addChild( hscrollBar );
			addChild( vscrollBar );
		}
		
		public function get mouseWheelMode() : int {
			return _mouseWheelMode;
		}
		
		public function set mouseWheelMode( value : int ) : void {
			_mouseWheelMode = value;
			setMouseWheel( mouseWheelMode );
		}
		
		protected function setMouseWheel( mode : int ) : void {
			viewport.removeEventListener( MouseEvent.MOUSE_WHEEL, mouseWheelH );
			viewport.removeEventListener( MouseEvent.MOUSE_WHEEL, mouseWheelV );
			switch( mode ) {
				case DisableMouseWheel:
					return;
				case MouseWheelH:
					viewport.addEventListener( MouseEvent.MOUSE_WHEEL, mouseWheelH );
					break;
				case MouseWheelV:
				default:
					viewport.addEventListener( MouseEvent.MOUSE_WHEEL, mouseWheelV );
					break;
			}
		}
		
		public function get viewport() : IViewport {
			return _viewport;
		}
		
		public function set viewport( value : IViewport ) : void {
			if( _viewport ) {
				_viewport.removeEventListener( Viewport.ContentResize, onContentResize );
				_viewport.removeEventListener( Container.Resize, onContainerResize );
				setMouseWheel( DisableMouseWheel );
			}
			_viewport = value;
			if( _viewport ) {
				_viewport.addEventListener( Viewport.ContentResize, onContentResize );
				_viewport.addEventListener( Container.Resize, onContainerResize );
				_viewport.clipAndEnableScrolling = true;
				setMouseWheel( mouseWheelMode );
				setScrollBarValue();
			}
		}
		
		private function mouseWheelV( event : MouseEvent ) : void {
			vscrollBar.value -= event.delta * 3;
		}
		
		private function mouseWheelH( event : MouseEvent ) : void {
			hscrollBar.value -= event.delta * 3;
		}
		
		private function onContentResize( e : Event ) : void {
			setScrollBarValue();
		}
		
		private function onContainerResize( e : Event ) : void {
			setScrollBarValue();
		}
		
		public function get hscrollBar() : HScrollBar {
			return _hscrollBar;
		}
		
		public function get vscrollBar() : VScrollBar {
			return _vscrollBar;
		}
		
//		public function set horizontalScrollPosition( value : Number ) : void {
//			viewport.horizontalScrollPosition = value;
//			hscrollBar.value = -value;
//		}
//		
//		public function set verticalScrollPosition( value : Number ) : void {
//			viewport.verticalScrollPosition = value;
//			vscrollBar.value = -value;
//		}
		
		private function onHScrollBarChanged( e : Event ) : void {
			viewport.horizontalScrollPosition = -hscrollBar.value;
		}
		
		private function onVScrollBarChanged( e : Event ) : void {
			viewport.verticalScrollPosition = -vscrollBar.value;
		}
		
		private function setScrollBarValue() : void {
			hscrollBar.model.viewSize = viewport.containerWidth;
			hscrollBar.model.contentSize = viewport.contentWidth;
			
			vscrollBar.model.viewSize = viewport.containerHeight;
			vscrollBar.model.contentSize = viewport.contentHeight;
		}
	}
}
