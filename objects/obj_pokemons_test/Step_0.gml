if(!textfield_name.changed && !textfield_type.changed) { exit; }

var _name = string_lower(textfield_name.value);
var _type = string_lower(textfield_type.value);

var _name_length = string_length(_name);
var _type_length = string_length(_type);

if(_name_length + _type_length < 1) {
	pokemons.entries = undefined;
	exit;
}

var _t = get_timer();

// Search by english name
var _names = pokedex_name.search(_name, false, 
	method({_name_length}, function(_name) {
		return string_copy(_name, 1, _name_length);
	}
));

// Search by type
var _types_one = pokedex_type_one.search(_type);
var _types_two = pokedex_type_two.search(_type);

var _types = binder_results_union(_types_one, _types_two);

// Get results
var _results;
if(_name_length > 0 && _type_length > 0) {
	_results = binder_results_intersection(_names, _types);
}
else if(_name_length > 0) {
	_results = _names;
}
else {
	_results = _types;
} 

pokemons.entries = _results.fetch_values(limit);
pokemons.count = _results.count;
pokemons.time = (get_timer() - _t) / 1000;