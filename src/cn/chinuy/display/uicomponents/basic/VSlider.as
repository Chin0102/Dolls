package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.uicomponents.supports.abstracts.AbstractSlider;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class VSlider extends AbstractSlider {
		
		public static const Skin : String = "VSlider";
		
		public function VSlider() {
			super();
			initSkin();
		}
		
		override protected function get defaultWidth() : Number {
			return 10;
		}
		
		override protected function get defaultHeight() : Number {
			return 150;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		override protected function get bgLength() : Number {
			if( view && view.hasElement( Element_Bg )) {
				return view.element( Element_Bg ).height;
			}
			return 0;
		}
		
		override protected function get btnMousePosition() : Number {
			if( view && view.hasElement( Element_Btn )) {
				return view.element( Element_Btn ).mouseY;
			}
			return super.btnMousePosition;
		}
		
		override protected function onMouseMove( e : MouseEvent = null ) : void {
			var bgBar : DisplayObject = view.element( Element_Bg );
			if( bgBar ) {
				if( positive ) {
					model.valuePercent = ( bgBar.mouseY - mousePositionOffset ) / ( bgBar.height - _btnSize );
				} else {
					model.valuePercent = ( bgBar.height - bgBar.mouseY - mousePositionOffset ) / ( bgBar.height - _btnSize );
				}
			}
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
//			if( isNaN( _btnSize )) {
			if( view.hasElement( Element_Btn )) {
				_btnSize = view.element( Element_Btn ).height;
			} else {
				_btnSize = 0;
			}
//			}
		}
		
		override protected function updateDisplay() : void {
			if( view ) {
				var bgBar : DisplayObject = view.element( Element_Bg );
				if( bgBar ) {
					var btn : DisplayObject = view.element( Element_Btn );
					var valueBar : DisplayObject = view.element( Element_Bar );
					
					var total : Number = bgBar.height - _btnSize;
					var h : Number = total * model.valuePercent;
					
					if( positive ) {
						if( btn ) {
							btn.y = h + bgBar.y;
							btn.height = _btnSize;
						}
						if( valueBar ) {
							valueBar.y = bgBar.y;
							valueBar.height = h + _btnSize / 2;
						}
					} else {
						var btnY : Number = total - h + bgBar.y;
						if( btn ) {
							btn.y = btnY;
							btn.height = _btnSize;
						}
						if( valueBar ) {
							valueBar.y = btnY + _btnSize / 2;
							valueBar.height = h + _btnSize / 2;
						}
					}
				}
			}
		}
	}
}
