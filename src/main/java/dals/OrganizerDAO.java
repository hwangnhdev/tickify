package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

import viewModels.EventDetailDTO;
import viewModels.EventSummaryDTO;
import models.Order;
import viewModels.OrderDetailDTO;

import utils.DBContext;

/**
 *
 * @author Duong Minh Kiet - CE180166
 */
public class OrganizerDAO extends DBContext {

    public EventDetailDTO getCustomerEventDetail(int customerId, int eventId) {
    EventDetailDTO detail = null;
    String sql = "SELECT " +
                 "    e.event_id AS eventId, " +
                 "    e.event_name AS eventName, " +
                 "    MIN(s.start_date) AS startDate, " +
                 "    MAX(s.end_date) AS endDate, " +
                 "    e.location AS location, " +
                 "    e.status AS eventStatus, " +
                 "    e.description AS description, " +
                 "    ( " +
                 "        SELECT TOP 1 image_url " +
                 "        FROM EventImages " +
                 "        WHERE event_id = e.event_id " +
                 "        ORDER BY image_id " +
                 "    ) AS imageURL, " +
                 "    org.organization_name AS organizationName " +
                 "FROM Events e " +
                 "INNER JOIN Organizers org ON e.organizer_id = org.organizer_id " +
                 "INNER JOIN Showtimes s ON e.event_id = s.event_id " +
                 "WHERE e.event_id = ? " +
                 "  AND EXISTS ( " +
                 "      SELECT 1 " +
                 "      FROM Orders o " +
                 "      INNER JOIN OrderDetails od ON o.order_id = od.order_id " +
                 "      INNER JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id " +
                 "      INNER JOIN Showtimes s2 ON tt.showtime_id = s2.showtime_id " +
                 "      WHERE s2.event_id = e.event_id " +
                 "        AND o.customer_id = ? " +
                 "  ) " +
                 "GROUP BY e.event_id, e.event_name, e.location, e.status, e.description, org.organization_name";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, eventId);
        ps.setInt(2, customerId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                detail = new EventDetailDTO();
                detail.setEventId(rs.getInt("eventId"));
                detail.setEventName(Objects.toString(rs.getString("eventName"), ""));
                detail.setStartDate(rs.getTimestamp("startDate"));
                detail.setEndDate(rs.getTimestamp("endDate"));
                detail.setLocation(Objects.toString(rs.getString("location"), ""));
                detail.setEventStatus(Objects.toString(rs.getString("eventStatus"), ""));
                detail.setDescription(Objects.toString(rs.getString("description"), ""));
                detail.setImageUrl(Objects.toString(rs.getString("imageURL"), ""));
                detail.setOrganizationName(Objects.toString(rs.getString("organizationName"), ""));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return detail;
}




