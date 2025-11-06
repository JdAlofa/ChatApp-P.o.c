# Real-Time Chat Application - Proof of Concept

This project is a proof-of-concept (PoC) for a real-time web-based chat application. It demonstrates a full-stack implementation of a public chat room where multiple users can connect and exchange messages instantly.

The repository is structured into two main parts:

- `back/`: A Spring Boot application that serves as the WebSocket backend.
- `front/`: An Angular single-page application that provides the user interface.

---

## Technology Stack

### Backend (`back/`)

- **Framework**: Spring Boot
- **Language**: Java
- **Build Tool**: Maven
- **Real-Time Communication**: Spring WebSockets with STOMP protocol over SockJS for reliable messaging.

### Frontend (`front/`)

- **Framework**: Angular
- **Language**: TypeScript, HTML, SCSS
- **Real-Time Communication**: `@stomp/stompjs` and `sockjs-client` to connect to the backend WebSocket server.
- **State Management**: RxJS for handling asynchronous message streams.

---

## How to Launch and Test the Application

To run this application, you will need to start both the backend and frontend servers separately.

### 1. Run the Backend Server

The backend is responsible for handling WebSocket connections and broadcasting messages.

1.  Open a terminal
2.  Navigate to the backend project directory: 
3.  Clean the project and run the Spring Boot application using Maven:
    ```sh
    mvn clean spring-boot:run
    ```
4.  The backend server will start and listen on `http://localhost:8080`.

### 2. Run the Frontend Application

The frontend provides the chat interface for users.

1.  Open a **new** terminal or command prompt.
2.  Navigate to the frontend project directory:
3.  If you haven't already, install the necessary Node.js dependencies:
    ```sh
    npm install
    ```
4.  Serve the Angular application:
    ```sh
    ng serve
    ```
5.  The frontend development server will start and be accessible at `http://localhost:4200`.

### 3. Test the Live Chat

To see the real-time functionality in action:

1.  Open two separate browser windows or tabs.
2.  Navigate to `http://localhost:4200` in both windows.
3.  In the first window, enter a username (e.g., "UserA") and click "Connect".
4.  In the second window, enter a different username (e.g., "UserB") and click "Connect".
5.  Type a message in one window and press Enter or click "Send". The message should appear instantly in both chat windows.
