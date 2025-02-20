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
    description VARCHAR(MAX),
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
	image_title VARCHAR(255) NOT NULL,
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
