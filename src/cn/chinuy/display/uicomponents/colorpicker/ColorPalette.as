package cn.chinuy.display.uicomponents.colorpicker {
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.display.BitmapData;
	import flash.display.GradientType;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	/**
	 * @author chin
	 */
	public class ColorPalette extends UIContainer implements IColorPanel {
		
		private var holder : Sprite = new Sprite();
		private var bd : BitmapData;
		private var _color : int;
		private var _tempColor : int;
		
		public function ColorPalette( w : Number = 235, h : Number = 157 ) {
			super();
			
			bd = new BitmapData( w, h );
			
			var c : Array = [ 0xFF0000, 0xFFFF00, 0x00FF00, 0x00FFFF, 0x0000FF, 0xFF00FF, 0xFF0000 ];
			var a : Array = [ 1, 1, 1, 1, 1, 1, 1 ];
			var r : Array = [ 0, int( 255 / 6 ), int( 255 / 6 * 2 ), int( 255 / 6 * 3 ), int( 255 / 6 * 4 ), int( 255 / 6 * 5 ), 255 ];
			var angle : Number = 0;
			var m : Matrix = new Matrix();
			m.createGradientBox( w, h, angle * Math.PI / 180 );
			var s1 : Sprite = new Sprite();
			s1.graphics.beginGradientFill( GradientType.LINEAR, c, a, r, m, SpreadMethod.PAD );
			s1.graphics.drawRect( 0, 0, w, h );
			s1.graphics.endFill();
			holder.addChild( s1 );
			
			h /= 2;
			angle = 90;
			c = [ 0xFFFFFF, 0xFFFFFF ];
			a = [ 1, 0 ];
			r = [ 0, 255 ];
			m = new Matrix();
			m.createGradientBox( w, h, angle * Math.PI / 180 );
			var s2 : Sprite = new Sprite();
			s2.graphics.beginGradientFill( GradientType.LINEAR, c, a, r, m, SpreadMethod.PAD );
			s2.graphics.drawRect( 0, 0, w, h );
			s2.graphics.endFill();
			holder.addChild( s2 );
			
			c = [ 0, 0 ];
			a = [ 0, 1 ];
			r = [ 0, 255 ];
			m = new Matrix();
			m.createGradientBox( w, h, angle * Math.PI / 180 );
			var s3 : Sprite = new Sprite();
			s3.graphics.beginGradientFill( GradientType.LINEAR, c, a, r, m, SpreadMethod.PAD );
			s3.graphics.drawRect( 0, 0, w, h );
			s3.graphics.endFill();
			s3.y = h;
			holder.addChild( s3 );
			
			tempColor = -1;
			color = -1;
			
			bd.draw( holder );
			addChild( holder );
			holder.addEventListener( MouseEvent.MOUSE_DOWN, onMouseDown );
			holder.addEventListener( MouseEvent.MOUSE_MOVE, onHolderMouseMove );
		}
		
		protected function onHolderMouseMove( event : MouseEvent ) : void {
			tempColor = getColor();
		}
		
		protected function onMouseDown( event : MouseEvent ) : void {
			holder.removeEventListener( MouseEvent.MOUSE_MOVE, onHolderMouseMove );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			stage.addEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			color = getColor();
		}
		
		protected function onMouseMove( event : MouseEvent ) : void {
			color = tempColor = getColor();
		}
		
		protected function onMouseUp( event : MouseEvent ) : void {
			holder.addEventListener( MouseEvent.MOUSE_MOVE, onHolderMouseMove );
			stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseUp );
			tempColor = -1;
		}
		
		protected function getColor() : int {
			var w : int = holder.width - 1;
			var h : int = holder.height;
			var mx : int = Math.max( 0, Math.min( w, holder.mouseX ));
			var my : int = Math.max( 0, Math.min( h, holder.mouseY ));
			return bd.getPixel( mx, my );
		}
		
		override protected function sizeRender() : void {
			holder.x = int(( width - holder.width ) / 2 );
			holder.y = int(( height - holder.height ) / 2 );
		}
		
		public function get color() : int {
			return _color;
		}
		
		public function set color( value : int ) : void {
			if( value >= -1 && value <= 0xFFFFFF ) {
				var changed : Boolean = _color != value;
				if( changed ) {
					_color = value;
					dispatchEvent( new Event( Event.SELECT ));
				}
			}
		}
		
		public function get tempColor() : int {
			return _tempColor;
		}
		
		public function set tempColor( value : int ) : void {
			if( value >= -1 && value <= 0xFFFFFF ) {
				var changed : Boolean = _tempColor != value;
				if( changed ) {
					_tempColor = value;
					dispatchEvent( new Event( Event.CHANGE ));
				}
			}
		}
	}
}
