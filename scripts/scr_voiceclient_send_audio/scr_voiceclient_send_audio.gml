function scr_voiceclient_send_audio(audio_buffer, Len, rate, format){
	//send audio buffer
	var bitSend = voice_write_buffer;
	buffer_seek(bitSend, buffer_seek_start, 0);
	buffer_write(bitSend, buffer_u8, 4)//case 4: audio packet
	buffer_write(bitSend, buffer_s16, Len);
	buffer_write(bitSend, buffer_s16, rate);
	buffer_write(bitSend, buffer_s16, format);
	buffer_write(bitSend, buffer_u64, current_time);
		
	buffer_copy(audio_buffer, 0, Len, bitSend, buffer_tell(bitSend)) //Put the audio_buffer data into the buffer we are sending
			
	buffer_seek(bitSend, buffer_seek_relative, Len);
	scr_sendpacket(voice_server_socket, bitSend, voice_header_buffer, voice_send_buffer); //Send the whole data to server
}