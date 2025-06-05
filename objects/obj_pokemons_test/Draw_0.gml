var _line_height = 16;

draw_set_valign(fa_top);

if(!is_undefined(pokemons.entries)) {
	draw_set_color(c_gray);
	draw_text(x, y + 0 * _line_height, $"{pokemons.count} Pokemons found [{pokemons.time}ms]");
	draw_set_color(c_dkgray);
	
	var _i;
	for(_i = 0; _i < array_length(pokemons.entries); _i++) {
		var _pokemon = pokemons.entries[_i];
		draw_text(x, y + (_i + 1) * _line_height, $"{_pokemon.name} [{string_join_ext(",", _pokemon.type)}] N. {_pokemon.id}");
	}
	
	draw_set_color(c_gray);
	if(pokemons.count > limit) {
		draw_text(x, y + (_i + 1) * _line_height, $"+ {pokemons.count - limit} more");
	}
}

draw_set_color(c_gray);

draw_text(x, y + 10 * _line_height, "Types: Normal,Fire,Water,Electric,Grass,Ice,Fighting,Poison,Ground");
draw_text(x, y + 11 * _line_height, "       Flying,Psychic,Bug,Rock,Ghost,Dragon,Dark,Steel,Fairy");
draw_text(x, y + 12 * _line_height, "Press < to go to the previous room");