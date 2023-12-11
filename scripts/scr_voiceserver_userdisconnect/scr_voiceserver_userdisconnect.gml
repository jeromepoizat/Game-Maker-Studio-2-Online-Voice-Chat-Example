function scr_voiceserver_userdisconnect(_m_socket){
	buffer_seek(voice_write_buffer[_m_socket ], buffer_seek_start, 0);
	buffer_write(voice_write_buffer[_m_socket ], buffer_u8, 3);
	buffer_write(voice_write_buffer[_m_socket ], buffer_u16, _m_socket);
	buffer_write(voice_write_buffer[_m_socket ], buffer_u8, 2); //remove user
	for(var k = ds_map_find_first(global.server_voice_users); !is_undefined(k); k = ds_map_find_next(global.server_voice_users,k) ){
		scr_sendpacket(k, voice_write_buffer[_m_socket ], voice_header_buffer[_m_socket ], voice_send_buffer[_m_socket ]);
	}		
		
	//remove user from ds map
	if ds_map_exists(global.server_voice_users,_m_socket){
		ds_map_destroy(global.server_voice_users[? _m_socket]);
		ds_map_delete(global.server_voice_users,_m_socket);
	}
		
	//delete buffers
	buffer_delete(voice_fragment_buffer[_m_socket]);
	buffer_delete(voice_tmp_buffer[_m_socket ]);
	buffer_delete(voice_header_buffer[_m_socket ]);
	buffer_delete(voice_write_buffer[_m_socket ]);
	buffer_delete(voice_send_buffer[_m_socket ]);
}