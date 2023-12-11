function scr_voiceserver_send_userinfo(socket){
	if ds_map_exists(global.server_voice_users, socket){
		
		var write_buffer = voice_write_buffer[socket];
					
		//send client its own info
		buffer_seek(write_buffer, buffer_seek_start, 0);
		buffer_write(write_buffer, buffer_u8, 3);
		buffer_write(write_buffer, buffer_u16, socket);
		buffer_write(write_buffer, buffer_u8, 0); //self user add
		buffer_write(write_buffer, buffer_string, global.server_voice_users[? socket][? "username"]);
		buffer_write(write_buffer, buffer_u16, global.server_voice_users[? socket][? "party_id"]);
		buffer_write(write_buffer, buffer_u8, global.server_voice_users[? socket][? "mic_on"]);
		scr_sendpacket(socket, write_buffer, voice_header_buffer[socket], voice_send_buffer[socket]);	
					
		//send client info to all other clients
		buffer_seek(write_buffer, buffer_seek_start, 0);
		buffer_write(write_buffer, buffer_u8, 3);
		buffer_write(write_buffer, buffer_u16, socket);
		buffer_write(write_buffer, buffer_u8, 1); //other user add
		buffer_write(write_buffer, buffer_string, global.server_voice_users[? socket][? "username"]);
		buffer_write(write_buffer, buffer_u16, global.server_voice_users[? socket][? "party_id"]);
		buffer_write(write_buffer, buffer_u8, global.server_voice_users[? socket][? "mic_on"]);
		for(var k = ds_map_find_first(global.server_voice_users); !is_undefined(k); k = ds_map_find_next(global.server_voice_users,k) ){
			if k != socket {
				scr_sendpacket(k, write_buffer, voice_header_buffer[socket], voice_send_buffer[socket]);
			}
		}
	}
}