package com.sideProject.model;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ChatMessageVO {

	private String from;
	private String content;
	private String roomId;
	private String time;
	
	Date now = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
	
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public String getTime() {
		time = sdf.format(now);
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
}
