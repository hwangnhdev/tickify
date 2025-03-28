package dals;

import models.Ticket;
import utils.DBContext;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import viewModels.CustomerTicketDTO;
import viewModels.TicketItemDTO;
import viewModels.OrderSummaryDTO;
import viewModels.CalculationDTO;
import viewModels.EventSummaryDTO;
import viewModels.OrderDetailDTO;

public class TicketDAO extends DBContext {

    private static final String INSERT_TICKET
            = "INSERT INTO Ticket (order_detail_id, seat_id, ticket_code, price, status, created_at, updated_at, ticket_qr_code) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

    private static final String CHECK_TICKET_EXIST
            = "SELECT COUNT(*) FROM Ticket WHERE ticket_code = ?";

    private static final String CHECK_TICKET_STATUS
            = "SELECT t.status AS ticket_status "
            + "FROM Orders o "
            + "JOIN OrderDetails od ON o.order_id = od.order_id "
            + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
            + "JOIN Ticket t ON od.order_detail_id = t.order_detail_id "
            + "JOIN Seats s ON t.seat_id = s.seat_id "
            + "WHERE o.order_id = ? AND s.seat_id = ?";

    private static final String UPDATE_TICKET_STATUS
            = "UPDATE Ticket SET status = 'used', updated_at = GETDATE() WHERE seat_id = ?";

