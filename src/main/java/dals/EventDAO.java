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

//    private static final String SQL_SELECT_ALL_EVENTS = ;
    public List<Events> getEventsByPage(int page, int pageSize) {
        List<Events> listEvents = new ArrayList<>();
        String sql = "WITH EventPagination AS ( "
                + "SELECT ROW_NUMBER() OVER (ORDER BY created_at ASC) AS rownum, * "
                + "FROM Events "
                + ") "
                + "SELECT * FROM EventPagination WHERE rownum BETWEEN ? AND ?";
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
            System.out.println("Error fetching paginated events: " + e.getMessage());
        }
        return listEvents;
    }

    public int getTotalEvents() {
        String sql = "SELECT COUNT(*) FROM Events";
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

    public static void main(String[] args) {

//        EventDAO ld = new EventDAO();
//        int countEvents = ld.getTotalEvents();
//        System.out.println(countEvents);
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getAllEvents();
//        for (Events event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getCategoryId());
//        }
//        EventDAO ld = new EventDAO();
//        List<Events> list = ld.getTop10LatestEvents();
//        for (Events event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getCategoryId());
//        }
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
        EventDAO eventDAO = new EventDAO();

        // Kiểm tra với trang đầu tiên, mỗi trang 9 sự kiện
        int page = 1;
        int pageSize = 12;

        int totalEvents = eventDAO.getTotalEvents();
        int totalPages = (int) Math.ceil((double) totalEvents / pageSize);

        System.out.println("Total Events: " + totalEvents);
        System.out.println("Total Pages: " + totalPages);

        for (int i = 1; i <= totalPages; i++) {
            List<Events> events = eventDAO.getEventsByPage(i, pageSize);
            System.out.println("===== Events on Page " + i + " =====");
            for (Events event : events) {
                System.out.println("Event ID: " + event.getEventId() + " | Name: " + event.getEventName());
            }
        }

    }
}
