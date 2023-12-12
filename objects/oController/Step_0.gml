fps_sum += fps_real;
fps_count += 1;

//Application is nether initialized as a server nor client:
if (voice_client == false && voice_server == false){
	if keyboard_check(ord("C")){
		//Start Application as client
		scr_voiceclient_start();
	}
	else
	if keyboard_check(ord("S")){
		//Start Application as client
		scr_voiceserver_start();
	}
}
else
if (voice_client == true){
	//	voice client step	
	if (connected_to_voice_server == true){
		if keyboard_check(pushToTalkKey) {
			if (mic_on == false && mic_set == true){
				mic_on = true;
				record_info[mic_id] = audio_start_recording(mic_id);
				
				//send to server recording has started
				scr_voiceclient_send_userinfo();
			}
		}
		else
		{
			if (mic_on == true){
				mic_on = false;
				
				audio_stop_recording(record_info[mic_id]); 
				
				//send to server recording has stopped
				scr_voiceclient_send_userinfo();
			}
		}
	}
	
	//change microphone
	for (var i = 0; i < number_of_mics; i += 1){
		if keyboard_check(ord(string(i+1))){
			mic_id = i;
			mic_set = true;
		}
	}
}