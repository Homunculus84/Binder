if(!textfield.changed) { exit; }

var _value = string_lower(textfield.value);
var _length = string_length(_value);

if(_length < 1) {
	prefixes.entries = undefined;
	anagrams.entries = undefined;
	exit;
}

var _result, _t = undefined;

// Search by prefix
_t = get_timer();
_result = words_alpha.search(_value, false, 
	method({_length}, function(_word) {
		return string_copy(_word, 1, _length);
	}
));

prefixes.entries = _result.fetch_values(limit, offset);
prefixes.count = _result.count;
prefixes.time = (get_timer() - _t) / 1000;

// Search anagrams
_t = get_timer();
_result = words_anagrams.search(_value, true);

anagrams.entries = _result.fetch_values(limit, offset);
anagrams.count = _result.count;
anagrams.time = (get_timer() - _t) / 1000;