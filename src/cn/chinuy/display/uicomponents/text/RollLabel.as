package cn.chinuy.display.uicomponents.text {
	import flash.display.Shape;
	import flash.events.TimerEvent;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	
	/**
	 * @author chin
	 */
	public class RollLabel extends Label {
		
		private var rollChecker : Timer;
		private var runTimer : Timer;
		
		private var fieldMinX : Number;
		private var fieldMaxX : Number = 0;
		private var positive : Boolean = true;
		
		private var speed : Number = 2;
		private var rollFlag : Boolean = false;
		
		private var fieldMask : Shape = new Shape();
		
		private var _rollDelay : Number = 300;
		
		public function RollLabel( text : String = "", autoSize : Boolean = true ) {
			super( text, false );
			field.autoSize = TextFieldAutoSize.LEFT;
			multiline = wordWrap = false;
			
			rollChecker = new Timer( rollDelay );
			rollChecker.addEventListener( TimerEvent.TIMER, checkMouseOver );
			
			runTimer = new Timer( 50 );
			runTimer.addEventListener( TimerEvent.TIMER, moveField );
			
			addChild( fieldMask );
		}
		
		public function get rollDelay() : Number {
			return _rollDelay;
		}
		
		public function set rollDelay( value : Number ) : void {
			_rollDelay = value;
			rollChecker.delay = rollDelay;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			field.mask = fieldMask;
		}
		
		override protected function updateDisplay() : void {
			fieldMinX = width - field.width;
			fieldMask.graphics.clear();
			fieldMask.graphics.beginFill( 0, 0 );
			fieldMask.graphics.drawRect( 0, 0, width, height );
			fieldMask.graphics.endFill();
		}
		
		public function roll( flag : Boolean ) : void {
			rollFlag = flag;
			if( rollFlag ) {
				if( fieldMinX < 0 ) {
					rollChecker.stop();
					rollChecker.start();
				}
			} else {
				if( rollChecker.running ) {
					rollChecker.stop();
				}
				if( runTimer.running ) {
					runTimer.stop();
					field.x = fieldMaxX;
					positive = true;
				}
			}
		}
		
		override protected function onMouseOverState() : void {
			super.onMouseOverState();
			roll( mouseOver );
		}
		
		private function checkMouseOver( event : TimerEvent ) : void {
			if( rollFlag ) {
				runTimer.start();
			}
		}
		
		private function moveField( event : TimerEvent ) : void {
			if( positive ) {
				if( field.x > fieldMinX ) {
					field.x -= speed;
				}
				if( field.x <= fieldMinX ) {
					positive = false;
				}
			} else {
				if( field.x < fieldMaxX ) {
					field.x += speed;
				}
				if( field.x >= fieldMaxX ) {
					positive = true;
				}
			}
		}
	}
}
