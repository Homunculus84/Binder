changed = false;

if(mouse_check_button_pressed(mb_left)) {
	if(position_meeting(mouse_x, mouse_y, id)) {
		focus();
	}
	else {
		blur();
	}
}

if(active && value != keyboard_string) {
	value = keyboard_string;
	changed = true;
}