package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.uicomponents.supports.abstracts.AbstractSlider;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * @author Chin
	 */
	public class HSlider extends AbstractSlider {
		
		public static const Skin : String = "HSlider";
		
		public function HSlider() {
			super();
			initSkin();
		}
		
		override protected function get defaultWidth() : Number {
			return 150;
		}
		
		override protected function get defaultHeight() : Number {
			return 10;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		override protected function get bgLength() : Number {
			if( view && view.hasElement( Element_Bg )) {
				return view.element( Element_Bg ).width;
			}
			return 0;
		}
		
		override protected function get btnMousePosition() : Number {
			if( view && view.hasElement( Element_Btn )) {
				return view.element( Element_Btn ).mouseX;
			}
			return super.btnMousePosition;
		}
		
		override protected function onMouseMove( e : MouseEvent = null ) : void {
			var bgBar : DisplayObject = view.element( Element_Bg );
			if( bgBar ) {
				if( positive ) {
					model.valuePercent = ( bgBar.mouseX - mousePositionOffset ) / ( bgBar.width - _btnSize );
				} else {
					model.valuePercent = ( bgBar.width - bgBar.mouseX - mousePositionOffset ) / ( bgBar.width - _btnSize );
				}
			}
		}
		
		override public function get mousePositionValue() : Number {
			var bgBar : DisplayObject = view.element( Element_Bg );
			if( bgBar ) {
				if( positive ) {
					return model.percent2Value(( bgBar.mouseX - getMousePositionOffset()) / ( bgBar.width - _btnSize ));
				} else {
					return model.percent2Value(( bgBar.width - bgBar.mouseX - getMousePositionOffset()) / ( bgBar.width - _btnSize ));
				}
			}
			return 0;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
//			if( isNaN( _btnSize )) {
			if( view.hasElement( Element_Btn )) {
				_btnSize = view.element( Element_Btn ).width;
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
					
					var total : Number = bgBar.width - _btnSize;
					var w : Number = total * model.valuePercent;
					
					if( positive ) {
						if( btn ) {
							btn.x = w + bgBar.x;
							btn.width = _btnSize;
						}
						if( valueBar ) {
							valueBar.x = bgBar.x;
							valueBar.width = w + _btnSize / 2;
						}
					} else {
						var btnX : Number = total - w + bgBar.x;
						if( btn ) {
							btn.x = btnX;
							btn.width = _btnSize;
						}
						if( valueBar ) {
							valueBar.x = btnX + _btnSize / 2;
							valueBar.width = w + _btnSize / 2;
						}
					}
				}
			}
		}
	}
}
