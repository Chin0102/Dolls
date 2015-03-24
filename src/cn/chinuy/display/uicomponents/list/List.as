package cn.chinuy.display.uicomponents.list {
	import cn.chinuy.display.UISprite;
	import cn.chinuy.display.uicomponents.basic.VScrollBar;
	import cn.chinuy.display.uicomponents.container.VGroup;
	import cn.chinuy.display.uicore.UIComponent;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class List extends UIComponent implements IList {
		
		public static const Skin : String = "List";
		
		public static const Component_VScrollBar : String = "VScrollBar";
		
		public static const Setting_Box : String = "BoxSetting";
		public static const Setting_Box_Default : Object = { margin:[ 0, 0, 10, 0 ]};
		
		private var _model : ListModel;
		
		private var _vscrollBar : VScrollBar;
		private var _vbox : VGroup;
		private var _selected : IItem;
		
		private var _lastAction : String;
		private var _lastIndex : int;
		private var _lastItem : IItem;
		
		public function List() {
			super();
			initSkin();
		}
		
		public function get lastItem() : IItem {
			return _lastItem;
		}
		
		public function get lastIndex() : int {
			return _lastIndex;
		}
		
		public function get lastAction() : String {
			return _lastAction;
		}
		
		public function get model() : ListModel {
			if( _model == null ) {
				_model = new ListModel( this );
			}
			return _model;
		}
		
		public function get box() : VGroup {
			if( _vbox == null ) {
				_vbox = new VGroup();
				_vbox.addEventListener( Event.RESIZE, onBoxContainerResize );
				addChild( _vbox );
			}
			return _vbox;
		}
		
		private function onMouseWheel( event : MouseEvent ) : void {
			vscrollBar.value -= event.delta;
		}
		
		public function get vscrollBar() : VScrollBar {
			if( _vscrollBar == null ) {
				_vscrollBar = new VScrollBar();
				_vscrollBar.addEventListener( Event.CHANGE, onVScrollBarChanged );
			}
			return _vscrollBar;
		}
		
		public function set selected( value : IItem ) : void {
			if( _selected && _selected.displayObject.hasOwnProperty( "selected" )) {
				_selected.displayObject[ "selected" ] = false;
			}
			_selected = value;
			if( _selected.displayObject.hasOwnProperty( "selected" )) {
				_selected.displayObject[ "selected" ] = true;
			}
		}
		
		public function get selected() : IItem {
			return _selected;
		}
		
		override protected function get defaultWidth() : Number {
			return 100;
		}
		
		override protected function get defaultHeight() : Number {
			return 100;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		protected function get defaultBoxSetting() : Object {
			return Setting_Box_Default;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.addComponent( Component_VScrollBar, vscrollBar );
			view.applySetting( box, Setting_Box, defaultBoxSetting );
		}
		
		private function onBoxContainerResize( event : Event ) : void {
			box.measure();
			updateVscrollBar();
		}
		
		protected function updateVscrollBar() : void {
			vscrollBar.model.viewSize = box.containerHeight;
			vscrollBar.model.contentSize = box.contentHeight;
		}
		
		protected function onVScrollBarChanged( event : Event ) : void {
			box.verticalScrollPosition = -vscrollBar.value;
		}
		
		public function get length() : int {
			return model.length;
		}
		
		public function index( index : int ) : IItem {
			return model.index( index );
		}
		
		public function indexOf( item : IItem ) : int {
			return model.indexOf( item );
		}
		
		public function add( item : IItem, index : int = -1 ) : int {
			index = model.add( item, index );
			if( index >= 0 ) {
				onItemAdded( index, item );
			}
			return index;
		}
		
		public function remove( item : IItem ) : int {
			var index : int = model.remove( item );
			if( index >= 0 ) {
				onItemRemoved( index, item );
			}
			return index;
		}
		
		public function removeAt( index : int ) : IItem {
			var item : IItem = model.removeAt( index );
			if( index >= 0 ) {
				onItemRemoved( index, item );
			}
			return item;
		}
		
		public function replaceAt( item : IItem, index : uint ) : IItem {
			var oldItem : IItem = model.replaceAt( item, index );
			if( oldItem ) {
				onItemRemoved( index, oldItem );
				onItemAdded( index, item );
			}
			return oldItem;
		}
		
		public function replace( oldItem : IItem, newItem : IItem ) : int {
			var index : int = model.replace( oldItem, newItem );
			if( index >= 0 ) {
				onItemRemoved( index, oldItem );
				onItemAdded( index, newItem );
			}
			return index;
		}
		
		protected function onItemAdded( index : int, item : IItem ) : void {
			item.displayObject.addEventListener( MouseEvent.CLICK, onItemClick );
			box.addChildAt( item.displayObject, index );
			var layoutAble : UISprite = item.displayObject as UISprite;
			if( layoutAble ) {
				layoutAble.left = 0;
				layoutAble.right = 0;
			}
			updateVscrollBar();
			_lastAction = Event.ADDED;
			_lastIndex = index;
			_lastItem = item;
			dispatchEvent( new Event( Event.CHANGE ));
		}
		
		protected function onItemRemoved( index : int, item : IItem ) : void {
			item.displayObject.removeEventListener( MouseEvent.CLICK, onItemClick );
			box.removeChildAt( index );
			updateVscrollBar();
			_lastAction = Event.REMOVED;
			_lastIndex = index;
			_lastItem = item;
			dispatchEvent( new Event( Event.CHANGE ));
		}
		
		protected function onItemClick( event : Event ) : void {
			var item : IItem = event.target as IItem;
			if( item ) {
				selected = item;
				_lastAction = Event.SELECT;
				_lastIndex = indexOf( item );
				_lastItem = item;
				dispatchEvent( new Event( Event.CHANGE ));
			}
		}
	}
}
