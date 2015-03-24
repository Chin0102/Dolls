package cn.chinuy.display.uicore {
	import cn.chinuy.display.UISprite;
	
	/**
	 * @author chin
	 */
	public interface IDisplaySource {
		
		function get name() : String;
		
		function create() : UISprite;
	}
}
