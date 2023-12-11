function scr_voiceclient_stop(){
	connected_to_voice_server = false;

	network_destroy(voice_server_socket);
	ds_map_destroy(voice_chat_users_dsmap);

	buffer_delete(voice_fragment_buffer);
	buffer_delete(voice_tmp_buffer);
	buffer_delete(voice_send_buffer);
	buffer_delete(voice_write_buffer);
	buffer_delete(voice_header_buffer);
	
	voice_client = false;
	display_text = "Press 'C' to start a voice client \n Press 'S' to start a voice server";
	
	audio_debug(false);

}