DROP TABLE IF EXISTS message_supports;
DROP TABLE IF EXISTS ticket_supports;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS reservations;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS agencies;
DROP TABLE IF EXISTS clients;

-- Table for Agencies
CREATE TABLE agencies (
    agency_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    opening_hours VARCHAR(100)
);

--Table for clients
CREATE TABLE clients (
    client_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    birthday DATE,
    driving_license_number VARCHAR(50) NOT NULL UNIQUE
);

-- Table for Vehicles
-- A vehicle belongs to one agency.
CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT PRIMARY KEY,
    category VARCHAR(50) NOT NULL,
    model VARCHAR(100) NOT NULL,
    fuel VARCHAR(50),
    registration_plate VARCHAR(20) NOT NULL UNIQUE,
    transmission VARCHAR(50),
    agency_id INT,
    FOREIGN KEY (agency_id) REFERENCES agencies(agency_id) ON DELETE SET NULL
);

-- Table for Reservations
-- A reservation is made by one client for one vehicle.
CREATE TABLE reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    beginning_date DATE NOT NULL,
    end_date DATE NOT NULL,
    amount_paid DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL, -- e.g., 'CONFIRMED', 'CANCELLED', 'COMPLETED'
    client_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id) ON DELETE RESTRICT
);

-- Table for Payments
-- A reservation can have multiple payments.
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50) NOT NULL, -- e.g., 'SUCCESS', 'FAILED', 'PENDING'
    amount DECIMAL(10, 2) NOT NULL,
    creation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    provider_ref VARCHAR(255), -- e.g., Stripe or PayPal transaction ID
    reservation_id INT NOT NULL,
    FOREIGN KEY (reservation_id) REFERENCES reservations(reservation_id) ON DELETE CASCADE
);

-- Table for Support Tickets
-- A client can have multiple support tickets.
CREATE TABLE ticket_supports (
    ticket_id INT AUTO_INCREMENT PRIMARY KEY,
    status VARCHAR(50) NOT NULL, -- e.g., 'OPEN', 'IN_PROGRESS', 'CLOSED'
    subject VARCHAR(255) NOT NULL,
    contact_medium VARCHAR(50), -- e.g., 'EMAIL', 'PHONE'
    client_id INT NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE
);

-- Table for Support Messages
-- A ticket can have multiple messages.
CREATE TABLE message_supports (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    client_id INT, -- Tracks who sent the message (client or an agent)
    ticket_id INT NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES ticket_supports(ticket_id) ON DELETE CASCADE,
    FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE SET NULL
);
