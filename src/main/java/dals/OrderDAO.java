package dals;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import models.Order;
import models.TicketDetailDTO;
import utils.DBContext;

public class OrderDAO extends DBContext {

    private static final String SELECT_ALL_ORDERS = "SELECT * FROM Orders";
    private static final String SELECT_ORDER_BY_ID = "SELECT * FROM Orders WHERE order_id = ?";
    private static final String INSERT_ORDER = "INSERT INTO Orders (customer_id, voucher_id, total_price, order_date, payment_status, transaction_id, created_at, updated_at) "
            + "VALUES (?, ?, ?, GETDATE(), ?, ?, GETDATE(), GETDATE())";
    private static final String UPDATE_ORDER = "UPDATE Orders SET payment_status = ?, updated_at = GETDATE() WHERE order_id = ?";

    public List<Order> selectAllOrders() {
        List<Order> orders = new ArrayList<>();
        try ( PreparedStatement st = connection.prepareStatement(SELECT_ALL_ORDERS);  ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                orders.add(mapResultSetToOrder(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public Order selectOrderById(int id) {
        Order order = null;
        try ( PreparedStatement st = connection.prepareStatement(SELECT_ORDER_BY_ID)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                order = mapResultSetToOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }

    public int insertOrder(Order order) {
        try ( PreparedStatement st = connection.prepareStatement(INSERT_ORDER, Statement.RETURN_GENERATED_KEYS)) {
            st.setInt(1, order.getCustomerId());

            // Kiểm tra voucher_id
            if (order.getVoucherId() > 0) {
                st.setInt(2, order.getVoucherId());
            } else {
                st.setNull(2, Types.INTEGER); // Đặt NULL nếu không có voucher
            }

            st.setDouble(3, order.getTotalPrice());
            st.setString(4, order.getPaymentStatus());
            st.setString(5, order.getTransactionId());

            int rowsInserted = st.executeUpdate();

            if (rowsInserted > 0) {
                try ( ResultSet generatedKeys = st.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1); // Trả về order_id mới được tạo
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Trả về -1 nếu insert thất bại
    }

    public static void main(String[] args) {
        Order order = new Order(0, 1, 0, 250000.0, null,
                "Paid", "TXN12345", null, null);

        OrderDAO od = new OrderDAO();
        od.insertOrder(order);
    }

    public boolean updateOrder(int orderId, String paymentStatus) {
        try ( PreparedStatement st = connection.prepareStatement(UPDATE_ORDER)) {
            st.setString(1, paymentStatus);
            st.setInt(2, orderId);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        return new Order(
                rs.getInt("order_id"),
                rs.getInt("customer_id"),
                rs.getInt("voucher_id"),
                rs.getDouble("total_price"),
                rs.getTimestamp("order_date"),
                rs.getString("payment_status"),
                rs.getString("transaction_id"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
        );
    }

    public Order getLatestOrder(int customerId) {
        Order order = null;
        String sql = "SELECT TOP 1 * FROM Orders WHERE customer_id = ? ORDER BY order_id DESC";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, customerId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                order = mapResultSetToOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
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

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            ps.setInt(2, orderId);
            try ( ResultSet rs = ps.executeQuery()) {
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

//    /**
//     * Lấy danh sách đơn hàng theo organizer và trạng thái thanh toán với phân
//     * trang.
//     *
//     * @param organizerId ID của organizer.
//     * @param paymentStatus Trạng thái thanh toán ("all", "paid", "pending").
//     * @param offset Vị trí bắt đầu lấy dữ liệu.
//     * @param pageSize Số đơn hàng mỗi trang.
//     * @return Danh sách đơn hàng.
//     */
//    public List<Order> getOrdersByOrganizerAndPaymentStatus(int organizerId, String paymentStatus, int offset, int pageSize) {
//        List<Order> orders = new ArrayList<>();
//        String query = "SELECT order_id, customer_id, voucherId, totalPrice, order_date, paymentStatus, transactionId, createdAt, updatedAt "
//                + "FROM Orders WHERE customer_id = ?";
//        try ( Connection conn = new DBContext().connection;  PreparedStatement ps = conn.prepareStatement(query)) {
//
//            ps.setInt(1, customerId);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                Order order = new Order();
//                order.setOrderId(rs.getInt("order_id"));
//                order.setCustomerId(rs.getInt("customer_id"));
//                order.setVoucherId(rs.getInt("voucherId"));
//                order.setTotalPrice(rs.getDouble("totalPrice"));
//                order.setOrderDate(rs.getTimestamp("order_date"));
//                order.setPaymentStatus(rs.getString("paymentStatus"));
//                order.setTransactionId(rs.getString("transactionId"));
//                order.setCreatedAt(rs.getTimestamp("createdAt"));
//                order.setUpdatedAt(rs.getTimestamp("updatedAt"));
//                orders.add(order);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return orders;
//    }

//    /**
//     * Đếm tổng số đơn hàng theo organizer và trạng thái thanh toán.
//     *
//     * @param organizerId ID của organizer.
//     * @param paymentStatus Trạng thái thanh toán ("all", "paid", "pending").
//     * @return Số đơn hàng.
//     */
//    public Order getOrderById(int orderId) {
//        Order order = null;
//        String query = "SELECT order_id, customer_id, voucherId, totalPrice, order_date, paymentStatus, transactionId, createdAt, updatedAt "
//                + "FROM Orders WHERE order_id = ?";
//        try ( Connection conn = new DBContext().connection;  PreparedStatement ps = conn.prepareStatement(query)) {
//
//            ps.setInt(1, orderId);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                order = new Order();
//                order.setOrderId(rs.getInt("order_id"));
//                order.setCustomerId(rs.getInt("customer_id"));
//                order.setVoucherId(rs.getInt("voucherId"));
//                order.setTotalPrice(rs.getDouble("totalPrice"));
//                order.setOrderDate(rs.getTimestamp("order_date"));
//                order.setPaymentStatus(rs.getString("paymentStatus"));
//                order.setTransactionId(rs.getString("transactionId"));
//                order.setCreatedAt(rs.getTimestamp("createdAt"));
//                order.setUpdatedAt(rs.getTimestamp("updatedAt"));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return tickets;
//    }

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
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setString(2, ticketCode);
            try ( ResultSet rs = ps.executeQuery()) {
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
