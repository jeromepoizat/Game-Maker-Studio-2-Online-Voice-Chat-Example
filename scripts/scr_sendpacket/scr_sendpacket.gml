function scr_sendpacket(socket, w_buffer, h_buffer, s_buffer){
	
	var w_b_tell = buffer_tell(w_buffer);
	
	//Add the message size info at the beginning of the message
	buffer_seek(h_buffer, buffer_seek_start, 0);
	buffer_write(h_buffer, buffer_u8, 99);
	buffer_write(h_buffer, buffer_u32,w_b_tell);
	
	var h_b_tell = buffer_tell(h_buffer);
	
	buffer_copy(h_buffer, 0, h_b_tell, s_buffer, 0);
	buffer_copy(w_buffer, 0, w_b_tell, s_buffer, h_b_tell);
	
	network_send_raw(socket, s_buffer, h_b_tell + w_b_tell);
	
	//count sent data
	outbps += (h_b_tell + w_b_tell);
}