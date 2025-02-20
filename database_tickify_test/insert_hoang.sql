-- Chèn dữ liệu vào Customers
INSERT INTO Customers (full_name, email, address, phone, profile_picture, status) VALUES
('John Doe', 'john@example.com', '123 Main St', '1234567890', 'john.jpg', 1),
('Alice Smith', 'alice@example.com', '456 Park Ave', '9876543210', 'alice.jpg', 1),
('Bob Johnson', 'bob@example.com', '789 Elm St', '5556667777', 'bob.jpg', 1),
('Emma Davis', 'emma@example.com', '321 Pine St', '1112223333', 'emma.jpg', 1),
('Michael Brown', 'michael@example.com', '654 Oak St', '4445556666', 'michael.jpg', 1);

-- Chèn dữ liệu vào Admins
INSERT INTO Admins (name, email, password, profile_picture) VALUES
('Admin One', 'admin1@example.com', 'hashed_password1', 'admin1.jpg'),
('Admin Two', 'admin2@example.com', 'hashed_password2', 'admin2.jpg');

-- Chèn dữ liệu vào Categories
INSERT INTO Categories (category_name, description) VALUES
('Concert', 'Live music performances.'),
('Technology', 'Tech events and conferences.'),
('Sports', 'Live sports events.'),
('Festival', 'Cultural and food festivals.'),
('Exhibition', 'Art, science, and industry exhibitions.');

