/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Events;
import utils.DBContext;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class EventDAO extends DBContext {

////////////////////////////////////////////////////////////////////////////////
    public List<Events> getEventsByPage(int page, int pageSize) {
        List<Events> listEvents = new ArrayList<>();
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
                + "WHERE ep.rownum BETWEEN ? AND ?;";  // Không dùng AND với image_title

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int start = (page - 1) * pageSize + 1;
            int end = page * pageSize;
            st.setInt(1, start);
            st.setInt(2, end);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events(
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

////////////////////////////////////////////////////////////////////////////////
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

////////////////////////////////////////////////////////////////////////////////
    public List<Events> getAllEvents() {
        List<Events> listEvents = new ArrayList<>();
        String sql = "SELECT * FROM Events";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events(
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
////////////////////////////////////////////////////////////////////////////////

    public List<Events> getTop10LatestEvents() {
        List<Events> listEvents = new ArrayList<>();
        String sql = "SELECT TOP 10 * \n"
                + "FROM Events \n"
                + "ORDER BY created_at DESC";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events(
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
////////////////////////////////////////////////////////////////////////////////

    public List<Events> getUpcomingEvents() {
        List<Events> listEvents = new ArrayList<>();
        String sql = "SELECT TOP 10 * FROM Events "
                + "WHERE start_date >= GETDATE() "
                + "ORDER BY start_date ASC";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events(
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
            System.out.println("Error fetching upcoming events: " + e.getMessage());
        }
        return listEvents;
    }
////////////////////////////////////////////////////////////////////////////////

    public List<Events> getTopPicksForYou(int customerId) {
        List<Events> listEvents = new ArrayList<>();
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
                + "    MIN(tt.price) AS min_price "
                + "FROM Events e "
                + "JOIN TicketTypes tt ON e.event_id = tt.event_id "
                + "CROSS JOIN UserBudget "
                + "WHERE tt.price <= UserBudget.budget "
                + "GROUP BY e.event_id, e.category_id, e.event_name, e.location, e.event_type, "
                + "         e.status, e.start_date, e.end_date, e.created_at, e.updated_at "
                + "ORDER BY min_price DESC;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events(
                        rs.getInt("event_id"),
                        0,
                        rs.getString("event_name"),
                        "",
                        "",
                        "",
                        "",
                        null,
                        null,
                        null,
                        null
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching upcoming events: " + e.getMessage());
        }
        return listEvents;
    }
////////////////////////////////////////////////////////////////////////////////

    public List<Events> getRecommendedEvents(int customerId) {
        List<Events> listEvents = new ArrayList<>();
        String sql = "\n"
                + "            WITH UserCategories AS (\n"
                + "                SELECT DISTINCT e.category_id\n"
                + "                FROM Orders o\n"
                + "                JOIN OrderDetails od ON o.order_id = od.order_id\n"
                + "                JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id\n"
                + "                JOIN Events e ON tt.event_id = e.event_id\n"
                + "                WHERE o.customer_id = ?\n"
                + "            ),\n"
                + "            AllCategories AS (\n"
                + "                SELECT category_id FROM Categories\n"
                + "            ),\n"
                + "            CategoriesToRecommend AS (\n"
                + "                SELECT category_id FROM UserCategories\n"
                + "                UNION\n"
                + "                SELECT category_id FROM AllCategories\n"
                + "                WHERE NOT EXISTS (SELECT 1 FROM UserCategories)\n"
                + "            )\n"
                + "            SELECT TOP 10 \n"
                + "                e.event_id, e.category_id, e.event_name, e.location, e.event_type, \n"
                + "                e.status, e.start_date, e.end_date, e.created_at, e.updated_at, \n"
                + "                MIN(tt.price) AS min_price\n"
                + "            FROM Events e\n"
                + "            JOIN TicketTypes tt ON e.event_id = tt.event_id\n"
                + "            WHERE e.category_id IN (SELECT category_id FROM CategoriesToRecommend)\n"
                + "            GROUP BY e.event_id, e.category_id, e.event_name, e.location, e.event_type, \n"
                + "                     e.status, e.start_date, e.end_date, e.created_at, e.updated_at\n"
                + "            ORDER BY min_price DESC;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, customerId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Events event = new Events(
                        rs.getInt("event_id"),
                        0,
                        rs.getString("event_name"),
                        "",
                        "",
                        "",
                        "",
                        null,
                        null,
                        null,
                        null
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching upcoming events: " + e.getMessage());
        }
        return listEvents;
    }
////////////////////////////////////////////////////////////////////////////////

    public List<Events> getTopEventsWithLimit() {
        List<Events> listEvents = new ArrayList<>();
        String sql = "SELECT TOP 10 e.event_id, e.event_name, "
                + "COALESCE(SUM(od.quantity), 0) AS total_tickets "
                + "FROM Events e "
                + "JOIN TicketTypes tt ON e.event_id = tt.event_id "
                + "LEFT JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id "
                + "GROUP BY e.event_id, e.event_name "
                + "ORDER BY total_tickets DESC";

        try {
            // Prepare SQL statement
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            // Fetch event data
            while (rs.next()) {
                Events event = new Events(
                        rs.getInt("event_id"),
                        0,
                        rs.getString("event_name"),
                        "",
                        "",
                        "",
                        "",
                        null,
                        null,
                        null,
                        null
                );
                listEvents.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching top events: " + e.getMessage());
        }
        return listEvents;
    }
////////////////////////////////////////////////////////////////////////////////

    public static void main(String[] args) {
////////////////////////////////////////////////////////////////////////////
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getRecommendedEvents(1);
//        for (Events event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getEventId());
//        }
////////////////////////////////////////////////////////////////////////////
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getTopPicksForYou(1);
//        for (Events event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getEventId());
//        }
////////////////////////////////////////////////////////////////////////////
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getUpcomingEvents();
//        for (Events event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getCategoryId());
//        }
////////////////////////////////////////////////////////////////////////////
//        EventDAO ld = new EventDAO();
//        int countEvents = ld.getTotalEvents();
//        System.out.println(countEvents);
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getAllEvents();
//        for (Events event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getCategoryId());
//        }
////////////////////////////////////////////////////////////////////////////
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getTop10LatestEvents();
//        for (Events event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getCategoryId());
//        }
////////////////////////////////////////////////////////////////////////////
//        // Create instance of EventDAO
//        EventDAO eventDAO = new EventDAO();
//        // Test fetching top 10 best-selling events
//        int limit = 10;
//        List<Events> events = eventDAO.getTopEventsWithLimit();
//        // Print results to check if the query works correctly
//        System.out.println("===== Top " + limit + " Best-Selling Events =====");
//        for (Events event : events) {
//            System.out.println("Event ID: " + event.getEventId()
//                    + " | Name: " + event.getEventName()
//            );
//        }
//        // Check if the result contains the correct number of events
//        if (events.size() == limit) {
//            System.out.println("Test Passed: Retrieved " + limit + " events successfully.");
//        } else {
//            System.out.println("Test Failed: Expected " + limit + " events but got " + events.size());
//        }
////////////////////////////////////////////////////////////////////////////
        EventDAO eventDAO = new EventDAO();

        // Kiểm tra với trang đầu tiên, mỗi trang 9 sự kiện
        int page = 1;
        int pageSize = 16;

        int totalEvents = eventDAO.getTotalEvents();
        int totalPages = (int) Math.ceil((double) totalEvents / pageSize);

        System.out.println("Total Events: " + totalEvents);
        System.out.println("Total Pages: " + totalPages);

        for (int i = 1; i <= totalPages; i++) {
            List<Events> events = eventDAO.getEventsByPage(i, pageSize);
            System.out.println("===== Events on Page " + i + " =====");
            for (Events event : events) {
                System.out.println("Event ID: " + event.getEventId() + " | Name: " + event.getEventName());
                System.out.println("Event ID: " + event.getImageURL() + " | Name: " + event.getImageTitle());
            }
        }
    }
}
