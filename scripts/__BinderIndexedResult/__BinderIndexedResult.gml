// Feather disable all

/// @param binder			Binder that generated the results
/// #param indexes			Array of indexes to the source data
function __BinderIndexedResult(_binder, _indexes) constructor {

	__indexes		= _indexes;

	binder			= _binder;
	count			= array_length(__indexes);
	
	#region private
	
		static __fetch = function(_limit, _offset, _refs) {
			if(_limit < 0) { _limit = count; }
			if(_offset <= 0) { _offset = 0; }
		
			var _count = max(0, min(count - _offset, _limit));
			var _values = array_create(_count);
		
			if(_refs) {
				for(var _i = 0; _i < _count; _i++) {
					_values[_i] = __indexes[_i];
				}
			}
			else {
				var _data = binder.data;
				for(var _i = 0; _i < _count; _i++) {
					_values[_i] = _data[__indexes[_i]];
				}
			}
		
			return _values;
		}
	
	#endregion
	
	#region public

	static fetch_values = function(_limit = -1, _offset = 0) {
		return __fetch(_limit, _offset, false);
	}
	
	static fetch_indexes = function(_limit = -1, _offset = 0) {
		return __fetch(_limit, _offset, true);
	}
	
	#endregion
	
}