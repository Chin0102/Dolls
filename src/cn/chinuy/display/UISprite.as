package cn.chinuy.display {
	
	import cn.chinuy.display.layout.ILayoutElement;
	import cn.chinuy.display.layout.ILayoutModel;
	import cn.chinuy.display.layout.LayoutModel;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class UISprite extends Sprite implements ILayoutElement {
		
		protected var layout : ILayoutModel;
		
		public function UISprite() {
			super();
			initLayout();
			addEventListener( Event.RESIZE, onSelfResize );
		}
		
		public function set margin( value : Array ) : void {
			if( value && value.length >= 4 ) {
				left = value[ 0 ];
				top = value[ 1 ];
				right = value[ 2 ];
				bottom = value[ 3 ];
			}
		}
		
		public function get displayObject() : DisplayObject {
			return this;
		}
		
		public function get renderEnable() : Boolean {
			return layout.renderEnable;
		}
		
		public function set renderEnable( value : Boolean ) : void {
			layout.renderEnable = value;
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
		
		public function get viewWidth() : Number {
			return super.width;
		}
		
		public function get viewHeight() : Number {
			return super.height;
		}
		
		override public function get x() : Number {
			return layout.x;
		}
		
		override public function set x( value : Number ) : void {
			layout.x = value;
		}
		
		override public function get y() : Number {
			return layout.y;
		}
		
		override public function set y( value : Number ) : void {
			layout.y = value;
		}
		
		override public function get width() : Number {
			return layout.width;
		}
		
		override public function set width( value : Number ) : void {
			layout.width = value;
		}
		
		override public function get height() : Number {
			return layout.height;
		}
		
		override public function set height( value : Number ) : void {
			layout.height = value;
		}
		
		protected function initLayout() : void {
			layout = new LayoutModel( this );
		}
		
		protected function onSelfResize( e : Event ) : void {
			posRender();
			resizeBG();
			sizeRender();
		}
		
		protected function posRender() : void {
			superx = x;
			supery = y;
		}
		
		protected function sizeRender() : void {
			superwidth = width;
			superheight = height;
		}
		
		final protected function set superx( value : Number ) : void {
			super.x = value;
		}
		
		final protected function set supery( value : Number ) : void {
			super.y = value;
		}
		
		final protected function set superwidth( value : Number ) : void {
			super.width = value;
		}
		
		final protected function set superheight( value : Number ) : void {
			super.height = value;
		}
		
		final protected function superAddChild( child : DisplayObject ) : DisplayObject {
			return super.addChild( child );
		}
		
		final protected function superAddChildAt( child : DisplayObject, index : int ) : DisplayObject {
			return super.addChildAt( child, index );
		}
		
		final protected function superRemoveChild( child : DisplayObject ) : DisplayObject {
			return super.removeChild( child );
		}
		
		final protected function superRemoveChildAt( index : int ) : DisplayObject {
			return super.removeChildAt( index );
		}
		
		//bg
		private var _bgColor : int = -1;
		private var _bgAlpha : Number = 1;
		
		public function get bgAlpha() : Number {
			return _bgAlpha;
		}
		
		public function set bgAlpha( value : Number ) : void {
			_bgAlpha = value;
			resizeBG();
		}
		
		public function get bgColor() : int {
			return _bgColor;
		}
		
		public function set bgColor( value : int ) : void {
			_bgColor = value;
			if( bgColor >= 0 ) {
				resizeBG();
			} else {
				graphics.clear();
			}
		}
		
		private function resizeBG() : void {
			if( bgColor >= 0 ) {
				graphics.clear();
				graphics.beginFill( bgColor, bgAlpha );
				graphics.drawRect( 0, 0, width, height );
				graphics.endFill();
			}
		}
	}
}