-- Chèn dữ liệu vào Events
INSERT INTO Events (category_id, event_name, location, event_type, status, description, start_date, end_date) VALUES
(1, 'Rock Festival', 'Open Arena', 'Music', 'Active', 'Rock bands live.', '2025-06-20', '2025-06-21'),
(2, 'AI & Robotics Summit', 'Tech Hub', 'Technology', 'Active', 'Advancements in AI.', '2025-07-25', '2025-07-26'),
(3, 'National Basketball League', 'Sports Arena', 'Sports', 'Active', 'Finals of national basketball.', '2025-09-30', '2025-10-01'),
(4, 'Christmas Market', 'Downtown Plaza', 'Festival', 'Active', 'Holiday shopping & food.', '2025-12-15', '2025-12-25'),
(5, 'Classic Paintings Showcase', 'Museum Hall', 'Exhibition', 'Active', 'Display of classic artworks.', '2025-08-30', '2025-08-31'),
(1, 'Hip Hop Night', 'Club XYZ', 'Music', 'Active', 'Live hip hop music.', '2025-07-10', '2025-07-11'),
(1, 'Jazz Evening', 'Jazz Lounge', 'Music', 'Active', 'Smooth jazz night.', '2025-08-05', '2025-08-05'),
(2, 'Blockchain Expo', 'Tech Convention Center', 'Technology', 'Active', 'Blockchain innovations.', '2025-09-20', '2025-09-21'),
(2, 'Cybersecurity Forum', 'Virtual Event', 'Technology', 'Active', 'Talks on cyber threats.', '2025-10-12', '2025-10-13'),
(3, 'Marathon 2025', 'City Streets', 'Sports', 'Active', 'Annual city marathon.', '2025-11-05', '2025-11-05'),
(3, 'Tennis Open', 'Grand Stadium', 'Sports', 'Active', 'National tennis tournament.', '2025-12-01', '2025-12-05'),
(4, 'Food & Wine Festival', 'Park Grounds', 'Festival', 'Active', 'Gourmet food tasting.', '2025-10-15', '2025-10-16'),
(4, 'Halloween Carnival', 'Downtown', 'Festival', 'Active', 'Costume party & games.', '2025-10-31', '2025-10-31'),
(5, 'Tech Gadgets Expo', 'Convention Hall', 'Exhibition', 'Active', 'Latest tech gadgets.', '2025-09-01', '2025-09-02'),
(5, 'Space Exploration Fair', 'Science Center', 'Exhibition', 'Active', 'Space tech innovations.', '2025-11-10', '2025-11-12'),
(1, 'K-Pop Concert', 'Stadium ABC', 'Music', 'Active', 'Live K-Pop performances.', '2025-12-20', '2025-12-21'),
(3, 'Football Championship', 'National Stadium', 'Sports', 'Active', 'Top football teams.', '2025-11-30', '2025-12-01'),
(4, 'Christmas Celebration', 'Central Park', 'Festival', 'Active', 'Christmas music & lights.', '2025-12-24', '2025-12-25'),
(2, 'Startup Pitch Night', 'Tech Hub', 'Technology', 'Active', 'Startup investment opportunities.', '2025-09-15', '2025-09-15'),
(5, 'Photography Exhibition', 'Gallery Hall', 'Exhibition', 'Active', 'Showcasing world-class photography.', '2025-08-25', '2025-08-26'),
(1, 'Indie Rock Night', 'Music Hall', 'Music', 'Active', 'Live indie rock performances.', '2025-07-15', '2025-07-15'),
(1, 'Electronic Dance Festival', 'Beachside Arena', 'Music', 'Active', 'A night of EDM and DJs.', '2025-08-22', '2025-08-23'),
(2, 'Future Tech Conference', 'Innovation Hub', 'Technology', 'Active', 'Discussing future tech trends.', '2025-11-20', '2025-11-21'),
(2, 'Virtual Reality Summit', 'Tech Center', 'Technology', 'Active', 'Exploring VR advancements.', '2025-10-05', '2025-10-06'),
(3, 'International Chess Tournament', 'Grand Hall', 'Sports', 'Active', 'Global chess masters compete.', '2025-09-10', '2025-09-15'),
(3, 'Extreme Sports Expo', 'Mountain Park', 'Sports', 'Active', 'Showcasing extreme sports.', '2025-06-28', '2025-06-29'),
(4, 'Cultural Heritage Fair', 'City Square', 'Festival', 'Active', 'Traditional arts and crafts.', '2025-07-05', '2025-07-07'),
(4, 'Lantern Festival', 'Riverside Park', 'Festival', 'Active', 'Lanterns lighting up the night.', '2025-09-18', '2025-09-18'),
(5, 'Modern Art Exhibition', 'Art Gallery', 'Exhibition', 'Active', 'Contemporary art showcase.', '2025-07-12', '2025-07-14'),
(5, 'Historical Artifacts Display', 'National Museum', 'Exhibition', 'Active', 'Ancient relics and history.', '2025-11-02', '2025-11-05'),
(1, 'Acoustic Music Night', 'Cozy Café', 'Music', 'Active', 'Intimate acoustic performances.', '2025-06-25', '2025-06-25'),
(2, 'AI Ethics Panel', 'Online Webinar', 'Technology', 'Active', 'Debating AI’s ethical impact.', '2025-08-15', '2025-08-15'),
(3, 'City Cycling Race', 'Downtown Streets', 'Sports', 'Active', 'Annual city cycling event.', '2025-09-08', '2025-09-08'),
(4, 'Oktoberfest Celebration', 'Beer Garden', 'Festival', 'Active', 'German beer & culture.', '2025-10-10', '2025-10-12'),
(5, 'Futuristic Architecture Expo', 'Convention Center', 'Exhibition', 'Active', 'Innovations in architecture.', '2025-12-05', '2025-12-07'),
(1, 'Blues & Soul Night', 'City Lounge', 'Music', 'Active', 'Relaxing blues and soul tunes.', '2025-08-18', '2025-08-18'),
(2, 'Green Energy Forum', 'Sustainability Center', 'Technology', 'Active', 'Future of renewable energy.', '2025-11-28', '2025-11-29'),
(3, 'Pro Wrestling Showdown', 'Stadium XYZ', 'Sports', 'Active', 'High-energy wrestling matches.', '2025-07-30', '2025-07-30'),
(4, 'Harvest Festival', 'Farm Grounds', 'Festival', 'Active', 'Celebrating autumn harvest.', '2025-10-05', '2025-10-07'),
(5, 'Anime & Manga Convention', 'Expo Hall', 'Exhibition', 'Active', 'Celebrating anime culture.', '2025-09-22', '2025-09-23');


