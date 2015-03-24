package cn.chinuy.display.uicomponents.supports.boxes {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class Box extends Sprite {
		
		public static const ContentResize : String = "ContentResize";
		
		private var w : Number = 0;
		private var h : Number = 0;
		
		private var _appointW : Number;
		private var _appointH : Number;
		
		private var _hGap : Number = 0;
		private var _vGap : Number = 0;
		
		public function Box() {
			super();
		}
		
		public function get hGap() : Number {
			return _hGap;
		}
		
		public function set hGap( value : Number ) : void {
			var changed : Boolean = _hGap != value;
			if( changed ) {
				_hGap = value;
				measure();
			}
		}
		
		public function get vGap() : Number {
			return _vGap;
		}
		
		public function set vGap( value : Number ) : void {
			var changed : Boolean = _vGap != value;
			if( changed ) {
				_vGap = value;
				measure();
			}
		}
		
		public function get appointH() : Number {
			return _appointH;
		}
		
		public function set appointH( value : Number ) : void {
			_appointH = value;
			measure();
		}
		
		public function get appointW() : Number {
			return _appointW;
		}
		
		public function set appointW( value : Number ) : void {
			_appointW = value;
			measure();
		}
		
		override public function get width() : Number {
			return isNaN( appointW ) ? super.width : appointW;
		}
		
		override public function get height() : Number {
			return isNaN( appointH ) ? super.height : appointH;
		}
		
		override public function set width( value : Number ) : void {
		}
		
		override public function set height( value : Number ) : void {
		}
		
		override public function addChild( child : DisplayObject ) : DisplayObject {
			child = super.addChild( child );
			measure();
			return child;
		}
		
		override public function addChildAt( child : DisplayObject, index : int ) : DisplayObject {
			child = super.addChildAt( child, index );
			measure();
			return child;
		}
		
		override public function removeChild( child : DisplayObject ) : DisplayObject {
			child = super.removeChild( child );
			measure();
			return child;
		}
		
		override public function removeChildAt( index : int ) : DisplayObject {
			var child : DisplayObject = super.removeChildAt( index );
			measure();
			return child;
		}
		
		public function measure() : void {
			updateChildren();
			if( w != width || h != height ) {
				w = width;
				h = height;
				dispatchEvent( new Event( ContentResize ));
			}
		}
		
		protected function updateChildren() : void {
		}
	}
}
