package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.TicketDetailDTO;
import utils.DBContext;

public class TicketDAO extends DBContext {

    // Constructor kế thừa từ DBContext
    public TicketDAO() {
        super(); // Gọi constructor của DBContext để thiết lập kết nối
    }

    /**
     * Lấy chi tiết đơn hàng theo orderId, bao gồm eventName, voucher,
     * và ảnh sự kiện từ EventImages (nếu có).
     */
    public TicketDetailDTO getTicketDetailByOrderId(int orderId) {
        TicketDetailDTO detail = null;
        String sql = "SELECT " +
                     "    o.order_date, " +
                     "    o.payment_status, " +
                     "    c.full_name AS customer_name, " +
                     "    c.email AS customer_email, " +
                     "    c.phone AS customer_phone, " +
                     "    c.address AS customer_address, " +
                     "    e.event_name AS event_name, " +
                     "    tt.name AS ticket_type, " +
                     "    tt.price AS ticket_price, " +
                     "    od.quantity AS ticket_quantity, " +
                     "    v.code AS voucher_code, " +
                     "    v.[discount_type] AS voucher_discount_type, " +
                     "    v.discount_value AS voucher_discount_value, " +
                     "    o.total_price AS order_total_price, " +
                     "    ei.image_url AS ticket_image " +
                     "FROM Orders o " +
                     "JOIN Customers c ON o.customer_id = c.customer_id " +
                     "JOIN OrderDetails od ON o.order_id = od.order_id " +
                     "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id " +
                     "JOIN Events e ON tt.event_id = e.event_id " +
                     "LEFT JOIN Vouchers v ON o.voucher_id = v.voucher_id " +
                     "LEFT JOIN EventImages ei ON e.event_id = ei.event_id " +
                     "WHERE o.order_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {  // Sử dụng connection kế thừa từ DBContext
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    detail = new TicketDetailDTO();
                    detail.setOrderDate(rs.getDate("order_date"));
                    detail.setPaymentStatus(rs.getString("payment_status"));
                    detail.setCustomerName(rs.getString("customer_name"));
                    detail.setCustomerEmail(rs.getString("customer_email"));
                    detail.setCustomerPhone(rs.getString("customer_phone"));
                    detail.setCustomerAddress(rs.getString("customer_address"));
                    detail.setEventName(rs.getString("event_name"));
                    detail.setTicketType(rs.getString("ticket_type"));
                    detail.setTicketPrice(rs.getDouble("ticket_price"));
                    detail.setTicketQuantity(rs.getInt("ticket_quantity"));
                    detail.setVoucherCode(rs.getString("voucher_code"));
                    detail.setVoucherDiscountType(rs.getString("voucher_discount_type"));
                    detail.setVoucherDiscountValue(rs.getDouble("voucher_discount_value"));
                    detail.setOrderTotalPrice(rs.getDouble("order_total_price"));
                    detail.setTicketImage(rs.getString("ticket_image")); // lấy ảnh
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // Thay bằng logging nếu cần
        }
        return detail;
    }
}
