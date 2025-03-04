package dals;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.CustomerTicketDTO;
import models.Order;
import models.OrderSearchDTO;
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
     * Tìm kiếm đơn hàng theo từ khóa cho organizer. Từ khóa được áp dụng cho
     * Order ID (ép sang VARCHAR) hoặc Customer Name.
     *
     * @param organizerId ID của organizer (ví dụ: 2)
     * @param keyword Từ khóa tìm kiếm (ví dụ: "1" hoặc "Alice")
     * @return Danh sách OrderSearchDTO chứa các đơn hàng phù hợp.
     */
    public List<OrderSearchDTO> searchOrders(int organizerId, String keyword) {
        List<OrderSearchDTO> orders = new ArrayList<>();
        String sql = "SELECT DISTINCT "
                + "    o.order_id, "
                + "    o.order_date, "
                + "    o.total_price, "
                + "    o.payment_status, "
                + "    o.transaction_id, "
                + "    c.full_name AS customer_name, "
                + "    c.email AS customer_email, "
                + "    c.phone AS customer_phone "
                + "FROM Orders o "
                + "JOIN Customers c ON o.customer_id = c.customer_id "
                + "JOIN OrderDetails od ON o.order_id = od.order_id "
                + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "JOIN Organizers org ON tt.event_id = org.event_id "
                + "WHERE org.organizer_id = ? "
                + "  AND (CAST(o.order_id AS VARCHAR(50)) LIKE ? OR c.full_name LIKE ?) "
                + "ORDER BY o.order_date DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, organizerId);
            String searchPattern = "%" + keyword + "%";
            ps.setString(2, searchPattern);
            ps.setString(3, searchPattern);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderSearchDTO dto = new OrderSearchDTO();
                    dto.setOrderId(rs.getInt("order_id"));
                    dto.setOrderDate(rs.getDate("order_date"));
                    dto.setTotalPrice(rs.getDouble("total_price"));
                    dto.setPaymentStatus(rs.getString("payment_status"));
                    dto.setTransactionId(rs.getString("transaction_id"));
                    dto.setCustomerName(rs.getString("customer_name"));
                    dto.setCustomerEmail(rs.getString("customer_email"));
                    dto.setCustomerPhone(rs.getString("customer_phone"));
                    orders.add(dto);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orders;
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

    public List<CustomerTicketDTO> getTicketsByCustomer(int customerId) {
        List<CustomerTicketDTO> tickets = new ArrayList<>();
        String query = "SELECT "
                + "T.ticket_code AS orderCode, "
                + "T.status AS ticketStatus, "
                + "O.payment_status AS paymentStatus, "
                + "S.start_date AS startDate, "
                + "S.end_date AS endDate, "
                + "E.location AS location, "
                + "E.event_name AS eventName, "
                + "T.price AS unitPrice "
                + "FROM Customers C "
                + "JOIN Orders O ON C.customer_id = O.customer_id "
                + "JOIN OrderDetails OD ON O.order_id = OD.order_id "
                + "JOIN Ticket T ON OD.order_detail_id = T.order_detail_id "
                + "JOIN Seats SE ON T.seat_id = SE.seat_id "
                + "JOIN TicketTypes TT ON SE.ticket_type_id = TT.ticket_type_id "
                + "JOIN Showtimes S ON TT.showtime_id = S.showtime_id "
                + "JOIN Events E ON S.event_id = E.event_id "
                + "WHERE C.customer_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
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
