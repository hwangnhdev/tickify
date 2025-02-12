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

    private static final String SQL_SELECT_ALL_EVENTS = "SELECT TOP 20 * \n"
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

    public static void main(String[] args) {
        EventDAO ld = new EventDAO();
        List<Events> list = ld.getAllEvents();
        for (Events event : list) {
            System.out.println(event.getEventName());
            System.out.println(event.getCategoryId());
        }
    }
}
