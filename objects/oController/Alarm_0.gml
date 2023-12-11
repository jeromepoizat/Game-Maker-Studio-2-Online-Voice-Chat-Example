/// @description 1second timer

show_inbps = inbps;
show_outbps = outbps;
total_inbps += inbps;
total_outbps += outbps
inbps = 0;
outbps = 0;

if show_inbps > max_inbps {
	max_inbps = show_inbps;
}

if show_outbps > max_outbps {
	max_outbps = show_outbps;
}

show_fps = round(fps_sum / fps_count);
ips = min(60,show_fps);
fps_sum = 0;
fps_count = 0;

alarm[0] = room_speed;


//send ping to client (Server Only)

if (voice_server == true){
	for(var k = ds_map_find_first(global.server_voice_users); !is_undefined(k); k = ds_map_find_next(global.server_voice_users,k) ){
		scr_voiceserver_send_ping(k);
	}
}

