package cn.chinuy.display.uicomponents.supports.transition {
	import cn.chinuy.display.uicomponents.supports.transition.ITransitable;
	import cn.chinuy.display.uicomponents.supports.transition.ITransition;
	import cn.chinuy.display.uicomponents.supports.transition.TransitionEvent;
	import cn.chinuy.tween.Tween;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class TweenTransition extends EventDispatcher implements ITransition {
		
		protected var tween : Tween = new Tween();
		
		private var _positiveObj : Object;
		private var _positiveDuration : int;
		private var _negativeObj : Object;
		private var _negativeDuration : int;
		private var _invisibleOnClose : Boolean;
		
		private var target : ITransitable;
		private var positive : Boolean;
		
		public function TweenTransition( positiveObj : Object, negativeObj : Object, positiveDuraion : int = 150, negativeDuration : int = 150, invisibleOnClose : Boolean = true ) {
			super();
			this.positiveObj = positiveObj;
			this.negativeObj = negativeObj;
			this.positiveDuration = positiveDuraion;
			this.negativeDuration = negativeDuration;
			this.invisibleOnClose = invisibleOnClose;
		}
		
		public function get invisibleOnClose() : Boolean {
			return _invisibleOnClose;
		}
		
		public function set invisibleOnClose( value : Boolean ) : void {
			_invisibleOnClose = value;
		}
		
		public function get negativeDuration() : int {
			return _negativeDuration;
		}
		
		public function set negativeDuration( value : int ) : void {
			_negativeDuration = value;
		}
		
		public function get negativeObj() : Object {
			return _negativeObj;
		}
		
		public function set negativeObj( value : Object ) : void {
			_negativeObj = value;
		}
		
		public function get positiveDuration() : int {
			return _positiveDuration;
		}
		
		public function set positiveDuration( value : int ) : void {
			_positiveDuration = value;
		}
		
		public function get positiveObj() : Object {
			return _positiveObj;
		}
		
		public function set positiveObj( value : Object ) : void {
			_positiveObj = value;
		}
		
		protected function onFinish( event : Event ) : void {
			dispatchEvent( new TransitionEvent( TransitionEvent.End, positive ));
			if( invisibleOnClose && !positive ) {
				target.displayObject.visible = false;
			}
		}
		
		public function start( target : ITransitable, positive : Boolean ) : void {
			this.target = target;
			this.positive = positive;
			dispatchEvent( new TransitionEvent( TransitionEvent.Start, positive ));
			if( tween.running ) {
				tween.removeEventListener( Tween.Finish, onFinish );
				tween.finish();
			}
			if( positive ) {
				target.displayObject.visible = true;
				tween.begin( target.displayObject, positiveObj, positiveDuration );
			} else {
				tween.begin( target.displayObject, negativeObj, negativeDuration );
			}
			tween.addEventListener( Tween.Finish, onFinish );
		}
	}
}
