function scr_voiceclient_receive_userinfo(buffer){
	
	var socket_id = buffer_read(buffer, buffer_u16);
	var user_status = buffer_read(buffer, buffer_u8);//0: update self, 1: update other, 2: remove
	
	if (user_status == 0 || user_status == 1){
		
		//update a user
		
		var username = buffer_read(buffer, buffer_string);
		var party_id = buffer_read(buffer, buffer_u16);
		var mic_on = buffer_read(buffer, buffer_u8);
		
		if user_status == 0 {
			my_voice_id = socket_id;
		}
		
		if !ds_map_exists(voice_chat_users_dsmap, socket_id){
			ds_map_add_map(voice_chat_users_dsmap, socket_id, ds_map_create());
		}
		voice_chat_users_dsmap[? socket_id][? "username"] = username;
		voice_chat_users_dsmap[? socket_id][? "party_id"] = party_id;
		voice_chat_users_dsmap[? socket_id][? "mic_on"] = mic_on;
		
		//if mic is off stop audio stream
		if audioQueue[socket_id] != -1 && mic_on == false {
			audio_stop_sound(audioQueue[socket_id]);
			audio_free_play_queue(audioQueue[socket_id]);
			audioQueue[socket_id] = -1;			
		}
	}
	else if (user_status == 2){
		//Removing user
		if ds_map_exists(voice_chat_users_dsmap, socket_id){
			ds_map_destroy(voice_chat_users_dsmap[? socket_id]);
			ds_map_delete(voice_chat_users_dsmap, socket_id);			
		}
		//stop audio stream
		if audioQueue[socket_id] != -1 {
			audio_stop_sound(audioQueue[socket_id]);
			audio_free_play_queue(audioQueue[socket_id]);
			audioQueue[socket_id] = -1;			
		}
	}
}
