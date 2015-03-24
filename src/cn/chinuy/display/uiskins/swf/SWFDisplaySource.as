package cn.chinuy.display.uiskins.swf {
	import cn.chinuy.display.UISprite;
	import cn.chinuy.display.uicore.IDisplaySource;
	
	/**
	 * @author chin
	 */
	public class SWFDisplaySource implements IDisplaySource {
		
		private var parser : SWFSkinParser;
		private var info : Object;
		
		public function SWFDisplaySource( sourceInfo : Object, parser : SWFSkinParser ) {
			info = sourceInfo;
			this.parser = parser;
		}
		
		public function get name() : String {
			return info[ "name" ];
		}
		
		public function create() : UISprite {
			return parser.createSprite( info[ "source" ]);
		}
	
	}
}
