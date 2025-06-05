#macro	BINDER_VERSION		"1.0.0"

__binder_system();
function __binder_system() {
	static _system = undefined;
	if(!is_undefined(_system)) { return _system; }
	
	__binder_trace($"Using Binder {BINDER_VERSION} by Homunculus84");
	
	_system = {}
	with(_system) {
	
	}
	
	return _system;
}

function __binder_error(_error){
	show_error($"[Binder] {BINDER_VERSION}: {_error}\n", true);
}

function __binder_trace(_message){
	show_debug_message($"[Binder] {_message}");
}