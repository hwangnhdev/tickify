package dals;

import models.Ticket;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import viewModels.CustomerTicketDTO;
import viewModels.TicketDetailDTO;

public class TicketDAO extends DBContext {

    private static final String INSERT_TICKET
            = "INSERT INTO Ticket (order_detail_id, seat_id, ticket_code, price, status, created_at, updated_at) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String CHECK_TICKET_EXIST = "SELECT COUNT(*) FROM Ticket WHERE ticket_code = ?";
    private static final String CHECK_TICKET_STATUS
            = "SELECT t.status AS ticket_status\n"
            + "FROM Orders o\n"
            + "JOIN OrderDetails od ON o.order_id = od.order_id\n"
            + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id\n"
            + "JOIN Ticket t ON od.order_detail_id = t.order_detail_id\n"
            + "JOIN Seats s ON t.seat_id = s.seat_id\n"
            + "WHERE o.order_id = ? and s.seat_id = ?";
    private static final String UPDATE_TICKET_STATUS
            = "UPDATE Ticket "
            + "SET status = 'used', updated_at = GETDATE() "
            + "WHERE seat_id = ?";

    public boolean insertTicket(Ticket ticket) {
        try ( PreparedStatement st = connection.prepareStatement(INSERT_TICKET)) {

            st.setInt(1, ticket.getOrderDetailId());
            st.setInt(2, ticket.getSeatId());
            st.setString(3, ticket.getTicketCode());
            st.setDouble(4, ticket.getPrice());
            st.setString(5, ticket.getStatus());
            st.setTimestamp(6, ticket.getCreatedAt());
            st.setTimestamp(7, ticket.getUpdatedAt());

            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isTicketExist(String ticketCode) {
        try ( PreparedStatement st = connection.prepareStatement(CHECK_TICKET_EXIST)) {
            st.setString(1, ticketCode);
            ResultSet rs = st.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public String getTicketStatus(int orderId, int seatId) {
        try ( PreparedStatement st = connection.prepareStatement(CHECK_TICKET_STATUS)) {
            st.setInt(1, orderId);
            st.setInt(2, seatId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("ticket_status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Không tìm thấy vé
    }

    public boolean updateTicketStatus(int seatId) {
        try ( PreparedStatement st = connection.prepareStatement(UPDATE_TICKET_STATUS)) {
            st.setInt(1, seatId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy danh sách vé theo order_id.
     */
    public List<Ticket> getTicketsByOrderId(int orderId) {
        List<Ticket> tickets = new ArrayList<>();
        String query = "SELECT ticket_id, order_detail_id, seat_id, ticket_code, price, status, created_at, updated_at "
                + "FROM Tickets WHERE order_detail_id = ?";
        try ( Connection conn = new DBContext().connection;  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Ticket ticket = new Ticket();
                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setOrderDetailId(rs.getInt("order_detail_id"));
                ticket.setSeatId(rs.getInt("seat_id"));
                ticket.setTicketCode(rs.getString("ticket_code"));
                ticket.setPrice(rs.getDouble("price"));
                ticket.setStatus(rs.getString("status"));
                ticket.setCreatedAt(rs.getTimestamp("created_at"));
                ticket.setUpdatedAt(rs.getTimestamp("updated_at"));
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    /**
     * Lấy chi tiết vé theo ticketId.
     */
    public Ticket getTicketById(int ticketId) {
        Ticket ticket = null;
        String query = "SELECT ticket_id, order_detail_id, seat_id, ticket_code, price, status, created_at, updated_at "
                + "FROM Tickets WHERE ticket_id = ?";
        try ( Connection conn = new DBContext().connection;  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, ticketId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ticket = new Ticket();
                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setOrderDetailId(rs.getInt("order_detail_id"));
                ticket.setSeatId(rs.getInt("seat_id"));
                ticket.setTicketCode(rs.getString("ticket_code"));
                ticket.setPrice(rs.getDouble("price"));
                ticket.setStatus(rs.getString("status"));
                ticket.setCreatedAt(rs.getTimestamp("created_at"));
                ticket.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ticket;
    }

    public List<CustomerTicketDTO> getTicketsByCustomer(int customerId, String filter) {
        List<CustomerTicketDTO> tickets = new ArrayList<>();
        StringBuilder query = new StringBuilder();
        query.append("SELECT ");
        query.append("T.ticket_code AS orderCode, ");
        query.append("T.status AS ticketStatus, ");
        query.append("O.payment_status AS paymentStatus, ");
        query.append("S.start_date AS startDate, ");
        query.append("S.end_date AS endDate, ");
        query.append("E.location AS location, ");
        query.append("E.event_name AS eventName, ");
        query.append("T.price AS unitPrice ");
        query.append("FROM Customers C ");
        query.append("JOIN Orders O ON C.customer_id = O.customer_id ");
        query.append("JOIN OrderDetails OD ON O.order_id = OD.order_id ");
        query.append("JOIN Ticket T ON OD.order_detail_id = T.order_detail_id ");
        query.append("JOIN Seats SE ON T.seat_id = SE.seat_id ");
        query.append("JOIN TicketTypes TT ON SE.ticket_type_id = TT.ticket_type_id ");
        query.append("JOIN Showtimes S ON TT.showtime_id = S.showtime_id ");
        query.append("JOIN Events E ON S.event_id = E.event_id ");
        query.append("WHERE C.customer_id = ? ");

        if (filter != null && !filter.equalsIgnoreCase("all")) {
            // Lọc theo trạng thái thanh toán
            if (filter.equalsIgnoreCase("paid") || filter.equalsIgnoreCase("pending")) {
                query.append("AND LOWER(O.payment_status) = ? ");
            } else if (filter.equalsIgnoreCase("upcoming")) {
                // Vé sắp diễn ra: ngày bắt đầu sau thời gian hiện tại
                query.append("AND S.start_date > CURRENT_TIMESTAMP ");
            } else if (filter.equalsIgnoreCase("past")) {
                // Vé đã diễn ra: ngày bắt đầu trước thời gian hiện tại
                query.append("AND S.start_date < CURRENT_TIMESTAMP ");
            }
        }

        try ( PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            stmt.setInt(1, customerId);
            // Nếu lọc theo paid hoặc pending, gán tham số thứ 2
            if (filter != null && (filter.equalsIgnoreCase("paid") || filter.equalsIgnoreCase("pending"))) {
                stmt.setString(2, filter.toLowerCase());
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CustomerTicketDTO ticket = new CustomerTicketDTO();
                ticket.setOrderCode(rs.getString("orderCode"));
                ticket.setTicketStatus(rs.getString("ticketStatus"));
                ticket.setPaymentStatus(rs.getString("paymentStatus"));
                ticket.setStartDate(rs.getDate("startDate"));
                ticket.setEndDate(rs.getDate("endDate"));
                ticket.setLocation(rs.getString("location"));
                ticket.setEventName(rs.getString("eventName"));
                ticket.setUnitPrice(rs.getDouble("unitPrice"));
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

  public TicketDetailDTO getTicketDetail(String ticketCode, int customerId) {
    TicketDetailDTO detail = null;
    String sql = "SELECT "
            + "    T.ticket_code AS orderCode, "
            + "    T.status AS ticketStatus, "
            + "    O.payment_status AS paymentStatus, "
            + "    S.start_date AS startDate, "
            + "    S.end_date AS endDate, "
            + "    E.location AS location, "
            + "    CONCAT(Seats.seat_row, '-', Seats.seat_col) AS seat, "
            + "    E.event_name AS eventName, "
            + "    T.price AS ticketPrice, "
            + "    EI.image_url AS eventImage, "
            + "    C.full_name AS buyerName, "
            + "    C.email AS buyerEmail, "
            + "    C.phone AS buyerPhone, "
            + "    C.address AS buyerAddress, "
            + "    TT.name AS ticketType, "
            + "    OD.quantity AS quantity, "
            + "    T.price AS amount, "
            + "    O.total_price AS originalTotalAmount, "
            + "    CASE WHEN O.voucher_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS voucherApplied, "
            // Voucher kiểu phần trăm
            + "    CASE WHEN V.discount_type = 'percentage' THEN V.code ELSE NULL END AS voucherPercentageCode, "
            + "    CASE WHEN V.discount_type = 'percentage' THEN O.total_price * (V.discount_value / 100) ELSE 0 END AS discountPercentage, "
            // Voucher kiểu tiền cố định
            + "    CASE WHEN V.discount_type = 'fixed' THEN V.code ELSE NULL END AS voucherFixedCode, "
            + "    CASE WHEN V.discount_type = 'fixed' THEN V.discount_value ELSE 0 END AS discountFixed, "
            // Tính final total amount
            + "    O.total_price - CASE WHEN V.discount_type = 'percentage' THEN O.total_price * (V.discount_value / 100) "
            + "                         WHEN V.discount_type = 'fixed' THEN V.discount_value ELSE 0 END AS finalTotalAmount "
            + "FROM Ticket T "
            + "JOIN OrderDetails OD ON T.order_detail_id = OD.order_detail_id "
            + "JOIN Orders O ON OD.order_id = O.order_id "
            + "JOIN Customers C ON O.customer_id = C.customer_id "
            + "JOIN Seats ON T.seat_id = Seats.seat_id "
            + "JOIN TicketTypes TT ON Seats.ticket_type_id = TT.ticket_type_id "
            + "JOIN Showtimes S ON TT.showtime_id = S.showtime_id "
            + "JOIN Events E ON S.event_id = E.event_id "
            + "LEFT JOIN (SELECT event_id, MIN(image_id) AS min_image_id FROM EventImages GROUP BY event_id) EI_sub "
            + "    ON E.event_id = EI_sub.event_id "
            + "LEFT JOIN EventImages EI ON EI_sub.min_image_id = EI.image_id "
            + "LEFT JOIN Vouchers V ON O.voucher_id = V.voucher_id "
            + "WHERE C.customer_id = ? AND T.ticket_code = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, customerId);
        ps.setString(2, ticketCode);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                detail = new TicketDetailDTO();
                detail.setOrderCode(rs.getString("orderCode"));
                detail.setTicketStatus(rs.getString("ticketStatus"));
                detail.setPaymentStatus(rs.getString("paymentStatus"));
                detail.setStartDate(rs.getTimestamp("startDate"));
                detail.setEndDate(rs.getTimestamp("endDate"));
                detail.setLocation(rs.getString("location"));
                detail.setSeat(rs.getString("seat"));
                detail.setEventName(rs.getString("eventName"));
                detail.setTicketPrice(rs.getDouble("ticketPrice"));
                detail.setEventImage(rs.getString("eventImage"));
                detail.setBuyerName(rs.getString("buyerName"));
                detail.setBuyerEmail(rs.getString("buyerEmail"));
                detail.setBuyerPhone(rs.getString("buyerPhone"));
                detail.setBuyerAddress(rs.getString("buyerAddress"));
                detail.setTicketType(rs.getString("ticketType"));
                detail.setQuantity(rs.getInt("quantity"));
                detail.setAmount(rs.getDouble("amount"));
                detail.setOriginalTotalAmount(rs.getDouble("originalTotalAmount"));
                detail.setVoucherApplied(rs.getString("voucherApplied"));
                // Dữ liệu voucher kiểu phần trăm
                detail.setVoucherPercentageCode(rs.getString("voucherPercentageCode"));
                detail.setDiscountPercentage(rs.getDouble("discountPercentage"));
                // Dữ liệu voucher kiểu tiền cố định
                detail.setVoucherFixedCode(rs.getString("voucherFixedCode"));
                detail.setDiscountFixed(rs.getDouble("discountFixed"));
                detail.setFinalTotalAmount(rs.getDouble("finalTotalAmount"));
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return detail;
}

}
