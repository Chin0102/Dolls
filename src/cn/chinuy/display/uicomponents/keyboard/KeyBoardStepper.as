package cn.chinuy.display.uicomponents.keyboard {
	import cn.chinuy.display.uicomponents.model.SliderModel;
	
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	/**
	 * @author chin
	 */
	public class KeyBoardStepper extends EventDispatcher {
		
		private var lowerKey : uint;
		private var higherKey : uint;
		
		private var lowerOperate : Boolean;
		private var higherOperate : Boolean;
		
		private var operateFinish : Boolean;
		
		private var stepperModel : SliderModel;
		
		public function KeyBoardStepper( target : InteractiveObject, lowerKey : uint, higherKey : uint ) {
			model = new SliderModel();
			this.lowerKey = lowerKey;
			this.higherKey = higherKey;
			target.addEventListener( KeyboardEvent.KEY_DOWN, onKeyDown );
			target.addEventListener( KeyboardEvent.KEY_UP, onKeyUp );
		}
		
		public function get finish() : Boolean {
			return operateFinish;
		}
		
		public function get model() : SliderModel {
			return stepperModel;
		}
		
		public function set model( value : SliderModel ) : void {
			if( stepperModel ) {
				stepperModel.removeEventListener( Event.CHANGE, dispatchEvent );
			}
			stepperModel = value;
			stepperModel.addEventListener( Event.CHANGE, dispatchEvent );
		}
		
		protected function onKeyUp( event : KeyboardEvent ) : void {
			switch( event.keyCode ) {
				case lowerKey:
					lowerOperate = false;
					onOperate();
					break;
				
				case higherKey:
					higherOperate = false;
					onOperate();
					break;
			}
		}
		
		protected function onKeyDown( event : KeyboardEvent ) : void {
			switch( event.keyCode ) {
				case lowerKey:
					lowerOperate = true;
					onOperate();
					break;
				
				case higherKey:
					higherOperate = true;
					onOperate();
					break;
			}
		}
		
		private function onOperate() : void {
			if( lowerOperate && higherOperate ) {
				return;
			}
			operateFinish = !lowerOperate && !higherOperate;
			if( lowerOperate ) {
				model.lower();
			} else if( higherOperate ) {
				model.higher();
			}
		}
	}
}
