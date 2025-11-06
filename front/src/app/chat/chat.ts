// filepath: src\app\chat\chat.component.ts
import { Component, OnDestroy, OnInit } from '@angular/core';
import { WebsocketService } from '../services/websocket-service/websocket-service';
import { ChatMessage } from '../../shared/interfaces/chat-message-interface';
import { FormsModule } from '@angular/forms';

import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-chat',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './chat.html',
  styleUrls: ['./chat.scss'],
})
export class ChatComponent implements OnInit, OnDestroy {
  messages: ChatMessage[] = [];
  username: string = '';
  messageContent: string = '';
  isConnected: boolean = false;

  constructor(public websocketService: WebsocketService) {}

  ngOnInit(): void {
    this.websocketService.message$.subscribe((messages) => {
      this.messages = messages;
    });
  }

  connect(): void {
    if (this.username) {
      // Check only for username
      this.websocketService.connect(this.username);
      this.isConnected = true;
    } else {
      alert('Please enter a username.'); // Updated alert
    }
  }

  disconnect(): void {
    this.websocketService.disconnect();
    this.isConnected = false;
    this.messages = []; // Clear messages on disconnect
  }

  sendMessage(): void {
    if (this.messageContent.trim() !== '') {
      const chatMessage: ChatMessage = {
        from: this.username,
        to: 'all',
        content: this.messageContent,
      };
      this.websocketService.sendMessage(chatMessage);
      this.messageContent = '';
    }
  }

  ngOnDestroy(): void {
    this.disconnect();
  }
}
