package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.uicomponents.supports.boxes.Box;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class Viewport extends Container implements IViewport {
		
		public static const ContentResize : String = "ContentResize";
		
		protected var scroller : Scroller = new Scroller();
		protected var box : Box;
		
		public function Viewport() {
			super();
			clipAndEnableScrolling = true;
			initBox();
			box.addEventListener( ContentResize, dispatchEvent );
			innerContainer.addChild( box );
		}
		
		protected function initBox() : void {
			box = new Box();
		}
		
		public function get scrollerEnable() : Boolean {
			return scroller.parent == this;
		}
		
		public function set scrollerEnable( value : Boolean ) : void {
			if( scrollerEnable != value ) {
				if( value ) {
					updateScrollerSize();
					scroller.viewport = this;
					superAddChild( scroller );
				} else {
					superRemoveChild( scroller );
					scroller.viewport = null;
				}
			}
		}
		
		override protected function onInnerContainerResize( event : Event ) : void {
			super.onInnerContainerResize( event );
			updateScrollerSize();
		}
		
		protected function updateScrollerSize() : void {
			scroller.x = innerContainer.x;
			scroller.y = innerContainer.y;
			scroller.width = containerWidth;
			scroller.height = containerHeight;
		}
		
		override public function addChild( child : DisplayObject ) : DisplayObject {
			return box.addChild( child );
		}
		
		override public function addChildAt( child : DisplayObject, index : int ) : DisplayObject {
			return box.addChildAt( child, index );
		}
		
		override public function removeChild( child : DisplayObject ) : DisplayObject {
			return box.removeChild( child );
		}
		
		override public function removeChildAt( index : int ) : DisplayObject {
			return box.removeChildAt( index );
		}
		
		override public function get numChildren() : int {
			return box.numChildren;
		}
		
		override public function getChildAt( index : int ) : DisplayObject {
			return box.getChildAt( index );
		}
		
		override public function getChildByName( name : String ) : DisplayObject {
			return box.getChildByName( name );
		}
		
		public function measure() : void {
			box.measure();
		}
		
		public function get contentWidth() : Number {
			return box.width;
		}
		
		public function get contentHeight() : Number {
			return box.height;
		}
		
		public function get horizontalScrollPosition() : Number {
			return box.x;
		}
		
		public function get verticalScrollPosition() : Number {
			return box.y;
		}
		
		public function set horizontalScrollPosition( value : Number ) : void {
			box.x = value;
		}
		
		public function set verticalScrollPosition( value : Number ) : void {
			box.y = value;
		}
	}
}
