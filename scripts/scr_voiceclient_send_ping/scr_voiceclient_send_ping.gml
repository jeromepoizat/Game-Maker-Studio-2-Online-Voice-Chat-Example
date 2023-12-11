function scr_voiceclient_send_ping(){

	buffer_seek(voice_write_buffer, buffer_seek_start, 0);
	buffer_write(voice_write_buffer, buffer_u8, 1);
	scr_sendpacket(voice_server_socket, voice_write_buffer, voice_header_buffer, voice_send_buffer);
	
	//reset connection time-out timer
	alarm[1]=room_speed*5;
}