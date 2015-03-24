package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.uicore.UIComponent;
	
	/**
	 * @author chin
	 */
	public class BaseButton extends UIComponent {
		
		public static const State_Disabled : String = "DisabledState";
		public static const State_Normal : String = "NormalState";
		public static const State_Over : String = "OverState";
		public static const State_Down : String = "DownState";
		public static const State_SelectedNormal : String = "SelectedNormalState";
		public static const State_SelectedOver : String = "SelectedOverState";
		public static const State_SelectedDown : String = "SelectedDownState";
		
		private static const States : Array = [ State_Disabled,
												State_Normal,
												State_Over,
												State_Down,
												State_SelectedNormal,
												State_SelectedOver,
												State_SelectedDown ];
		
		protected var stateOrder : Array;
		private var selectedValue : Boolean;
		private var _buttonMode : Boolean;
		
		public function BaseButton() {
			super();
			buttonMode = true;
		}
		
		override public function get buttonMode() : Boolean {
			return _buttonMode;
		}
		
		override public function set buttonMode( value : Boolean ) : void {
			super.buttonMode = _buttonMode = value;
		}
		
		override protected function get defaultWidth() : Number {
			return 60;
		}
		
		override protected function get defaultHeight() : Number {
			return 20;
		}
		
		override protected function get defaultMouseChildren() : Boolean {
			return false;
		}
		
		public function get selected() : Boolean {
			return selectedValue;
		}
		
		public function set selected( value : Boolean ) : void {
			selectedValue = value;
			updateState();
		}
		
		override public function set enabled( value : Boolean ) : void {
			super.enabled = value;
			super.buttonMode = value && buttonMode;
			updateState();
		}
		
		override protected function onMouseOverState() : void {
			super.onMouseOverState();
			if( !mouseDown ) {
				updateState();
			}
		}
		
		override protected function onMouseDownState() : void {
			if( mouseOver || !mouseDown ) {
				updateState();
			}
		}
		
		protected function updateState() : void {
			var si : int;
			var dsi : int = 1;
			if( enabled ) {
				si = mouseDown ? 3 : ( mouseOver ? 2 : 1 );
				if( selected ) {
					si += 3;
					dsi += 3;
				}
			}
			stateOrder = [ States[ si ], States[ dsi ], State_Normal ];
			if( view ) {
				view.setState.apply( this, stateOrder );
			}
		}
		
		override protected function updateDisplay() : void {
			updateState();
		}
	
	}
}
