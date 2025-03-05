package dals;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.CustomerTicketDTO;
import models.Order;
import models.OrganizerOrderDetail;
import models.OrganizerOrderDetailDTO;
import models.OrganizerOrderHeader;
import models.TicketDetailDTO;
import utils.DBContext;

/**
 * OrderDAO xử lý các thao tác truy vấn liên quan đến đơn hàng. Lớp này kế thừa
 * từ DBContext để sử dụng thuộc tính connection.
 */
public class OrderDAO extends DBContext {

    // Constructor kế thừa từ DBContext để khởi tạo kết nối.
    public OrderDAO() {
        super(); // Gọi constructor của DBContext
    }

    /**
     * Lấy thông tin chi tiết đơn hàng cho organizer sử dụng CTE. Bao gồm thông
     * tin header và danh sách chi tiết đơn hàng.
     *
     * @param orderId ID của đơn hàng cần truy vấn.
     * @return OrganizerOrderDetailDTO chứa header và danh sách chi tiết đơn
     * hàng.
     * @throws SQLException Nếu có lỗi truy vấn.
     */
    public OrganizerOrderDetailDTO getOrderDetailForOrganizer(int orderId) throws SQLException {
        OrganizerOrderDetailDTO dto = new OrganizerOrderDetailDTO();
        OrganizerOrderHeader header = null;
        List<OrganizerOrderDetail> details = new ArrayList<>();

        String sql = "WITH OrderHeader AS ( "
                + "    SELECT o.order_id, o.order_date, o.total_price, o.payment_status, o.transaction_id, "
                + "           v.code AS voucher_code, c.full_name AS customer_name, c.email AS customer_email, c.phone AS customer_phone "
                + "    FROM Orders o "
                + "    JOIN Customers c ON o.customer_id = c.customer_id "
                + "    LEFT JOIN Vouchers v ON o.voucher_id = v.voucher_id "
                + "    WHERE o.order_id = ? "
                + "), OrderDetailsCTE AS ( "
                + "    SELECT od.order_detail_id, od.order_id, tt.name AS ticket_type, od.quantity, od.price AS unit_price, "
                + "           (od.quantity * od.price) AS detail_total_price "
                + "    FROM OrderDetails od "
                + "    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "    WHERE od.order_id = ? "
                + ") "
                + "SELECT h.order_id, h.order_date, h.total_price, h.payment_status, h.transaction_id, h.voucher_code, "
                + "       h.customer_name, h.customer_email, h.customer_phone, "
                + "       d.order_detail_id, d.ticket_type, d.quantity, d.unit_price, d.detail_total_price "
                + "FROM OrderHeader h "
                + "LEFT JOIN OrderDetailsCTE d ON h.order_id = d.order_id "
                + "ORDER BY d.order_detail_id";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    if (header == null) {
                        header = new OrganizerOrderHeader();
                        header.setOrderId(rs.getInt("order_id"));
                        header.setOrderDate(rs.getTimestamp("order_date"));
                        header.setTotalPrice(rs.getBigDecimal("total_price"));
                        header.setPaymentStatus(rs.getString("payment_status"));
                        header.setTransactionId(rs.getString("transaction_id"));
                        header.setVoucherCode(rs.getString("voucher_code"));
                        header.setCustomerName(rs.getString("customer_name"));
                        header.setCustomerEmail(rs.getString("customer_email"));
                        header.setCustomerPhone(rs.getString("customer_phone"));
                    }
                    int orderDetailId = rs.getInt("order_detail_id");
                    if (!rs.wasNull()) {
                        OrganizerOrderDetail detail = new OrganizerOrderDetail();
                        detail.setOrderDetailId(orderDetailId);
                        detail.setOrderId(rs.getInt("order_id"));
                        detail.setTicketType(rs.getString("ticket_type"));
                        detail.setQuantity(rs.getInt("quantity"));
                        detail.setUnitPrice(rs.getBigDecimal("unit_price"));
                        detail.setDetailTotalPrice(rs.getBigDecimal("detail_total_price"));
                        details.add(detail);
                    }
                }
            }
        }
        dto.setOrderHeader(header);
        dto.setOrderDetails(details);
        return dto;
    }

    /**
     * Lấy danh sách đơn hàng theo organizer và trạng thái thanh toán với phân
     * trang.
     *
     * @param organizerId ID của organizer.
     * @param paymentStatus Trạng thái thanh toán ("all", "paid", "pending").
     * @param offset Vị trí bắt đầu lấy dữ liệu.
     * @param pageSize Số đơn hàng mỗi trang.
     * @return Danh sách đơn hàng.
     */
    public List<Order> getOrdersByOrganizerAndPaymentStatus(int organizerId, String paymentStatus, int offset, int pageSize) {
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
                + "  AND ( ? = 'all' OR LOWER(o.payment_status) = ? ) "
                + "ORDER BY o.order_date DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, organizerId);
            stmt.setString(2, paymentStatus.toLowerCase());
            stmt.setString(3, paymentStatus.toLowerCase());
            stmt.setInt(4, offset);
            stmt.setInt(5, pageSize);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setTotalPrice(rs.getBigDecimal("total_price"));
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
     * Phương thức mới: Tìm kiếm đơn hàng theo organizer và từ khóa tìm kiếm (theo tên khách hàng).
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
                    order.setTotalPrice(rs.getBigDecimal("total_price"));
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

    /**
     * Lấy chi tiết vé cho khách hàng dựa trên ticketCode và customerId.
     *
     * @param ticketCode Mã vé cần xem chi tiết.
     * @param customerId ID của khách hàng (để xác thực quyền truy cập).
     * @return TicketDetailDTO chứa thông tin chi tiết vé, hoặc null nếu không
     * tìm thấy.
     */
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
}
