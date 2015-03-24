package cn.chinuy.display.layout {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class AutoSizeModel extends EventDispatcher {
		
		private var _target : ILayoutElement;
		private var _sizeBy : ILayoutElement;
		private var _enable : Boolean;
		
		private var _lPadding : Number = 0;
		private var _rPadding : Number = 0;
		private var _tPadding : Number = 0;
		private var _bPadding : Number = 0;
		
		public function AutoSizeModel() {
			super();
		}
		
		public function target( target : ILayoutElement ) : void {
			_target = target;
		}
		
		public function sizeBy( sizeBy : ILayoutElement, enable : Boolean = true ) : void {
			_sizeBy = sizeBy;
			this.enable = enable;
		}
		
		public function get enable() : Boolean {
			return _enable;
		}
		
		public function set enable( value : Boolean ) : void {
			_enable = value;
			if( _sizeBy ) {
				if( enable ) {
					_sizeBy.addEventListener( Event.RESIZE, onResize );
				} else {
					_sizeBy.removeEventListener( Event.RESIZE, onResize );
				}
			}
		}
		
		public function get width() : Number {
			return _sizeBy.width + lPadding + rPadding;
		}
		
		public function get height() : Number {
			return _sizeBy.height + tPadding + bPadding;
		}
		
		public function set padding( value : Number ) : void {
			_lPadding = _rPadding = _tPadding = _bPadding = value;
			updataSize();
		}
		
		public function get bPadding() : Number {
			return _bPadding;
		}
		
		public function set bPadding( value : Number ) : void {
			_bPadding = value;
			updataSize();
		}
		
		public function get tPadding() : Number {
			return _tPadding;
		}
		
		public function set tPadding( value : Number ) : void {
			_tPadding = value;
			updataSize();
		}
		
		public function get rPadding() : Number {
			return _rPadding;
		}
		
		public function set rPadding( value : Number ) : void {
			_rPadding = value;
			updataSize();
		}
		
		public function get lPadding() : Number {
			return _lPadding;
		}
		
		public function set lPadding( value : Number ) : void {
			_lPadding = value;
			updataSize();
		}
		
		protected function onResize( event : Event ) : void {
			updataSize();
		}
		
		protected function updataSize() : void {
			if( enable ) {
				_sizeBy.removeEventListener( Event.RESIZE, onResize );
				_sizeBy.left = lPadding;
				_sizeBy.top = tPadding;
				_target.width = width;
				_target.height = height;
				_sizeBy.addEventListener( Event.RESIZE, onResize );
			}
		}
	}
}
