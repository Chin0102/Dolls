package cn.chinuy.display.graphics {
	import flash.display.Graphics;
	
	/**
	 * @author Chin
	 */
	public function drawRect( graphics : Graphics, x : int, y : int, w : int, h : int, color : int = 0, alpha : Number = 1, clear : Boolean = false ) : void {
		if( clear )
			graphics.clear();
		graphics.beginFill( color, alpha );
		graphics.drawRect( x, y, w, h );
		graphics.endFill();
	}
}
