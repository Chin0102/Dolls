package cn.chinuy.display.layout {
	
	/**
	 * @author chin
	 */
	public class LayoutValue {
		
		public static const NULL : String = "";
		
		private var _data : *;
		
		private var _null : Boolean;
		private var _percent : Boolean;
		private var _number : Number;
		
		public function LayoutValue( data : * = "" ) {
			reset( data );
		}
		
		public function get data() : * {
			return _data;
		}
		
		public function get isNull() : Boolean {
			return _null;
		}
		
		public function get isPercent() : Boolean {
			return _percent;
		}
		
		public function get number() : Number {
			return _number;
		}
		
		public function reset( data : * = "" ) : void {
			_data = data;
			_null = String( data ) == NULL;
			if( isNull ) {
				_percent = false;
				_number = -1;
			} else {
				_percent = isNaN( data );
				if( isPercent ) {
					var v : Number = parseInt( data );
					_number = v / 100;
					_data = v + "%";
				} else {
					_number = data;
				}
			}
		}
		
		public function calc( total : Number ) : Number {
			if( isNull ) {
				return NaN;
			} else if( isNaN( total )) {
				return 0;
			} else {
				return isPercent ? total * number : number;
			}
		}
	}
}
