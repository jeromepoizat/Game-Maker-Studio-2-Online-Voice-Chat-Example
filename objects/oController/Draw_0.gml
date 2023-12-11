/// @description Draw event
//Draw header text
draw_text(25,25,display_text);

//Draw debug info
draw_text_transformed_color(650,50,"ping : "+string(ping)+" ms",1,1,0,c_orange,c_yellow,c_orange,c_yellow,1);
draw_text_transformed_color(650,50+25,"in : "+string(show_inbps/1000)+" kbps",1,1,0,c_orange,c_yellow,c_orange,c_yellow,1);
draw_text_transformed_color(650,50+25*2,"out : "+string(show_outbps/1000)+" kbps",1,1,0,c_orange,c_yellow,c_orange,c_yellow,1);
draw_text_transformed_color(650,50+25*3,"max in : "+string(max_inbps/1000)+" kbps",1,1,0,c_orange,c_yellow,c_orange,c_yellow,1);
draw_text_transformed_color(650,50+25*4,"max out : "+string(max_outbps/1000)+" kbps",1,1,0,c_orange,c_yellow,c_orange,c_yellow,1);
draw_text_transformed_color(650,50+25*5,"Total in : "+string(round(total_inbps/10000)/100)+" Mb",1,1,0,c_orange,c_yellow,c_orange,c_yellow,1);
draw_text_transformed_color(650,50+25*6,"Total out : "+string(round(total_outbps/10000)/100)+" Mb",1,1,0,c_orange,c_yellow,c_orange,c_yellow,1);
draw_text_transformed_color(650,50+25*7,"last packet : "+string(lastpacket),1,1,0,c_orange,c_yellow,c_orange,c_yellow,1);
draw_text_transformed_color(650,50+25*8,"fps : "+string(show_fps) + "("+string(ips)+")",1,1,0,c_orange,c_yellow,c_orange,c_yellow,1);

//Draw for Client
if (voice_client == true){
	//draw mic info
	draw_text(25,60,"mic_id: "+string(mic_id));
	draw_text(25,90,"mic_set: "+string(mic_set));
	draw_text(25,120,"Push to talk key: "+string(chr(pushToTalkKey)));
	draw_text(25,150,"Press number key to change mic:");
	//draw microphones list
	for (var i = 0; i < number_of_mics; i += 1){
		draw_text(25,150+(i+1)*30,string(i+1)+" - " + mic_names[i]);
	}	
	
	//draw users
	draw_text(650,340,"Online users:");
	var i = 0;
	for(var k = ds_map_find_first(voice_chat_users_dsmap); !is_undefined(k); k = ds_map_find_next(voice_chat_users_dsmap,k) ){	
		i += 1;
		draw_text_transformed_color(
			650,
			350+25*i,
			voice_chat_users_dsmap[? k][? "username"] +
			"(" + string(k) + ") " +
			string(voice_chat_users_dsmap[? k][? "mic_on"]),
			1,1,0,c_aqua,c_aqua,c_white,c_lime,1
		);	
	}
}

//Draw for Server
if (voice_server == true){
	//draw all users
	draw_text(650,340,"Online users:");
	var i = 0;
	for(var k = ds_map_find_first(global.server_voice_users); !is_undefined(k); k = ds_map_find_next(global.server_voice_users,k) ){	
		i += 1;
		draw_text_transformed_color(
			650,
			350+25*i,
			global.server_voice_users[? k][? "username"] +
			"(" + string(k) + ") " +
			string(global.server_voice_users[? k][? "mic_on"]),
			1,1,0,c_aqua,c_aqua,c_white,c_lime,1
		);	
	}
}




