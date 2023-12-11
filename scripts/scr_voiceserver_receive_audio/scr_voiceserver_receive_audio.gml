function scr_voiceserver_receive_audio(buffer, socket){
	
	var Len = buffer_read(buffer, buffer_s16); //Get voice recording length
	var rate = buffer_read(buffer, buffer_s16);
	var format = buffer_read(buffer, buffer_s16);
	var timeStamp = buffer_read(buffer, buffer_u64);
		

	if (packetTimeStamp[socket] != timeStamp) {
		packetTimeStamp[socket] = timeStamp
		
		var bitSend = voice_write_buffer[socket];
		
		buffer_seek(bitSend, buffer_seek_start, 0);
		buffer_write(bitSend, buffer_u8, 4)
		buffer_write(bitSend, buffer_u16, socket);
		buffer_write(bitSend, buffer_s16, Len);
		buffer_write(bitSend, buffer_s16, rate);
		buffer_write(bitSend, buffer_s16, format);
		buffer_write(bitSend, buffer_u64, timeStamp);
		
		buffer_copy(buffer, buffer_tell(buffer), Len, bitSend, buffer_tell(bitSend));
		buffer_seek(bitSend, buffer_seek_relative, Len);
		
		//send audio to all users of the same party
		var party_to_send = global.server_voice_users[? socket][? "party_id"];
		for(var k = ds_map_find_first(global.server_voice_users); !is_undefined(k); k = ds_map_find_next(global.server_voice_users,k) ){
			if global.server_voice_users[? k][? "party_id"] == party_to_send {
				scr_sendpacket(k, bitSend, voice_header_buffer[socket], voice_send_buffer[socket]);
			}
		}
		
		buffer_seek(buffer, buffer_seek_relative, Len);
		
	} else {
		//skip duplicated packet
		buffer_seek(buffer, buffer_seek_relative, Len);	
	}
}