package com.chatapp;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import com.chatapp.models.ChatMessage;

@Controller
public class ChatController {

    @MessageMapping("/chat")
    @SendTo("/topic/public")
    public ChatMessage processMessage(@Payload ChatMessage chatMessage) {
        // The received message is returned and broadcast to all subscribers of
        // /topic/public
        return chatMessage;
    }
}
