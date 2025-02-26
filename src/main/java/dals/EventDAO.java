/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import com.google.gson.Gson;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.sql.Date;
import java.util.List;
import models.Category;
import models.EventImage;
import models.Event;
import models.Seat;
import models.TicketType;
import utils.DBContext;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class EventDAO extends DBContext {

    /*getEventsByPage*/
    public List<Event> getEventsByPage(int page, int pageSize) {
        List<Event> listEvents = new ArrayList<>();
        String sql = "WITH EventPagination AS (\n"
                + "    SELECT ROW_NUMBER() OVER (ORDER BY e.created_at ASC) AS rownum, e.*\n"
                + "    FROM Events e\n"
                + "),\n"
                + "EventImagesFiltered AS (\n"
                + "    SELECT ei.event_id, MIN(ei.image_url) AS image_url, MIN(ei.image_title) AS image_title\n"
                + "    FROM EventImages ei\n"
                + "    WHERE ei.image_title LIKE '%banner%'\n"
                + "    GROUP BY ei.event_id\n"
                + ")\n"
                + "SELECT ep.*, eif.image_url, eif.image_title\n"
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
                Event event = new Event(
                        rs.getInt("event_id"),
                        rs.getString("event_name"),
                        rs.getString("image_url"), // Lấy ảnh (có thể null)
                        rs.getString("image_title") // Lấy image_title (có thể null)
                );
                listEvents.add(event);
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

    /*getAllEvents*/
    public List<Event> getAllEvents() {
        List<Event> listEvents = new ArrayList<>();
        String sql = "SELECT * FROM Events";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("event_id"),
                        rs.getInt("category_id"),
                        rs.getString("event_name"),
                        rs.getString("location"),
                        rs.getString("event_type"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getTop10LatestEvents*/
    public List<Event> getTop10LatestEvents() {
        List<Event> listEvents = new ArrayList<>();
        String sql = "SELECT TOP 10 "
                + "e.event_id, e.category_id, e.event_name, e.location, e.event_type, "
                + "e.status, e.description, e.start_date, e.end_date, e.created_at, e.updated_at, "
                + "ei.image_url, ei.image_title "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%logo_event%' "
                + "ORDER BY e.created_at DESC";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("event_id"),
                        rs.getString("event_name"),
                        rs.getString("image_url"),
                        rs.getString("image_title")
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getUpcomingEvents*/
    public List<Event> getUpcomingEvents() {
        List<Event> listEvents = new ArrayList<>();
        String sql = "SELECT TOP 10 "
                + "e.event_id, e.category_id, e.event_name, e.location, e.event_type, "
                + "e.status, e.description, e.start_date, e.end_date, e.created_at, e.updated_at, "
                + "ei.image_url, ei.image_title "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%banner%' "
                + "WHERE e.start_date >= GETDATE() "
                + "ORDER BY e.start_date ASC";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("event_id"),
                        rs.getString("event_name"),
                        rs.getString("image_url"),
                        rs.getString("image_title")
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching upcoming events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getTopPicksForYou*/
    public List<Event> getTopPicksForYou(int customerId) {
        List<Event> listEvents = new ArrayList<>();
        String sql = "WITH AvgPrice AS ( "
                + "    SELECT AVG(tt.price) AS userBudget "
                + "    FROM Orders o "
                + "    JOIN OrderDetails od ON o.order_id = od.order_id "
                + "    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "    WHERE o.customer_id = ? "
                + "), "
                + "SuggestedPrice AS ( "
                + "    SELECT TOP 10 tt.price AS defaultBudget "
                + "    FROM TicketTypes tt "
                + "    JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id "
                + "    GROUP BY tt.price "
                + "    ORDER BY COUNT(*) DESC "
                + "), "
                + "UserBudget AS ( "
                + "    SELECT COALESCE((SELECT userBudget FROM AvgPrice), "
                + "                    (SELECT defaultBudget FROM SuggestedPrice), "
                + "                    100.00) AS budget "
                + ") "
                + "SELECT DISTINCT TOP 10 "
                + "    e.event_id, e.category_id, e.event_name, e.location, e.event_type, "
                + "    e.status, e.start_date, e.end_date, e.created_at, e.updated_at, "
                + "    MIN(tt.price) AS min_price, "
                + "    ei.image_url, ei.image_title "
                + "FROM Events e "
                + "JOIN TicketTypes tt ON e.event_id = tt.event_id "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%banner%' "
                + "CROSS JOIN UserBudget "
                + "WHERE tt.price <= UserBudget.budget "
                + "GROUP BY e.event_id, e.category_id, e.event_name, e.location, e.event_type, "
                + "         e.status, e.start_date, e.end_date, e.created_at, e.updated_at, "
                + "         ei.image_url, ei.image_title "
                + "ORDER BY min_price DESC;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("event_id"),
                        rs.getString("event_name"),
                        rs.getString("image_url"),
                        rs.getString("image_title")
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching recommended events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getRecommendedEvents*/
    public List<Event> getRecommendedEvents(int customerId) {
        List<Event> listEvents = new ArrayList<>();
        String sql = "WITH UserCategories AS ( "
                + "    SELECT DISTINCT e.category_id "
                + "    FROM Orders o "
                + "    JOIN OrderDetails od ON o.order_id = od.order_id "
                + "    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "    JOIN Events e ON tt.event_id = e.event_id "
                + "    WHERE o.customer_id = ? "
                + "), "
                + "AllCategories AS ( "
                + "    SELECT category_id FROM Categories "
                + "), "
                + "CategoriesToRecommend AS ( "
                + "    SELECT category_id FROM UserCategories "
                + "    UNION "
                + "    SELECT category_id FROM AllCategories "
                + "    WHERE NOT EXISTS (SELECT 1 FROM UserCategories) "
                + ") "
                + "SELECT TOP 10 "
                + "    e.event_id, e.category_id, e.event_name, e.location, e.event_type, "
                + "    e.status, e.start_date, e.end_date, e.created_at, e.updated_at, "
                + "    MIN(tt.price) AS min_price, "
                + "    ei.image_url, ei.image_title "
                + "FROM Events e "
                + "JOIN TicketTypes tt ON e.event_id = tt.event_id "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%logo_banner%' "
                + "WHERE e.category_id IN (SELECT category_id FROM CategoriesToRecommend) "
                + "GROUP BY e.event_id, e.category_id, e.event_name, e.location, e.event_type, "
                + "         e.status, e.start_date, e.end_date, e.created_at, e.updated_at, "
                + "         ei.image_url, ei.image_title "
                + "ORDER BY min_price DESC;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("event_id"),
                        rs.getString("event_name"),
                        rs.getString("image_url"),
                        rs.getString("image_title")
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching recommended events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getTopEventsWithLimit*/
    public List<Event> getTopEventsWithLimit() {
        List<Event> listEvents = new ArrayList<>();
        String sql = "SELECT TOP 10 \n"
                + "    e.event_id, \n"
                + "    e.event_name, \n"
                + "    COALESCE(SUM(od.quantity), 0) AS total_tickets, \n"
                + "    ei.image_url, \n"
                + "    ei.image_title\n"
                + "FROM Events e\n"
                + "JOIN TicketTypes tt ON e.event_id = tt.event_id\n"
                + "LEFT JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id\n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%banner%'\n"
                + "GROUP BY e.event_id, e.event_name, ei.image_url, ei.image_title\n"
                + "ORDER BY total_tickets DESC;";

        try {
            // Prepare SQL statement
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            // Fetch event data
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("event_id"),
                        rs.getString("event_name"),
                        rs.getString("image_url"),
                        rs.getString("image_title")
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return listEvents;
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
                        rs.getString("event_name"),
                        rs.getString("location"),
                        rs.getString("event_type"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                return event;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return null;
    }

    /*selectEventImagesByID*/
    public EventImage selectEventImagesByID(int id) {
        String sql = "SELECT * FROM EventImages\n"
                + "WHERE event_id = ? AND image_title LIKE '%banner%';";

        try {
            // Prepare SQL statement
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            // Fetch event data
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
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return null;
    }

    /*selectEventCategoriesID*/
    public Category selectEventCategoriesID(int id) {
        String sql = "SELECT * FROM Categories\n"
                + "INNER JOIN Events ON Categories.category_id = Events.category_id\n"
                + "WHERE event_id = ?";

        try {
            // Prepare SQL statement
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();

            // Fetch event data
            if (rs.next()) {
                Category eventCategories = new Category(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("description"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                return eventCategories;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return null;
    }

    /*searchEventsByQuery*/
    public List<Event> searchEventsByQuery(String query) {
        List<Event> listEvents = new ArrayList<>();
        String sql = "SELECT * FROM Events\n"
                + "WHERE event_name LIKE ?";

        try {
            // Prepare SQL statement
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + query + "%");
            ResultSet rs = st.executeQuery();

            // Fetch event data
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("event_id"),
                        rs.getInt("category_id"),
                        rs.getString("event_name"),
                        rs.getString("location"),
                        rs.getString("event_type"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return listEvents;
    }

    /*getSoldTicketsStatistic*/
    public List<Event> getSoldTicketsStatistic() {
        List<Event> listEvents = new ArrayList<>();
        String sql = "SELECT * FROM Events\n"
                + "WHERE event_name LIKE ?";

        try {
            // Prepare SQL statement
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            // Fetch event data
            while (rs.next()) {
                Event event = new Event(
                        rs.getInt("event_id"),
                        rs.getInt("category_id"),
                        rs.getString("event_name"),
                        rs.getString("location"),
                        rs.getString("event_type"),
                        rs.getString("status"),
                        rs.getString("description"),
                        rs.getDate("start_date"),
                        rs.getDate("end_date"),
                        rs.getDate("created_at"),
                        rs.getDate("updated_at")
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return listEvents;
    }

    /*createEvent*/
    public void createEvent(Event event, List<EventImage> images, int customerId, String organizationName,
            List<TicketType> ticketTypes, List<Seat> seats) {
        String sql = "{CALL InsertEventWithImages(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";

        try ( CallableStatement stmt = connection.prepareCall(sql)) {
            // Set parameters for Events
            stmt.setString(1, event.getEventName());
            stmt.setString(2, event.getLocation());
            stmt.setString(3, event.getEventType());
            stmt.setString(4, event.getStatus());
            stmt.setString(5, event.getDescription());
            stmt.setTimestamp(6, new Timestamp(event.getStartDate().getTime())); // Giữ giờ
            stmt.setTimestamp(7, new Timestamp(event.getEndDate().getTime()));   // Giữ giờ

            // Set categoryId (nullable)
            stmt.setInt(8, event.getCategoryId());

            // Set Organizer parameters
            stmt.setInt(9, customerId);
            stmt.setString(10, organizationName);

            // Convert images to JSON
            Gson gson = new Gson();
            String imagesJson = gson.toJson(images);
            stmt.setNString(11, imagesJson);

            // Convert ticket types to JSON
            String ticketTypesJson = gson.toJson(ticketTypes);
            stmt.setNString(12, ticketTypesJson);

            // Convert seats to JSON (nullable)
            String seatsJson = (seats != null && !seats.isEmpty()) ? gson.toJson(seats) : null;
            stmt.setNString(13, seatsJson);

            // Execute the stored procedure
            stmt.execute();
            System.out.println("Event created successfully with all related data.");
        } catch (SQLException e) {
            System.out.println("Error creating event: " + e.getMessage());
            throw new RuntimeException("Failed to create event", e);
        }
    }

    /*main*/
    public static void main(String[] args) {
        /*createEvent*/
        EventDAO eventDAO = new EventDAO();

        // Create Event object
        Event event = new Event(
                0, // eventId will be auto-generated
                2, // categoryId
                "Festival 2025",
                "Saigon",
                "Cultural",
                "Active",
                "A vibrant festival",
                new Date(Timestamp.valueOf(LocalDateTime.of(2025, 4, 1, 9, 0)).getTime()), // 2025-04-01 09:00:00
                new Date(Timestamp.valueOf(LocalDateTime.of(2025, 4, 3, 18, 0)).getTime()), // 2025-04-03 18:00:00
                null, // createdAt
                null // updatedAt
        );

        // Create list of EventImage
        List<EventImage> images = Arrays.asList(
                new EventImage("https://res.cloudinary.com/dnvpphtov/image/upload/v1739624793/sbtebivpbkgr9indbdhy.jpg", "Music logo_banner"),
                new EventImage("https://res.cloudinary.com/dnvpphtov/image/upload/v1739624800/k240hpwtibcpxwgeibay.jpg", "Music logo_event"),
                new EventImage("https://res.cloudinary.com/dnvpphtov/image/upload/v1739624800/k240hpwtibcpxwgeibay.jpg", "Music logo_organizer")
        );

        // Organizer info
        int customerId = 2;
        String organizationName = "Vivid Corp";

        // Create list of TicketType
        List<TicketType> ticketTypes = Arrays.asList(
                new TicketType("VIP", "VIP seating", 150.00, 50),
                new TicketType("General", "General admission", 50.00, 200)
        );

        // Create list of Seat (optional)
        List<Seat> seats = Arrays.asList(
                new Seat("A", "1", "Available"),
                new Seat("A", "2", "Available")
        );
        // Nếu không cần ghế, có thể truyền null: List<Seat> seats = null;

        // Call createEvent method
        eventDAO.createEvent(event, images, customerId, organizationName, ticketTypes, seats);

        /*searchEventsByQuery*/
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.searchEventsByQuery("Rock Festival");
//        int count = 0;
//        for (Event event : list) {
//            System.out.println(event.getEventName());
//            count++;
//        }
//        System.out.println(count);

        /*selectEventByID*/
//        EventDAO ld = new EventDAO();
//        Event event = ld.selectEventByID(1);
//        System.out.println(event.getEventName());

        /*selectEventByID*/
//        EventDAO ld = new EventDAO();
//        EventImage event = ld.selectEventImagesByID(1);
//        System.out.println(event.getImageId());

        /*selectEventCategoriesID*/
//        EventDAO ld = new EventDAO();
//        Category event = ld.selectEventCategoriesID(1);
//        System.out.println(event.getCategoryName());

        /*getTopEventsWithLimit*/
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getTopEventsWithLimit();
//        for (Event event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getImageURL());
//            System.out.println(event.getImageTitle());
//        }

        /*getTop10LatestEvents*/
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getTop10LatestEvents();
//        for (Event event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getImageURL());
//        }

        /*getUpcomingEvents*/
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getUpcomingEvents();
//        for (Event event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getImageURL());
//            System.out.println(event.getImageTitle());
//        }

        /*getTopPicksForYou*/
//        EventDAO ld = new EventDAO();
//        List<Event> list = ld.getTopPicksForYou(3);
//        for (Event event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getImageURL());
//            System.out.println(event.getImageTitle());
//        }

        /*getRecommendedEvents*/
//        EventDAO ld = new EventDAO();
//        List<Event> list = ld.getRecommendedEvents(1);
//        for (Event event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getImageURL());
//            System.out.println(event.getImageTitle());
//        }

        /*getTotalEvents*/
//        EventDAO ld = new EventDAO();
//        int countEvents = ld.getTotalEvents();
//        System.out.println(countEvents);
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getAllEvents();
//        for (Event event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getCategoryId());
//        }

        /*getTopEventsWithLimit*/
        // Create instance of EventDAO
//        EventDAO eventDAO = new EventDAO();
//        // Test fetching top 10 best-selling events
//        int limit = 10;
//        List<Event> events = eventDAO.getTopEventsWithLimit();
//        // Print results to check if the query works correctly
//        System.out.println("===== Top " + limit + " Best-Selling Event =====");
//        for (Event event : events) {
//            System.out.println("Event ID: " + event.getEventId()
//                    + " | Name: " + event.getEventName()
//            );
//            System.out.println(event.getImageURL());
//        }
//        // Check if the result contains the correct number of events
//        if (events.size() == limit) {
//            System.out.println("Test Passed: Retrieved " + limit + " events successfully.");
//        } else {
//            System.out.println("Test Failed: Expected " + limit + " events but got " + events.size());
//        }

        /*getEventsByPage*/
//        EventDAO eventDAO = new EventDAO();
//
//        // Kiểm tra với trang đầu tiên, mỗi trang 9 sự kiện
//        int page = 1;
//        int pageSize = 16;
//
//        int totalEvents = eventDAO.getTotalEvents();
//        int totalPages = (int) Math.ceil((double) totalEvents / pageSize);
//
//        System.out.println("Total Event: " + totalEvents);
//        System.out.println("Total Pages: " + totalPages);
//
//        for (int i = 1; i <= totalPages; i++) {
//            List<Events> events = eventDAO.getEventsByPage(i, pageSize);
//            System.out.println("===== Event on Page " + i + " =====");
//            for (Event event : events) {
//                System.out.println("Event ID: " + event.getEventId() + " | Name: " + event.getEventName());
//                System.out.println("Event ID: " + event.getImageURL() + " | Name: " + event.getImageTitle());
//            }
//        }
    }
}
