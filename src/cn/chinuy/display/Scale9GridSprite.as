package cn.chinuy.display {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * @author chin
	 */
	public class Scale9GridSprite extends UISprite {
		
		private var map : Array = [];
		private var source : BitmapData;
		
		private var leftWidth : int;
		private var rightWidth : int;
		private var topHeight : int;
		private var bottomHeight : int;
		
		public static function create( displayObject : DisplayObject ) : UISprite {
			if( displayObject.scale9Grid ) {
				return new Scale9GridSprite( displayObject, displayObject.scale9Grid );
			} else {
				var sprite : UISprite = new UISprite();
				sprite.width = displayObject.width;
				sprite.height = displayObject.height;
				sprite.addChild( displayObject );
				return sprite;
			}
		}
		
		public function Scale9GridSprite( target : DisplayObject, rectangle : Rectangle ) {
			super();
			
			this.filters = target.filters;
			
			var w : Number = target.width;
			var h : Number = target.height;
			
			if( rectangle.width < 1 ) {
				rectangle.inflate( 1 - rectangle.width, 0 );
			}
			
			if( rectangle.height < 1 ) {
				rectangle.inflate( 0, 1 - rectangle.height );
			}
			
			if( rectangle.x < 1 ) {
				rectangle.offset( 1 - rectangle.x, 0 );
			}
			
			if( rectangle.y < 1 ) {
				rectangle.offset( 0, 1 - rectangle.y );
			}
			
			if( rectangle.right + 1 > w ) {
				rectangle.offset( w - 1 - rectangle.right, 0 );
			}
			
			if( rectangle.bottom + 1 > h ) {
				rectangle.offset( 0, h - 1 - rectangle.bottom );
			}
			
			var x1 : int = Math.max( 1, rectangle.x );
			var y1 : int = Math.max( 1, rectangle.y );
			var x2 : int = Math.min( w - 1, rectangle.right );
			var y2 : int = Math.min( h - 1, rectangle.bottom );
			
			source = new BitmapData( w, h, true, 0 );
			source.draw( target );
			
			leftWidth = x1;
			rightWidth = w - x2;
			topHeight = y1;
			bottomHeight = h - y2;
			
			map[ 0 ] = getBitmap( 0, 0, x1, y1 );
			map[ 1 ] = getBitmap( x1, 0, x2 - x1, y1 );
			map[ 2 ] = getBitmap( x2, 0, rightWidth, y1 );
			
			map[ 3 ] = getBitmap( 0, y1, x1, y2 - y1 );
			map[ 4 ] = getBitmap( x1, y1, x2 - x1, y2 - y1 );
			map[ 5 ] = getBitmap( x2, y1, rightWidth, y2 - y1 );
			
			map[ 6 ] = getBitmap( 0, y2, x1, bottomHeight );
			map[ 7 ] = getBitmap( x1, y2, x2 - x1, bottomHeight );
			map[ 8 ] = getBitmap( x2, y2, rightWidth, bottomHeight );
		}
		
		override protected function sizeRender() : void {
			
			var rightX : int = width - rightWidth;
			var midWidth : int = rightX - leftWidth;
			
			var hasWidth : Boolean = midWidth > 0;
			if( hasWidth ) {
				bitmap( 1 ).width = midWidth;
				bitmap( 4 ).width = midWidth;
				bitmap( 7 ).width = midWidth;
			}
			bitmap( 2 ).x = rightX;
			bitmap( 5 ).x = rightX;
			bitmap( 8 ).x = rightX;
			
			var bottomY : int = height - bottomHeight;
			var midHeight : int = bottomY - topHeight;
			
			var hasHeight : Boolean = midHeight > 0;
			if( hasHeight ) {
				bitmap( 3 ).height = midHeight;
				bitmap( 4 ).height = midHeight;
				bitmap( 5 ).height = midHeight;
			}
			
			bitmap( 1 ).visible = hasWidth;
			bitmap( 7 ).visible = hasWidth;
			
			bitmap( 3 ).visible = hasHeight;
			bitmap( 5 ).visible = hasHeight;
			
			bitmap( 4 ).visible = hasWidth && hasHeight;
			
			bitmap( 6 ).y = bottomY;
			bitmap( 7 ).y = bottomY;
			bitmap( 8 ).y = bottomY;
		}
		
		protected function bitmap( i : int ) : Bitmap {
			return map[ i ];
		}
		
		protected function getBitmap( x : int, y : int, width : int, height : int ) : DisplayObject {
			if( width <= 0 || height <= 0 ) {
				return null;
			}
			var bitmapData : BitmapData = new BitmapData( width, height, true, 0 );
			bitmapData.copyPixels( source, new Rectangle( x, y, width, height ), new Point( 0, 0 ), null, null, true );
			var bitmap : Bitmap = new Bitmap( bitmapData );
			bitmap.x = x;
			bitmap.y = y;
			this.addChild( bitmap );
			return bitmap;
		}
	}
}
