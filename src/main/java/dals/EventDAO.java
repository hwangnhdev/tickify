package dals;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import models.Category;
import models.Event;
import models.EventImage;
import models.Organizer;
import models.Seat;
import models.ShowTime;
import models.TicketType;
import utils.DBContext;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class EventDAO extends DBContext {

    // Phương thức để cập nhật sự kiện bằng stored procedure [dbo].[UpdateEventByID]
    public boolean updateEventByID(
            int eventId,
            int customerId,
            String organizationName,
            String accountHolder,
            String accountNumber,
            String bankName,
            int categoryId,
            String eventName,
            String location,
            String eventType,
            String description,
            String status,
            String eventLogoUrl,
            String backgroundImageUrl,
            String organizerImageUrl,
            List<ShowTime> showTimes,
            List<TicketType> ticketTypes,
            List<Seat> seats) {

        // Khởi tạo Gson với định dạng ngày giờ khớp với SQL Server DATETIME (yyyy-MM-dd HH:mm:ss)
        Gson gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd HH:mm:ss")
                .create();

        // Chuẩn bị JSON cho ShowTimes, TicketTypes và Seats
        String showTimesJson = prepareShowTimesJson(showTimes, gson);
        String ticketTypesJson = prepareTicketTypesJson(ticketTypes, showTimes, gson);
        String seatsJson = (seats != null && !seats.isEmpty()) ? prepareSeatsJson(seats, gson) : null;

        String sql = "{CALL [dbo].[UpdateEventByID](?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";

        try ( CallableStatement stmt = connection.prepareCall(sql)) {
            // Thiết lập các tham số đầu vào khớp với stored procedure
            stmt.setInt(1, eventId);
            stmt.setInt(2, customerId);
            stmt.setString(3, organizationName);
            stmt.setString(4, accountHolder);
            stmt.setString(5, accountNumber);
            stmt.setString(6, bankName);
            stmt.setInt(7, categoryId);
            stmt.setString(8, eventName);
            stmt.setString(9, location);
            stmt.setString(10, eventType);
            stmt.setString(11, description);
            stmt.setString(12, status);
            stmt.setString(13, eventLogoUrl);
            stmt.setString(14, backgroundImageUrl);
            stmt.setString(15, organizerImageUrl);
            stmt.setString(16, showTimesJson);
            stmt.setString(17, ticketTypesJson);
            if (seatsJson != null) {
                stmt.setString(18, seatsJson);
            } else {
                stmt.setNull(18, Types.NVARCHAR);
            }

            // Thực thi stored procedure
            stmt.execute();

            // Nếu thực thi thành công, trả về true
            return true;

        } catch (SQLException e) {
            System.err.println("Lỗi khi cập nhật sự kiện: " + e.getMessage());
            e.printStackTrace(); // In stack trace để debug
            return false;
        }
    }

    // Method to create an event using the stored procedure [dbo].[CreateEvent]
    public EventCreationResult createEvent(
            int customerId,
            String organizationName,
            String accountHolder,
            String accountNumber,
            String bankName,
            int categoryId,
            String eventName,
            String location,
            String eventType,
            String description,
            String status,
            String eventLogoUrl,
            String backgroundImageUrl,
            String organizerImageUrl,
            List<ShowTime> showTimes,
            List<TicketType> ticketTypes,
            List<Seat> seats) {

        // Initialize Gson with custom date format matching SQL Server DATETIME (yyyy-MM-dd HH:mm:ss)
        Gson gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd HH:mm:ss")
                .create();

        // Prepare JSON for ShowTimes, TicketTypes, and Seats
        String showTimesJson = prepareShowTimesJson(showTimes, gson);
        String ticketTypesJson = prepareTicketTypesJson(ticketTypes, showTimes, gson);
        String seatsJson = (seats != null && !seats.isEmpty()) ? prepareSeatsJson(seats, gson) : null; // Removed ticketTypes parameter since ticketTypeName is now in Seat

        String sql = "{CALL [dbo].[CreateEvent](?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        EventCreationResult result = new EventCreationResult();

        try ( CallableStatement stmt = connection.prepareCall(sql)) {
            // Set input parameters (match stored procedure parameters)
            stmt.setInt(1, customerId);
            stmt.setString(2, organizationName);
            stmt.setString(3, accountHolder);
            stmt.setString(4, accountNumber);
            stmt.setString(5, bankName);
            stmt.setInt(6, categoryId);
            stmt.setString(7, eventName);
            stmt.setString(8, location);
            stmt.setString(9, eventType);
            stmt.setString(10, description);
            stmt.setString(11, status);
            stmt.setString(12, eventLogoUrl);
            stmt.setString(13, backgroundImageUrl);
            stmt.setString(14, organizerImageUrl);
            stmt.setString(15, showTimesJson);
            stmt.setString(16, ticketTypesJson);
            if (seatsJson != null) {
                stmt.setString(17, seatsJson);
            } else {
                stmt.setNull(17, Types.NVARCHAR);
            }

            // Register output parameters
            stmt.registerOutParameter(18, Types.INTEGER); // @EventId
            stmt.registerOutParameter(19, Types.INTEGER); // @OrganizerId

            // Execute the stored procedure and log for debugging
            System.out.println("Executing stored procedure with ShowTimes JSON: " + showTimesJson);
            System.out.println("Executing stored procedure with TicketTypes JSON: " + ticketTypesJson);
            System.out.println("Executing stored procedure with Seats JSON: " + seatsJson);
            stmt.execute();

            // Retrieve output parameters
            result.eventId = stmt.getInt(18);
            result.organizerId = stmt.getInt(19);

            // Check if the creation was successful
            if (result.eventId == -1 || result.organizerId == -1) {
                throw new SQLException("Failed to create event. EventId or OrganizerId returned -1. Check SQL Server logs for details.");
            }

        } catch (SQLException e) {
            System.err.println("Error creating event: " + e.getMessage());
            e.printStackTrace(); // Log full stack trace for debugging
            result.eventId = -1;
            result.organizerId = -1;
        }

        return result;
    }

    // Helper method to prepare ShowTimes JSON
    private String prepareShowTimesJson(List<ShowTime> showTimes, Gson gson) {
        if (showTimes == null || showTimes.isEmpty()) {
            throw new IllegalArgumentException("ShowTimes list cannot be null or empty");
        }

        List<Object> showTimesList = new ArrayList<>();
        for (ShowTime st : showTimes) {
            if (st.getStartDate() == null || st.getEndDate() == null) {
                throw new IllegalArgumentException("StartDate and EndDate in ShowTimes cannot be null");
            }
            showTimesList.add(new ShowTimeJson(
                    st.getStartDate(),
                    st.getEndDate(),
                    st.getStatus() != null ? st.getStatus() : "Scheduled"
            ));
        }
        return gson.toJson(showTimesList);
    }

    // Helper method to prepare TicketTypes JSON
    private String prepareTicketTypesJson(List<TicketType> ticketTypes, List<ShowTime> showTimes, Gson gson) {
        if (ticketTypes == null || ticketTypes.isEmpty()) {
            throw new IllegalArgumentException("TicketTypes list cannot be null or empty");
        }
        if (showTimes == null || showTimes.isEmpty()) {
            throw new IllegalArgumentException("ShowTimes list cannot be null or empty for TicketTypes mapping");
        }

        List<Object> ticketTypesList = new ArrayList<>();
        int showTimeIndex = 0;

        for (TicketType tt : ticketTypes) {
            if (tt.getName() == null || tt.getTotalQuantity() <= 0) {
                throw new IllegalArgumentException("Ticket name and totalQuantity are required for each ticket type");
            }

            if (showTimeIndex < showTimes.size()) {
                ShowTime matchingShowTime = showTimes.get(showTimeIndex);
                ticketTypesList.add(new TicketTypeJson(
                        matchingShowTime.getStartDate(),
                        matchingShowTime.getEndDate(),
                        tt.getName(),
                        tt.getDescription() != null ? tt.getDescription() : "",
                        tt.getPrice(),
                        tt.getColor() != null ? tt.getColor() : "#000000",
                        tt.getTotalQuantity()
                ));
                showTimeIndex++;
                if (showTimeIndex >= showTimes.size()) {
                    showTimeIndex = 0; // Reset index to reuse ShowTimes if more ticket types than show times
                }
            } else {
                throw new IllegalArgumentException("Insufficient ShowTimes for mapping TicketTypes");
            }
        }
        return gson.toJson(ticketTypesList);
    }

    // Helper method to prepare Seats JSON
    private String prepareSeatsJson(List<Seat> seats, Gson gson) {
        if (seats == null || seats.isEmpty()) {
            return null; // Return null for empty or null seats (handled by stored procedure)
        }

        List<Object> seatsList = new ArrayList<>();
        for (Seat seat : seats) {
            if (seat.getTicketTypeName() == null || seat.getSeatRow() == null) {
                throw new IllegalArgumentException("ticketTypeName and seatRow are required for each seat");
            }
            seatsList.add(new SeatJson(
                    seat.getTicketTypeName(),
                    seat.getSeatRow(),
                    seat.getSeatCol() // Lấy seatCol từ model Seat
            ));
        }
        return gson.toJson(seatsList);
    }

    // Inner class to hold the result of event creation
    public static class EventCreationResult {

        public int eventId;
        public int organizerId;

        public EventCreationResult() {
            this.eventId = -1;
            this.organizerId = -1;
        }
    }

    // Inner classes to match stored procedure JSON structure
    private static class ShowTimeJson {

        public Timestamp startDate;
        public Timestamp endDate;
        public String status;

        public ShowTimeJson(Timestamp startDate, Timestamp endDate, String status) {
            this.startDate = startDate;
            this.endDate = endDate;
            this.status = status;
        }
    }

    private static class TicketTypeJson {

        public Timestamp showTimeStartDate;
        public Timestamp showTimeEndDate;
        public String name;
        public String description;
        public double price;
        public String color;
        public int totalQuantity;

        public TicketTypeJson(Timestamp showTimeStartDate, Timestamp showTimeEndDate, String name, String description, double price, String color, int totalQuantity) {
            this.showTimeStartDate = showTimeStartDate;
            this.showTimeEndDate = showTimeEndDate;
            this.name = name;
            this.description = description;
            this.price = price;
            this.color = color;
            this.totalQuantity = totalQuantity;
        }
    }

    private static class SeatJson {

        public String ticketTypeName;
        public String seatRow;
        public String seatCol; // Thêm trường seatCol

        public SeatJson(String ticketTypeName, String seatRow, String seatCol) {
            this.ticketTypeName = ticketTypeName;
            this.seatRow = seatRow;
            this.seatCol = seatCol; // Khởi tạo seatCol
        }
    }

    /**
     * Retrieves the event details based on the provided event ID.
     *
     * @param eventId The ID of the event to retrieve.
     * @return An Event object if found, otherwise null.
     */
    public Event getEventById(int eventId) {
        String sql = "SELECT event_id, category_id, organizer_id, event_name, location, event_type, status, description, created_at, updated_at "
                + "FROM Events "
                + "WHERE event_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Event(
                        rs.getInt("event_id"),
                        rs.getInt("category_id"),
                        rs.getInt("organizer_id"),
                        rs.getString("event_name"),
                        rs.getString("location"),
                        rs.getString("event_type"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving event: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Retrieves the list of images associated with the specified event ID.
     *
     * @param eventId The ID of the event.
     * @return A list of EventImage objects.
     */
    public List<EventImage> getEventImagesByEventId(int eventId) {
        List<EventImage> images = new ArrayList<>();
        String sql = "SELECT image_id, event_id, image_url, image_title "
                + "FROM EventImages "
                + "WHERE event_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                EventImage image = new EventImage(
                        rs.getInt("image_id"),
                        rs.getInt("event_id"),
                        rs.getString("image_url"),
                        rs.getString("image_title")
                );
                images.add(image);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving event images: " + e.getMessage());
            e.printStackTrace();
        }
        return images;
    }

    /**
     * Retrieves the organizer details for the specified event ID.
     *
     * @param eventId The ID of the event.
     * @return An Organizer object if found, otherwise null.
     */
    public Organizer getOrganizerByEventId(int eventId) {
        String sql = "SELECT o.organizer_id, o.customer_id, o.organization_name, o.account_holder, o.account_number, o.bank_name, o.created_at, o.updated_at "
                + "FROM Events e "
                + "INNER JOIN Organizers o ON e.organizer_id = o.organizer_id "
                + "WHERE e.event_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Organizer(
                        rs.getInt("organizer_id"),
                        rs.getInt("customer_id"),
                        rs.getString("organization_name"),
                        rs.getString("account_holder"),
                        rs.getString("account_number"),
                        rs.getString("bank_name"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving organizer: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Retrieves the list of show times for the specified event ID.
     *
     * @param eventId The ID of the event.
     * @return A list of ShowTime objects.
     */
    public List<ShowTime> getShowTimesByEventId(int eventId) {
        List<ShowTime> showTimes = new ArrayList<>();
        String sql = "SELECT showtime_id, event_id, start_date, end_date, status, created_at, updated_at "
                + "FROM Showtimes "
                + "WHERE event_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                ShowTime showTime = new ShowTime(
                        rs.getInt("showtime_id"),
                        rs.getInt("event_id"),
                        rs.getTimestamp("start_date"),
                        rs.getTimestamp("end_date"),
                        rs.getString("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                showTimes.add(showTime);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving show times: " + e.getMessage());
            e.printStackTrace();
        }
        return showTimes;
    }

    /**
     * Retrieves the list of ticket types for the specified event ID.
     *
     * @param eventId The ID of the event.
     * @return A list of TicketType objects.
     */
    public List<TicketType> getTicketTypesByEventId(int eventId) {
        List<TicketType> ticketTypes = new ArrayList<>();
        String sql = "SELECT tt.ticket_type_id, tt.showtime_id, tt.name, tt.description, tt.price, tt.color, tt.total_quantity, tt.sold_quantity, tt.created_at, tt.updated_at "
                + "FROM Showtimes st "
                + "INNER JOIN TicketTypes tt ON st.showtime_id = tt.showtime_id "
                + "WHERE st.event_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                TicketType ticketType = new TicketType(
                        rs.getInt("ticket_type_id"),
                        rs.getInt("showtime_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("color"),
                        rs.getInt("total_quantity"),
                        rs.getInt("sold_quantity"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                ticketTypes.add(ticketType);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving ticket types: " + e.getMessage());
            e.printStackTrace();
        }
        return ticketTypes;
    }

    /**
     * Retrieves the list of seats for the specified event ID.
     *
     * @param eventId The ID of the event.
     * @return A list of Seat objects.
     */
    public List<Seat> getSeatsByEventId(int eventId) {
        List<Seat> seats = new ArrayList<>();
        String sql = "WITH MaxSeats AS (\n"
                + "    SELECT \n"
                + "        Seats.seat_row,\n"
                + "        MAX(CAST(Seats.seat_col AS INT)) AS max_seat_col\n"
                + "    FROM Seats\n"
                + "    INNER JOIN TicketTypes ON Seats.ticket_type_id = TicketTypes.ticket_type_id\n"
                + "    INNER JOIN Showtimes ON TicketTypes.showtime_id = Showtimes.showtime_id\n"
                + "    WHERE Showtimes.event_id = ?\n"
                + "    GROUP BY Seats.seat_row\n"
                + ")\n"
                + "SELECT \n"
                + "    s.seat_id,\n"
                + "    s.ticket_type_id,\n"
                + "    s.seat_row,\n"
                + "    s.seat_col,\n"
                + "    s.status\n"
                + "FROM Seats s\n"
                + "INNER JOIN TicketTypes tt ON s.ticket_type_id = tt.ticket_type_id\n"
                + "INNER JOIN Showtimes st ON tt.showtime_id = st.showtime_id\n"
                + "INNER JOIN MaxSeats ms ON s.seat_row = ms.seat_row AND CAST(s.seat_col AS INT) = ms.max_seat_col\n"
                + "WHERE st.event_id = ?\n"
                + "ORDER BY s.seat_row;";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.setInt(2, eventId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat(
                        rs.getInt("seat_id"),
                        rs.getInt("ticket_type_id"),
                        rs.getString("seat_row"),
                        rs.getString("seat_col"),
                        rs.getString("status")
                );
                seats.add(seat);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving seats: " + e.getMessage());
            e.printStackTrace();
        }
        return seats;
    }

    /*getCategoryByName*/
    public Category getCategoryByEventID(int eventId) {
        String sql = "SELECT Categories.category_id, Categories.category_name, Categories.description, Categories.created_at, Categories.updated_at\n"
                + "FROM Categories \n"
                + "INNER JOIN Events ON Categories.category_id = Events.category_id\n"
                + "WHERE Events.event_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, eventId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Category category = new Category(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("description"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                return category;
            }

        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }

        return null;
    }

    // Example main method to test createEvent
    public static void main(String[] args) {

        /*Create Event*/
//        EventDAO eventDAO = new EventDAO();
//
//        // Sample data for testing (matching stored procedure test data)
//        int customerId = 8;
//        String organizationName = "Huynh Le Cong Bien";
//        String accountHolder = "John Doe";
//        String accountNumber = "1234567890";
//        String bankName = "Sample Bank";
//        int categoryId = 1;
//        String eventName = "Sample Concert";
//        String location = "Hanoi, Vietnam";
//        String eventType = "seatedevent";
//        String description = "A sample concert event";
//        String status = "Pending";
//        String eventLogoUrl = "https://example.com/logo.png";
//        String backgroundImageUrl = "https://example.com/background.png";
//        String organizerImageUrl = "https://example.com/organizer.png";
//
//        // Sample ShowTimes
//        List<ShowTime> showTimes = new ArrayList<>();
//        showTimes.add(new ShowTime(0, 0, Timestamp.valueOf("2025-03-01 14:00:00"), Timestamp.valueOf("2025-03-01 16:00:00"), "Scheduled", null, null));
//        showTimes.add(new ShowTime(0, 0, Timestamp.valueOf("2025-04-01 14:00:00"), Timestamp.valueOf("2025-04-01 16:00:00"), "Scheduled", null, null));
//
//        // Sample TicketTypes
//        List<TicketType> ticketTypes = new ArrayList<>();
//        ticketTypes.add(new TicketType(0, 0, "VIP", "VIP seating", 150000, "#FF0000", 16, 0, null, null));
//        ticketTypes.add(new TicketType(0, 0, "Normal", "Normal seating", 80000, "#00FF00", 30, 0, null, null));
//        ticketTypes.add(new TicketType(0, 0, "VIP Vui", "VIP seating", 150000, "#FF0000", 16, 0, null, null));
//        ticketTypes.add(new TicketType(0, 0, "Normal Vui", "Normal seating", 80000, "#00FF00", 16, 0, null, null));
//
//        // Sample Seats with seatCol (reflecting actual seat quantities for each row)
//        List<Seat> seats = new ArrayList<>();
//        seats.add(new Seat(0, 0, "A", "10", "Available", "VIP")); // Row A with 10 seats for VIP
//        seats.add(new Seat(0, 0, "B", "16", "Available", "VIP")); // Row B with 16 seats for VIP
//        seats.add(new Seat(0, 0, "C", "15", "Available", "Normal")); // Row C with 15 seats for Normal
//        seats.add(new Seat(0, 0, "D", "15", "Available", "Normal")); // Row D with 15 seats for Normal
//        seats.add(new Seat(0, 0, "E", "16", "Available", "VIP Vui")); // Row E with 16 seats for VIP Vui
//        seats.add(new Seat(0, 0, "F", "16", "Available", "Normal Vui")); // Row F with 16 seats for Normal Vui
//
//        // Call createEvent method
//        EventCreationResult result = eventDAO.createEvent(
//                customerId, organizationName, accountHolder, accountNumber, bankName,
//                categoryId, eventName, location, eventType, description, status,
//                eventLogoUrl, backgroundImageUrl, organizerImageUrl,
//                showTimes, ticketTypes, seats
//        );
//
//        // Print result
//        System.out.println("Created Event ID: " + result.eventId);
//        System.out.println("Organizer ID: " + result.organizerId);
        /*Update Event*/
//        EventDAO eventDAO = new EventDAO();
//
//        // Dữ liệu mẫu để cập nhật sự kiện với ID 574
//        int eventId = 574;
//        int customerId = 9;
//        String organizationName = "Updated Tang Thanh Vui";
//        String accountHolder = "Updated John Doe";
//        String accountNumber = "0987654321";
//        String bankName = "Updated Bank";
//        int categoryId = 2;
//        String eventName = "Updated Sample Concert";
//        String location = "Ho Chi Minh City, Vietnam";
//        String eventType = "seatedevent";
//        String description = "An updated sample concert event";
//        String status = "Pending";
//        String eventLogoUrl = "https://example.com/updated_logo.png";
//        String backgroundImageUrl = "https://example.com/updated_background.png";
//        String organizerImageUrl = "https://example.com/updated_organizer.png";
//
//        // Dữ liệu ShowTimes mẫu
//        List<ShowTime> showTimes = new ArrayList<>();
//        showTimes.add(new ShowTime(0, 0, Timestamp.valueOf("2025-03-02 14:00:00"), Timestamp.valueOf("2025-03-02 16:00:00"), "Scheduled", null, null));
//
//        // Dữ liệu TicketTypes mẫu
//        List<TicketType> ticketTypes = new ArrayList<>();
//        ticketTypes.add(new TicketType(0, 0, "VIP Updated", "Updated VIP seating", 200000, "#FF0000", 10, 0, null, null));
//
//        // Dữ liệu Seats mẫu
//        List<Seat> seats = new ArrayList<>();
//        seats.add(new Seat(0, 0, "A", "1", "Available", "VIP Updated"));
//
//        // Gọi phương thức updateEventByID
//        boolean success = eventDAO.updateEventByID(
//                eventId, customerId, organizationName, accountHolder, accountNumber, bankName,
//                categoryId, eventName, location, eventType, description, status,
//                eventLogoUrl, backgroundImageUrl, organizerImageUrl,
//                showTimes, ticketTypes, seats
//        );
//
//        // In kết quả
//        System.out.println("Update Successfully: " + success);

        /*Test all method get by eventid*/
        // Tạo một instance của EventDAO
        EventDAO eventDAO = new EventDAO();

        // Chọn một event ID có sẵn trong cơ sở dữ liệu để test
        int testEventId = 577; // Thay bằng một ID thực tế từ cơ sở dữ liệu của bạn

        try {
            // 1. Kiểm tra getEventById
            Event event = eventDAO.getEventById(testEventId);
            System.out.println("Event Information:");
            if (event != null) {
                System.out.println(event);
            } else {
                System.out.println("Không tìm thấy sự kiện.");
            }

            // 2. Kiểm tra getEventImagesByEventId
            List<EventImage> images = eventDAO.getEventImagesByEventId(testEventId);
            System.out.println("\nEventImages:");
            for (EventImage image : images) {
                System.out.println(image);
            }

            // 3. Kiểm tra getOrganizerByEventId
            Organizer organizer = eventDAO.getOrganizerByEventId(testEventId);
            System.out.println("\nOrganizer:");
            if (organizer != null) {
                System.out.println(organizer);
            } else {
                System.out.println("Không tìm thấy người tổ chức.");
            }

            // 4. Kiểm tra getShowTimesByEventId
            List<ShowTime> showTimes = eventDAO.getShowTimesByEventId(testEventId);
            System.out.println("\nShowtimes:");
            for (ShowTime showTime : showTimes) {
                System.out.println(showTime);
            }

            // 5. Kiểm tra getTicketTypesByEventId
            List<TicketType> ticketTypes = eventDAO.getTicketTypesByEventId(testEventId);
            System.out.println("\nTicketTypes:");
            for (TicketType ticketType : ticketTypes) {
                System.out.println(ticketType);
            }

            // 6. Kiểm tra getSeatsByEventId
            List<Seat> seats = eventDAO.getSeatsByEventId(testEventId);
            System.out.println("\nSeats:");
            for (Seat seat : seats) {
                System.out.println(seat.getSeatRow());
            }

            // 3. Kiểm tra getOrganizerByEventId
            Category category = eventDAO.getCategoryByEventID(testEventId);
            System.out.println("\nCategory:");
            if (category != null) {
                System.out.println(category);
            } else {
                System.out.println("Không tìm thấy người tổ chức.");
            }
        } catch (Exception e) {
            // Xử lý ngoại lệ nếu có lỗi xảy ra trong quá trình kiểm tra
            System.err.println("Đã xảy ra lỗi trong quá trình kiểm tra: " + e.getMessage());
            e.printStackTrace();
        }
    }

}
