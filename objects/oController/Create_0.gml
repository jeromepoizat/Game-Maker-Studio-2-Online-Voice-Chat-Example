/// @description Init variables

//general variables
voice_client = false; //applcation is set as client
voice_server = false; //applcation is set as server
display_text = "Press 'C' to start a voice client \n Press 'S' to start a voice server"; //text displayed

//network variables (used both in client and server)
voice_server_ip = "localhost"
voice_server_port = 2623;

//debug variables (used both in client and server)
ping = 0;
inbps = 0;
outbps = 0;
max_inbps = 0;
max_outbps = 0;
total_inbps = 0;
total_outbps = 0;
show_inbps = inbps;
show_outbps = outbps;
fps_count = 0;
fps_sum = 0;
show_fps = 0;
ips = 60;
lastpacket = -1;

alarm[0]= room_speed;
