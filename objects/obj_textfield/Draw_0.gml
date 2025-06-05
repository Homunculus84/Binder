draw_self();

draw_set_valign(fa_middle);

if(value == "") {
	draw_set_color(c_gray);
	draw_text(x + 8, y + sprite_height div 2, placeholder );
}
else {
	draw_set_color(c_dkgray);
	draw_text(x + 8, y + sprite_height div 2, value );
}