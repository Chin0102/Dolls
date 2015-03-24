package cn.chinuy.display.uicomponents.list {
	
	/**
	 * @author chin
	 */
	public interface IList {
		
		function get length() : int;
		
		function index( index : int ) : IItem;
		
		function indexOf( item : IItem ) : int;
		
		function add( item : IItem, index : int = -1 ) : int;
		
		function remove( item : IItem ) : int;
		
		function removeAt( index : int ) : IItem;
		
		function replaceAt( item : IItem, index : uint ) : IItem;
		
		function replace( oldItem : IItem, newItem : IItem ) : int;
	
	}
}
