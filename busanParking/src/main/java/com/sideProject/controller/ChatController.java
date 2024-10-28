package com.sideProject.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.sideProject.model.ChatMessageVO;

@Controller
public class ChatController {

	private Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Autowired 
	private final SimpMessagingTemplate messaginTemplate;
	
	public ChatController(SimpMessagingTemplate messaginTemplate) {
		this.messaginTemplate = messaginTemplate;
	}
	
	@MessageMapping("/enter")
	public void sendMessage(ChatMessageVO vo) {
		logger.info("{}가 메시지를 보냄", vo.getFrom());
		
		messaginTemplate.convertAndSend("/broker/room/" + vo.getRoomId(), vo);
	}
}
