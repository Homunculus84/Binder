changed = false;

if(active) { focus(); }

function focus() {
	active = true;
	image_index = 1;
	keyboard_string = value;
}

function blur() {
	active = false;
	image_index = 0;
}