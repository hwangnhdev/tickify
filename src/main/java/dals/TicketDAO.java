package dals;

import models.Ticket;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.CustomerTicketDTO;
import models.TicketDetailDTO;

public class TicketDAO extends DBContext {

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
                + "    V.code AS voucherCode, "
                + "    CASE "
                + "        WHEN V.discount_type = 'percentage' THEN O.total_price * (V.discount_value / 100) "
                + "        WHEN V.discount_type = 'fixed' THEN V.discount_value "
                + "        ELSE 0 "
                + "    END AS discount, "
                + "    O.total_price - "
                + "    CASE "
                + "        WHEN V.discount_type = 'percentage' THEN O.total_price * (V.discount_value / 100) "
                + "        WHEN V.discount_type = 'fixed' THEN V.discount_value "
                + "        ELSE 0 "
                + "    END AS finalTotalAmount "
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
                    detail.setVoucherCode(rs.getString("voucherCode"));
                    detail.setDiscount(rs.getDouble("discount"));
                    detail.setFinalTotalAmount(rs.getDouble("finalTotalAmount"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return detail;
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

        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
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
}
