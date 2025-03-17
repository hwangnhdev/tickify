package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Event;
import models.EventImage;
import viewModels.FilterEvent;
import utils.DBContext;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class FilterEventDAO extends DBContext {

    /*getFilteredEvents*/
    public List<EventImage> getFilteredEvents(FilterEvent filters) {
        List<EventImage> events = new ArrayList<>();

        // Constructing the base SQL query with event details
        StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT \n"
                + "e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, \n"
                + "e.location, e.event_type, e.created_at, e.updated_at, ei.image_url, ei.image_title,\n"
                + "MIN(CAST(s.start_date AS DATE)) AS start_date, MAX(CAST(s.end_date AS DATE)) AS end_date,\n"
                + "CAST(e.created_at AS DATE) AS created_at, CAST(e.updated_at AS DATE) AS updated_at\n"
                + "FROM Events e\n"
                + "LEFT JOIN Showtimes s ON e.event_id = s.event_id \n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%logo_banner%'\n"
                + "WHERE e.status = 'Approved'"
        );

        // List to store query parameters
        List<Object> parameters = new ArrayList<>();

        // Filtering by category IDs
        if (filters.getCategoryID() != null && !filters.getCategoryID().isEmpty()) {
            StringBuilder categoryPlaceholders = new StringBuilder();
            for (int i = 0; i < filters.getCategoryID().size(); i++) {
                if (i > 0) {
                    categoryPlaceholders.append(", ");
                }
                categoryPlaceholders.append("?");
            }
            sql.append(" AND e.category_id IN (").append(categoryPlaceholders).append(")");
            parameters.addAll(filters.getCategoryID());
        }

        // Filtering by location
        if (filters.getLocation() != null && !filters.getLocation().isEmpty()) {
            sql.append(" AND e.location LIKE ?");
            parameters.add("%" + filters.getLocation() + "%");
        }

        // Filtering by event date range
        if (filters.getStartDate() != null && filters.getEndDate() != null) {
            sql.append(" AND s.start_date >= ? AND s.end_date <= ?");
            parameters.add(new java.sql.Date(filters.getStartDate().getTime()));
            parameters.add(new java.sql.Date(filters.getEndDate().getTime()));
        }

        // Filtering by search query
        if (filters.getSearchQuery() != null && !filters.getSearchQuery().isEmpty()) {
            sql.append(" AND e.event_name LIKE ?");
            parameters.add("%" + filters.getSearchQuery() + "%");
        }

        sql.append(" GROUP BY e.event_id, e.event_name, e.category_id, e.organizer_id, e.description, e.status, \n"
                + "e.location, e.event_type, e.created_at, e.updated_at, ei.image_url, ei.image_title");

        // Print the final SQL query and parameters for debugging
        System.out.println("Final SQL Query: " + sql.toString());
        System.out.println("Parameters: " + parameters);

        try ( PreparedStatement st = connection.prepareStatement(sql.toString())) {
            // Set query parameters dynamically
            for (int i = 0; i < parameters.size(); i++) {
                st.setObject(i + 1, parameters.get(i));
            }

            // Execute query and process results
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
                events.add(eventImage);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching filtered events: " + e.getMessage());
        }

        return events;
    }

    public static void main(String[] args) {
        FilterEventDAO filterEventDAO = new FilterEventDAO();

        // Defining filter criteria
        List<Integer> categories = new ArrayList<>();
        categories.add(1);
        String location = "Thành Phố Hồ Chí Minh";
        java.util.Date startDate = java.sql.Date.valueOf("2025-03-01");
        java.util.Date endDate = java.sql.Date.valueOf("2025-03-31");
        String priceRange = "below_150";
        boolean hasVoucher = true;
        String query = "Concert";

        // Creating a filter object with the specified criteria
        FilterEvent filterEvent = new FilterEvent(categories, null, null, null, null, false, null);

        // Fetching the filtered events
        List<EventImage> filteredEvents = filterEventDAO.getFilteredEvents(filterEvent);
        int count = 0;

        // Printing the event names and count of filtered events
        for (EventImage filteredEvent : filteredEvents) {
            System.out.println("Event ID: " + filteredEvent.getEventId());
            System.out.println("Event Name: " + filteredEvent.getEventName());
            System.out.println("Image Title: " + filteredEvent.getImageTitle());
            System.out.println("Image URL: " + filteredEvent.getImageUrl());
            System.out.println("------------------------");
            count++;
        }
        System.out.println("Total events found: " + count);
    }
}
