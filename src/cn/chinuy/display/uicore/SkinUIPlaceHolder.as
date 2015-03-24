package cn.chinuy.display.uicore {
	import flash.display.Sprite;
	
	/**
	 * @author chin
	 */
	public class SkinUIPlaceHolder extends Sprite {
		
		private var componentProperties : Object;
		
		public function SkinUIPlaceHolder( properties : Object ) {
			super();
			componentProperties = properties;
		}
		
		public function replace( component : UIComponent ) : void {
			if( componentProperties ) {
				for( var i : String in componentProperties ) {
					if( component.hasOwnProperty( i )) {
						component[ i ] = componentProperties[ i ];
					}
				}
			}
			if( parent ) {
				var index : int = parent.getChildIndex( this );
				parent.addChildAt( component, index );
				parent.removeChild( this );
			}
		}
	}
}
