package dals;

import models.Tickets;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Duong Minh Kiet - CE180166
 *
 * DAO xử lý các truy vấn liên quan đến vé (Tickets).
 */
public class TicketDAO {

    /**
     * Lấy toàn bộ vé của khách hàng (không lọc theo trạng thái).
     *
     * @param customerId Mã khách hàng.
     * @return Danh sách vé của khách hàng.
     */
    public List<Tickets> getTicketsByCustomerId(int customerId) {
        List<Tickets> ticketsList = new ArrayList<>();
        String query = "SELECT "
                + " t.ticket_id, t.order_detail_id, t.seat_id, t.ticket_code, t.price, "
                + " t.status AS ticket_status, t.check_in_datetime, t.created_at, t.updated_at, "
                + " o.event_name, o.order_code, o.order_date, o.start_time, o.end_time, "
                + " o.location, o.status AS order_status, o.ticket_type "
                + "FROM Tickets t "
                + "JOIN Orders o ON t.order_detail_id = o.order_id "
                + "WHERE o.user_id = ?";
        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tickets ticket = new Tickets();
                // Lấy dữ liệu từ bảng Tickets
                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setOrderDetailId(rs.getInt("order_detail_id"));
                ticket.setSeatId(rs.getInt("seat_id"));
                ticket.setTicketCode(rs.getString("ticket_code"));
                ticket.setPrice(rs.getDouble("price"));
                ticket.setStatus(rs.getString("ticket_status"));
                ticket.setCheckInDatetime(rs.getTimestamp("check_in_datetime"));
                ticket.setCreatedAt(rs.getTimestamp("created_at"));
                ticket.setUpdatedAt(rs.getTimestamp("updated_at"));
                // Lấy dữ liệu từ bảng Orders
                ticket.setEventName(rs.getString("event_name"));
                ticket.setOrderCode(rs.getString("order_code"));
                ticket.setOrderDate(rs.getDate("order_date"));
                ticket.setStartTime(rs.getTime("start_time"));
                ticket.setEndTime(rs.getTime("end_time"));
                ticket.setLocation(rs.getString("location"));
                ticket.setOrderStatus(rs.getString("order_status"));
                ticket.setTicketType(rs.getString("ticket_type"));
                ticketsList.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ticketsList;
    }

