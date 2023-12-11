
function scr_voiceclient_handlemessage(buffer){
	
	while(true) {
		
		var expected_packet_size = 0;
	    var message_id = buffer_read(buffer,buffer_u8);
		
		if (message_id == 99){ //packet with the size information of next packet
			if (buffer_tell(buffer)+4 < buffer_get_size(buffer)){ //packet is of the correct size (at least 4bytes)
				expected_packet_size = buffer_read(buffer,buffer_u32); //read expected size of the incoming packet
			}
			else //packet size is incorrect (incomplete packet)
			{
				//add the packet to the voice_fragment_buffer, exit the message handler and wait for the remaining data
				buffer_delete(voice_fragment_buffer);
		        voice_fragment_buffer = buffer_create(buffer_get_size(buffer) - (buffer_tell(buffer)-1), buffer_fixed, 1); //buffer_tell()-1 to put back the message_id into the buffer
		        buffer_copy(buffer,buffer_tell(buffer)-1,buffer_get_size(buffer) - (buffer_tell(buffer)-1),voice_fragment_buffer,0);
		        voice_packet_fragmented = true;
	            exit; 
			}
		}
		
		
	    if (buffer_get_size(buffer) - (buffer_tell(buffer) ) < expected_packet_size){ // packet is smaller than the expected size = voice_packet_fragmented packet
			//add the packet to the voice_fragment_buffer, exit the message handler and wait for the remaining data
			buffer_delete(voice_fragment_buffer);
		    voice_fragment_buffer = buffer_create(buffer_get_size(buffer) - (buffer_tell(buffer)-5), buffer_fixed, 1); //buffer_tell()-5 to put back the message_id and size into the buffer
		    buffer_copy(buffer,buffer_tell(buffer)-5,buffer_get_size(buffer) - (buffer_tell(buffer)-5),voice_fragment_buffer,0);
			voice_packet_fragmented = true;
		    exit;
	    }
		
		if message_id == 99 {
			message_id = buffer_read(buffer,buffer_u8);
			lastpacket = message_id;
		}


	    switch(message_id)
	    {
			//receive ping 
			case 1:
				scr_voiceclient_send_ping();
			break;
			
			//receive ping value
			case 2:
				ping = buffer_read(buffer,buffer_u16);
			break;
			
			//receive user info
			case 3:
				scr_voiceclient_receive_userinfo(buffer);
			break;
			
			//voice message
			case 4:
				scr_voiceclient_receive_audio(buffer);
			break;
			
			
		}
		
		if( buffer_tell(buffer) >= buffer_get_size(buffer) ){
			break;	
		}
		
	}
}