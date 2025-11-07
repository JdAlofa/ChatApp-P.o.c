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
- **Database**: MySQL
- **Real-Time Communication**: Spring WebSockets with STOMP protocol over SockJS for reliable messaging.

### Frontend (`front/`)

- **Framework**: Angular
- **Language**: TypeScript, HTML, SCSS
- **Real-Time Communication**: `@stomp/stompjs` and `sockjs-client` to connect to the backend WebSocket server.
- **State Management**: RxJS for handling asynchronous message streams.

---

## Prerequisites

Before running the application, ensure you have the following installed:

- **Java 21** (JDK)
- **Maven**
- **Node.js** and **npm**
- **MySQL Server** (running on `localhost:3306`)
- **Angular CLI** (optional, but recommended)

---

## Setup Instructions

### 1. Database Setup

1. Install and start MySQL Server on your machine.
2. The application will automatically create the `car_rentals_db` database on first launch.
3. Ensure MySQL is running on `localhost:3306`.

### 2. Environment Variables Configuration

The backend requires database credentials to be set as environment variables. You have two options:

#### Option A: Using a `.env` File (Recommended for Development)

1. Navigate to the `back/` directory.
2. Create a `.env` file with the following content:
   ```properties
   SPRING_DATASOURCE_USERNAME=root
   SPRING_DATASOURCE_PASSWORD=your_mysql_password
   ```
3. Replace `your_mysql_password` with your actual MySQL root password.
4. The Spring Boot application will automatically load these variables using the `spring-dotenv` dependency.

#### Option B: Setting System Environment Variables

**On Linux/macOS:**

```bash
export SPRING_DATASOURCE_USERNAME=your_username
export SPRING_DATASOURCE_PASSWORD=your_mysql_password
```

**On Windows (Command Prompt):**

```cmd
set SPRING_DATASOURCE_USERNAME=your_username
set SPRING_DATASOURCE_PASSWORD=your_mysql_password
```

**On Windows (PowerShell):**

```powershell
$env:SPRING_DATASOURCE_USERNAME="your_username"
$env:SPRING_DATASOURCE_PASSWORD="your_mysql_password"
```

---

## How to Launch and Test the Application

To run this application, you will need to start both the backend and frontend servers separately.

### 1. Run the Backend Server

The backend is responsible for handling WebSocket connections and broadcasting messages.

1. Open a terminal
2. Navigate to the backend project directory:
   ```sh
   cd back/
   ```
3. Ensure your environment variables are set (see [Environment Variables Configuration](#2-environment-variables-configuration)).
4. Clean the project and run the Spring Boot application using Maven:
   ```sh
   mvn clean spring-boot:run
   ```
5. The backend server will start and listen on `http://localhost:8080`.

**Note:** On first run, the application will create the database schema automatically. After the first successful run, you may want to change `spring.sql.init.mode=always` to `spring.sql.init.mode=never` in `application.properties` to prevent re-creating tables on every restart.

### 2. Run the Frontend Application

The frontend provides the chat interface for users.

1. Open a **new** terminal or command prompt.
2. Navigate to the frontend project directory:
   ```sh
   cd front/
   ```
3. If you haven't already, install the necessary Node.js dependencies:
   ```sh
   npm install
   ```
4. Serve the Angular application:
   ```sh
   ng serve
   ```
5. The frontend development server will start and be accessible at `http://localhost:4200`.

### 3. Test the Live Chat

To see the real-time functionality in action:

1. Open two separate browser windows or tabs.
2. Navigate to `http://localhost:4200` in both windows.
3. In the first window, enter a username (e.g., "UserA") and click "Connect".
4. In the second window, enter a different username (e.g., "UserB") and click "Connect".
5. Type a message in one window and press Enter or click "Send". The message should appear instantly in both chat windows.

---

## Troubleshooting

### Backend won't start - Database connection error

- Verify MySQL is running: `sudo systemctl status mysql` (Linux) or check Services (Windows)
- Confirm your database credentials in the `.env` file or environment variables
- Check that MySQL is listening on port 3306

### Environment variables not loading

- If using `.env` file, ensure it's in the `back/` directory
- For system environment variables, restart your terminal after setting them
- Verify variables are set: `echo $SPRING_DATASOURCE_USERNAME` (Linux/macOS) or `echo %SPRING_DATASOURCE_USERNAME%` (Windows)

### Schema creation fails

- Check the `back/src/main/resources/schema.sql` file for syntax errors
- Verify you have CREATE and DROP privileges on your MySQL user
