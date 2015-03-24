package cn.chinuy.display.graphics.stroke {
	import cn.chinuy.display.graphics.pen.IPen;
	
	import flash.display.Graphics;
	import flash.display.IGraphicsStroke;
	
	/**
	 * @author chin
	 */
	public interface IStroke extends IGraphicsStroke {
		
		function apply( graphics : Graphics, width : Number, height : Number, pen : IPen, x : Number = 0, y : Number = 0 ) : void;
		
		function get fillX() : Number;
		
		function get fillY() : Number;
		
		function get fillWidth() : Number;
		
		function get fillHeight() : Number;
	
	}
}
