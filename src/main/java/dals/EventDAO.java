/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
import java.util.Arrays;
import java.util.List;
import models.Category;
import models.Event;
import models.EventImage;
import models.Organizer;
import models.Seat;
import models.Showtime;
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
            List<Showtime> showTimes,
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
            List<Showtime> showTimes,
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
    private String prepareShowTimesJson(List<Showtime> showTimes, Gson gson) {
        if (showTimes == null || showTimes.isEmpty()) {
            throw new IllegalArgumentException("ShowTimes list cannot be null or empty");
        }

        List<Object> showTimesList = new ArrayList<>();
        for (Showtime st : showTimes) {
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
    private String prepareTicketTypesJson(List<TicketType> ticketTypes, List<Showtime> showTimes, Gson gson) {
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
                Showtime matchingShowTime = showTimes.get(showTimeIndex);
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
            if (seat.getName() == null || seat.getSeatRow() == null) {
                throw new IllegalArgumentException("ticketTypeName and seatRow are required for each seat");
            }
            seatsList.add(new SeatJson(
                    seat.getName(),
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
    public List<Showtime> getShowTimesByEventId(int eventId) {
        List<Showtime> showTimes = new ArrayList<>();
        String sql = "SELECT showtime_id, event_id, start_date, end_date, status, created_at, updated_at "
                + "FROM Showtimes "
                + "WHERE event_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Showtime showTime = new Showtime(
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
     * Retrieves the list of ticket types for the specified showtime ID.
     *
     * @param showtimeId The ID of the showtime.
     * @return A list of TicketType objects.
     */
    public List<TicketType> getTicketTypesByShowtimeId(int showtimeId) {
        List<TicketType> ticketTypes = new ArrayList<>();
        String sql = "SELECT ticket_type_id, showtime_id, name, description, price, color, total_quantity, sold_quantity, created_at, updated_at "
                + "FROM TicketTypes "
                + "WHERE showtime_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, showtimeId);
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

    /**
     * Retrieves the list of events by name using a partial match for a specific
     * organizer.
     *
     * @param eventName The name or partial name of the event to search for.
     * @param organizerId The ID of the organizer to filter events.
     * @return A list of Event objects matching the search criteria.
     */
    public List<Event> searchEventByName(String eventName, int organizerId) {
        List<Event> events = new ArrayList<>();
        String sql = "SELECT event_id, category_id, organizer_id, event_name, location, event_type, status, description, created_at, updated_at "
                + "FROM Events "
                + "WHERE event_name LIKE ? AND organizer_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Thêm ký tự % để tìm kiếm gần đúng
            stmt.setString(1, "%" + eventName + "%");
            stmt.setInt(2, organizerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Event event = new Event(
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
                events.add(event);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving events: " + e.getMessage());
            e.printStackTrace();
        }
        return events;
    }

    /**
     * Retrieves the list of events by name using a partial match for a specific
     * organizer.
     *
     * @param eventName The name or partial name of the event to search for.
     * @param organizerId The ID of the organizer to filter events.
     * @return A list of Event objects matching the search criteria.
     */
    public List<EventImage> searchEventByNameImage(String eventName, int organizerId) {
        List<EventImage> listEventImage = new ArrayList<>();
        String sql = "SELECT e.event_id, e.category_id, e.organizer_id, e.event_name, e.location, e.event_type, e.status, e.description, e.created_at, e.updated_at, ei.image_id, ei.image_url, ei.image_title\n"
                + "                FROM Events e\n"
                + "                LEFT JOIN (SELECT event_id, image_id, image_url, image_title\n"
                + "                FROM EventImages\n"
                + "                WHERE image_title = 'logo_banner') ei ON e.event_id = ei.event_id\n"
                + "                WHERE e.event_name LIKE ? AND e.organizer_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, "%" + eventName + "%");
            stmt.setInt(2, organizerId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getInt("image_id"),
                        rs.getString("image_url"),
                        rs.getString("image_title"),
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
                listEventImage.add(eventImage);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving events: " + e.getMessage());
            e.printStackTrace();
        }
        return listEventImage;
    }

    /*selectEventByID*/
    public Event selectEventByID(int id) {
        String sql = "SELECT * FROM Events\n"
                + "WHERE event_id = ?";

        try {
            // Prepare SQL statement
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            // Fetch event data
            if (rs.next()) {
                Event event = new Event(
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
                return event;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return null;
    }

    /**
     * Retrieves the list of show times for the specified event ID.
     *
     * @param eventId The ID of the event.
     * @return A list of ShowTime objects.
     */
    public List<TicketType> getTicketTypeByShowtimeId(int showtimeId) {
        List<TicketType> ticketTypes = new ArrayList<>();
        String sql = "SELECT ticket_type_id, showtime_id, name, description, price, color, total_quantity, sold_quantity, created_at, updated_at\n"
                + "FROM     TicketTypes\n"
                + "WHERE showtime_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, showtimeId);
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
            System.err.println("Error retrieving show times: " + e.getMessage());
            e.printStackTrace();
        }
        return ticketTypes;
    }

    /*=======================================Home Event==============================================================================================*/
 /*getEventsByPage*/
    public List<EventImage> getEventsByPage(int page, int pageSize) {
        List<EventImage> listEvents = new ArrayList<>();
        String sql = "WITH EventPagination AS (\n"
                + "    SELECT ROW_NUMBER() OVER (ORDER BY e.created_at ASC) AS rownum, e.*\n"
                + "    FROM Events e\n"
                + "),\n"
                + "EventImagesFiltered AS (\n"
                + "    SELECT ei.event_id, ei.image_id, MIN(ei.image_url) AS image_url, MIN(ei.image_title) AS image_title\n"
                + "    FROM EventImages ei\n"
                + "    WHERE ei.image_title LIKE '%logo_banner%'\n"
                + "    GROUP BY ei.event_id, ei.image_id\n"
                + ")\n"
                + "SELECT ep.*, eif.image_id, eif.image_url, eif.image_title\n"
                + "FROM EventPagination ep\n"
                + "LEFT JOIN EventImagesFiltered eif \n"
                + "ON ep.event_id = eif.event_id\n"
                + "WHERE ep.rownum BETWEEN ? AND ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int start = (page - 1) * pageSize + 1;
            int end = page * pageSize;
            st.setInt(1, start);
            st.setInt(2, end);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getString("image_url"),
                        rs.getString("image_title"),
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
                listEvents.add(eventImage);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching paginated events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getTotalEvents*/
    public int getTotalEvents() {
        String sql = "SELECT COUNT(DISTINCT e.event_id) \n"
                + "FROM Events e\n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%banner%';";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting events: " + e.getMessage());
        }
        return 0;
    }

    /*getTop10LatestEvents*/
    public List<EventImage> getTop10LatestEvents() {
        List<EventImage> listEvents = new ArrayList<>();
        String sql = "SELECT TOP 20\n"
                + "e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, e.location, e.event_type, e.created_at, e.updated_at, ei.image_url, ei.image_title\n"
                + "FROM Events e\n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%logo_event%'\n"
                + "WHERE e.status = 'Active'\n"
                + "ORDER BY e.created_at DESC";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getString("image_url"),
                        rs.getString("image_title"),
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
                listEvents.add(eventImage);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top 10 latest events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getUpcomingEvents*/
    public List<EventImage> getUpcomingEvents() {
        List<EventImage> listEvents = new ArrayList<>();
        String sql = "SELECT TOP 20\n"
                + "    e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, \n"
                + "    e.location, e.event_type, e.created_at, e.updated_at, \n"
                + "    ei.image_url, ei.image_title, \n"
                + "    MIN(s.start_date) AS start_date, MAX(s.end_date) AS end_date\n"
                + "FROM Events e\n"
                + "JOIN Showtimes s ON e.event_id = s.event_id AND s.status = 'Active'\n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%logo_banner%'\n"
                + "WHERE s.start_date >= GETDATE()\n"
                + "GROUP BY e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, \n"
                + "         e.location, e.event_type, e.created_at, e.updated_at, ei.image_url, ei.image_title\n"
                + "ORDER BY MIN(s.start_date) ASC;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getString("image_url"),
                        rs.getString("image_title"),
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
                listEvents.add(eventImage);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching upcoming events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getRecommendedEvents*/
    public List<EventImage> getRecommendedEvents(int customerId) {
        List<EventImage> listEvents = new ArrayList<>();
        String sql = "WITH UserCategories AS (\n"
                + "    SELECT DISTINCT e.category_id\n"
                + "    FROM Orders o\n"
                + "    JOIN OrderDetails od ON o.order_id = od.order_id\n"
                + "    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id\n"
                + "    JOIN Showtimes s ON tt.showtime_id = s.showtime_id\n"
                + "    JOIN Events e ON s.event_id = e.event_id\n"
                + "    WHERE o.customer_id = ?\n"
                + "),\n"
                + "AllCategories AS (\n"
                + "    SELECT category_id FROM Categories\n"
                + "),\n"
                + "CategoriesToRecommend AS (\n"
                + "    SELECT category_id FROM UserCategories\n"
                + "    UNION\n"
                + "    SELECT category_id FROM AllCategories\n"
                + "    WHERE NOT EXISTS (SELECT 1 FROM UserCategories)\n"
                + ")\n"
                + "SELECT TOP 20\n"
                + "        e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, \n"
                + "    e.location, e.event_type, e.created_at, e.updated_at, \n"
                + "    ei.image_url, ei.image_title, MIN(tt.price) AS min_price\n"
                + "FROM Events e\n"
                + "JOIN Showtimes s ON e.event_id = s.event_id\n"
                + "JOIN TicketTypes tt ON s.showtime_id = tt.ticket_type_id \n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%banner%'\n"
                + "WHERE e.category_id IN (SELECT category_id FROM CategoriesToRecommend) AND E.status = 'Active'\n"
                + "GROUP BY e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, \n"
                + "    e.location, e.event_type, e.created_at, e.updated_at, \n"
                + "    ei.image_url, ei.image_title\n"
                + "ORDER BY min_price DESC;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getString("image_url"),
                        rs.getString("image_title"),
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
                listEvents.add(eventImage);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching recommended events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getTopEventsWithLimit*/
    public List<EventImage> getTopEventsWithLimit() {
        List<EventImage> listEvents = new ArrayList<>();
        String sql = "SELECT TOP 20\n"
                + "e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, \n"
                + "e.location, e.event_type, e.created_at, e.updated_at, \n"
                + "ei.image_url, ei.image_title, COALESCE(SUM(od.quantity), 0) AS total_tickets\n"
                + "FROM Events e\n"
                + "LEFT JOIN Showtimes s ON e.event_id = s.event_id\n"
                + "LEFT JOIN TicketTypes tt ON s.showtime_id = tt.ticket_type_id\n"
                + "LEFT JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id\n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%banner%'\n"
                + "WHERE e.status = 'Active'\n"
                + "GROUP BY e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, \n"
                + "e.location, e.event_type, e.created_at, e.updated_at, ei.image_url, ei.image_title\n"
                + "ORDER BY total_tickets DESC;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getString("image_url"),
                        rs.getString("image_title"),
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
                listEvents.add(eventImage);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return listEvents;
    }

    /*selectEventImagesByID*/
    public EventImage selectEventImagesByID(int id) {
        String sql = "SELECT * FROM EventImages\n"
                + "WHERE event_id = ? AND image_title LIKE '%banner%';";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getInt("image_id"),
                        rs.getInt("event_id"),
                        rs.getString("image_url"),
                        rs.getString("image_title")
                );
                return eventImage;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching event images: " + e.getMessage());
        }
        return null;
    }

    /*getTopEventsWithLimit*/
    public List<EventImage> getImageEventsByEventId(int eventId) {
        List<EventImage> listEvents = new ArrayList<>();
        String sql = "SELECT\n"
                + "e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, e.location, e.event_type, e.created_at, e.updated_at, ei.image_url, ei.image_title\n"
                + "FROM Events e\n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id\n"
                + "WHERE e.event_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, eventId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getString("image_url"),
                        rs.getString("image_title"),
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
                listEvents.add(eventImage);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return listEvents;
    }

    /*selectEventCategoriesID*/
    public Category selectEventCategoriesID(int id) {
        String sql = "SELECT c.*\n"
                + "FROM Categories c\n"
                + "INNER JOIN Events e ON c.category_id = e.category_id\n"
                + "WHERE e.event_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Category eventCategories = new Category(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("description"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                return eventCategories;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching event categories: " + e.getMessage());
        }
        return null;
    }

    public List<EventImage> searchEventsByQuery(String query) {
        List<EventImage> listEvents = new ArrayList<>();
        String sql = "SELECT e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, e.location, e.event_type, e.created_at, e.updated_at, ei.image_url, ei.image_title\n"
                + "FROM Events e\n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%logo_banner%'\n"
                + "WHERE e.event_name LIKE ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + query + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getString("image_url"),
                        rs.getString("image_title"),
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
                listEvents.add(eventImage);
            }
        } catch (SQLException e) {
            System.out.println("Error searching events: " + e.getMessage());
        }
        return listEvents;
    }

    /* getTotalRevenueOfEventById */
    public List<Double> getTotalRevenueOfEventById(int eventId) {
        List<Double> listTotals = new ArrayList<>();

        String sql = "SELECT \n"
                + "    s.event_id,\n"
                + "    COALESCE(SUM(od.quantity * od.price), 0) AS total_revenue,\n"
                + "    COALESCE(SUM(od.quantity), 0) AS tickets_sold,\n"
                + "    SUM(tt.total_quantity) AS total_tickets,\n"
                + "    SUM(tt.total_quantity) - COALESCE(SUM(od.quantity), 0) AS tickets_remaining,\n"
                + "    (COALESCE(SUM(od.quantity), 0) * 100.0 / NULLIF(SUM(tt.total_quantity), 0)) AS fill_rate\n"
                + "FROM Showtimes s\n"
                + "JOIN TicketTypes tt ON tt.showtime_id = s.showtime_id \n"
                + "LEFT JOIN OrderDetails od ON od.ticket_type_id = tt.ticket_type_id \n"
                + "LEFT JOIN Orders o ON o.order_id = od.order_id\n"
                + "WHERE s.event_id = ?\n"
                + "GROUP BY s.event_id;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, eventId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                listTotals.add(rs.getDouble("total_revenue"));
                listTotals.add(rs.getDouble("tickets_sold"));
                listTotals.add(rs.getDouble("total_tickets"));
                listTotals.add(rs.getDouble("tickets_remaining"));
                listTotals.add(rs.getDouble("fill_rate"));
            }
        } catch (SQLException e) {
            System.out.println("Error searching events: " + e.getMessage());
        }
        return listTotals;
    }

    /*getTotalRevenueOfEventById*/
    public List<Double> getTotalRevenueChartOfEventById(int eventId, int year) {
        List<Double> monthlyRevenue = new ArrayList<>(Arrays.asList(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));

        String sql = "WITH RevenueByMonth AS (\n"
                + "    SELECT \n"
                + "        MONTH(o.order_date) AS Month,\n"
                + "        SUM(od.quantity * od.price) AS Revenue,\n"
                + "        SUM(od.quantity) AS TicketQuantity\n"
                + "    FROM [dbo].[Orders] o\n"
                + "    INNER JOIN [dbo].[OrderDetails] od ON o.order_id = od.order_id\n"
                + "    INNER JOIN [dbo].[TicketTypes] tt ON od.ticket_type_id = tt.ticket_type_id\n"
                + "    INNER JOIN [dbo].[Showtimes] st ON tt.showtime_id = st.showtime_id\n"
                + "    INNER JOIN [dbo].[Events] e ON st.event_id = e.event_id\n"
                + "    WHERE \n"
                + "        e.event_id = ? -- Thay bằng ID của sự kiện cần tìm\n"
                + "        AND YEAR(o.order_date) = ? -- Thay bằng năm cần tìm\n"
                + "    GROUP BY MONTH(o.order_date)\n"
                + ")\n"
                + "\n"
                + "SELECT \n"
                + "    m.Month,\n"
                + "    ISNULL(rm.Revenue, 0) AS Revenue,\n"
                + "    ISNULL(rm.TicketQuantity, 0) AS TicketQuantity\n"
                + "FROM (\n"
                + "    SELECT 1 AS Month UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION \n"
                + "    SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION \n"
                + "    SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12\n"
                + ") m\n"
                + "LEFT JOIN RevenueByMonth rm ON m.Month = rm.Month\n"
                + "ORDER BY m.Month;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, eventId);
            st.setInt(2, year);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int month = rs.getInt("Month") - 1;
                double revenue = rs.getDouble("Revenue");
                monthlyRevenue.set(month, revenue);
            }
        } catch (SQLException e) {
            System.out.println("Error searching events: " + e.getMessage());
        }
        return monthlyRevenue;
    }
    
    /*getTotalRevenueOfEventById*/
    public List<Double> getTotalTicketsChartOfEventById(int eventId, int year) {
        List<Double> monthlyRevenue = new ArrayList<>(Arrays.asList(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));

        String sql = "WITH RevenueByMonth AS (\n"
                + "    SELECT \n"
                + "        MONTH(o.order_date) AS Month,\n"
                + "        SUM(od.quantity * od.price) AS Revenue,\n"
                + "        SUM(od.quantity) AS TicketQuantity\n"
                + "    FROM [dbo].[Orders] o\n"
                + "    INNER JOIN [dbo].[OrderDetails] od ON o.order_id = od.order_id\n"
                + "    INNER JOIN [dbo].[TicketTypes] tt ON od.ticket_type_id = tt.ticket_type_id\n"
                + "    INNER JOIN [dbo].[Showtimes] st ON tt.showtime_id = st.showtime_id\n"
                + "    INNER JOIN [dbo].[Events] e ON st.event_id = e.event_id\n"
                + "    WHERE \n"
                + "        e.event_id = ? -- Thay bằng ID của sự kiện cần tìm\n"
                + "        AND YEAR(o.order_date) = ? -- Thay bằng năm cần tìm\n"
                + "    GROUP BY MONTH(o.order_date)\n"
                + ")\n"
                + "\n"
                + "SELECT \n"
                + "    m.Month,\n"
                + "    ISNULL(rm.Revenue, 0) AS Revenue,\n"
                + "    ISNULL(rm.TicketQuantity, 0) AS TicketQuantity\n"
                + "FROM (\n"
                + "    SELECT 1 AS Month UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION \n"
                + "    SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION \n"
                + "    SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12\n"
                + ") m\n"
                + "LEFT JOIN RevenueByMonth rm ON m.Month = rm.Month\n"
                + "ORDER BY m.Month;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, eventId);
            st.setInt(2, year);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                int month = rs.getInt("Month") - 1;
                double revenue = rs.getDouble("TicketQuantity");
                monthlyRevenue.set(month, revenue);
            }
        } catch (SQLException e) {
            System.out.println("Error searching events: " + e.getMessage());
        }
        return monthlyRevenue;
    }

    public static void main(String[] args) {
        EventDAO d = new EventDAO();
        List<Showtime> monthlyRevenue = d.getShowTimesByEventId(1);
        for (Showtime double1 : monthlyRevenue) {
            System.out.println(double1);
        }
    }

}
