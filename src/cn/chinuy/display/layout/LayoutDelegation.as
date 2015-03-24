package cn.chinuy.display.layout {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class LayoutDelegation extends EventDispatcher implements ILayoutElement {
		
		private var layout : ILayoutModel;
		private var target : DisplayObject;
		private var isContainer : Boolean;
		
		public function LayoutDelegation( target : DisplayObject, isContainer : Boolean = false ) {
			super();
			initTarget( target, isContainer );
			addEventListener( Event.RESIZE, onResize );
			layout = new LayoutModel( this );
		}
		
		private function initTarget( target : DisplayObject, isContainer : Boolean ) : void {
			this.isContainer = isContainer;
			this.target = target;
			target.addEventListener( Event.ADDED, dispatchEvent );
			target.addEventListener( Event.REMOVED, dispatchEvent );
		}
		
		private function onResize( e : Event ) : void {
			target.x = x;
			target.y = y;
			if( !isContainer ) {
				target.width = width;
				target.height = height;
			}
			target.dispatchEvent( e );
		}
		
		public function get viewWidth() : Number {
			return target.width;
		}
		
		public function get viewHeight() : Number {
			return target.height;
		}
		
		public function get parent() : DisplayObjectContainer {
			return target.parent;
		}
		
		public function get displayObject() : DisplayObject {
			return target;
		}
		
		public function get left() : * {
			return layout.left;
		}
		
		public function set left( value : * ) : void {
			layout.left = value;
		}
		
		public function get right() : * {
			return layout.right;
		}
		
		public function set right( value : * ) : void {
			layout.right = value;
		}
		
		public function get top() : * {
			return layout.top;
		}
		
		public function set top( value : * ) : void {
			layout.top = value;
		}
		
		public function get bottom() : * {
			return layout.bottom;
		}
		
		public function set bottom( value : * ) : void {
			layout.bottom = value;
		}
		
		public function get leftTarget() : DisplayObject {
			return layout.leftTarget;
		}
		
		public function set leftTarget( value : DisplayObject ) : void {
			layout.leftTarget = value;
		}
		
		public function get rightTarget() : DisplayObject {
			return layout.rightTarget;
		}
		
		public function set rightTarget( value : DisplayObject ) : void {
			layout.rightTarget = value;
		}
		
		public function get topTarget() : DisplayObject {
			return layout.topTarget;
		}
		
		public function set topTarget( value : DisplayObject ) : void {
			layout.topTarget = value;
		}
		
		public function get bottomTarget() : DisplayObject {
			return layout.bottomTarget;
		}
		
		public function set bottomTarget( value : DisplayObject ) : void {
			layout.bottomTarget = value;
		}
		
		public function get hcenter() : * {
			return layout.hcenter;
		}
		
		public function set hcenter( value : * ) : void {
			layout.hcenter = value;
		}
		
		public function get vcenter() : * {
			return layout.vcenter;
		}
		
		public function set vcenter( value : * ) : void {
			layout.vcenter = value;
		}
		
		public function get renderEnable() : Boolean {
			return layout.renderEnable;
		}
		
		public function set renderEnable( value : Boolean ) : void {
			layout.renderEnable = value;
		}
		
		public function get x() : Number {
			return layout.x;
		}
		
		public function set x( value : Number ) : void {
			layout.x = value;
		}
		
		public function get y() : Number {
			return layout.y;
		}
		
		public function set y( value : Number ) : void {
			layout.y = value;
		}
		
		public function get width() : Number {
			return layout.width;
		}
		
		public function set width( value : Number ) : void {
			layout.width = value;
		}
		
		public function get height() : Number {
			return layout.height;
		}
		
		public function set height( value : Number ) : void {
			layout.height = value;
		}
	}
}
