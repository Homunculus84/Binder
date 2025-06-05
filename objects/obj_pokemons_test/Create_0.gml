textfield_name = textfield_pokemons_name;
textfield_type = textfield_pokemons_type;

limit = 7;

pokemons = {
	count:		0,
	time:		0,
	entries:	undefined
}

// Load pokemon database
var _buffer = buffer_load("pokedex.json");
pokedex = json_parse(buffer_read(_buffer, buffer_text));
buffer_delete(_buffer);

// Create a binder by pokemon name (english), and generate the index
pokedex_name = new Binder(pokedex, function(_p) { return string_lower(_p.name); }, true);

// Create a binder by pokemon name (japanese), and generate the index
pokedex_type_one = new Binder(pokedex, function(_p) { return string_lower(_p.type[0]); }, true);

// Create a binder by pokemon name (japanese), and generate the index
pokedex_type_two = new Binder(pokedex, function(_p) { return string_lower(_p.type[1]); }, true);