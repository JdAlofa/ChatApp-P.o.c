import { Injectable } from '@angular/core';
import { Client, IMessage } from '@stomp/stompjs';
import { BehaviorSubject, Observable } from 'rxjs';
import { ChatMessage } from '../../../shared/interfaces/chat-message-interface';

@Injectable({
  providedIn: 'root',
})
export class WebsocketService {
  private client: Client;
  private messageSubject: BehaviorSubject<ChatMessage[]> = new BehaviorSubject<ChatMessage[]>([]);
  public message$: Observable<ChatMessage[]> = this.messageSubject.asObservable();

  constructor() {
    this.client = new Client({
      brokerURL: 'ws://localhost:8080/gs-guide-websocket',
      reconnectDelay: 5000,
      heartbeatIncoming: 4000,
      heartbeatOutgoing: 4000,
    });
    this.client.onConnect = (frame) => {
      console.log('Connected : Frame ' + frame);

      // Subscribe to the public topic for group chat messages
      this.client.subscribe('/topic/public', (message: IMessage) => {
        const chatMessage = JSON.parse(message.body) as ChatMessage;
        const currentMessages = this.messageSubject.getValue();
        this.messageSubject.next([...currentMessages, chatMessage]);
      });
    };

    this.client.onStompError = (frame) => {
      console.error('Broker reported error: ' + frame.headers['message']);
      console.error('Additional error details: ' + frame.body);
    };
  }
  connect(username: string) {
    // The username is passed as a header, which Spring Security can use for authentication
    // For this example, we are just using it to identify the user session
    this.client.connectHeaders = {
      user: username,
    };
    this.client.activate();
  }

  disconnect() {
    this.client.deactivate();
    console.log('Disconnected');
  }

  sendMessage(chatMessage: ChatMessage) {
    this.client.publish({ destination: '/app/chat', body: JSON.stringify(chatMessage) });
  }
}
