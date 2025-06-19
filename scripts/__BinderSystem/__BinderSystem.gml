#macro	BINDER_VERSION			"1.2.0"

__BinderSystem();

function __BinderSystem() {
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

function __binder_version_parse(_version = BINDER_VERSION) {
	var _parts = string_split(_version, ".");
	
	return { 
		major: real(_parts[0]), 
		minor: real(_parts[1]), 
		patch: real(_parts[2]) 
	};
}