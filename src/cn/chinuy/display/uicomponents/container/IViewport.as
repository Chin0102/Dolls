package cn.chinuy.display.uicomponents.container {
	
	/**
	 * @author chin
	 */
	public interface IViewport extends IContainer {
		
		function measure() : void;
		
		function get contentWidth() : Number;
		function get contentHeight() : Number;
		
		function get clipAndEnableScrolling() : Boolean;
		function set clipAndEnableScrolling( value : Boolean ) : void;
		
		function get horizontalScrollPosition() : Number;
		function get verticalScrollPosition() : Number;
		
		function set horizontalScrollPosition( value : Number ) : void;
		function set verticalScrollPosition( value : Number ) : void;
	}
}
