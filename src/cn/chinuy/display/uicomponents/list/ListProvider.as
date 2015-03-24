package cn.chinuy.display.uicomponents.list {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * @author chin
	 */
	public class ListProvider extends EventDispatcher {
		
		private var _data : *;
		
		public function ListProvider( listData : * = null ) {
			super();
			this.data = listData;
		}
		
		public function set data( value : * ) : void {
			_data = value;
		}
	}
}
