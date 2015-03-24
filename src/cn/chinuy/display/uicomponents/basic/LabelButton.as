package cn.chinuy.display.uicomponents.basic {
	import cn.chinuy.display.layout.AutoSizeModel;
	
	/**
	 * @author chin
	 */
	public class LabelButton extends Button {
		
		public static const Skin : String = "LabelButton";
		public static const Setting_Label_Default : Object = { size:12, color:0xCCCCCC };
		
		protected var _autoSizeModel : AutoSizeModel;
		
		public function LabelButton( label : String = "" ) {
			super( label );
			autoSizeModel.sizeBy( labelText, false );
		}
		
		override protected function get defaultLabelSetting() : Object {
			return Setting_Label_Default;
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		protected function get autoSizeModel() : AutoSizeModel {
			if( _autoSizeModel == null ) {
				_autoSizeModel = new AutoSizeModel();
				_autoSizeModel.target( this );
			}
			return _autoSizeModel;
		}
		
		public function get autoSize() : Boolean {
			return autoSizeModel.enable;
		}
		
		public function set autoSize( value : Boolean ) : void {
			autoSizeModel.enable = value;
		}
		
		public function set padding( value : Number ) : void {
			autoSizeModel.padding = value;
		}
		
		public function get bPadding() : Number {
			return autoSizeModel.bPadding;
		}
		
		public function set bPadding( value : Number ) : void {
			autoSizeModel.bPadding = value;
		}
		
		public function get tPadding() : Number {
			return autoSizeModel.tPadding;
		}
		
		public function set tPadding( value : Number ) : void {
			autoSizeModel.tPadding = value;
		}
		
		public function get rPadding() : Number {
			return autoSizeModel.rPadding;
		}
		
		public function set rPadding( value : Number ) : void {
			autoSizeModel.rPadding = value;
		}
		
		public function get lPadding() : Number {
			return autoSizeModel.lPadding;
		}
		
		public function set lPadding( value : Number ) : void {
			autoSizeModel.lPadding = value;
		}
	
	}
}
