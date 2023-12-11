function scr_voiceserver_send_ping(socket){

	if (ping_sent[socket] == false){	
		
		ping_start_timer[socket] = get_timer();
		buffer_seek(voice_write_buffer[socket], buffer_seek_start, 0);
		buffer_write(voice_write_buffer[socket], buffer_u8, 1);
		scr_sendpacket(socket, voice_write_buffer[socket], voice_header_buffer[socket], voice_send_buffer[socket]);
		
		ping_sent[socket] = true;
	}
}