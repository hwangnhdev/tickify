-- Database: TicketBooking
CREATE DATABASE TickifyDB;
GO
USE TickifyDB;
GO

-- Customers Table
CREATE TABLE Customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(15),
    profile_picture VARCHAR(255),
    status BIT DEFAULT 1
);

-- Admins Table
CREATE TABLE Admins (
    admin_id INT IDENTITY(1,1) PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    profile_picture VARCHAR(255)
);

-- Categories Table
CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(100) NOT NULL,
    description TEXT,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Events Table
CREATE TABLE Events (
    event_id INT IDENTITY(1,1) PRIMARY KEY,
    category_id INT,
    event_name VARCHAR(255) NOT NULL,
    location VARCHAR(255),
    event_type VARCHAR(100),
    status VARCHAR(100),
    description TEXT,
    start_date DATETIME NOT NULL,
    end_date DATETIME NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- EventImages Table
CREATE TABLE EventImages (
    image_id INT IDENTITY(1,1) PRIMARY KEY,
    event_id INT NOT NULL,
    image_url VARCHAR(2083) NOT NULL,
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- Seats Table
CREATE TABLE Seats (
    seat_id INT IDENTITY(1,1) PRIMARY KEY,
    event_id INT,
    seat_row VARCHAR(10),
    seat_number VARCHAR(10),
    status VARCHAR(10),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- TicketTypes Table
CREATE TABLE TicketTypes (
    ticket_type_id INT IDENTITY(1,1) PRIMARY KEY,
    event_id INT,
    name NVARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    total_quantity INT NOT NULL,
    sold_quantity INT DEFAULT 0,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- Vouchers Table
CREATE TABLE Vouchers (
    voucher_id INT IDENTITY(1,1) PRIMARY KEY,
    code VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    discount_type VARCHAR(100),
    discount_value DECIMAL(10,2),
    expiration_date DATETIME,
    usage_limit INT,
    status BIT DEFAULT 1,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE()
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    voucher_id INT,
    total_price DECIMAL(10,2) NOT NULL,
    order_date DATETIME DEFAULT GETDATE(),
    payment_status VARCHAR(100),
    transaction_id VARCHAR(100),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (voucher_id) REFERENCES Vouchers(voucher_id)
);

-- OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    ticket_type_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (ticket_type_id) REFERENCES TicketTypes(ticket_type_id)
);

-- Tickets Table
CREATE TABLE Tickets (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    order_detail_id INT,
    seat_id INT,
    ticket_code VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    status VARCHAR(100),
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_detail_id) REFERENCES OrderDetails(order_detail_id),
    FOREIGN KEY (seat_id) REFERENCES Seats(seat_id)
);

-- Customer_auths Table
CREATE TABLE Customer_auths (
    customer_auth_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    auth_provider VARCHAR(100) NOT NULL,
    password VARCHAR(255) NULL,
    provider_id VARCHAR(255) NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Organizers Table
CREATE TABLE Organizers (
    organizer_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    event_id INT NOT NULL,
    organization_name VARCHAR(150) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (event_id) REFERENCES Events(event_id)
);

-- Insert sample data for Customers
INSERT INTO Customers (full_name, email, address, phone, profile_picture, status) VALUES
('John Doe', 'john@example.com', '123 Main St', '1234567890', 'john.jpg', 1),
('Alice Smith', 'alice@example.com', '456 Park Ave', '9876543210', 'alice.jpg', 1),
('Bob Johnson', 'bob@example.com', '789 Elm St', '5556667777', 'bob.jpg', 1),
('Emma Davis', 'emma@example.com', '321 Pine St', '1112223333', 'emma.jpg', 1),
('Michael Brown', 'michael@example.com', '654 Oak St', '4445556666', 'michael.jpg', 1);

-- Insert sample data for Admins
INSERT INTO Admins (name, email, password, profile_picture) VALUES
('Admin One', 'admin1@example.com', 'hashed_password1', 'admin1.jpg'),
('Admin Two', 'admin2@example.com', 'hashed_password2', 'admin2.jpg'),
('Admin Three', 'admin3@example.com', 'hashed_password3', 'admin3.jpg'),
('Admin Four', 'admin4@example.com', 'hashed_password4', 'admin4.jpg'),
('Admin Five', 'admin5@example.com', 'hashed_password5', 'admin5.jpg');

-- Insert sample data for Events
INSERT INTO Events (category_id, event_name, location, event_type, status, description, start_date, end_date) VALUES
(1, 'Concert A', 'Stadium 1', 'Music', 'Active', 'A great concert event.', '2025-06-01', '2025-06-02'),
(2, 'Tech Conference', 'Convention Center', 'Technology', 'Active', 'Annual tech conference.', '2025-07-10', '2025-07-12'),
(3, 'Art Expo', 'Gallery Hall', 'Exhibition', 'Active', 'Art exhibition of modern artists.', '2025-08-15', '2025-08-16'),
(4, 'Sports Final', 'Arena 5', 'Sports', 'Active', 'Championship final match.', '2025-09-20', '2025-09-20'),
(5, 'Food Festival', 'City Park', 'Festival', 'Active', 'A variety of cuisines to enjoy.', '2025-10-05', '2025-10-06');

-- Insert sample data for Customer_auths
INSERT INTO Customer_auths (customer_id, auth_provider, password, provider_id) VALUES
(1, 'EMAIL', 'hashed_password1', NULL),
(2, 'GOOGLE', NULL, 'google_id_2'),
(3, 'FACEBOOK', NULL, 'facebook_id_3'),
(4, 'EMAIL', 'hashed_password4', NULL),
(5, 'GOOGLE', NULL, 'google_id_5');
