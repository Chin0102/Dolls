package cn.chinuy.display.graphics.fill {
	import flash.display.Graphics;
	import flash.display.IGraphicsFill;
	
	/**
	 * @author chin
	 */
	public interface IFill extends IGraphicsFill {
		
		function apply( graphics : Graphics, width : Number, height : Number ) : void;
	}
}
