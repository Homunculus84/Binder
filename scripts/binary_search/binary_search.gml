// Feather disable all

/// @func binary_search(array, value, [multiple], [map_fn])
/// @param {Array} array			Array to use for the lookup
/// @param {Any} value				Value to look for
/// @param {Boolean} [multiple]		Whether to search for single or multiple values
/// @param {Function} [map_fn]		Mapping function to apply to the array elements for the comparisons
/// @returns {Struct}
function binary_search(_array, _value, _multiple = false, _map_fn = undefined) {
	
	static _default_map_fn = function(_v) { return _v; }
	
	_map_fn			??= _default_map_fn;

	var _lft		= 0;
	var _rgt		= array_length(_array) - 1;

	while (_lft <= _rgt) {
		var _mid = (_lft + _rgt) div 2;
		var _mid_value = _map_fn(_array[_mid]);
		
		if (_mid_value == _value) {
		
			if(_multiple) {
				_lft = __binary_search_expand_left(_array, _value, _map_fn, _lft, _mid);
				_rgt = __binary_search_expand_right(_array, _value, _map_fn, _mid, _rgt);

				return {count: _rgt - _lft + 1, start: _lft}
			}
			else {
				return {count: 1, start: _mid}
			}
			
		}
				
		else if (_mid_value < _value) {
			_lft = _mid + 1;
		}
				
		else {
			_rgt = _mid - 1;
		}
	}

	return {count: 0, start: -1}
	
}

function __binary_search_expand_left(_array, _value, _map_fn, _lft, _rgt) {

	var _result = undefined;

	while (_lft <= _rgt) {
	    var _mid = (_lft + _rgt) div 2;
		var _mid_value = _map_fn(_array[_mid]);
		
		if(_mid_value < _value) {
			_lft = _mid + 1;
		}
		
		else {
			if(_mid_value == _value) { _result = _mid; }
			_rgt = _mid - 1;
		}
	}
    
	return _result;
	
}

function __binary_search_expand_right(_array, _value, _map_fn, _lft, _rgt) {

	var _result = undefined;

	while (_lft <= _rgt) {
	    var _mid = (_lft + _rgt) div 2;
		var _mid_value = _map_fn(_array[_mid]);
		
		if(_mid_value > _value) {
			_rgt = _mid - 1;
		}
		else {
			if(_mid_value == _value) { _result = _mid; }
			_lft = _mid + 1;
		}
	}
    
	return _result;
	
}