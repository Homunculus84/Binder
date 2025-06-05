// Feather disable all

/// Pass-through function (returns the passed value)
/// @param value
function binder_pass_through(_value) {
	return _value;
}

/// Reverses the characters in a string
/// @param string
function binder_string_reverse(_string) {
	var _chars = binder_string_to_char_array(_string);
	array_reverse_ext(_chars);
	return string_concat_ext(_chars);
}

/// Sorts all characters in a string
/// @param string
function binder_string_sort(_string) {
	var _chars = binder_string_to_char_array(_string);
	array_sort(_chars, true);
	return string_concat_ext(_chars);
}

/// Returns an array of characters from a string
/// @param _string
function binder_string_to_char_array(_string) {
	var _chars = array_create(string_length(_string));
	
	string_foreach(_string, method({_chars}, function(_char, _i) {
		_chars[_i - 1] = _char;
	})); 
	
	return _chars;
}

/// Returns a new result by intersecting the output of two or more searches on the same binder
/// @param result
/// @param ...results
function binder_results_intersection(_result) {
	
    var _indexes = _result.fetch_indexes();

    for (var _i = 1; _i < argument_count; _i++) {
		var _other_indexes = argument[_i].fetch_indexes();
		var _indexes = array_intersection(_indexes, _other_indexes);
    }

	var _new_result = new __BinderIndexedResult(_result.binder, _indexes);

    return _new_result;
}

/// Returns a new result by merging the output of two or more searches on the same binder
/// @param result
/// @param ...results
function binder_results_union(_result) {	
    var _indexes = _result.fetch_indexes();

    for (var _i = 1; _i < argument_count; _i++) {
		var _other_indexes = argument[_i].fetch_indexes();
		var _indexes = array_union(_indexes, _other_indexes);
    }

	var _new_result = new __BinderIndexedResult(_result.binder, _indexes);

    return _new_result;
}