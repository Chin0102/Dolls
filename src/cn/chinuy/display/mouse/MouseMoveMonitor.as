package cn.chinuy.display.mouse {
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	 * @author Chin
	 */
	public class MouseMoveMonitor extends EventDispatcher implements IEventDispatcher {
		
		private var _timer : Timer;
		private var _target : DisplayObject;
		
		private var _callBackOnMoving : Boolean;
		private var _moving : Boolean = false;
		
		public function MouseMoveMonitor( target : DisplayObject, delay : int = 3000, callBackOnMoving : Boolean = true ) {
			_target = target;
			_timer = new Timer( delay );
			_timer.addEventListener( TimerEvent.TIMER, checkTime );
			this.callBackOnMoving = callBackOnMoving;
		}
		
		public function get callBackOnMoving() : Boolean {
			return _callBackOnMoving;
		}
		
		public function set callBackOnMoving( value : Boolean ) : void {
			_callBackOnMoving = value;
		}
		
		public function get delay() : int {
			return _timer.delay;
		}
		
		public function set delay( value : int ) : void {
			_timer.delay = value;
		}
		
		public function run() : void {
			_target.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_timer.start();
		}
		
		public function stop() : void {
			_target.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			_timer.stop();
		}
		
		public function get isMove() : Boolean {
			return _moving;
		}
		
		private function onMouseMove( e : MouseEvent ) : void {
			_timer.stop();
			var change : Boolean = !isMove;
			_moving = true;
			if( callBackOnMoving || change ) {
				callback();
			}
			_timer.start();
		}
		
		private function checkTime( e : TimerEvent ) : void {
			_timer.stop();
			_moving = false;
			callback();
		}
		
		private function callback() : void {
			dispatchEvent( new MouseEvent( MouseEvent.MOUSE_MOVE ));
		}
	}
}
