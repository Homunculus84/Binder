// Feather disable all

/// @param binder			Binder that generated the results
/// #param raw_output		Output of a binary search
function __BinderRawResult(_binder, _raw_output) constructor {
	
	__start		= _raw_output.start;
	
	binder		= _binder;
	count		= _raw_output.count;

	#region private

	static __fetch = function(_limit, _offset, _refs) {
		if(count == 0) { return []; }
		
		if(_limit < 0) { _limit = count; }
		if(_offset < 0) { _offset = 0; }
		
		var _count = max(0, min(count - _offset, _limit));
		var _start = __start + _offset;
		var _end = _start + _count;
		
		var _result = array_create(_count);
		
		if(_refs) {
			for(var _i = _start; _i < _end; _i++) {
				_result[_i - _start] = binder.get_ref(_i);
			}
		}
		else {
			for(var _i = _start; _i < _end; _i++) {
				_result[_i - _start] = binder.get_val_raw(_i);
			}
		}
		
		return _result;
	}

	#endregion
	
	#region public

	static fetch_values = function(_limit = -1, _offset = 0) {
		return __fetch(_limit, _offset, false)
	}
	
	static fetch_indexes = function(_limit = -1, _offset = 0) {
		return __fetch(_limit, _offset, true);
	}
	
	#endregion
	
}