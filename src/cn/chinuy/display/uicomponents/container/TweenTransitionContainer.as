package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.uicomponents.supports.transition.TweenTransition;
	
	/**
	 * @author chin
	 */
	public class TweenTransitionContainer extends Container {
		
		private var tweenTransition : TweenTransition = new TweenTransition({}, {});
		
		public function TweenTransitionContainer() {
			super();
			transition = tweenTransition;
		}
		
		public function get negativeDuration() : int {
			return tweenTransition.negativeDuration;
		}
		
		public function set negativeDuration( value : int ) : void {
			tweenTransition.negativeDuration = value;
		}
		
		public function get negativeObj() : Object {
			return tweenTransition.negativeObj;
		}
		
		public function set negativeObj( value : Object ) : void {
			tweenTransition.negativeObj = value;
		}
		
		public function get positiveDuration() : int {
			return tweenTransition.positiveDuration;
		}
		
		public function set positiveDuration( value : int ) : void {
			tweenTransition.positiveDuration = value;
		}
		
		public function get positiveObj() : Object {
			return tweenTransition.positiveObj;
		}
		
		public function set positiveObj( value : Object ) : void {
			tweenTransition.positiveObj = value;
		}
	}
}