    /**
     * Lấy vé của khách hàng theo trạng thái hoặc phân loại theo thời gian.
     *
     * @param customerId Mã khách hàng.
     * @param status Trạng thái hoặc phân loại (ví dụ: "Finished", "Processing",
     * "Cancelled", "Upcoming", "Past", "ALL").
     * @return Danh sách vé thỏa mãn điều kiện.
     */
    public List<Tickets> getTicketsByCustomerIdAndStatus(int customerId, String status) {
        List<Tickets> ticketsList = new ArrayList<>();
        String query = "";
        boolean isTimeBasedFilter = false;

        if (status == null || status.equalsIgnoreCase("ALL")) {
            return getTicketsByCustomerId(customerId);
        } else if (status.equalsIgnoreCase("Upcoming")) {
            isTimeBasedFilter = true;
            query = "SELECT "
                    + " t.ticket_id, t.order_detail_id, t.seat_id, t.ticket_code, t.price, "
                    + " t.status AS ticket_status, t.check_in_datetime, t.created_at, t.updated_at, "
                    + " o.event_name, o.order_code, o.order_date, o.start_time, o.end_time, "
                    + " o.location, o.status AS order_status, o.ticket_type "
                    + "FROM Tickets t "
                    + "JOIN Orders o ON t.order_detail_id = o.order_id "
                    + "WHERE o.user_id = ? "
                    + "AND DATEADD(MINUTE, DATEDIFF(MINUTE, 0, o.start_time), CAST(o.order_date AS DATETIME)) > GETDATE()";
        } else if (status.equalsIgnoreCase("Past")) {
            isTimeBasedFilter = true;
            query = "SELECT "
                    + " t.ticket_id, t.order_detail_id, t.seat_id, t.ticket_code, t.price, "
                    + " t.status AS ticket_status, t.check_in_datetime, t.created_at, t.updated_at, "
                    + " o.event_name, o.order_code, o.order_date, o.start_time, o.end_time, "
                    + " o.location, o.status AS order_status, o.ticket_type "
                    + "FROM Tickets t "
                    + "JOIN Orders o ON t.order_detail_id = o.order_id "
                    + "WHERE o.user_id = ? "
                    + "AND DATEADD(MINUTE, DATEDIFF(MINUTE, 0, o.start_time), CAST(o.order_date AS DATETIME)) <= GETDATE()";
        } else {
            query = "SELECT "
                    + " t.ticket_id, t.order_detail_id, t.seat_id, t.ticket_code, t.price, "
                    + " t.status AS ticket_status, t.check_in_datetime, t.created_at, t.updated_at, "
                    + " o.event_name, o.order_code, o.order_date, o.start_time, o.end_time, "
                    + " o.location, o.status AS order_status, o.ticket_type "
                    + "FROM Tickets t "
                    + "JOIN Orders o ON t.order_detail_id = o.order_id "
                    + "WHERE o.user_id = ? AND o.status = ?";
        }

        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, customerId);
            if (!isTimeBasedFilter) {
                ps.setString(2, status);
            }
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Tickets ticket = new Tickets();
                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setOrderDetailId(rs.getInt("order_detail_id"));
                ticket.setSeatId(rs.getInt("seat_id"));
                ticket.setTicketCode(rs.getString("ticket_code"));
                ticket.setPrice(rs.getDouble("price"));
                ticket.setStatus(rs.getString("ticket_status"));
                ticket.setCheckInDatetime(rs.getTimestamp("check_in_datetime"));
                ticket.setCreatedAt(rs.getTimestamp("created_at"));
                ticket.setUpdatedAt(rs.getTimestamp("updated_at"));
                ticket.setEventName(rs.getString("event_name"));
                ticket.setOrderCode(rs.getString("order_code"));
                ticket.setOrderDate(rs.getDate("order_date"));
                ticket.setStartTime(rs.getTime("start_time"));
                ticket.setEndTime(rs.getTime("end_time"));
                ticket.setLocation(rs.getString("location"));
                ticket.setOrderStatus(rs.getString("order_status"));
                ticket.setTicketType(rs.getString("ticket_type"));
                ticketsList.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ticketsList;
    }

    /**
     * Lấy chi tiết vé theo ticketId. Phương thức này được sử dụng cho chức năng
     * View Ticket Detail và không ảnh hưởng đến các chức năng viewall.
     *
     * @param ticketId ID của vé cần xem chi tiết.
     * @return Đối tượng Tickets chứa dữ liệu chi tiết vé, hoặc null nếu không
     * tìm thấy.
     */
    public Tickets getTicketById(int ticketId) {
        Tickets ticket = null;
        String query = "SELECT "
                + " t.ticket_id, t.order_detail_id, t.seat_id, t.ticket_code, t.price, "
                + " t.status AS ticket_status, t.check_in_datetime, t.created_at, t.updated_at, "
                + " o.event_name, o.order_code, o.order_date, o.start_time, o.end_time, "
                + " o.location, o.status AS order_status, o.ticket_type "
                + "FROM Tickets t "
                + "JOIN Orders o ON t.order_detail_id = o.order_id "
                + "WHERE t.ticket_id = ?";
        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, ticketId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ticket = new Tickets();
                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setOrderDetailId(rs.getInt("order_detail_id"));
                ticket.setSeatId(rs.getInt("seat_id"));
                ticket.setTicketCode(rs.getString("ticket_code"));
                ticket.setPrice(rs.getDouble("price"));
                ticket.setStatus(rs.getString("ticket_status"));
                ticket.setCheckInDatetime(rs.getTimestamp("check_in_datetime"));
                ticket.setCreatedAt(rs.getTimestamp("created_at"));
                ticket.setUpdatedAt(rs.getTimestamp("updated_at"));
                ticket.setEventName(rs.getString("event_name"));
                ticket.setOrderCode(rs.getString("order_code"));
                ticket.setOrderDate(rs.getDate("order_date"));
                ticket.setStartTime(rs.getTime("start_time"));
                ticket.setEndTime(rs.getTime("end_time"));
                ticket.setLocation(rs.getString("location"));
                ticket.setOrderStatus(rs.getString("order_status"));
                ticket.setTicketType(rs.getString("ticket_type"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ticket;
    }

}
