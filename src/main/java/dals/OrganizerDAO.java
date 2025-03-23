package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import viewModels.EventDetailDTO;
import viewModels.EventSummaryDTO;
import viewModels.OrderDetailDTO;
import utils.DBContext;
import viewModels.TicketItemDTO;

public class OrganizerDAO extends DBContext {

    // Lấy thông tin chi tiết của event mà customer đã mua vé (nếu cần)
    public EventDetailDTO getCustomerEventDetail(int customerId, int eventId) {
        EventDetailDTO detail = null;
        String sql = "SELECT "
                + "    e.event_id AS eventId, "
                + "    e.event_name AS eventName, "
                + "    MIN(s.start_date) AS startDate, "
                + "    MAX(s.end_date) AS endDate, "
                + "    e.location AS location, "
                + "    e.status AS eventStatus, "
                + "    e.description AS description, "
                + "    ( "
                + "        SELECT TOP 1 image_url "
                + "        FROM EventImages "
                + "        WHERE event_id = e.event_id "
                + "        ORDER BY image_id "
                + "    ) AS imageURL, "
                + "    org.organization_name AS organizationName "
                + "FROM Events e "
                + "JOIN Organizers org ON e.organizer_id = org.organizer_id "
                + "JOIN Showtimes s ON e.event_id = s.event_id "
                + "WHERE e.event_id = ? "
                // Đảm bảo event chỉ được lấy khi customer có đặt vé liên quan
                + "  AND EXISTS ( "
                + "      SELECT 1 "
                + "      FROM Orders o "
                + "      JOIN OrderDetails od ON o.order_id = od.order_id "
                + "      JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "      JOIN Showtimes s2 ON tt.showtime_id = s2.showtime_id "
                + "      WHERE s2.event_id = e.event_id "
                + "        AND o.customer_id = ? "
                + "  ) "
                + "GROUP BY e.event_id, e.event_name, e.location, e.status, e.description, org.organization_name";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, customerId);
            try ( ResultSet rs = ps.executeQuery()) {
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

    // Lấy danh sách event theo customer (theo organizer được liên kết với customer)
    public List<EventSummaryDTO> getEventsByCustomer(int customerId, String filter) {
        List<EventSummaryDTO> events = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("WITH BannerImages AS ( ");
        sql.append("    SELECT event_id, image_url, ");
        sql.append("           ROW_NUMBER() OVER (PARTITION BY event_id ");
        sql.append("                              ORDER BY CASE WHEN LOWER(image_title) LIKE '%banner%' THEN 0 ELSE 1 END, image_id) AS rn ");
        sql.append("    FROM EventImages ");
        sql.append(") ");
        sql.append("SELECT ");
        sql.append("    e.event_id AS eventId, ");
        sql.append("    e.event_name AS eventName, ");
        sql.append("    MIN(s.start_date) AS startDate, ");
        sql.append("    MAX(s.end_date) AS endDate, ");
        sql.append("    e.location, ");
        sql.append("    e.status, ");
        sql.append("    ISNULL(bi.image_url, 'https://your-cloud-storage.com/path/to/default-banner.jpg') AS image ");
        sql.append("FROM Events e ");
        sql.append("JOIN Showtimes s ON e.event_id = s.event_id ");
        sql.append("LEFT JOIN BannerImages bi ON e.event_id = bi.event_id AND bi.rn = 1 ");
        sql.append("WHERE e.organizer_id IN (SELECT organizer_id FROM Organizers WHERE customer_id = ?) ");

        // Nếu filter là trạng thái cụ thể (Processing, Approved, Rejected), dùng điều kiện trong WHERE
        if (filter != null && !filter.equalsIgnoreCase("all")
                && !filter.equalsIgnoreCase("upcoming") && !filter.equalsIgnoreCase("past")) {
            sql.append("AND LOWER(e.status) = ? ");
        }

        sql.append("GROUP BY e.event_id, e.event_name, e.location, e.status, bi.image_url ");

        // Với upcoming và past, sử dụng mệnh đề HAVING để lọc theo ngày
        if (filter != null) {
            if (filter.equalsIgnoreCase("upcoming")) {
                sql.append("HAVING MIN(s.start_date) > GETDATE() ");
            } else if (filter.equalsIgnoreCase("past")) {
                sql.append("HAVING MAX(s.end_date) < GETDATE() ");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            ps.setInt(index++, customerId);
            if (filter != null && !filter.equalsIgnoreCase("all")
                    && !filter.equalsIgnoreCase("upcoming") && !filter.equalsIgnoreCase("past")) {
                ps.setString(index++, filter.toLowerCase());
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                EventSummaryDTO eventSummary = new EventSummaryDTO();
                eventSummary.setEventId(rs.getInt("eventId"));
                eventSummary.setEventName(rs.getString("eventName"));
                eventSummary.setStartDate(rs.getTimestamp("startDate"));
                eventSummary.setEndDate(rs.getTimestamp("endDate"));
                eventSummary.setLocation(rs.getString("location"));
                eventSummary.setEventStatus(rs.getString("status"));
                eventSummary.setImageUrl(rs.getString("image"));
                events.add(eventSummary);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    public List<OrderDetailDTO> getOrderDetailsByEventAndPaymentStatus(
            int eventId, String paymentStatus, String searchOrder, int offset, int pageSize) {
        List<OrderDetailDTO> orders = new ArrayList<>();
        String sql = "SELECT \n"
                + "    o.order_id, \n"
                + "    o.order_date, \n"
                + "    o.total_price, \n"
                + "    o.payment_status, \n"
                + "    c.full_name AS customerName, \n"
                + "    MIN(e.event_name) AS event_name, \n"
                + "    MIN(e.location) AS location \n"
                + "FROM Orders o \n"
                + "JOIN Customers c ON o.customer_id = c.customer_id \n"
                + "JOIN OrderDetails od ON o.order_id = od.order_id \n"
                + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id \n"
                + "JOIN Showtimes s ON tt.showtime_id = s.showtime_id \n"
                + "JOIN Events e ON s.event_id = e.event_id \n"
                + "WHERE e.event_id = ? \n"
                + "  AND (LOWER(?) = 'all' OR LOWER(o.payment_status) = LOWER(?)) \n"
                + "  AND ( ? IS NULL OR c.full_name LIKE ? ) \n"
                + "GROUP BY \n"
                + "    o.order_id, \n"
                + "    o.order_date, \n"
                + "    o.total_price, \n"
                + "    o.payment_status, \n"
                + "    c.full_name \n"
                + "ORDER BY o.order_date DESC \n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            int index = 1;
            st.setInt(index++, eventId);
            st.setString(index++, paymentStatus);
            st.setString(index++, paymentStatus);
            if (searchOrder == null || searchOrder.trim().isEmpty()) {
                st.setString(index++, null);
                st.setString(index++, null);
            } else {
                st.setString(index++, searchOrder);
                st.setString(index++, "%" + searchOrder + "%");
            }
            st.setInt(index++, offset);
            st.setInt(index++, pageSize);
            try ( ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    OrderDetailDTO order = new OrderDetailDTO();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setGrandTotal(rs.getDouble("total_price"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setCustomerName(rs.getString("customerName"));
                    order.setEventName(rs.getString("event_name"));
                    order.setLocation(rs.getString("location"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching order details: " + e.getMessage());
        }
        return orders;
    }

    public int countOrdersByEventAndPaymentStatus(
            int eventId, String paymentStatus, String searchOrder) {
        int count = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) ");
        sql.append("FROM Orders o ");
        sql.append("JOIN OrderDetails od ON o.order_id = od.order_id ");
        sql.append("JOIN Customers c ON o.customer_id = c.customer_id ");
        sql.append("JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id ");
        sql.append("JOIN Showtimes s ON tt.showtime_id = s.showtime_id ");
        sql.append("JOIN Events e ON s.event_id = e.event_id ");
        sql.append("WHERE e.event_id = ? ");
        if (!"all".equalsIgnoreCase(paymentStatus)) {
            sql.append("AND LOWER(o.payment_status) = ? ");
        }
        if (searchOrder != null && !searchOrder.isEmpty()) {
            sql.append("AND c.full_name LIKE ? ");
        }

        try ( PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int index = 1;
            st.setInt(index++, eventId);
            if (!"all".equalsIgnoreCase(paymentStatus)) {
                st.setString(index++, paymentStatus.toLowerCase());
            }
            if (searchOrder != null && !searchOrder.isEmpty()) {
                st.setString(index++, "%" + searchOrder + "%");
            }
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error counting orders: " + e.getMessage());
        }
        return count;
    }

    public int countOrdersByEventAndPaymentStatus(int eventId, String paymentStatus) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total "
                + "FROM Orders o "
                + "JOIN OrderDetails od ON o.order_id = od.order_id "
                + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "JOIN Showtimes st ON tt.showtime_id = st.showtime_id "
                + "JOIN Events e ON st.event_id = e.event_id "
                + "WHERE e.event_id = ? "
                + "  AND ( ? = 'all' OR LOWER(o.payment_status) = ? )";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, eventId);
            st.setString(2, paymentStatus.toLowerCase());
            st.setString(3, paymentStatus.toLowerCase());
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error counting orders (simple version): " + e.getMessage());
        }
        return count;
    }

    // Đếm tổng số đơn hàng theo organizer và trạng thái thanh toán (phiên bản rút gọn)
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

    public EventDetailDTO getEventDetail(int eventId) {
        EventDetailDTO detail = null;
        String sql
                = "WITH BannerImages AS ( "
                + "    SELECT event_id, image_url, "
                + "           ROW_NUMBER() OVER (PARTITION BY event_id "
                + "                              ORDER BY CASE WHEN LOWER(image_title) LIKE '%banner%' THEN 0 ELSE 1 END, image_id) AS rn "
                + "    FROM EventImages "
                + ") "
                + "SELECT "
                + "    e.event_id AS eventId, "
                + "    e.event_name AS eventName, "
                + "    MIN(s.start_date) AS startDate, "
                + "    MAX(s.end_date) AS endDate, "
                + "    e.location AS location, "
                + "    e.status AS eventStatus, "
                + "    e.description AS description, "
                + "    ISNULL(bi.image_url, 'https://your-cloud-storage.com/path/to/default-banner.jpg') AS imageURL, "
                + "    org.organization_name AS organizationName "
                + "FROM Events e "
                + "JOIN Organizers org ON e.organizer_id = org.organizer_id "
                + "JOIN Showtimes s ON e.event_id = s.event_id "
                + "LEFT JOIN BannerImages bi ON e.event_id = bi.event_id AND bi.rn = 1 "
                + "WHERE e.event_id = ? "
                + "GROUP BY e.event_id, e.event_name, e.location, e.status, e.description, org.organization_name, bi.image_url";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    detail = new EventDetailDTO();
                    detail.setEventId(rs.getInt("eventId"));
                    detail.setEventName(rs.getString("eventName") != null ? rs.getString("eventName") : "");
                    detail.setStartDate(rs.getTimestamp("startDate"));
                    detail.setEndDate(rs.getTimestamp("endDate"));
                    detail.setLocation(rs.getString("location") != null ? rs.getString("location") : "");
                    detail.setEventStatus(rs.getString("eventStatus") != null ? rs.getString("eventStatus") : "");
                    detail.setDescription(rs.getString("description") != null ? rs.getString("description") : "");
                    detail.setImageUrl(rs.getString("imageURL") != null ? rs.getString("imageURL")
                            : "https://your-cloud-storage.com/path/to/default-banner.jpg");
                    detail.setOrganizationName(rs.getString("organizationName") != null ? rs.getString("organizationName") : "");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detail;
    }

}