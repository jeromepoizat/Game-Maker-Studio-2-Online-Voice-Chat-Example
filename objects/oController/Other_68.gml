switch(async_load[? "type"]){
	
	case network_type_connect:
		//Server only
		
		//var _m_ip = async_load[? "ip" ];
		var _m_port = async_load[? "port" ];
        var _m_buffer = async_load[? "buffer" ];
        //var _m_size   = async_load[? "size" ];
		var _m_socket = async_load[? "socket"];
	
		if (voice_server == true) && (_m_port == voice_server_port){
			scr_voiceserver_userconnect(_m_socket);
		}
		
	break;
	
	
	case network_type_disconnect:
		//Server only
		
		//var _m_ip = async_load[? "ip" ];
		var _m_port = async_load[? "port" ];
        var _m_buffer = async_load[? "buffer" ];
        //var _m_size   = async_load[? "size" ];
		var _m_socket = async_load[? "socket"];

		if (voice_server == true) &&  (_m_port == voice_server_port) && (_m_socket != undefined){
			//send to all clients that user disconnected
			scr_voiceserver_userdisconnect(_m_socket);
		}
		
	break;
	
        
    case network_type_data:
		//Client and Server
		
		//var _m_ip = async_load[? "ip" ];
		var _m_port = async_load[? "port" ];
        var _m_buffer = async_load[? "buffer" ];
        var _m_size   = async_load[? "size" ];
		var _m_socket = async_load[? "id"];
		
		inbps += _m_size;
		
		if (_m_port == voice_server_port) && (_m_socket != undefined){
				
			//CLIENT
			if voice_client == true {
				
				if voice_packet_fragmented == true {
					var _voice_tmp_buffer = buffer_create(buffer_get_size(_m_buffer) + buffer_get_size(voice_fragment_buffer), buffer_fixed, 1);
				
					buffer_copy(voice_fragment_buffer, 0, buffer_get_size(voice_fragment_buffer), _voice_tmp_buffer,0);
					buffer_copy(_m_buffer, 0, buffer_get_size(_m_buffer), _voice_tmp_buffer, buffer_get_size(_voice_tmp_buffer));
				
					voice_packet_fragmented = false;
					
					scr_voiceclient_handlemessage(_voice_tmp_buffer);
						
					buffer_delete(_voice_tmp_buffer);
				}
				else
				{
					scr_voiceclient_handlemessage(_m_buffer);
				}
			}
				
			//SERVER
			if voice_server == true {
				if voice_packet_fragmented[@ _m_socket] == true {

					var _voice_tmp_buffer = buffer_create(buffer_get_size(_m_buffer) + buffer_get_size(voice_fragment_buffer[@ _m_socket]), buffer_fixed, 1);
				
					buffer_copy(voice_fragment_buffer[@ _m_socket], 0, buffer_get_size(voice_fragment_buffer[@ _m_socket]), _voice_tmp_buffer,0);
					buffer_copy(_m_buffer, 0, buffer_get_size(_m_buffer), _voice_tmp_buffer, buffer_get_size(_voice_tmp_buffer));
				
					voice_packet_fragmented[@ _m_socket] = false;
					
					scr_voiceserver_handlemessage(_voice_tmp_buffer, _m_socket);
						
					buffer_delete(_voice_tmp_buffer);
				}
				else {
					scr_voiceserver_handlemessage(_m_buffer, _m_socket);	
				}
			}
		}
		
    break;
	
}