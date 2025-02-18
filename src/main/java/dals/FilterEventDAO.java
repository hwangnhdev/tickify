/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import models.Events;
import models.FilterEvent;
import utils.DBContext;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class FilterEventDAO extends DBContext {

    public List<Events> getFilteredEvents(FilterEvent filters) {
        List<Events> events = new ArrayList<>();

        // Base query
        StringBuilder sql = new StringBuilder("SELECT DISTINCT e.* \n"
                + "FROM Events e\n"
                + "LEFT JOIN TicketTypes t ON e.event_id = t.event_id\n"
                + "LEFT JOIN Vouchers v ON v.voucher_id IS NOT NULL\n"
                + "WHERE 1 = 1 ");

        // Parameters
        List<Object> parameters = new ArrayList<>();

        // Filter by category
        if (filters.getCategoryID() != null) {
            sql.append(" AND e.category_id = ?");
            parameters.add(filters.getCategoryID());
        }

        // Filter by location
        if (filters.getLocation() != null && !filters.getLocation().isEmpty()) {
            sql.append(" AND e.location LIKE ?");
            parameters.add("%" + filters.getLocation() + "%");
        }

        // Filter by date range
        if (filters.getStartDate() != null && filters.getEndDate() != null) {
            sql.append(" AND e.start_date >= ? AND e.end_date <= ?");
            parameters.add(filters.getStartDate());
            parameters.add(filters.getEndDate());
        }

        // Filter by price range
        if (filters.getPrice() != null) {
            switch (filters.getPrice()) {
                case "below_150":
                    sql.append(" AND t.price < 150");
                    break;
                case "between_150_300":
                    sql.append(" AND t.price BETWEEN 150 AND 300");
                    break;
                case "greater_300":
                    sql.append(" AND t.price > 300");
                    break;
            }
        }

        // Filter events that have vouchers
        if (filters.isVouchers()) {
            sql.append(" AND v.voucher_id IS NOT NULL");
        }

        try ( PreparedStatement st = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < parameters.size(); i++) {
                st.setObject(i + 1, parameters.get(i));
            }

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
                events.add(event);
            }
        } catch (SQLException e) {
            System.out.println("Error fetching filtered events: " + e.getMessage());
        }

        return events;
    }

    public static void main(String[] args) {
        FilterEventDAO filterEventDAO = new FilterEventDAO();

        // Thiết lập các bộ lọc
        List<Integer> categories = Arrays.asList(1, 2);
        String location = "Open Arena";
        Date startDate = Date.valueOf("2025-06-20 00:00:00.000");
        Date endDate = Date.valueOf("2025-06-21 00:00:00.000");
        String priceRange = "between_150_300"; // Các giá trị hợp lệ: "below 150", "between 150 and 300", "greater than 300"
        boolean hasVoucher = true;

        // Tạo đối tượng FilterEvent
        FilterEvent filterEvent = new FilterEvent(categories, location, startDate, endDate, priceRange, hasVoucher);

        // Gọi phương thức lọc sự kiện
        List<Events> filteredEvents = filterEventDAO.getFilteredEvents(filterEvent);

        // Hiển thị kết quả
        for (Events event : filteredEvents) {
            System.out.println(event.getEventName());
        }
    }
}
