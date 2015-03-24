package cn.chinuy.display.graphics.pen {
	import flash.display.Graphics;
	import flash.display.IGraphicsFill;
	import flash.display.IGraphicsPath;
	import flash.display.IGraphicsStroke;
	
	/**
	 * @author chin
	 */
	public interface IPen extends IGraphicsPath {
		
		function draw( graphics : Graphics, stroke : IGraphicsStroke, fill : IGraphicsFill, width : Number, height : Number, x : Number = 0, y : Number = 0, applyStyle : Boolean = true, endFill : Boolean = true ) : void;
	
	}
}
