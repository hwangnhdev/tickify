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
import models.EventImage;
import utils.DBContext;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class EventImageDAO extends DBContext {

    /*getAllImageEvents*/
    public List<EventImage> getAllImageEvents() {
        List<EventImage> listImageEvents = new ArrayList<>();
        String sql = "SELECT * FROM EventImages";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                EventImage eventimages = new EventImage(
                        rs.getInt("image_id"),
                        rs.getInt("event_id"),
                        rs.getString("image_url"),
                        rs.getString("image_title"));
                listImageEvents.add(eventimages);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching events: " + e.getMessage());
        }
        return listImageEvents;
    }

    /*getImagesByEventId*/
    public List<EventImage> getImagesByEventId(int eventId) {
        List<EventImage> listImageEvents = new ArrayList<>();
        String sql = "SELECT * FROM EventImages WHERE event_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, eventId); // Gán giá trị eventId vào câu SQL
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                EventImage eventImage = new EventImage(
                        rs.getInt("image_id"),
                        rs.getInt("event_id"),
                        rs.getString("image_url"),
                        rs.getString("image_title"));
                listImageEvents.add(eventImage);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching images by eventId: " + e.getMessage());
        }
        return listImageEvents;
    }

    public static void main(String[] args) {
        /*getAllImageEvents*/
//        EventImageDAO ld = new EventImageDAO();
//        List<EventImages> list = ld.getAllImageEvents();
//        for (EventImage event : list) {
//            System.out.println(event.getEventId());
//            System.out.println(event.getImageUrl());
//        }

        /*getImagesByEventId*/
        EventImageDAO ld = new EventImageDAO();
        List<EventImage> list = ld.getImagesByEventId(1);
        for (EventImage event : list) {
            System.out.println(event.getEventId());
            System.out.println(event.getImageUrl());
        }
    }
}
