package cn.chinuy.display.uicomponents.list {
	import cn.chinuy.display.uicomponents.basic.Button;
	import cn.chinuy.display.uicomponents.text.Label;
	import cn.chinuy.display.uicomponents.text.RollLabel;
	
	/**
	 * @author chin
	 */
	public class LabelButtonItem extends Button implements IItem {
		
		public static const Skin : String = "LabelButtonItem";
		
		public static const Setting_Label_Default : Object = { left:0, right:0, vcenter:0 };
		
		private var _list : IList;
		
		public function LabelButtonItem( label : String, value : * = null ) {
			if( value == null ) {
				value = label;
			}
			super( label, value );
		}
		
		override protected function onMouseOverState() : void {
			super.onMouseOverState();
			var rollLabel : RollLabel = buttonLabel as RollLabel;
			rollLabel.roll( mouseOver );
		}
		
		override protected function createLabel() : Label {
			return new RollLabel();
		}
		
		override protected function get defaultWidth() : Number {
			return 100;
		}
		
		override protected function get defaultHeight() : Number {
			return 20;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		override protected function get defaultLabelSetting() : Object {
			return Setting_Label_Default;
		}
		
		public function set list( list : IList ) : void {
			_list = list;
		}
		
		public function get list() : IList {
			return _list;
		}
		
		public function get index() : int {
			if( list ) {
				return list.indexOf( this );
			}
			return -1;
		}
		
		public function remove() : void {
			if( list ) {
				list.remove( this );
			}
		}
		
		override public function toString() : String {
			return String( value );
		}
	
	}
}
