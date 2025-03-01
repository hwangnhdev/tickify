package dals;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
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

        // Initialize Gson with custom date format matching SQL Server DATETIME
        Gson gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd HH:mm:ss")
                .create();

        // Prepare JSON for ShowTimes, TicketTypes, and Seats
        String showTimesJson = prepareShowTimesJson(showTimes, gson);
        String ticketTypesJson = prepareTicketTypesJson(ticketTypes, showTimes, gson);
        String seatsJson = (seats != null && !seats.isEmpty()) ? prepareSeatsJson(seats, ticketTypes, gson) : null;

        String sql = "{CALL [dbo].[CreateEvent](?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        EventCreationResult result = new EventCreationResult();

        try ( CallableStatement stmt = connection.prepareCall(sql)) {
            // Set input parameters
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

            // Execute the stored procedure
            stmt.execute();

            // Retrieve output parameters
            result.eventId = stmt.getInt(18);
            result.organizerId = stmt.getInt(19);

            // Check if the creation was successful
            if (result.eventId == -1 || result.organizerId == -1) {
                throw new SQLException("Failed to create event. EventId or OrganizerId returned -1.");
            }

        } catch (SQLException e) {
            System.err.println("Error creating event: " + e.getMessage());
            result.eventId = -1;
            result.organizerId = -1;
        }

        return result;
    }

    // Helper method to prepare ShowTimes JSON
    private String prepareShowTimesJson(List<ShowTime> showTimes, Gson gson) {
        List<Object> showTimesList = new ArrayList<>();
        for (ShowTime st : showTimes) {
            showTimesList.add(new ShowTimeJson(
                    st.getStartDate(),
                    st.getEndDate(),
                    st.getStatus()
            ));
        }
        return gson.toJson(showTimesList);
    }

    // Helper method to prepare TicketTypes JSON (Adjusted to avoid lambda)
    private String prepareTicketTypesJson(List<TicketType> ticketTypes, List<ShowTime> showTimes, Gson gson) {
        List<Object> ticketTypesList = new ArrayList<>();
        int showTimeIndex = 0; // Giả sử TicketTypes được sắp xếp theo thứ tự ShowTimes

        for (TicketType tt : ticketTypes) {
            // Lấy ShowTime tương ứng theo thứ tự (giả định đơn giản hóa)
            if (showTimeIndex < showTimes.size()) {
                ShowTime matchingShowTime = showTimes.get(showTimeIndex);
                ticketTypesList.add(new TicketTypeJson(
                        matchingShowTime.getStartDate(),
                        matchingShowTime.getEndDate(),
                        tt.getName(),
                        tt.getDescription(),
                        tt.getPrice(),
                        tt.getColor(),
                        tt.getTotalQuantity()
                ));
                showTimeIndex++;
                // Nếu danh sách TicketTypes dài hơn ShowTimes, reset index để tái sử dụng ShowTimes
                if (showTimeIndex >= showTimes.size()) {
                    showTimeIndex = 0;
                }
            }
        }
        return gson.toJson(ticketTypesList);
    }

    // Helper method to prepare Seats JSON
    private String prepareSeatsJson(List<Seat> seats, List<TicketType> ticketTypes, Gson gson) {
        List<Object> seatsList = new ArrayList<>();
        for (Seat seat : seats) {
            // Tìm TicketType tương ứng dựa trên thứ tự hoặc tên (giả định đơn giản)
            for (TicketType tt : ticketTypes) {
                if (seat.getSeatRow().equals("A") && tt.getName().equals("VIP")
                        || seat.getSeatRow().equals("B") && tt.getName().equals("Normal")
                        || seat.getSeatRow().equals("C") && tt.getName().equals("VIP Vui")
                        || seat.getSeatRow().equals("D") && tt.getName().equals("Normal Vui")) {
                    seatsList.add(new SeatJson(
                            tt.getName(),
                            seat.getSeatRow()
                    ));
                    break;
                }
            }
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

        public SeatJson(String ticketTypeName, String seatRow) {
            this.ticketTypeName = ticketTypeName;
            this.seatRow = seatRow;
        }
    }

    // Example main method to test createEvent
    public static void main(String[] args) {
        EventDAO eventDAO = new EventDAO();

        // Sample data for testing
        int customerId = 10;
        String organizationName = "Tang Thanh Vui";
        String accountHolder = "John Doe";
        String accountNumber = "1234567890";
        String bankName = "Sample Bank";
        int categoryId = 1;
        String eventName = "Sample Concert";
        String location = "Hanoi, Vietnam";
        String eventType = "seatedevent";
        String description = "A sample concert event";
        String status = "Pending";
        String eventLogoUrl = "https://example.com/logo.png";
        String backgroundImageUrl = "https://example.com/background.png";
        String organizerImageUrl = "https://example.com/organizer.png";

        // Sample ShowTimes
        List<ShowTime> showTimes = new ArrayList<>();
        showTimes.add(new ShowTime(0, 0, Timestamp.valueOf("2025-03-01 14:00:00"), Timestamp.valueOf("2025-03-01 16:00:00"), "Scheduled", null, null));
        showTimes.add(new ShowTime(0, 0, Timestamp.valueOf("2025-04-01 14:00:00"), Timestamp.valueOf("2025-04-01 16:00:00"), "Scheduled", null, null));

        // Sample TicketTypes
        List<TicketType> ticketTypes = new ArrayList<>();
        ticketTypes.add(new TicketType(0, 0, "VIP", "VIP seating", 150000, "#FF0000", 16, 0, null, null));
        ticketTypes.add(new TicketType(0, 0, "Normal", "Normal seating", 80000, "#00FF00", 16, 0, null, null));
        ticketTypes.add(new TicketType(0, 0, "VIP Vui", "VIP seating", 150000, "#FF0000", 16, 0, null, null));
        ticketTypes.add(new TicketType(0, 0, "Normal Vui", "Normal seating", 80000, "#00FF00", 16, 0, null, null));

        // Sample Seats
        List<Seat> seats = new ArrayList<>();
        seats.add(new Seat(0, 0, "A", null, "Available"));
        seats.add(new Seat(0, 0, "B", null, "Available"));
        seats.add(new Seat(0, 0, "C", null, "Available"));
        seats.add(new Seat(0, 0, "D", null, "Available"));

        // Call createEvent method
        EventCreationResult result = eventDAO.createEvent(
                customerId, organizationName, accountHolder, accountNumber, bankName,
                categoryId, eventName, location, eventType, description, status,
                eventLogoUrl, backgroundImageUrl, organizerImageUrl,
                showTimes, ticketTypes, seats
        );

        // Print result
        System.out.println("Created Event ID: " + result.eventId);
        System.out.println("Organizer ID: " + result.organizerId);
    }
}
