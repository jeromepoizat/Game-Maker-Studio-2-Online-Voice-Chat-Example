function scr_voiceclient_receive_audio(buffer){
	
	var voice_id = buffer_read(buffer, buffer_u16);
	var Len = buffer_read(buffer, buffer_s16);
	var rate = buffer_read(buffer, buffer_s16);
	var format = buffer_read(buffer, buffer_s16);
	var timeStamp = buffer_read(buffer, buffer_u64);
	
	if (voice_packetTimeStamp != timeStamp){
					
		voice_packetTimeStamp = timeStamp;

		//extract audio buffer from buffer
		var audio_buffer = buffer_create(Len, buffer_fixed, 1);
		buffer_copy(buffer, buffer_tell(buffer), Len, audio_buffer, 0);
		buffer_seek(buffer, buffer_seek_relative, Len);	
		
		//if (my_voice_id != voice_id){ uncomment this if you want to mute self audio
		
		if (audioQueue[voice_id] == -1) {
			audioQueue[voice_id] = audio_create_play_queue(format, rate, 0);
		}	

		audio_queue_sound(audioQueue[voice_id], audio_buffer, 0, Len);
		if !audio_is_playing(audioQueue[voice_id]){
			audio_play_sound(audioQueue[voice_id], 1, 0);
		}
		
		//} uncomment this if you want to mute self audio

	} else {
		//skip duplicated audio packet
		buffer_seek(buffer, buffer_seek_relative, Len);
	}
	
}