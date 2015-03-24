package cn.chinuy.display.layout {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * @author chin
	 */
	public class LayoutModel extends EventDispatcher implements ILayoutModel {
		
		protected var leftValue : LayoutValue = new LayoutValue;
		protected var rightValue : LayoutValue = new LayoutValue;
		protected var topValue : LayoutValue = new LayoutValue;
		protected var bottomValue : LayoutValue = new LayoutValue;
		protected var hcenterValue : LayoutValue = new LayoutValue;
		protected var vcenterValue : LayoutValue = new LayoutValue;
		
		protected var xValue : Number = 0;
		protected var yValue : Number = 0;
		protected var widthValue : Number = -1;
		protected var heightValue : Number = -1;
		protected var hasWidth : Boolean = false;
		protected var hasHeight : Boolean = false;
		
		protected var p : DisplayObjectContainer;
		protected var target : ILayoutElement;
		
		private var targetDict : Dictionary;
		private var _leftTarget : DisplayObject;
		private var _rightTarget : DisplayObject;
		private var _topTarget : DisplayObject;
		private var _bottomTarget : DisplayObject;
		private var renderEnableValue : Boolean = true;
		
		public function LayoutModel( target : ILayoutElement ) {
			super();
			targetDict = new Dictionary();
			this.target = target;
			if( target.parent ) {
				setParent( target.parent );
			} else {
				target.addEventListener( Event.ADDED, onAdded );
			}
		}
		
		public function get renderEnable() : Boolean {
			return renderEnableValue;
		}
		
		public function set renderEnable( value : Boolean ) : void {
			renderEnableValue = value;
			if( renderEnable ) {
				resize();
			}
		}
		
		public function get left() : * {
			return leftValue.data;
		}
		
		public function set left( value : * ) : void {
			leftValue.reset( value );
			resize();
		}
		
		public function get right() : * {
			return rightValue.data;
		}
		
		public function set right( value : * ) : void {
			rightValue.reset( value );
			resize();
		}
		
		public function get top() : * {
			return topValue.data;
		}
		
		public function set top( value : * ) : void {
			topValue.reset( value );
			resize();
		}
		
		public function get bottom() : * {
			return bottomValue.data;
		}
		
		public function set bottom( value : * ) : void {
			bottomValue.reset( value );
			resize();
		}
		
		public function get leftTarget() : DisplayObject {
			return _leftTarget;
		}
		
		public function set leftTarget( value : DisplayObject ) : void {
			var changed : Boolean = _leftTarget != value;
			if( changed ) {
				removeTarget( _leftTarget );
				addTarget( value );
				_leftTarget = value;
				resize();
			}
		}
		
		public function get rightTarget() : DisplayObject {
			return _rightTarget;
		}
		
		public function set rightTarget( value : DisplayObject ) : void {
			var changed : Boolean = _rightTarget != value;
			if( changed ) {
				removeTarget( _rightTarget );
				addTarget( value );
				_rightTarget = value;
				resize();
			}
		}
		
		public function get topTarget() : DisplayObject {
			return _topTarget;
		}
		
		public function set topTarget( value : DisplayObject ) : void {
			var changed : Boolean = _topTarget != value;
			if( changed ) {
				removeTarget( _topTarget );
				addTarget( value );
				_topTarget = value;
				resize();
			}
		}
		
		public function get bottomTarget() : DisplayObject {
			return _bottomTarget;
		}
		
		public function set bottomTarget( value : DisplayObject ) : void {
			var changed : Boolean = _bottomTarget != value;
			if( changed ) {
				removeTarget( _bottomTarget );
				addTarget( value );
				_bottomTarget = value;
				resize();
			}
		}
		
		public function get hcenter() : * {
			return hcenterValue.data;
		}
		
		public function set hcenter( value : * ) : void {
			hcenterValue.reset( value );
			resize();
		}
		
		public function get vcenter() : * {
			return vcenterValue.data;
		}
		
		public function set vcenter( value : * ) : void {
			vcenterValue.reset( value );
			resize();
		}
		
		public function get x() : Number {
			return xValue;
		}
		
		public function set x( value : Number ) : void {
			if( !isNaN( value ) && leftValue.isNull && rightValue.isNull && hcenterValue.isNull ) {
				xValue = value;
				resize();
			}
		}
		
		public function get y() : Number {
			return yValue;
		}
		
		public function set y( value : Number ) : void {
			if( !isNaN( value ) && topValue.isNull && bottomValue.isNull && vcenterValue.isNull ) {
				yValue = value;
				resize();
			}
		}
		
		public function get width() : Number {
			if( widthValue < 0 && !hasWidth ) {
				return target.viewWidth;
			}
			return widthValue;
		}
		
		public function set width( value : Number ) : void {
			if( !isNaN( value ) && ( leftValue.isNull || rightValue.isNull )) {
				hasWidth = true;
				widthValue = value;
				resize();
			}
		}
		
		public function get height() : Number {
			if( heightValue < 0 && !hasHeight ) {
				return target.viewHeight;
			}
			return heightValue;
		}
		
		public function set height( value : Number ) : void {
			if( !isNaN( value ) && ( topValue.isNull || bottomValue.isNull )) {
				hasHeight = true;
				heightValue = value;
				resize();
			}
		}
		
		protected function onRemoved( event : Event ) : void {
			if( event.target == target ) {
				p.removeEventListener( Event.RESIZE, onResize );
				p = null;
				target.addEventListener( Event.ADDED, onAdded );
				target.removeEventListener( Event.REMOVED, onRemoved );
			}
		}
		
		protected function onAdded( event : Event ) : void {
			if( event.target == target ) {
				setParent( target.parent );
				resize();
			}
		}
		
		protected function setParent( parent : DisplayObjectContainer ) : void {
			p = parent;
			p.addEventListener( Event.RESIZE, onResize );
			target.removeEventListener( Event.ADDED, onAdded );
			target.addEventListener( Event.REMOVED, onRemoved );
		}
		
		protected function onResize( event : Event ) : void {
			resize();
		}
		
		protected function resize() : void {
			if( renderEnable ) {
				updateLayout();
			}
		}
		
		protected function updateLayout( size : Boolean = true, pos : Boolean = true, sendEvent : Boolean = true ) : void {
			
			if( p == null )
				return;
			var lt : Number = leftTarget == null ? 0 : ( leftTarget.x + leftTarget.width );
			var rt : Number = rightTarget == null ? p.width : rightTarget.x;
			var tt : Number = topTarget == null ? 0 : ( topTarget.y + topTarget.height );
			var bt : Number = bottomTarget == null ? p.height : bottomTarget.y;
			var pw : Number = rt - lt;
			var ph : Number = bt - tt;
			var lv : Number = leftValue.calc( pw );
			var rv : Number = rightValue.calc( pw );
			var hv : Number = hcenterValue.calc( pw );
			var tv : Number = topValue.calc( ph );
			var bv : Number = bottomValue.calc( ph );
			var vv : Number = vcenterValue.calc( ph );
			var w : Number = getLength( lv, rv, pw, width );
			var h : Number = getLength( tv, bv, ph, height );
			
			if( size ) {
				if( !leftValue.isNull && !rightValue.isNull ) {
					widthValue = w;
				}
				if( !topValue.isNull && !bottomValue.isNull ) {
					heightValue = h;
				}
			}
			if( pos ) {
				xValue = getPosition( lv, rv, hv, pw, widthValue, x ) + lt;
				yValue = getPosition( tv, bv, vv, ph, heightValue, y ) + tt;
			}
			if( sendEvent ) {
				target.dispatchEvent( new Event( Event.RESIZE ));
			}
		}
		
		private function removeTarget( target : DisplayObject ) : void {
			if( target != null ) {
				var num : int;
				num = targetDict[ target ];
				if( num == 1 ) {
					target.removeEventListener( Event.RESIZE, onResize );
					delete targetDict[ target ];
				} else {
					targetDict[ target ] = num - 1;
				}
			}
		}
		
		private function addTarget( target : DisplayObject ) : void {
			if( target != null ) {
				var num : int = targetDict[ target ];
				if( num <= 0 ) {
					target.addEventListener( Event.RESIZE, onResize );
					targetDict[ target ] = 1;
				} else {
					targetDict[ target ] = num + 1;
				}
			}
		}
		
		public static function getLength( a : Number, b : Number, total : Number, defValue : Number ) : int {
			if( total <= 0 ) {
				return 0;
			}
			if( validValue( a ) && validValue( b )) {
				return total - a - b;
			} else {
				return defValue;
			}
		}
		
		public static function getPosition( a : Number, b : Number, c : Number, total : Number, length : Number, defValue : Number ) : int {
			if( validValue( c )) {
				return ( total - length ) / 2 + c;
			} else {
				if( validValue( b )) {
					return total - length - b;
				} else if( validValue( a )) {
					return a;
				}
			}
			return defValue;
		}
		
		private static function validValue( value : Number ) : Boolean {
			return !isNaN( value );
		}
	}
}
