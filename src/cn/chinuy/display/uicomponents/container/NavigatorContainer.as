package cn.chinuy.display.uicomponents.container {
	import cn.chinuy.display.uicomponents.events.ContainerEvent;
	
	/**
	 * @author chin
	 */
	public class NavigatorContainer extends Container {
		
		private var map : Object = {};
		
		protected var _currentContent : INavigatorContent;
		protected var nextContent : INavigatorContent;
		
		public function NavigatorContainer() {
			super();
		}
		
		public function get currentContent() : INavigatorContent {
			return _currentContent;
		}
		
		public function getContent( label : String ) : INavigatorContent {
			return map[ label ];
		}
		
		public function addContent( content : INavigatorContent ) : void {
			content.close();
			map[ content.label ] = content;
		}
		
		public function removeContent( label : String ) : INavigatorContent {
			var content : INavigatorContent = map[ label ] as INavigatorContent;
			delete map[ label ];
			return content;
		}
		
		public function setCurrentContent( label : String ) : Boolean {
			var content : INavigatorContent = map[ label ] as INavigatorContent;
			if( content && content != currentContent ) {
				displayContent( content );
				return true;
			}
			return false;
		}
		
		protected function displayContent( content : INavigatorContent ) : void {
			nextContent = content;
			if( currentContent ) {
				removeCurrentContent();
			} else {
				addCurrentContent();
			}
		}
		
		private function onCurrentContentClose( e : ContainerEvent ) : void {
			currentContent.removeEventListener( ContainerEvent.Close, onCurrentContentClose );
			addCurrentContent();
		}
		
		protected function removeCurrentContent() : void {
			currentContent.addEventListener( ContainerEvent.Close, onCurrentContentClose );
			currentContent.close();
		}
		
		protected function addCurrentContent() : void {
			_currentContent = nextContent;
			addChild(( currentContent as IContainer ).displayObject );
			currentContent.display();
			nextContent = null;
		}
	}
}
