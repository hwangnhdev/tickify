package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.OrderDetail;
import utils.DBContext;

public class OrderDetailDAO extends DBContext {

    /**
     * Lấy chi tiết đơn hàng theo orderId với thông tin ghế.
     *
     * @param orderId Mã đơn hàng
     * @return OrderDetail chứa dữ liệu hoặc null nếu không tìm thấy.
     * @throws SQLException Lỗi truy xuất dữ liệu
     */
    public OrderDetail getOrderDetail(int orderId) throws SQLException {
        OrderDetail orderDetail = null;
        
        String sql = "SELECT " +
                "    o.order_id, " +
                "    o.order_date, " +
                "    o.total_price, " +
                "    o.payment_status, " +
                "    o.transaction_id, " +
                "    o.created_at AS order_created_at, " +
                "    c.full_name AS customer_name, " +
                "    c.email AS customer_email, " +
                "    e.event_name, " +
                "    e.location, " +
                "    org.organization_name, " +
                "    org.account_holder, " +
                "    org.account_number, " +
                "    org.bank_name, " +
                "    org.created_at AS organizer_created_at, " +
                "    od.quantity, " +
                "    MAX(od_total.total_quantity) AS total_quantity, " +
                "    v.code AS voucher_code, " +
                "    v.discount_type, " +
                "    v.discount_value, " +
                "    (o.total_price - COALESCE(v.discount_value, 0)) AS total_price_after_discount, " +
                "    SUM(o.total_price) OVER (PARTITION BY org.organization_name) AS total_bill_for_organization, " +
                "    STRING_AGG(CONCAT(s.seat_row, s.seat_col), ', ') AS seat_list " +
                "FROM Orders o " +
                "INNER JOIN Customers c ON o.customer_id = c.customer_id " +
                "INNER JOIN OrderDetails od ON o.order_id = od.order_id " +
                "INNER JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id " +
                "INNER JOIN Showtimes st ON tt.showtime_id = st.showtime_id " +
                "INNER JOIN Events e ON st.event_id = e.event_id " +
                "INNER JOIN Organizers org ON e.organizer_id = org.organizer_id " +
                "LEFT JOIN Vouchers v ON o.voucher_id = v.voucher_id " +
                "LEFT JOIN Ticket t ON od.order_detail_id = t.order_detail_id " +
                "LEFT JOIN Seats s ON t.seat_id = s.seat_id " +
                "CROSS APPLY ( " +
                "    SELECT SUM(od2.quantity) AS total_quantity " +
                "    FROM OrderDetails od2 " +
                "    WHERE od2.order_id = o.order_id " +
                ") AS od_total " +
                "WHERE o.order_id = ? " +
                "GROUP BY " +
                "    o.order_id, o.order_date, o.total_price, o.payment_status, o.transaction_id, " +
                "    o.created_at, c.full_name, c.email, e.event_name, e.location, " +
                "    org.organization_name, org.account_holder, org.account_number, org.bank_name, org.created_at, " +
                "    od.quantity, v.code, v.discount_type, v.discount_value " +
                "ORDER BY o.order_date DESC;";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    orderDetail = new OrderDetail();
                    orderDetail.setOrderId(rs.getInt("order_id"));
                    orderDetail.setOrderDate(rs.getTimestamp("order_date"));
                    orderDetail.setTotalPrice(rs.getDouble("total_price"));
                    orderDetail.setPaymentStatus(rs.getString("payment_status"));
                    orderDetail.setTransactionId(rs.getString("transaction_id"));
                    orderDetail.setOrderCreatedAt(rs.getTimestamp("order_created_at"));
                    orderDetail.setCustomerName(rs.getString("customer_name"));
                    orderDetail.setCustomerEmail(rs.getString("customer_email"));
                    orderDetail.setEventName(rs.getString("event_name"));
                    orderDetail.setLocation(rs.getString("location"));
                    orderDetail.setOrganizationName(rs.getString("organization_name"));
                    orderDetail.setAccountHolder(rs.getString("account_holder"));
                    orderDetail.setAccountNumber(rs.getString("account_number"));
                    orderDetail.setBankName(rs.getString("bank_name"));
                    orderDetail.setOrganizerCreatedAt(rs.getTimestamp("organizer_created_at"));
                    orderDetail.setQuantity(rs.getInt("quantity"));
                    orderDetail.setTotalQuantity(rs.getInt("total_quantity"));
                    orderDetail.setVoucherCode(rs.getString("voucher_code"));
                    orderDetail.setDiscountType(rs.getString("discount_type"));
                    orderDetail.setDiscountValue(rs.getDouble("discount_value"));
                    orderDetail.setTotalPriceAfterDiscount(rs.getDouble("total_price_after_discount"));
                    orderDetail.setTotalBillForOrganization(rs.getDouble("total_bill_for_organization"));
                    orderDetail.setSeatList(rs.getString("seat_list"));
                }
            }
        }
        return orderDetail;
    }
}
