package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.uicomponents.events.ContainerEvent;
	import cn.chinuy.display.uicomponents.supports.transition.ITransitable;
	import cn.chinuy.display.uicomponents.supports.transition.ITransition;
	import cn.chinuy.display.uicomponents.supports.transition.TransitionEvent;
	import cn.chinuy.display.uicomponents.supports.transition.VisibleTransition;
	import cn.chinuy.display.uicore.UIComponent;
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.events.Event;
	
	/**
	 * @author chin
	 */
	public class Container extends UIComponent implements IContainer, ITransitable {
		
		public static const Resize : String = "ContainerResize";
		
		private var _innerContainer : UIContainer;
		private var _transition : ITransition;
		private var _isDisplay : Boolean = true;
		
		private var _mask : Shape;
		private var _maskEnabled : Boolean;
		
		public function Container() {
			transition = newTransition();
			super();
			superAddChild( innerContainer );
			lPadding = rPadding = tPadding = bPadding = 0;
		}
		
		public function get clipAndEnableScrolling() : Boolean {
			return _maskEnabled;
		}
		
		public function set clipAndEnableScrolling( value : Boolean ) : void {
			var changed : Boolean = clipAndEnableScrolling != value;
			if( changed ) {
				_maskEnabled = value;
				if( clipAndEnableScrolling ) {
					innerContainer.addEventListener( Event.RESIZE, onInnerContainerResize );
					updateMaskSize();
					innerContainer.mask = thisMask;
					superAddChild( thisMask );
				} else {
					innerContainer.removeEventListener( Event.RESIZE, onInnerContainerResize );
					superRemoveChild( thisMask );
					innerContainer.mask = null;
				}
			}
		}
		
		protected function get thisMask() : Shape {
			if( _mask == null ) {
				_mask = new Shape();
			}
			return _mask;
		}
		
		protected function onInnerContainerResize( event : Event ) : void {
			updateMaskSize();
			dispatchEvent( new Event( Resize ));
		}
		
		protected function updateMaskSize() : void {
			thisMask.x = innerContainer.x;
			thisMask.y = innerContainer.y;
			thisMask.graphics.clear();
			thisMask.graphics.beginFill( 0, 0 );
			thisMask.graphics.drawRect( 0, 0, containerWidth, containerHeight );
			thisMask.graphics.endFill();
		}
		
		protected function get innerContainer() : UIContainer {
			if( _innerContainer == null ) {
				_innerContainer = new UIContainer();
			}
			return _innerContainer;
		}
		
		protected function newTransition() : ITransition {
			return new VisibleTransition();
		}
		
		public function get transition() : ITransition {
			return _transition;
		}
		
		public function set transition( value : ITransition ) : void {
			if( value == null )
				return;
			
			if( _transition ) {
				_transition.removeEventListener( TransitionEvent.Start, onTransitionStart );
				_transition.removeEventListener( TransitionEvent.End, onTransitionEnd );
			}
			_transition = value;
			_transition.addEventListener( TransitionEvent.Start, onTransitionStart );
			_transition.addEventListener( TransitionEvent.End, onTransitionEnd );
		}
		
		protected function onTransitionStart( event : TransitionEvent ) : void {
			dispatchEvent( new ContainerEvent( event.positive ? ContainerEvent.PreDisplay : ContainerEvent.PreClose ));
		}
		
		protected function onTransitionEnd( event : TransitionEvent ) : void {
			dispatchEvent( new ContainerEvent( event.positive ? ContainerEvent.Display : ContainerEvent.Close ));
		}
		
		public function get isDisplay() : Boolean {
			return _isDisplay;
		}
		
		override public function set enabled( value : Boolean ) : void {
			super.enabled = value;
			if( enabled ) {
				display();
			} else {
				close();
			}
		}
		
		public function display() : void {
			if( enabled ) {
				_isDisplay = true;
				transition.start( this, true );
			}
		}
		
		public function close() : void {
			_isDisplay = false;
			transition.start( this, false );
		}
		
		public function get containerWidth() : Number {
			return innerContainer.width;
		}
		
		public function get containerHeight() : Number {
			return innerContainer.height;
		}
		
		override public function contains( child : DisplayObject ) : Boolean {
			return innerContainer.contains( child );
		}
		
		override public function get numChildren() : int {
			return innerContainer.numChildren;
		}
		
		override public function getChildAt( index : int ) : DisplayObject {
			return innerContainer.getChildAt( index );
		}
		
		override public function getChildByName( name : String ) : DisplayObject {
			return innerContainer.getChildByName( name );
		}
		
		override public function addChild( child : DisplayObject ) : DisplayObject {
			return innerContainer.addChild( child );
		}
		
		override public function addChildAt( child : DisplayObject, index : int ) : DisplayObject {
			return innerContainer.addChildAt( child, index );
		}
		
		override public function removeChild( child : DisplayObject ) : DisplayObject {
			return innerContainer.removeChild( child );
		}
		
		override public function removeChildAt( index : int ) : DisplayObject {
			return innerContainer.removeChildAt( index );
		}
		
		public function get lPadding() : Number {
			return innerContainer.left;
		}
		
		public function set lPadding( value : Number ) : void {
			innerContainer.left = value;
		}
		
		public function get rPadding() : Number {
			return innerContainer.right;
		}
		
		public function set rPadding( value : Number ) : void {
			innerContainer.right = value;
		}
		
		public function get tPadding() : Number {
			return innerContainer.top;
		}
		
		public function set tPadding( value : Number ) : void {
			innerContainer.top = value;
		}
		
		public function get bPadding() : Number {
			return innerContainer.bottom;
		}
		
		public function set bPadding( value : Number ) : void {
			innerContainer.bottom = value;
		}
	}
}
