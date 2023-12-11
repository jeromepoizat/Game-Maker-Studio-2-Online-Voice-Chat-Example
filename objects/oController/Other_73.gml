/// @description Client recording
//Only applies for client
if (voice_client == true){
	if (mic_set == true) && (mic_on == true){
		var channel = async_load[? "channel_index"]

		if (channel == record_info[mic_id])
		{
			var ds_map = audio_get_recorder_info(channel) //Get devices information
			var rate = ds_map[? "sample_rate"] //Get sample rate
			var format = ds_map[? "data_format"] //Get device data format
			var audio_buffer = async_load[? "buffer_id"]
			var Len = async_load[? "data_len"] //Get Length of recording
			
			scr_voiceclient_send_audio(audio_buffer, Len, rate, format);
			
		}
	}
}


