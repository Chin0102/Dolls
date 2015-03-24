package cn.chinuy.display.uicore {
	
	/**
	 * @author chin
	 * <br><b>组件皮肤定义</b>
	 */
	public interface ISkin {
		
		function get name() : String;
		
		function create() : IUIView;
	}
}
