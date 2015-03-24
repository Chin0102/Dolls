package cn.chinuy.display.uicore {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * @author chin
	 */
	public interface IUIView {
		
		function get container() : DisplayObjectContainer;
		
		//Element
		function hasElement( name : String ) : Boolean;
		function element( name : String ) : DisplayObject;
		function elementProperty( name : String, propertyName : String, value : * ) : void;
		function elementVisible( name : String, visible : Boolean, defaultName : String = null ) : void;
		function elementListener( name : String, type : String, listener : Function, enabled : Boolean ) : void;
		
		//State
		function state( name : String ) : DisplayObject;
		function setState( ... state ) : void;
		
		//Component
		function addComponent( name : String, component : UIComponent ) : void;
		
		//Setting
		function setting( key : String ) : *;
		function hasSetting( key : String ) : Boolean;
		function applySetting( obj : Object, settingKey : String, defaultSetting : Object = null ) : void;
	}
}
