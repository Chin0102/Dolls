package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.layout.AutoSizeModel;
	import cn.chinuy.display.uicomponents.list.LabelButtonItem;
	import cn.chinuy.display.uicomponents.list.List;
	import cn.chinuy.display.uicomponents.text.Label;
	import cn.chinuy.display.uicomponents.text.RollLabel;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * @author chin
	 */
	public class ComboBox extends LabelButton {
		
		public static const Direction_Auto : int = 0;
		public static const Direction_Up : int = 1;
		public static const Direction_Bottom : int = 2;
		
		public static const Skin : String = "ComboBox";
		
		public static const Setting_Label_Default : Object = { color:0, size:12 };
		
		public static const Setting_ItemGroup : String = "ComboBoxItemGroup";
		public static const Setting_ItemGroup_Default : Object = { height:100 };
		
		public static const Setting_Item : String = "ComboBoxItem";
		public static const Setting_Item_Default : Object = { left:0, right:0 };
		
		private var listAnchorPoint : Point = new Point();
		private var listVisible : Boolean = false;
		private var list : List = new List();
		
		private var _direction : int;
		
		private var selfClickFlag : Boolean;
		
		public function ComboBox() {
			super();
			addEventListener( MouseEvent.CLICK, onSelfClick );
			list.addEventListener( Event.CHANGE, onListDataChange );
		}
		
		override protected function onMouseOverState() : void {
			super.onMouseOverState();
			var rollLabel : RollLabel = buttonLabel as RollLabel;
			rollLabel.roll( mouseOver );
		}
		
		override protected function createLabel() : Label {
			return new RollLabel();
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		override protected function get defaultWidth() : Number {
			return 100;
		}
		
		override protected function get defaultHeight() : Number {
			return 30;
		}
		
//		override protected function get defaultLabelSetting() : Object {
//			return Setting_Label_Default;
//		}
		
		protected function get defaultItemSetting() : Object {
			return Setting_Item_Default;
		}
		
		protected function get defaultItemGroupSetting() : Object {
			return Setting_ItemGroup_Default;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.applySetting( list, Setting_ItemGroup, defaultItemGroupSetting );
		}
		
		override protected function sizeRender() : void {
			list.width = width;
			listAnchorPoint.y = height;
			if( listVisible ) {
				updateGroupPos();
			}
		}
		
		public function get direction() : int {
			return _direction;
		}
		
		public function set direction( value : int ) : void {
			_direction = value;
		}
		
		override public function set label( value : String ) : void {
		}
		
		override public function set value( value : * ) : void {
		}
		
		final protected function set superLabel( value : String ) : void {
			super.label = value;
		}
		
		final protected function set superValue( value : * ) : void {
			super.value = value;
		}
		
		public function get numItems() : int {
			return list.length;
		}
		
		public function removeItemAt( index : int ) : void {
			list.removeAt( index );
		}
		
		public function addItem( label : String, value : *, select : Boolean = false ) : void {
			var item : LabelButtonItem = new LabelButtonItem( label, value );
			view.applySetting( item, Setting_Item, Setting_Item_Default );
			list.add( item );
			if( select ) {
				list.selected = item;
				selectItem( item );
			}
		}
		
		private function onListDataChange( event : Event ) : void {
			if( list.lastAction == Event.SELECT ) {
				selectItem( list.selected as LabelButtonItem );
			}
		}
		
		private function onSelfClick( event : MouseEvent ) : void {
			selfClickFlag = true;
			displayList( !listVisible );
		}
		
		private function onStageMouseUp( event : MouseEvent ) : void {
			if( selfClickFlag ) {
				selfClickFlag = false;
			} else {
				displayList( false );
			}
		}
		
		protected function selectItem( item : LabelButtonItem ) : void {
			superLabel = item.label;
			superValue = item.value;
			dispatchEvent( new Event( Event.CHANGE ));
		}
		
		protected function displayList( flag : Boolean ) : void {
			var change : Boolean = flag != listVisible;
			if( change ) {
				if( flag ) {
					updateGroupPos();
					listVisible = true;
					stage.addChild( list );
					stage.addEventListener( MouseEvent.MOUSE_UP, onStageMouseUp );
				} else {
					stage.removeEventListener( MouseEvent.MOUSE_UP, onStageMouseUp );
					stage.removeChild( list );
					listVisible = false;
				}
			}
		}
		
		protected function updateGroupPos() : void {
			var p : Point = localToGlobal( listAnchorPoint );
			list.x = p.x;
			var bottom : Boolean = direction == Direction_Bottom || list.height + p.y <= stage.stageHeight;
			if( bottom ) {
				list.y = p.y;
			} else {
				list.y = p.y - list.height - height;
			}
		}
	}
}
