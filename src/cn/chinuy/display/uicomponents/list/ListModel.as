package cn.chinuy.display.uicomponents.list {
	
	/**
	 * @author chin
	 */
	public class ListModel implements IList {
		
		private var arr : Array = [];
		
		private var target : IList;
		
		public function ListModel( target : IList = null ) {
			if( target == null ) {
				target = this;
			}
			this.target = target;
		}
		
		public function get length() : int {
			return arr.length;
		}
		
		public function index( index : int ) : IItem {
			return arr[ index ];
		}
		
		public function indexOf( item : IItem ) : int {
			return arr.indexOf( item );
		}
		
		public function add( item : IItem, index : int = -1 ) : int {
			if( index == -1 ) {
				index = length;
			}
			item.list = target;
			arr.splice( index, 0, item );
			return index;
		}
		
		public function remove( item : IItem ) : int {
			var index : int = indexOf( item );
			if( index >= 0 ) {
				item.list = null;
				arr.splice( index, 1 );
			}
			return index;
		}
		
		public function removeAt( index : int ) : IItem {
			if( index >= 0 && index < length ) {
				var item : IItem = this.index( index );
				item.list = null;
				arr.splice( index, 1 );
				return item;
			}
			return null;
		}
		
		public function replaceAt( item : IItem, index : uint ) : IItem {
			if( index >= 0 && index < length ) {
				var old : IItem = removeAt( index );
				add( item, index );
				return old;
			}
			return null;
		}
		
		public function replace( oldItem : IItem, newItem : IItem ) : int {
			var index : int = remove( oldItem );
			if( index >= 0 ) {
				add( newItem, index );
			}
			return index;
		}
	
	}
}