-- Chèn dữ liệu vào Seats
INSERT INTO Seats (event_id, seat_row, seat_number, status) VALUES
(1, 'A', '1', 'Available'),
(1, 'A', '2', 'Booked'),
(2, 'B', '10', 'Available'),
(2, 'B', '11', 'Booked');

-- Chèn dữ liệu vào TicketTypes
INSERT INTO TicketTypes (event_id, name, description, price, total_quantity) VALUES
(1, 'VIP', 'Front row seats', 100.00, 500),
(1, 'Standard', 'Regular seats', 50.00, 1000),
(2, 'Early Bird', 'Discounted tickets', 40.00, 300),
(6, 'VIP', 'Exclusive access', 150.00, 300),
(7, 'Standard', 'Regular ticket', 75.00, 500),
(8, 'General', 'Entry ticket', 50.00, 1000),
(9, 'Early Bird', 'Discounted ticket', 40.00, 200),
(10, 'Premium', 'Front row seats', 200.00, 150),
(11, 'VIP', 'Best seats', 250.00, 100),
(12, 'General Admission', 'Standard entry', 60.00, 700),
(13, 'Festival Pass', 'Access to all days', 90.00, 400),
(14, 'Day Pass', 'One day entry', 30.00, 600),
(15, 'Standard', 'General entry', 55.00, 900);

-- Chèn dữ liệu vào Vouchers
INSERT INTO Vouchers (code, description, discount_type, discount_value, expiration_date, usage_limit) VALUES
('SUMMER10', '10% off summer events', 'PERCENTAGE', 10.00, '2025-08-31', 1000),
('WELCOME50', '50K discount for new users', 'FIXED', 50.00, '2025-12-31', 500);

-- Chèn dữ liệu vào Orders
INSERT INTO Orders (customer_id, voucher_id, total_price, payment_status, transaction_id) VALUES
(1, NULL, 180.00, 'Completed', 'TXN123470'),
(2, 1, 290.00, 'Completed', 'TXN123471'),
(3, NULL, 350.00, 'Pending', 'TXN123472'),
(1, NULL, 500.00, 'Completed', 'TXN123473'),
(2, NULL, 300.00, 'Completed', 'TXN123474'),
(3, NULL, 400.00, 'Completed', 'TXN123475'),
(4, NULL, 250.00, 'Completed', 'TXN123476'),
(5, NULL, 350.00, 'Completed', 'TXN123477');

-- Chèn dữ liệu vào OrderDetails
INSERT INTO OrderDetails (order_id, ticket_type_id, quantity, price) VALUES
(1, 1, 2, 180.00),
(2, 2, 3, 290.00),
(3, 3, 1, 350.00),
(4, 6, 2, 300.00),
(4, 7, 3, 225.00),
(5, 8, 5, 250.00),
(5, 9, 1, 40.00),
(5, 10, 2, 400.00),
(3, 11, 2, 500.00),
(3, 12, 4, 240.00),
(2, 13, 3, 270.00),
(2, 14, 2, 60.00),
(1, 15, 4, 220.00);

-- Chèn dữ liệu vào Tickets
INSERT INTO Tickets (order_detail_id, seat_id, ticket_code, price, status) VALUES
(1, 1, 'TICKET123', 100.00, 'Valid'),
(2, 2, 'TICKET124', 50.00, 'Valid'),
(3, 3, 'TICKET125', 40.00, 'Used');

-- Chèn dữ liệu vào Customer_auths
INSERT INTO Customer_auths (customer_id, auth_provider, password, provider_id) VALUES
(1, 'EMAIL', 'hashed_password1', NULL),
(2, 'GOOGLE', NULL, 'google_id_2');

-- Chèn dữ liệu vào Organizers
INSERT INTO Organizers (customer_id, event_id, organization_name) VALUES
(1, 1, 'Music Corp'),
(2, 2, 'Tech World');
