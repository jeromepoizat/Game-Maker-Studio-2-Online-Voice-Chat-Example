function scr_voiceclient_start(){
	//init voice client
	
	randomize();
	
	username = get_string("Enter Username: ","user_"+string(irandom(1000)));
	my_voice_id = -1;
	
	audioQueue = array_create(1000, -1);
	
	connected_to_voice_server = false;
	
	voice_chat_users_dsmap = ds_map_create();
	//ds map key : server socket id
	//ds map value : a ds map with user informations
	
	mic_set = false; // wether a microphone is selected or not
	mic_id = 0; //id of the selected microphone
	mic_on = false; //recording voice or not
	
	number_of_mics = audio_get_recorder_count();
	record_info = array_create(number_of_mics, 0);
	mic_names = array_create(number_of_mics, "");
	show_debug_message("number of mics : " +string(number_of_mics));

	//loop microphones
	for (var i = 0; i < number_of_mics; i += 1){
					
		record_info[i] = audio_start_recording(i)					
		var ds_map = audio_get_recorder_info(i);
		
		//get microphone name
		if ds_exists(ds_map,ds_type_map){
			if ds_map_exists(ds_map, "name"){
				mic_names[i] = ds_map[? "name"];
				ds_map_destroy(ds_map);
			} 
		} 
					
		audio_stop_recording(record_info[i]);
	}
	
	//default to first microphone
	if (number_of_mics > 0){
		mic_set = true;
		mic_id = 0;
	}
	
	pushToTalkKey = ord("V"); //key used to record voice on press
	
	voice_packetTimeStamp = 0; //stores last audio packet timestamp, to check for duplicated audio packets
	voice_packet_fragmented = false; //It can happen that a packet received is incomplete, in that case this variable holds the information of weither the last packet received was fragmented
	voice_fragment_buffer = buffer_create(1,buffer_grow,1); //buffer used to store the fragmented packet
	voice_tmp_buffer = buffer_create(1, buffer_grow, 1);
	voice_send_buffer = buffer_create(1, buffer_grow, 1);
	voice_write_buffer = buffer_create(1, buffer_grow, 1);
	voice_header_buffer = buffer_create(1, buffer_grow, 1);

	//connect to server
	network_set_config(network_config_connect_timeout, 500);
	voice_server_socket = network_create_socket(network_socket_tcp);
	voice_server_connect = network_connect_raw(voice_server_socket, voice_server_ip, voice_server_port);
	
	if voice_server_connect < 0 {
		//connection failed
		scr_voiceclient_stop();
		exit;
	}
	else
	{
		connected_to_voice_server = true;
		voice_client = true;
		display_text  = "Voice chat Client";
		
		audio_debug(true);
		
		scr_voiceclient_send_userinfo();
		
		alarm[1]=room_speed*5; //connection time-out timer, reset by ping packet
		
	}
}