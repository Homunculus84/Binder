// Feather disable all

/// @param binder			Binder that generated the results
/// #param raw_output		Output of a binary search
function __BinderResult(_binder, _start, _count, _indexes = undefined) constructor {
	
	__start		= _start;
	__indexes	= _indexes;

	binder		= _binder;
	count		= _count;

	#region private

	static __collect_from_binder = function(_result, _start, _end, _refs) {
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
	}
	
	static __collect_from_indexes = function(_result, _start, _end, _refs) {
		if(_refs) {
			for(var _i = _start; _i < _end; _i++) {
				_result[_i] = __indexes[_i];
			}
		}
		else {
			var _data = binder.data;
			for(var _i = _start; _i < _end; _i++) {
				_result[_i] = _data[__indexes[_i]];
			}
		}
	}

	static __fetch = function(_limit, _offset, _refs) {
		if(count == 0) { return []; }
		
		var _start = max(__start, __start + _offset);
		var _end = _limit < 0 ? count + __start : min(count + __start, _start + _limit);

		var _result = array_create(max(0, _end - _start));		

		if(is_undefined(__indexes)) {
			__collect_from_binder(_result, _start, _end, _refs);
		}
		else {
			__collect_from_indexes(_result, _start, _end, _refs);
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