package cn.chinuy.display.uicomponents.model {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @author chin
	 */
	public class SliderModel extends EventDispatcher {
		
		private var _value : Number;
		private var _begin : Number;
		private var _end : Number;
		
		private var _stepSize : Number = 0;
		
		public function SliderModel( value : Number = 0, begin : Number = 0, end : Number = 1 ) {
			super();
			_value = value;
			_begin = begin;
			_end = end;
		}
		
		public function lower() : void {
			value -= stepSize;
		}
		
		public function higher() : void {
			value += stepSize;
		}
		
		public function get stepSize() : Number {
			return _stepSize;
		}
		
		public function set stepSize( value : Number ) : void {
			_stepSize = value;
		}
		
		public function get end() : Number {
			return _end;
		}
		
		public function set end( value : Number ) : void {
			_end = Math.max( value, begin );
			var v : Number = this.value;
			this.value = Math.min( this.value, end );
		}
		
		public function get begin() : Number {
			return _begin;
		}
		
		public function set begin( value : Number ) : void {
			_begin = Math.min( value, end );
			var v : Number = this.value;
			this.value = Math.max( this.value, begin );
		}
		
		public function get value() : Number {
			return _value;
		}
		
		public function get valuePercent() : Number {
			if( end == begin ) {
				return 0;
			}
			var offset : Number = -begin;
			return ( value + offset ) / ( end - begin );
		}
		
		public function set valuePercent( precent : Number ) : void {
			if( end == begin ) {
				return;
			}
			value = percent2Value( precent );
		}
		
		public function percent2Value( precent : Number ) : Number {
			var v : Number = 0;
			if( end != begin ) {
				var offset : Number = -begin;
				v = precent * ( end - begin ) - offset;
			}
			return checkValue( v );
		}
		
		public function set value( value : Number ) : void {
			_value = checkValue( value );
			dispatchEvent( new Event( Event.CHANGE ));
		}
		
		protected function checkValue( value : Number ) : Number {
			value = Number( value.toFixed( 2 ));
			value = Math.max( value, begin );
			value = Math.min( value, end );
			return value;
		}
	}
}
