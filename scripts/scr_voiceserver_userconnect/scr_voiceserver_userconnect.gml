function scr_voiceserver_userconnect(_m_socket){
	
	show_debug_message("connection from socket : "+string(_m_socket))
	
	voice_packet_fragmented[_m_socket] = false;
	voice_fragment_buffer[_m_socket] = buffer_create(1,buffer_grow,1); //buffer used to store the fragmented packet
	voice_tmp_buffer[_m_socket] = buffer_create(1, buffer_grow, 1);
	voice_send_buffer[_m_socket] = buffer_create(1, buffer_grow, 1);
	voice_write_buffer[_m_socket] = buffer_create(1, buffer_grow, 1);
	voice_header_buffer[_m_socket] = buffer_create(5, buffer_fixed, 1);
	ping_start_timer[_m_socket] = 0;
	ping_sent[_m_socket] = false;
	packetTimeStamp[_m_socket] = 0; //stores last audio packet timestamp, to check for duplicated audio packets
			
	ds_map_add_map(global.server_voice_users, _m_socket, ds_map_create());
	global.server_voice_users[? _m_socket][? "username"] = "";
	global.server_voice_users[? _m_socket][? "party_id"] = 0;
	global.server_voice_users[? _m_socket][? "mic_on"] = false;
			
	scr_voiceserver_send_ping(_m_socket);
	
	//send all users to connecting user
	var write_buffer = voice_write_buffer[_m_socket];
	for(var k = ds_map_find_first(global.server_voice_users); !is_undefined(k); k = ds_map_find_next(global.server_voice_users,k) ){
		if k != _m_socket {				
			buffer_seek(write_buffer, buffer_seek_start, 0);
			buffer_write(write_buffer, buffer_u8, 3);
			buffer_write(write_buffer, buffer_u16, k);
			buffer_write(write_buffer, buffer_u8, 1); //other user add
			buffer_write(write_buffer, buffer_string, global.server_voice_users[? k][? "username"]);
			buffer_write(write_buffer, buffer_u16, global.server_voice_users[? k][? "party_id"]);
			buffer_write(write_buffer, buffer_u8, global.server_voice_users[? k][? "mic_on"]);			
			scr_sendpacket(_m_socket, write_buffer, voice_header_buffer[_m_socket], voice_send_buffer[_m_socket]);
		}
	}
		
	
}