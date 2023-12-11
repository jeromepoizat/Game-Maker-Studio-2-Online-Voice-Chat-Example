function scr_voiceclient_send_userinfo(){
	buffer_seek(voice_write_buffer, buffer_seek_start, 0);
	buffer_write(voice_write_buffer, buffer_u8, 3);
	buffer_write(voice_write_buffer, buffer_string, username);
	buffer_write(voice_write_buffer, buffer_u8, mic_on);
	scr_sendpacket(voice_server_socket, voice_write_buffer, voice_header_buffer, voice_send_buffer);
}