    public boolean insertTicket(Ticket ticket) {
        try ( PreparedStatement st = connection.prepareStatement(INSERT_TICKET)) {
            st.setInt(1, ticket.getOrderDetailId());
            st.setInt(2, ticket.getSeatId());
            st.setString(3, ticket.getTicketCode());
            st.setDouble(4, ticket.getPrice());
            st.setString(5, ticket.getStatus());
            st.setTimestamp(6, ticket.getCreatedAt());
            st.setTimestamp(7, ticket.getUpdatedAt());
            st.setString(8, ticket.getTicketQRCode());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isTicketExist(String ticketCode) {
        try ( PreparedStatement st = connection.prepareStatement(CHECK_TICKET_EXIST)) {
            st.setString(1, ticketCode);
            try ( ResultSet rs = st.executeQuery()) {
                return rs.next() && rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public String getTicketStatus(int orderId, int seatId) {
        try ( PreparedStatement st = connection.prepareStatement(CHECK_TICKET_STATUS)) {
            st.setInt(1, orderId);
            st.setInt(2, seatId);
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    String status = rs.getString("ticket_status");
                    return status != null ? status : "";
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

    public List<CustomerTicketDTO> getTicketsByCustomer(int customerId, String filter) {
        List<CustomerTicketDTO> tickets = new ArrayList<>();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT O.order_id AS orderCode, ");
        sql.append("       MIN(T.status) AS ticketStatus, ");
        sql.append("       O.payment_status AS paymentStatus, ");
        sql.append("       S.start_date AS startDate, ");
        sql.append("       S.end_date AS endDate, ");
        sql.append("       E.location AS location, ");
        sql.append("       E.event_name AS eventName ");
        sql.append("FROM Customers C ");
        sql.append("JOIN Orders O ON C.customer_id = O.customer_id ");
        sql.append("JOIN OrderDetails OD ON O.order_id = OD.order_id ");
        sql.append("JOIN Ticket T ON OD.order_detail_id = T.order_detail_id ");
        sql.append("JOIN Seats SE ON T.seat_id = SE.seat_id ");
        sql.append("JOIN TicketTypes TT ON SE.ticket_type_id = TT.ticket_type_id ");
        sql.append("JOIN Showtimes S ON TT.showtime_id = S.showtime_id ");
        sql.append("JOIN Events E ON S.event_id = E.event_id ");
        sql.append("WHERE C.customer_id = ? ");
        sql.append("  AND O.payment_status IS NOT NULL ");
        sql.append("  AND S.start_date IS NOT NULL ");
        sql.append("  AND S.end_date IS NOT NULL ");
        sql.append("  AND E.location IS NOT NULL ");
        sql.append("  AND E.event_name IS NOT NULL ");

        // Áp dụng điều kiện filter nếu có
        if (filter != null && !filter.equalsIgnoreCase("all")) {
            if (filter.equalsIgnoreCase("paid") || filter.equalsIgnoreCase("pending")) {
                sql.append("AND LOWER(O.payment_status) = ? ");
            } else if (filter.equalsIgnoreCase("upcoming")) {
                sql.append("AND S.start_date > CURRENT_TIMESTAMP ");
            } else if (filter.equalsIgnoreCase("past")) {
                sql.append("AND S.start_date < CURRENT_TIMESTAMP ");
            }
        }

        sql.append("GROUP BY O.order_id, O.payment_status, S.start_date, S.end_date, E.location, E.event_name ");
        sql.append("ORDER BY S.start_date");

        try ( PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            stmt.setInt(1, customerId);
            if (filter != null && (filter.equalsIgnoreCase("paid") || filter.equalsIgnoreCase("pending"))) {
                stmt.setString(2, filter.toLowerCase());
            }
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    CustomerTicketDTO ticket = new CustomerTicketDTO();
                    ticket.setOrderCode(rs.getString("orderCode"));
                    ticket.setTicketStatus(rs.getString("ticketStatus"));
                    ticket.setPaymentStatus(rs.getString("paymentStatus"));
                    ticket.setStartDate(rs.getTimestamp("startDate"));
                    ticket.setEndDate(rs.getTimestamp("endDate"));
                    ticket.setLocation(rs.getString("location"));
                    ticket.setEventName(rs.getString("eventName"));
                    tickets.add(ticket);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    /**
     * Lấy chi tiết vé theo orderId (chỉ trả về record khi các thông tin bắt
     * buộc đều có giá trị).
     */
    public OrderDetailDTO getTicketDetailByOrderId(int orderId) throws SQLException {
        OrderDetailDTO detail = new OrderDetailDTO();

        // 1. Order Summary – chỉ lấy khi các trường bắt buộc không null
        String sqlOrderSummary = "SELECT o.order_date, o.payment_status, o.payment_status AS order_status, "
                + "       c.full_name AS buyer_name, c.email AS buyer_email, c.phone AS buyer_phone, c.address AS buyer_address, "
                + "       v.code AS voucherCode, v.discount_type, v.discount_value "
                + "FROM Orders o "
                + "JOIN Customers c ON o.customer_id = c.customer_id "
                + "LEFT JOIN Vouchers v ON o.voucher_id = v.voucher_id "
                + "WHERE o.order_id = ? "
                + "  AND o.payment_status IS NOT NULL "
                + "  AND c.full_name IS NOT NULL "
                + "  AND c.email IS NOT NULL "
                + "  AND c.phone IS NOT NULL "
                + "  AND c.address IS NOT NULL";
        OrderSummaryDTO orderSummary = new OrderSummaryDTO();
        try ( PreparedStatement ps = connection.prepareStatement(sqlOrderSummary)) {
            ps.setInt(1, orderId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    orderSummary.setOrderDate(rs.getTimestamp("order_date"));
                    orderSummary.setPaymentStatus(rs.getString("payment_status"));
                    orderSummary.setCustomerName(rs.getString("buyer_name"));
                    orderSummary.setCustomerEmail(rs.getString("buyer_email"));
                    orderSummary.setCustomerPhone(rs.getString("buyer_phone"));
                    orderSummary.setCustomerAddress(rs.getString("buyer_address"));
                    orderSummary.setVoucherCode(rs.getString("voucherCode")); // nếu null thì ko hiển thị ở JSP
                    orderSummary.setDiscountType(rs.getString("discount_type"));
                    orderSummary.setDiscountValue(rs.getBigDecimal("discount_value") != null ? rs.getBigDecimal("discount_value") : BigDecimal.ZERO);
                    orderSummary.setOrderId(orderId);
                }
            }
        }
        detail.setOrderSummary(orderSummary);

        // 2. Order Items – chỉ lấy khi các trường bắt buộc của vé không null
        // Trong phần lấy Order Items – bổ sung trường ticket_qr_code
        String sqlOrderItems = "SELECT tt.ticket_type_id, tt.name AS ticket_type, t.ticket_code, "
                + "       od.quantity, tt.price AS unit_price, (od.quantity * tt.price) AS subtotalPerType, "
                + "       s.seat_row + '-' + s.seat_col AS seats, "
                + "       o.payment_status, "
                + "       t.status AS ticket_status, "
                + "       t.ticket_qr_code " // <-- thêm trường mới
                + "FROM OrderDetails od "
                + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "JOIN Ticket t ON od.order_detail_id = t.order_detail_id "
                + "JOIN Seats s ON t.seat_id = s.seat_id " // ép buộc có thông tin ghế
                + "JOIN Orders o ON od.order_id = o.order_id "
                + "WHERE od.order_id = ? "
                + "  AND tt.name IS NOT NULL "
                + "  AND t.ticket_code IS NOT NULL "
                + "  AND t.status IS NOT NULL";
        List<TicketItemDTO> items = new ArrayList<>();
        try ( PreparedStatement ps = connection.prepareStatement(sqlOrderItems)) {
            ps.setInt(1, orderId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TicketItemDTO item = new TicketItemDTO();
                    item.setTicketTypeId(rs.getInt("ticket_type_id"));
                    item.setTicketType(rs.getString("ticket_type"));
                    item.setTicketCode(rs.getString("ticket_code"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setUnitPrice(rs.getBigDecimal("unit_price") != null ? rs.getBigDecimal("unit_price") : BigDecimal.ZERO);
                    item.setSubtotalPerType(rs.getBigDecimal("subtotalPerType") != null ? rs.getBigDecimal("subtotalPerType") : BigDecimal.ZERO);
                    item.setSeats(rs.getString("seats"));
                    item.setPaymentStatus(rs.getString("payment_status"));
                    item.setTicketStatus(rs.getString("ticket_status"));
                    // Ánh xạ ticket_qr_code
                    item.setTicketQRCode(rs.getString("ticket_qr_code"));
                    items.add(item);
                }
            }
        }
        detail.setOrderItems(items);

        // 2b. Grouped Order Items – cũng chỉ lấy khi tên vé không null
        String sqlGroupedOrderItems = "SELECT tt.ticket_type_id, tt.name AS ticket_type, tt.price AS unit_price, "
                + "       SUM(od.quantity) AS quantity, "
                + "       SUM(od.quantity * tt.price) AS subtotalPerType "
                + "FROM OrderDetails od "
                + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "WHERE od.order_id = ? "
                + "  AND tt.name IS NOT NULL "
                + "GROUP BY tt.ticket_type_id, tt.name, tt.price";
        List<TicketItemDTO> groupedItems = new ArrayList<>();
        try ( PreparedStatement ps = connection.prepareStatement(sqlGroupedOrderItems)) {
            ps.setInt(1, orderId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TicketItemDTO item = new TicketItemDTO();
                    item.setTicketTypeId(rs.getInt("ticket_type_id"));
                    item.setTicketType(rs.getString("ticket_type"));
                    item.setUnitPrice(rs.getBigDecimal("unit_price") != null ? rs.getBigDecimal("unit_price") : BigDecimal.ZERO);
                    item.setQuantity(rs.getInt("quantity"));
                    item.setSubtotalPerType(rs.getBigDecimal("subtotalPerType") != null ? rs.getBigDecimal("subtotalPerType") : BigDecimal.ZERO);
                    groupedItems.add(item);
                }
            }
        }
        detail.setGroupedOrderItems(groupedItems);

        // 3. Calculation – tính toán (nếu các thông tin bắt buộc có)
        String sqlCalculation = "SELECT v.code AS voucherCode, v.discount_type, v.discount_value, "
                + "       CASE WHEN v.discount_type = 'percentage' THEN "
                + "            CONVERT(DECIMAL(10,2), o.total_price / (1 - (v.discount_value / 100.0))) "
                + "            WHEN v.discount_type = 'Fixed' THEN "
                + "            CONVERT(DECIMAL(10,2), o.total_price + v.discount_value) "
                + "            ELSE o.total_price END AS total_subtotal, "
                + "       CASE WHEN v.discount_type = 'percentage' THEN "
                + "            CONVERT(DECIMAL(10,2), (o.total_price / (1 - (v.discount_value / 100.0))) - o.total_price) "
                + "            WHEN v.discount_type = 'Fixed' THEN "
                + "            CONVERT(DECIMAL(10,2), v.discount_value) "
                + "            ELSE 0 END AS discount_amount, "
                + "       o.total_price AS final_total "
                + "FROM Orders o "
                + "LEFT JOIN Vouchers v ON o.voucher_id = v.voucher_id "
                + "WHERE o.order_id = ?";
        CalculationDTO calc = new CalculationDTO();
        try ( PreparedStatement ps = connection.prepareStatement(sqlCalculation)) {
            ps.setInt(1, orderId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    calc.setTotalSubtotal(rs.getBigDecimal("total_subtotal") != null ? rs.getBigDecimal("total_subtotal") : BigDecimal.ZERO);
                    calc.setDiscountAmount(rs.getBigDecimal("discount_amount") != null ? rs.getBigDecimal("discount_amount") : BigDecimal.ZERO);
                    calc.setFinalTotal(rs.getBigDecimal("final_total") != null ? rs.getBigDecimal("final_total") : BigDecimal.ZERO);
                }
            }
        }
        detail.setCalculation(calc);

        // 4. Event Summary – chỉ lấy khi thông tin sự kiện bắt buộc có
        String sqlEventSummary = "SELECT DISTINCT e.event_id, e.event_name, e.location, st.start_date AS startTime, st.end_date AS endTime, "
                + "       ei.event_image, t.ticket_code, "
                + "       CONCAT(tt.name, ' - ', COALESCE(s.seat_row + '-' + s.seat_col, 'No seat')) AS ticketInfo "
                + "FROM Ticket t "
                + "JOIN OrderDetails od ON t.order_detail_id = od.order_detail_id "
                + "JOIN Orders o ON od.order_id = o.order_id "
                + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "JOIN Showtimes st ON tt.showtime_id = st.showtime_id "
                + "JOIN Events e ON st.event_id = e.event_id "
                + "JOIN Seats s ON t.seat_id = s.seat_id " // bắt buộc có thông tin ghế
                + "CROSS APPLY ( "
                + "    SELECT TOP 1 image_url AS event_image "
                + "    FROM EventImages "
                + "    WHERE event_id = e.event_id "
                + "    ORDER BY image_id "
                + ") ei "
                + "WHERE o.order_id = ? "
                + "  AND e.event_name IS NOT NULL "
                + "  AND e.location IS NOT NULL";
        EventSummaryDTO eventSummary = new EventSummaryDTO();
        try ( PreparedStatement ps = connection.prepareStatement(sqlEventSummary)) {
            ps.setInt(1, orderId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    eventSummary.setEventId(rs.getInt("event_id"));
                    eventSummary.setEventName(rs.getString("event_name"));
                    eventSummary.setLocation(rs.getString("location"));
                    eventSummary.setStartDate(rs.getTimestamp("startTime"));
                    eventSummary.setEndDate(rs.getTimestamp("endTime"));
                    eventSummary.setImageUrl(rs.getString("event_image"));
                    eventSummary.setTicketCode(rs.getString("ticket_code"));
                    eventSummary.setTicketInfo(rs.getString("ticketInfo"));
                }
            }
        }
        detail.setEventSummary(eventSummary);

        return detail;
    }

    public String getTicketQRCode(String ticketCode) {
        String sql = "SELECT ticket_qr_code FROM Ticket WHERE ticket_code = ?";
        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, ticketCode);
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return rs.getString("ticket_qr_code");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
