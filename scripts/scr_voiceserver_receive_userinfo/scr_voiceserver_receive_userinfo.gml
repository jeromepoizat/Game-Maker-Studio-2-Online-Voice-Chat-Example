function scr_voiceserver_receive_userinfo(buffer, socket){
	var username = buffer_read(buffer,buffer_string);
	var mic_on = buffer_read(buffer,buffer_u8);
	if ds_map_exists(global.server_voice_users, socket){
		global.server_voice_users[? socket][? "username"] = username;
		global.server_voice_users[? socket][? "mic_on"] = mic_on;
		
		//send user info to all clients
		scr_voiceserver_send_userinfo(socket);
	}
}