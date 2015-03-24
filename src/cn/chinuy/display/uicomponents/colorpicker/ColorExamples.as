package cn.chinuy.display.uicomponents.colorpicker {
	import cn.chinuy.data.color.toColorString;
	import cn.chinuy.display.graphics.drawRect;
	import cn.chinuy.display.uicore.UIContainer;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class ColorExamples extends UIContainer implements IColorPanel {
		
		private var holder : Sprite = new Sprite();
		private var mark : Shape = new Shape();
		private var _color : int;
		private var _tempColor : int;
		
		public function ColorExamples( size : uint = 13, colorPreset : Array = null ) {
			super();
			
			if( colorPreset == null ) {
				colorPreset = [ "00", "33", "66", "99", "CC", "FF" ];
			}
			
			drawRect( mark.graphics, 0, 0, size + 1, size + 1, 0xFFFFFF );
			drawRect( holder.graphics, 0, 0, size * 18 + 1, size * 12 + 1 );
			holder.addChild( mark );
			for( var i : int = 0; i < 6; i++ ) {
				var r : String = colorPreset[ i ];
				var bx : Number = i % 3 * 6;
				var by : Number = int( i / 3 ) * 6;
				for( var j : int = 0; j < 6; j++ ) {
					var g : String = colorPreset[ j ];
					for( var k : int = 0; k < 6; k++ ) {
						var rgb : String = "0x" + r + g + colorPreset[ k ];
						var s : Sprite = new Sprite();
						s.name = rgb;
						drawRect( s.graphics, 0, 0, size - 1, size - 1, Number( rgb ));
						holder.addChild( s );
						s.x = ( bx + j ) * size + 1;
						s.y = ( by + k ) * size + 1;
					}
				}
			}
			
			tempColor = -1;
			color = -1;
			
			addChild( holder );
			holder.addEventListener( MouseEvent.ROLL_OVER, onMouseOver );
			holder.addEventListener( MouseEvent.ROLL_OUT, onMouseOut );
			holder.addEventListener( MouseEvent.CLICK, onClick );
		}
		
		protected function onClick( event : MouseEvent ) : void {
			var sprite : Sprite = event.target as Sprite;
			if( sprite && sprite.name.indexOf( "0x" ) == 0 ) {
				color = Number( sprite.name );
			}
		}
		
		protected function onMouseOut( event : MouseEvent ) : void {
			var sprite : Sprite = event.target as Sprite;
			if( sprite && sprite.name.indexOf( "0x" ) == 0 ) {
				tempColor = -1;
			}
		}
		
		protected function onMouseOver( event : MouseEvent ) : void {
			var sprite : Sprite = event.target as Sprite;
			if( sprite && sprite.name.indexOf( "0x" ) == 0 ) {
				tempColor = Number( sprite.name );
			}
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
					var hasTempColor : Boolean = tempColor >= 0;
					mark.visible = hasTempColor;
					if( hasTempColor ) {
						var t : DisplayObject = holder.getChildByName( toColorString( tempColor ));
						mark.x = t.x - 1;
						mark.y = t.y - 1;
					}
					dispatchEvent( new Event( Event.CHANGE ));
				}
			}
		}
	}
}
