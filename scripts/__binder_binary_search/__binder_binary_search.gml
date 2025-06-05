// Feather disable all

/// @param binder			Binder that started the search
/// @param value			Value to look for
/// @param [eval_fn]		Filter function for the value comparisons on the mapped data
/// @param [multiple]		Whether to search for a single or multiple values
function __binder_binary_search(_binder, _value, _eval_fn = binder_pass_through, _multiple = false) {
	
	var _lft = 0;
	var _rgt = _binder.size - 1;

	while (_lft <= _rgt) {
		var _mid = (_lft + _rgt) div 2;
		var _mid_value = _eval_fn(_binder.get_val(_mid));
		
		if (_mid_value == _value) {
		
			if(_multiple) {
				_lft = __binder_expand_left(_binder, _value, _eval_fn, _lft, _mid);
				_rgt = __binder_expand_right(_binder, _value, _eval_fn, _mid, _rgt);

				return new __BinderResult(_binder, _lft, _rgt - _lft + 1);
			}
			else {
				return _binder.get_val_raw(_mid);
			}
			
		}
				
		else if (_mid_value < _value) {
			_lft = _mid + 1;
		}
				
		else {
			_rgt = _mid - 1;
		}
	}

	if(_multiple) {
		return new __BinderResult(_binder, -1, 0);;
	}
	else {
		return undefined;
	}
}

function __binder_expand_left(_binder, _value, _eval_fn, _lft, _rgt) {

	var _result = -1;

	while (_lft <= _rgt) {
	    var _mid = (_lft + _rgt) div 2;
		var _mid_value = _eval_fn(_binder.get_val(_mid));
		
		if(_mid_value < _value) {
			_lft = _mid + 1;
		}
		else {
			if(_mid_value == _value) {_result = _mid;}
			_rgt = _mid - 1;
		}
	}
    
	return _result;
}

function __binder_expand_right(_binder, _value, _eval_fn, _lft, _rgt) {

	var _result = -1;

	while (_lft <= _rgt) {
	    var _mid = (_lft + _rgt) div 2;
		var _mid_value = _eval_fn(_binder.get_val(_mid));
		
		if(_mid_value > _value) {
			_rgt = _mid - 1;
		}
		else {
			if(_mid_value == _value) {_result = _mid;}
			_lft = _mid + 1;
		}
	}
    
	return _result;
}