/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import models.EventDetailDTO;
import models.EventSummaryDTO;
import models.Order;

import utils.DBContext;

/**
 *
 * @author Duong Minh Kiet - CE180166
 */
public class OrganizerDAO extends DBContext {

    public EventDetailDTO getOrganizerEventDetail(int organizerId, int eventId) {
        EventDetailDTO detail = null;
        String sql = "SELECT "
                + "    e.event_id AS eventId, "
                + "    e.event_name AS eventName, "
                + "    MIN(s.start_date) AS startDate, "
                + "    MAX(s.end_date) AS endDate, "
                + "    e.location AS location, "
                + "    ( "
                + "        SELECT TOP 1 o.payment_status "
                + "        FROM Orders o "
                + "        JOIN OrderDetails od ON o.order_id = od.order_id "
                + "        JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "        JOIN Showtimes s2 ON tt.showtime_id = s2.showtime_id "
                + "        WHERE s2.event_id = e.event_id "
                + "        ORDER BY o.created_at DESC "
                + "    ) AS paymentStatus, "
                + "    e.status AS status, "
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
                + "WHERE org.organizer_id = ? AND e.event_id = ? "
                + "GROUP BY e.event_id, e.event_name, e.location, e.status, e.description, org.organization_name";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, organizerId);
            ps.setInt(2, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                detail = new EventDetailDTO();
                detail.setEventId(rs.getInt("eventId"));
                detail.setEventName(rs.getString("eventName"));
                detail.setStartDate(rs.getTimestamp("startDate"));
                detail.setEndDate(rs.getTimestamp("endDate"));
                detail.setLocation(rs.getString("location"));
                detail.setPaymentStatus(rs.getString("paymentStatus"));
                detail.setStatus(rs.getString("status"));
                detail.setDescription(rs.getString("description"));
                detail.setImageUrl(rs.getString("imageURL")); // Cần có thuộc tính imageUrl trong model
                detail.setOrganizationName(rs.getString("organizationName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detail;
    }

    public List<EventSummaryDTO> getEventsByOrganizer(int organizerId, String filter) {
        List<EventSummaryDTO> events = new ArrayList<>();

        // Base SQL query, đã thêm eventId
        String baseSql = "SELECT \n"
                + "    e.event_id AS eventId,\n"
                + "    e.event_name AS eventName,\n"
                + "    MIN(s.start_date) AS startDate,\n"
                + "    MAX(s.end_date) AS endDate,\n"
                + "    e.location AS location,\n"
                + "    (\n"
                + "        SELECT TOP 1 o.payment_status\n"
                + "        FROM Orders o\n"
                + "        JOIN OrderDetails od ON o.order_id = od.order_id\n"
                + "        JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id\n"
                + "        JOIN Showtimes s2 ON tt.showtime_id = s2.showtime_id\n"
                + "        WHERE s2.event_id = e.event_id\n"
                + "        ORDER BY o.created_at DESC\n"
                + "    ) AS paymentStatus,\n"
                + "    (\n"
                + "        SELECT TOP 1 image_url\n"
                + "        FROM EventImages\n"
                + "        WHERE event_id = e.event_id\n"
                + "        ORDER BY image_id\n"
                + "    ) AS image\n"
                + "FROM Events e\n"
                + "JOIN Showtimes s ON e.event_id = s.event_id\n"
                + "WHERE e.organizer_id = ? ";

        // Các điều kiện bổ sung theo bộ lọc
        String extraWhere = "";
        String groupBy = " GROUP BY e.event_id, e.event_name, e.location ";
        String havingClause = "";

        if (filter != null && !filter.equalsIgnoreCase("all")) {
            // Lọc theo payment status: pending hoặc paid
            if (filter.equalsIgnoreCase("pending") || filter.equalsIgnoreCase("paid")) {
                extraWhere += " AND (\n"
                        + "     SELECT TOP 1 o.payment_status\n"
                        + "     FROM Orders o\n"
                        + "     JOIN OrderDetails od ON o.order_id = od.order_id\n"
                        + "     JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id\n"
                        + "     JOIN Showtimes s2 ON tt.showtime_id = s2.showtime_id\n"
                        + "     WHERE s2.event_id = e.event_id\n"
                        + "     ORDER BY o.created_at DESC\n"
                        + " ) = ? ";
            } // Lọc các sự kiện sắp diễn ra (upcoming)
            else if (filter.equalsIgnoreCase("upcoming")) {
                havingClause = " HAVING MIN(s.start_date) > GETDATE() ";
            } // Lọc các sự kiện đã qua (past)
            else if (filter.equalsIgnoreCase("past")) {
                havingClause = " HAVING MAX(s.end_date) < GETDATE() ";
            }
        }

        String finalSql = baseSql + extraWhere + groupBy + havingClause;

        try (PreparedStatement ps = connection.prepareStatement(finalSql)) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, organizerId);
            if (filter != null && (filter.equalsIgnoreCase("pending") || filter.equalsIgnoreCase("paid"))) {
                ps.setString(paramIndex++, filter);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                EventSummaryDTO eventSummary = new EventSummaryDTO();
                eventSummary.setEventId(rs.getInt("eventId"));
                eventSummary.setEventName(rs.getString("eventName"));
                eventSummary.setStartDate(rs.getTimestamp("startDate"));
                eventSummary.setEndDate(rs.getTimestamp("endDate"));
                eventSummary.setLocation(rs.getString("location"));
                eventSummary.setPaymentStatus(rs.getString("paymentStatus"));
                // Lưu ý: alias trong SQL là "image" nhưng bạn set vào thuộc tính imageUrl của DTO
                eventSummary.setImageUrl(rs.getString("image"));

                events.add(eventSummary);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Có thể xử lý lỗi chi tiết hơn tại đây nếu cần
        }
        return events;
    }

    // Lấy danh sách order theo organizer, trạng thái thanh toán và tìm kiếm theo tên khách hàng
    public List<Order> getOrdersByOrganizerAndPaymentStatus(int organizerId, String paymentStatus, String searchOrder, int offset, int pageSize) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, o.order_date, o.total_price, o.payment_status, "
                + "       c.full_name AS customer_name, e.event_name, e.location, t.ticket_code "
                + "FROM Orders o "
                + "INNER JOIN Customers c ON o.customer_id = c.customer_id "
                + "INNER JOIN OrderDetails od ON o.order_id = od.order_id "
                + "INNER JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "INNER JOIN Showtimes st ON tt.showtime_id = st.showtime_id "
                + "INNER JOIN Events e ON st.event_id = e.event_id "
                + "INNER JOIN Organizers org ON e.organizer_id = org.organizer_id "
                + "INNER JOIN Ticket t ON t.order_detail_id = od.order_detail_id "
                + "WHERE org.organizer_id = ? "
                + "  AND ( ? = 'all' OR LOWER(o.payment_status) = ? ) "
                + "  AND ( ? IS NULL OR LOWER(c.full_name) LIKE '%' + ? + '%' ) "
                + "ORDER BY o.order_date DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, organizerId);
            // Payment status: nếu là 'all' thì không lọc, nếu không thì so sánh
            stmt.setString(2, paymentStatus.toLowerCase());
            stmt.setString(3, paymentStatus.toLowerCase());
            // Search theo tên khách hàng: nếu searchOrder null thì không lọc
            if (searchOrder == null) {
                stmt.setNull(4, Types.NVARCHAR);
                stmt.setNull(5, Types.NVARCHAR);
            } else {
                stmt.setNString(4, searchOrder.toLowerCase());
                stmt.setNString(5, "%" + searchOrder.toLowerCase() + "%");
            }
            stmt.setInt(6, offset);
            stmt.setInt(7, pageSize);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalPrice(rs.getDouble("total_price"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setEventName(rs.getString("event_name"));
                    order.setLocation(rs.getString("location"));
                    order.setTicketCode(rs.getString("ticket_code"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Đếm tổng số order theo organizer, trạng thái thanh toán và tìm kiếm theo tên khách hàng
    public int countOrdersByOrganizerAndPaymentStatus(int organizerId, String paymentStatus, String searchOrder) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total "
                + "FROM Orders o "
                + "INNER JOIN Customers c ON o.customer_id = c.customer_id "
                + "INNER JOIN OrderDetails od ON o.order_id = od.order_id "
                + "INNER JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "INNER JOIN Showtimes st ON tt.showtime_id = st.showtime_id "
                + "INNER JOIN Events e ON st.event_id = e.event_id "
                + "INNER JOIN Organizers org ON e.organizer_id = org.organizer_id "
                + "INNER JOIN Ticket t ON t.order_detail_id = od.order_detail_id "
                + "WHERE org.organizer_id = ? "
                + "  AND ( ? = 'all' OR LOWER(o.payment_status) = ? ) "
                + "  AND ( ? IS NULL OR LOWER(c.full_name) LIKE '%' + ? + '%' )";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, organizerId);
            stmt.setString(2, paymentStatus.toLowerCase());
            stmt.setString(3, paymentStatus.toLowerCase());
            if (searchOrder == null) {
                stmt.setNull(4, Types.NVARCHAR);
                stmt.setNull(5, Types.NVARCHAR);
            } else {
                stmt.setNString(4, searchOrder.toLowerCase());
                stmt.setNString(5, "%" + searchOrder.toLowerCase() + "%");
            }
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

    /**
     * Phương thức mới: Tìm kiếm đơn hàng theo organizer và từ khóa tìm kiếm
     * (theo tên khách hàng).
     *
     * @param organizerId ID của organizer.
     * @param keyword Từ khóa tìm kiếm.
     * @return Danh sách đơn hàng thỏa mãn điều kiện tìm kiếm.
     */
    public List<Order> searchOrders(int organizerId, String keyword) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT "
                + "    o.order_id, "
                + "    o.order_date, "
                + "    o.total_price, "
                + "    o.payment_status, "
                + "    c.full_name AS customer_name, "
                + "    e.event_name, "
                + "    e.location, "
                + "    t.ticket_code "
                + "FROM Orders o "
                + "INNER JOIN Customers c ON o.customer_id = c.customer_id "
                + "INNER JOIN OrderDetails od ON o.order_id = od.order_id "
                + "INNER JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "INNER JOIN Showtimes st ON tt.showtime_id = st.showtime_id "
                + "INNER JOIN Events e ON st.event_id = e.event_id "
                + "INNER JOIN Organizers org ON e.organizer_id = org.organizer_id "
                + "INNER JOIN Ticket t ON t.order_detail_id = od.order_detail_id "
                + "WHERE org.organizer_id = ? "
                + "  AND LOWER(c.full_name) LIKE ? "
                + "ORDER BY o.order_date DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, organizerId);
            stmt.setString(2, "%" + keyword.toLowerCase() + "%");
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalPrice(rs.getDouble("total_price"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setEventName(rs.getString("event_name"));
                    order.setLocation(rs.getString("location"));
                    order.setTicketCode(rs.getString("ticket_code"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

}
