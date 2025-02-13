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

    private static final String SQL_SELECT_ALL_EVENTS = "SELECT TOP 10 * \n"
            + "FROM Events \n"
            + "ORDER BY created_at DESC";

    public List<Events> getAllEvents() {
        List<Events> listEvents = new ArrayList<>();

        try {
            PreparedStatement st = connection.prepareStatement(SQL_SELECT_ALL_EVENTS);
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
//        List<Events> list = ld.getAllEvents();
//        for (Events event : list) {
//            System.out.println(event.getEventName());
//            System.out.println(event.getCategoryId());
//        }

        // Create instance of EventDAO
        EventDAO eventDAO = new EventDAO();

        // Test fetching top 10 best-selling events
        int limit = 10;
        List<Events> events = eventDAO.getTopEventsWithLimit();

        // Print results to check if the query works correctly
        System.out.println("===== Top " + limit + " Best-Selling Events =====");
        for (Events event : events) {
            System.out.println("Event ID: " + event.getEventId()
                    + " | Name: " + event.getEventName()
            );
        }

        // Check if the result contains the correct number of events
        if (events.size() == limit) {
            System.out.println("Test Passed: Retrieved " + limit + " events successfully.");
        } else {
            System.out.println("Test Failed: Expected " + limit + " events but got " + events.size());
        }
    }
}
