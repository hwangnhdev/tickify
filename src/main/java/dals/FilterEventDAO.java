///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
// */
//package dals;
//
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//import models.Event;
//import models.FilterEvent;
//import utils.DBContext;
//
///**
// *
// * @author Tang Thanh Vui - CE180901
// */
//public class FilterEventDAO extends DBContext {
//
//    /*searchEventsByQuery*/
//    public List<Event> getFilteredEvents(FilterEvent filters) {
//        List<Event> events = new ArrayList<>();
//
//        // Constructing the base SQL query with event details
//        StringBuilder sql = new StringBuilder("SELECT DISTINCT e.event_id, e.category_id, e.event_name, e.location, "
//                + "e.event_type, e.status, e.description, "
//                + "CAST(e.start_date AS DATE) AS start_date, CAST(e.end_date AS DATE) AS end_date, "
//                + "CAST(e.created_at AS DATE) AS created_at, CAST(e.updated_at AS DATE) AS updated_at, "
//                + "ei. * "
//                + "FROM Events e "
//                + "LEFT JOIN TicketTypes t ON e.event_id = t.event_id "
//                + "LEFT JOIN EventImages ei ON ei.event_id = e.event_id "
//                + "WHERE 1 = 1 AND ei.image_title LIKE '%logo_banner%' ");
//
//        // List to store query parameters
//        List<Object> parameters = new ArrayList<>();
//
//        // Filtering by category IDs
//        if (filters.getCategoryID() != null && !filters.getCategoryID().isEmpty()) {
//            StringBuilder categoryPlaceholders = new StringBuilder();
//            for (int i = 0; i < filters.getCategoryID().size(); i++) {
//                if (i > 0) {
//                    categoryPlaceholders.append(", ");
//                }
//                categoryPlaceholders.append("?");
//            }
//            sql.append(" AND e.category_id IN (" + categoryPlaceholders + ")");
//            parameters.addAll(filters.getCategoryID());
//        }
//
//        // Filtering by location
//        if (filters.getLocation() != null && !filters.getLocation().isEmpty()) {
//            sql.append(" AND e.location LIKE ?");
//            parameters.add("%" + filters.getLocation() + "%");
//        }
//
//        // Filtering by event date range
//        if (filters.getStartDate() != null && filters.getEndDate() != null) {
//            sql.append(" AND e.start_date >= ? AND e.end_date <= ?");
//            parameters.add(new java.sql.Date(filters.getStartDate().getTime()));
//            parameters.add(new java.sql.Date(filters.getEndDate().getTime()));
//        }
//
//        // Filtering by price range
//        if (filters.getPrice() != null) {
//            switch (filters.getPrice()) {
//                case "below_150":
//                    sql.append(" AND t.price < 150");
//                    break;
//                case "between_150_300":
//                    sql.append(" AND t.price BETWEEN 150 AND 300");
//                    break;
//                case "greater_300":
//                    sql.append(" AND t.price > 300");
//                    break;
//            }
//        }
//
//        // Filtering by voucher availability
//        if (filters.isVouchers()) {
//            sql.append(" AND v.voucher_id IS NOT NULL");
//        }
//
//        // Filtering by Search
//        if (filters.getSearchQuery() != null && !filters.getSearchQuery().isEmpty()) {
//            sql.append(" AND e.event_name LIKE ?");
//            parameters.add("%" + filters.getSearchQuery() + "%");
//        }
//
//        // Print the final SQL query and parameters for debugging
//        System.out.println("Final SQL Query: " + sql.toString());
//        System.out.println("Parameters: " + parameters);
//
//        try ( PreparedStatement st = connection.prepareStatement(sql.toString())) {
//            // Set query parameters dynamically
//            for (int i = 0; i < parameters.size(); i++) {
//                st.setObject(i + 1, parameters.get(i));
//            }
//
//            // Execute query and process results
//            ResultSet rs = st.executeQuery();
//            while (rs.next()) {
//                Event event = new Event(
//                        rs.getInt("event_id"),
//                        rs.getString("event_name"),
//                        rs.getString("image_url"),
//                        rs.getString("image_title")
//                );
//                events.add(event);
//            }
//        } catch (SQLException e) {
//            System.err.println("Error fetching filtered events: " + e.getMessage());
//        }
//
//        return events;
//    }
//
//    public static void main(String[] args) {
//        /*getFilteredEvents*/
////        FilterEventDAO filterEventDAO = new FilterEventDAO();
////
////        // Defining filter criteria
////        List<Integer> categories = Arrays.asList(1, 2);
////        String location = "Tech Hub";
////        Date startDate = Date.valueOf("2025-07-25");
////        Date endDate = Date.valueOf("2025-07-26");
////        String priceRange = "below_150";
////        boolean hasVoucher = true;
////        String query = "AI & Robotics Summit";
////
////        // Creating a filter object with the specified criteria
////        FilterEvent filterEvent = new FilterEvent(null, null, null, null, null, false, query);
////
////        // Fetching the filtered events
////        List<Event> filteredEvents = filterEventDAO.getFilteredEvents(filterEvent);
////        int count = 0;
////
////        // Printing the event names and count of filtered events
////        for (Event event : filteredEvents) {
////            System.out.println(event.getEventName());
////            System.out.println(event.getImageTitle());
////            System.out.println(event.getImageURL());
////            count++;
////        }
////        System.out.println(count);
//    }
//}
