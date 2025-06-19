#macro	BINDER_HEADER_SIZE		12
#macro	BINDER_MAGIC			0x52444E42

__BinderSerializer();

function __BinderSerializer() {
	static _serializer = undefined;
	if(!is_undefined(_serializer)) { return _serializer; }
	
	_serializer = {}
	
	with(_serializer) {
	
		#region private
	
		__buffer_chunk_size = function(_count) {
		    if (_count <= 255) {
		        return 1;
		    } else if (_count <= 65535) {
		        return 2;
		    } else if (_count <= 4294967295) {
		        return 4;
		    } else {
		        __binder_error("Value too large for u32");
		    }
		}
	
		__buffer_chunk_type = function(_chunk_size) {
			switch (_chunk_size) {
			    case 1: return buffer_u8;
			    case 2: return buffer_u16;
			    case 4: return buffer_u32;
			    default: __binder_error("Wrong chunk size in buffer");
			}
		}

		#endregion
	
		#region public
	
		from_buffer = function(_buffer) {
		    buffer_seek(_buffer, buffer_seek_start, 0);

			try {
			    var _magic = buffer_read(_buffer, buffer_u32);
				if (_magic != BINDER_MAGIC) { 
					if(BINDER_SHOW_WARN) { __binder_trace("Buffer does not contain Binder data"); }
					return undefined;
				}

				var _version		= buffer_read(_buffer, buffer_u8); 
				buffer_seek(_buffer, buffer_seek_relative, 2); // skip minor version + patch
				
				switch(_version) {
					case 1:
						var _entry_count	= buffer_read(_buffer, buffer_u32);
						var _chunk_size		= buffer_read(_buffer, buffer_u8);
						var _type			= __buffer_chunk_type(_chunk_size);
					
						var _data			= array_create(_entry_count);
		
						for (var _i = 0; _i < _entry_count; _i++) {
						    _data[_i] = buffer_read(_buffer, _type);
						}
					
						return _data;
						break;
					default: 
						if(BINDER_SHOW_WARN) { __binder_trace("Trying to read unsupported Binder version from buffer"); }
						return undefined;
				}
			}
			
			catch(_e) {
				if(BINDER_SHOW_WARN) { __binder_trace($"Error reading buffer"); }
				return undefined;
			} 
		}
		
		from_json = function(_json_string) {
			try {
				var _json		= json_parse(_json_string);
				var _version	= __binder_version_parse(_json.version);
				
				switch(_version.major) {
					case 1: 
						return _json.index;
					default: 
						if(BINDER_SHOW_WARN) { __binder_trace("Trying to read unsupported version from JSON"); }
						return undefined;
				}
			
			}
			
			catch (_e) {
				if(BINDER_SHOW_WARN) { __binder_trace("Failed to load binder from json string") }
				return undefined;
			}
		}
	
		to_buffer = function(_binder) {
			var _entry_count	= _binder.size;
			var _chunk_size		= __buffer_chunk_size(_entry_count);
			var _version		= __binder_version_parse();
		
			var _buffer			= buffer_create(BINDER_HEADER_SIZE + _chunk_size * _entry_count, buffer_fixed, 1);

			// write header
			buffer_write(_buffer, buffer_u32,	BINDER_MAGIC);
			buffer_write(_buffer, buffer_u8,	_version.major);
			buffer_write(_buffer, buffer_u8,	_version.minor);
			buffer_write(_buffer, buffer_u8,	_version.patch);
			buffer_write(_buffer, buffer_u32,	_entry_count);
			buffer_write(_buffer, buffer_u8,	_chunk_size);
		
			var _type	= __buffer_chunk_type(_chunk_size);
		
			// write data
			for(var _i = 0; _i < _entry_count; _i++) {
				buffer_write(_buffer, _type, _binder.get_ref(_i));
			}
		
			return _buffer;
		}
	
		to_json = function(_binder, _pretty) {
			var _struct = {
				version:	BINDER_VERSION,
				size:		_binder.size,
				index:		_binder.index
			}
		
			return json_stringify(_struct, _pretty);
		}
	
		#endregion
	
	}
	
	return _serializer;
}