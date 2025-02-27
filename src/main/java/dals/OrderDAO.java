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
import utils.DBContext;

/**
 * OrderDAO xử lý các thao tác truy vấn liên quan đến đơn hàng.
 * Lớp này kế thừa từ DBContext để sử dụng thuộc tính connection.
 */
public class OrderDAO extends DBContext {

    // Constructor kế thừa từ DBContext để khởi tạo kết nối.
    public OrderDAO() {
        super(); // Gọi constructor của DBContext
    }
    
    /**
     * Tìm kiếm đơn hàng theo từ khóa cho organizer.
     * Từ khóa được áp dụng cho Order ID (ép sang VARCHAR) hoặc Customer Name.
     *
     * @param organizerId ID của organizer (ví dụ: 2)
     * @param keyword Từ khóa tìm kiếm (ví dụ: "1" hoặc "Alice")
     * @return Danh sách OrderSearchDTO chứa các đơn hàng phù hợp.
     */
    public List<OrderSearchDTO> searchOrders(int organizerId, String keyword) {
        List<OrderSearchDTO> orders = new ArrayList<>();
        String sql = "SELECT DISTINCT " +
                     "    o.order_id, " +
                     "    o.order_date, " +
                     "    o.total_price, " +
                     "    o.payment_status, " +
                     "    o.transaction_id, " +
                     "    c.full_name AS customer_name, " +
                     "    c.email AS customer_email, " +
                     "    c.phone AS customer_phone " +
                     "FROM Orders o " +
                     "JOIN Customers c ON o.customer_id = c.customer_id " +
                     "JOIN OrderDetails od ON o.order_id = od.order_id " +
                     "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id " +
                     "JOIN Organizers org ON tt.event_id = org.event_id " +
                     "WHERE org.organizer_id = ? " +
                     "  AND (CAST(o.order_id AS VARCHAR(50)) LIKE ? OR c.full_name LIKE ?) " +
                     "ORDER BY o.order_date DESC";
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
     * Lấy thông tin chi tiết đơn hàng cho organizer sử dụng CTE. 
     * Bao gồm thông tin header và danh sách chi tiết đơn hàng.
     *
     * @param orderId ID của đơn hàng cần truy vấn.
     * @return OrganizerOrderDetailDTO chứa header và danh sách chi tiết đơn hàng.
     * @throws SQLException Nếu có lỗi truy vấn.
     */
    public OrganizerOrderDetailDTO getOrderDetailForOrganizer(int orderId) throws SQLException {
        OrganizerOrderDetailDTO dto = new OrganizerOrderDetailDTO();
        OrganizerOrderHeader header = null;
        List<OrganizerOrderDetail> details = new ArrayList<>();
        
        String sql = "WITH OrderHeader AS ( " +
                     "    SELECT o.order_id, o.order_date, o.total_price, o.payment_status, o.transaction_id, " +
                     "           v.code AS voucher_code, c.full_name AS customer_name, c.email AS customer_email, c.phone AS customer_phone " +
                     "    FROM Orders o " +
                     "    JOIN Customers c ON o.customer_id = c.customer_id " +
                     "    LEFT JOIN Vouchers v ON o.voucher_id = v.voucher_id " +
                     "    WHERE o.order_id = ? " +
                     "), OrderDetailsCTE AS ( " +
                     "    SELECT od.order_detail_id, od.order_id, tt.name AS ticket_type, od.quantity, od.price AS unit_price, " +
                     "           (od.quantity * od.price) AS detail_total_price " +
                     "    FROM OrderDetails od " +
                     "    JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id " +
                     "    WHERE od.order_id = ? " +
                     ") " +
                     "SELECT h.order_id, h.order_date, h.total_price, h.payment_status, h.transaction_id, h.voucher_code, " +
                     "       h.customer_name, h.customer_email, h.customer_phone, " +
                     "       d.order_detail_id, d.ticket_type, d.quantity, d.unit_price, d.detail_total_price " +
                     "FROM OrderHeader h " +
                     "LEFT JOIN OrderDetailsCTE d ON h.order_id = d.order_id " +
                     "ORDER BY d.order_detail_id";
                     
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
     * Lấy danh sách đơn hàng theo phân trang.
     *
     * @param offset Số bản ghi bỏ qua.
     * @param pageSize Số bản ghi trên mỗi trang.
     * @return Danh sách Order chứa thông tin đơn hàng.
     * @throws SQLException Nếu có lỗi truy vấn.
     */
    public List<Order> getOrdersWithPagination(int offset, int pageSize) throws SQLException {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.order_id, c.full_name AS customer_name, o.order_date, o.total_price, " +
                     "       COUNT(od.order_detail_id) AS total_tickets, o.payment_status, o.transaction_id " +
                     "FROM Orders o " +
                     "JOIN Customers c ON o.customer_id = c.customer_id " +
                     "JOIN OrderDetails od ON o.order_id = od.order_id " +
                     "GROUP BY o.order_id, c.full_name, o.order_date, o.total_price, o.payment_status, o.transaction_id " +
                     "ORDER BY o.order_date DESC " +
                     "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderId(rs.getInt("order_id"));
                    order.setCustomerName(rs.getString("customer_name"));
                    order.setOrderDate(rs.getDate("order_date"));
                    order.setTotalPrice(rs.getDouble("total_price"));
                    order.setTotalTickets(rs.getInt("total_tickets"));
                    order.setPaymentStatus(rs.getString("payment_status"));
                    order.setTransactionId(rs.getString("transaction_id"));
                    orders.add(order);
                }
            }
        }
        return orders;
    }
    
    /**
     * Đếm tổng số đơn hàng.
     *
     * @return Số lượng đơn hàng.
     * @throws SQLException Nếu có lỗi truy vấn.
     */
    public int countOrders() throws SQLException {
        int total = 0;
        String sql = "SELECT COUNT(DISTINCT order_id) AS total FROM Orders";
        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        }
        return total;
    }
    
    /**
     * Lấy danh sách vé đã mua của customer theo customerId.
     *
     * @param customerId ID của customer.
     * @return Danh sách CustomerTicketDTO chứa thông tin các vé đã mua.
     */
    public List<CustomerTicketDTO> getPurchasedTicketsByCustomer(int customerId) {
        List<CustomerTicketDTO> tickets = new ArrayList<>();
        String sql = "SELECT o.order_id, e.event_name, e.start_date, e.end_date, e.location, " +
                     "       t.ticket_id, tt.name AS ticket_type, tt.price AS unit_price, o.payment_status " +
                     "FROM Orders o " +
                     "JOIN OrderDetails od ON o.order_id = od.order_id " +
                     "JOIN Tickets t ON od.order_detail_id = t.order_detail_id " +
                     "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id " +
                     "JOIN Events e ON tt.event_id = e.event_id " +
                     "WHERE o.customer_id = ? " +
                     "ORDER BY e.start_date DESC, o.order_id";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CustomerTicketDTO dto = new CustomerTicketDTO();
                dto.setOrderId(rs.getInt("order_id"));
                dto.setEventName(rs.getString("event_name"));
                dto.setStartDate(rs.getDate("start_date"));
                dto.setEndDate(rs.getDate("end_date"));
                dto.setLocation(rs.getString("location"));
                dto.setTicketId(rs.getInt("ticket_id"));
                dto.setTicketType(rs.getString("ticket_type"));
                dto.setUnitPrice(rs.getDouble("unit_price"));
                dto.setPaymentStatus(rs.getString("payment_status"));
                tickets.add(dto);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return tickets;
    }
    
    /**
     * Lấy danh sách vé đã mua của customer theo customerId và payment_status.
     * So sánh không phân biệt chữ hoa/chữ thường.
     *
     * @param customerId ID của customer.
     * @param status Trạng thái cần lọc (ví dụ: pending, completed).
     * @return Danh sách CustomerTicketDTO chứa thông tin các vé theo payment_status.
     */
    public List<CustomerTicketDTO> getPurchasedTicketsByCustomerAndStatus(int customerId, String status) {
        List<CustomerTicketDTO> tickets = new ArrayList<>();
        String sql = "SELECT o.order_id, e.event_name, e.start_date, e.end_date, e.location, " +
                     "       t.ticket_id, tt.name AS ticket_type, tt.price AS unit_price, o.payment_status " +
                     "FROM Orders o " +
                     "JOIN OrderDetails od ON o.order_id = od.order_id " +
                     "JOIN Tickets t ON od.order_detail_id = t.order_detail_id " +
                     "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id " +
                     "JOIN Events e ON tt.event_id = e.event_id " +
                     "WHERE o.customer_id = ? AND LOWER(o.payment_status) = LOWER(?) " +
                     "ORDER BY e.start_date DESC, o.order_id";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, customerId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CustomerTicketDTO dto = new CustomerTicketDTO();
                dto.setOrderId(rs.getInt("order_id"));
                dto.setEventName(rs.getString("event_name"));
                dto.setStartDate(rs.getDate("start_date"));
                dto.setEndDate(rs.getDate("end_date"));
                dto.setLocation(rs.getString("location"));
                dto.setTicketId(rs.getInt("ticket_id"));
                dto.setTicketType(rs.getString("ticket_type"));
                dto.setUnitPrice(rs.getDouble("unit_price"));
                dto.setPaymentStatus(rs.getString("payment_status"));
                tickets.add(dto);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return tickets;
    }
}
