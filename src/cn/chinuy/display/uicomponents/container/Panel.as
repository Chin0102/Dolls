package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.uicomponents.basic.Button;
	import cn.chinuy.display.uicomponents.events.PanelEvent;
	import cn.chinuy.display.uicomponents.text.Label;
	
	import flash.events.MouseEvent;
	
	/**
	 * @author chin
	 */
	public class Panel extends BasePanel {
		
		public static const Skin : String = "Panel";
		
		public static const Component_Title : String = "TitleLabel";
		public static const Component_MinBtn : String = "MinButton";
		public static const Component_MaxBtn : String = "MaxButton";
		public static const Component_CloseBtn : String = "CloseButton";
		
		private var _titleLabel : Label;
		private var _minButton : Button;
		private var _maxButton : Button;
		private var _closeButton : Button;
		
		public function Panel() {
			super();
			initSkin();
		}
		
		override protected function get defaultSkin() : String {
			return Skin;
		}
		
		override protected function get defaultWidth() : Number {
			return 300;
		}
		
		override protected function get defaultHeight() : Number {
			return 200;
		}
		
		override protected function onViewChanged() : void {
			super.onViewChanged();
			view.addComponent( Component_Title, titleLabel );
			view.addComponent( Component_MinBtn, minButton );
			view.addComponent( Component_MaxBtn, maxButton );
			view.addComponent( Component_CloseBtn, closeButton );
		}
		
		public function get titleLabel() : Label {
			if( _titleLabel == null ) {
				_titleLabel = Label.create();
			}
			return _titleLabel;
		}
		
		public function get minButton() : Button {
			if( _minButton == null ) {
				_minButton = new Button();
				_minButton.addEventListener( MouseEvent.CLICK, onMinButtonClick );
			}
			return _minButton;
		}
		
		public function get maxButton() : Button {
			if( _maxButton == null ) {
				_maxButton = new Button();
				_maxButton.addEventListener( MouseEvent.CLICK, onMaxButtonClick );
			}
			return _maxButton;
		}
		
		public function get closeButton() : Button {
			if( _closeButton == null ) {
				_closeButton = new Button();
				_closeButton.addEventListener( MouseEvent.CLICK, onCloseButtonClick );
			}
			return _closeButton;
		}
		
		protected function onMinButtonClick( event : MouseEvent ) : void {
			dispatchEvent( new PanelEvent( PanelEvent.ClickToMin ));
		}
		
		protected function onMaxButtonClick( event : MouseEvent ) : void {
			dispatchEvent( new PanelEvent( PanelEvent.ClickToMax ));
		}
		
		protected function onCloseButtonClick( event : MouseEvent ) : void {
			dispatchEvent( new PanelEvent( PanelEvent.ClickToClose ));
		}
		
		public function set title( value : String ) : void {
			titleLabel.value = value;
		}
		
		public function get title() : String {
			return titleLabel.value;
		}
	
	}
}
