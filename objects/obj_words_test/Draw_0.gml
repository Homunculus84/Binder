var _line_height = 16;
var _textfield_value = textfield.value;

draw_set_valign(fa_top);

if(!is_undefined(prefixes.entries)) {
	draw_set_color(c_gray);
	draw_text(x, y + 1 * _line_height, $"{prefixes.count} Words starting with '{_textfield_value}' [{prefixes.time}ms]");
	draw_set_color(c_dkgray);
	draw_text(x, y + 2 * _line_height, string_join_ext(", ", prefixes.entries) + (prefixes.count > limit ? ", ..." : ""));
}

if(!is_undefined(anagrams.entries)) {
	draw_set_color(c_gray);
	draw_text(x, y + 4 * _line_height, $"{anagrams.count} Anagrams of '{_textfield_value}' [{anagrams.time}ms]");
	draw_set_color(c_dkgray);
	draw_text(x, y + 5 * _line_height, string_join_ext(", ", anagrams.entries) + (anagrams.count > limit ? ", ..." : ""));
}

draw_set_color(c_gray);
draw_text(x, y + 11 * _line_height, $"Based on a dictionary with {array_length(words)} words");
draw_text(x, y + 12 * _line_height, "Press > to go to the next room");