    public List<EventSummaryDTO> getEventsByCustomer(int customerId, String filter) {
        List<EventSummaryDTO> events = new ArrayList<>();
        String sql = "SELECT "
                + "    e.event_id AS eventId, "
                + "    e.event_name AS eventName, "
                + "    MIN(s.start_date) AS startDate, "
                + "    MAX(s.end_date) AS endDate, "
                + "    e.location AS location, "
                + "    e.status AS status, "
                + "    ( "
                + "        SELECT TOP 1 image_url "
                + "        FROM EventImages "
                + "        WHERE event_id = e.event_id "
                + "        ORDER BY image_id "
                + "    ) AS image "
                + "FROM Events e "
                + "JOIN Showtimes s ON e.event_id = s.event_id "
                + "WHERE EXISTS ( "
                + "    SELECT 1 "
                + "    FROM Orders o "
                + "    JOIN OrderDetails od ON o.order_id = od.order_id "
                + "    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "    JOIN Showtimes s2 ON tt.showtime_id = s2.showtime_id "
                + "    WHERE s2.event_id = e.event_id "
                + "      OR o.customer_id = ? "
                + ") ";

        // Nếu filter là processing, approved, hoặc rejected thì lọc theo e.status
        if (filter != null && (filter.equalsIgnoreCase("processing")
                || filter.equalsIgnoreCase("approved")
                || filter.equalsIgnoreCase("rejected"))) {
            sql += "AND LOWER(e.status) = ? ";
        }

        sql += "GROUP BY e.event_id, e.event_name, e.location, e.status ";

        // Nếu filter là upcoming hoặc past thì sử dụng HAVING để lọc theo thời gian
        if (filter != null && filter.equalsIgnoreCase("upcoming")) {
            sql += "HAVING MIN(s.start_date) > GETDATE() ";
        } else if (filter != null && filter.equalsIgnoreCase("past")) {
            sql += "HAVING MAX(s.end_date) < GETDATE() ";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int index = 1;
            ps.setInt(index++, customerId);
            if (filter != null && (filter.equalsIgnoreCase("processing")
                    || filter.equalsIgnoreCase("approved")
                    || filter.equalsIgnoreCase("rejected"))) {
                ps.setString(index++, filter.toLowerCase());
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                EventSummaryDTO eventSummary = new EventSummaryDTO();
                eventSummary.setEventId(rs.getInt("eventId"));
                eventSummary.setEventName(rs.getString("eventName") != null ? rs.getString("eventName") : "");
                eventSummary.setStartDate(rs.getTimestamp("startDate"));
                eventSummary.setEndDate(rs.getTimestamp("endDate"));
                eventSummary.setLocation(rs.getString("location") != null ? rs.getString("location") : "");
                // Gán giá trị của e.status vào thuộc tính eventStatus
                eventSummary.setEventStatus(rs.getString("status") != null ? rs.getString("status") : "");
                eventSummary.setImageUrl(rs.getString("image") != null ? rs.getString("image") : "");
                events.add(eventSummary);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<OrderDetailDTO> getOrderDetailsByOrganizerAndPaymentStatus(
            int organizerId, int eventId, String paymentStatus, String searchOrder, int offset, int pageSize) {
        List<OrderDetailDTO> orders = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT od.order_detail_id, o.order_id, o.order_date, o.total_price, o.payment_status, ");
        sql.append("       c.full_name AS customerName, e.event_name, e.location ");
        sql.append("FROM Orders o ");
        sql.append("JOIN OrderDetails od ON o.order_id = od.order_id ");
        sql.append("JOIN Customers c ON o.customer_id = c.customer_id ");
        sql.append("JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id ");
        sql.append("JOIN Showtimes s ON tt.showtime_id = s.showtime_id ");
        sql.append("JOIN Events e ON s.event_id = e.event_id ");
        sql.append("WHERE e.organizer_id = ? ");
        if (eventId > 0) {
            sql.append("AND e.event_id = ? ");
        }
        if (!"all".equalsIgnoreCase(paymentStatus)) {
            sql.append("AND LOWER(o.payment_status) = ? ");
        }
        if (searchOrder != null && !searchOrder.isEmpty()) {
            sql.append("AND c.full_name LIKE ? ");
        }
        sql.append("ORDER BY o.created_at DESC ");
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setInt(index++, organizerId);
            if (eventId > 0) {
                ps.setInt(index++, eventId);
            }
            if (!"all".equalsIgnoreCase(paymentStatus)) {
                ps.setString(index++, paymentStatus.toLowerCase());
            }
            if (searchOrder != null && !searchOrder.isEmpty()) {
                ps.setString(index++, "%" + searchOrder + "%");
            }
            ps.setInt(index++, offset);
            ps.setInt(index++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetailDTO order = new OrderDetailDTO();
                order.setOrderDetailId(rs.getInt("order_detail_id"));
                order.setOrderId(rs.getInt("order_id"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setGrandTotal(rs.getDouble("total_price"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setCustomerName(rs.getString("customerName"));
                order.setEventName(rs.getString("event_name"));
                order.setLocation(rs.getString("location"));
                // Các trường khác nếu có
                orders.add(order);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
    }

    public int countOrdersByOrganizerAndPaymentStatus(
            int organizerId, int eventId, String paymentStatus, String searchOrder) {
        int count = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) ");
        sql.append("FROM Orders o ");
        sql.append("JOIN OrderDetails od ON o.order_id = od.order_id ");
        sql.append("JOIN Customers c ON o.customer_id = c.customer_id ");
        sql.append("JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id ");
        sql.append("JOIN Showtimes s ON tt.showtime_id = s.showtime_id ");
        sql.append("JOIN Events e ON s.event_id = e.event_id ");
        sql.append("WHERE e.organizer_id = ? ");
        if (eventId > 0) {
            sql.append("AND e.event_id = ? ");
        }
        if (!"all".equalsIgnoreCase(paymentStatus)) {
            sql.append("AND LOWER(o.payment_status) = ? ");
        }
        if (searchOrder != null && !searchOrder.isEmpty()) {
            sql.append("AND c.full_name LIKE ? ");
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setInt(index++, organizerId);
            if (eventId > 0) {
                ps.setInt(index++, eventId);
            }
            if (!"all".equalsIgnoreCase(paymentStatus)) {
                ps.setString(index++, paymentStatus.toLowerCase());
            }
            if (searchOrder != null && !searchOrder.isEmpty()) {
                ps.setString(index++, "%" + searchOrder + "%");
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return count;
    }

    /**
     * Đếm tổng số đơn hàng theo organizer và trạng thái thanh toán.
     *
     * @param organizerId ID của organizer.
     * @param paymentStatus Trạng thái thanh toán ("all", "paid", "pending").
     * @return Số đơn hàng.
     */
    public int countOrdersByOrganizerAndPaymentStatus(int organizerId, String paymentStatus) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total "
                + "FROM Orders o "
                + "INNER JOIN OrderDetails od ON o.order_id = od.order_id "
                + "INNER JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "INNER JOIN Showtimes st ON tt.showtime_id = st.showtime_id "
                + "INNER JOIN Events e ON st.event_id = e.event_id "
                + "INNER JOIN Organizers org ON e.organizer_id = org.organizer_id "
                + "WHERE org.organizer_id = ? "
                + "  AND ( ? = 'all' OR LOWER(o.payment_status) = ? )";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, organizerId);
            stmt.setString(2, paymentStatus.toLowerCase());
            stmt.setString(3, paymentStatus.toLowerCase());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
}
