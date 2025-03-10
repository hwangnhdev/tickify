package dals;

import models.OrderDetailDTO;
import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OrderDetailDAO extends DBContext {

    public OrderDetailDTO getOrderDetailForOrganizer(int organizerId, int orderId) {
        OrderDetailDTO detail = null;
     String sql = "SELECT \n"
        + "    o.order_id,\n"
        + "    o.order_date,\n"
        + "    c.full_name AS customerName,\n"
        + "    c.email AS customerEmail,\n"
        + "    e.event_name,\n"
        + "    e.location,\n"
        + "    CAST(ROUND(o.total_price, 2) AS DECIMAL(10,2)) AS grandTotal,\n"
        + "    v.code AS voucherCode,\n"
        + "    v.discount_type,\n"
        + "    CAST(ISNULL(v.discount_value, 0) AS DECIMAL(10,2)) AS discount_value,\n"
        + "    CAST(ROUND(\n"
        + "      CASE \n"
        + "        WHEN LOWER(v.discount_type) = 'percentage' THEN o.total_price * (v.discount_value / 100.0)\n"
        + "        ELSE ISNULL(v.discount_value, 0)\n"
        + "      END, 2) AS DECIMAL(10,2)) AS discountAmount,\n"
        + "    CAST(ROUND(\n"
        + "      o.total_price - CASE \n"
        + "        WHEN LOWER(v.discount_type) = 'percentage' THEN o.total_price * (v.discount_value / 100.0)\n"
        + "        ELSE ISNULL(v.discount_value, 0)\n"
        + "      END, 2) AS DECIMAL(10,2)) AS totalAfterDiscount,\n"
        + "    STRING_AGG(t.ticket_code, ', ') AS seatList,\n"
        + "    ei.image_url,\n"
        + "    o.payment_status\n"
        + "FROM Orders o\n"
        + "JOIN Customers c ON o.customer_id = c.customer_id\n"
        + "JOIN OrderDetails od ON o.order_id = od.order_id\n"
        + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id\n"
        + "JOIN Showtimes st ON tt.showtime_id = st.showtime_id\n"
        + "JOIN Events e ON st.event_id = e.event_id\n"
        + "JOIN Organizers org ON e.organizer_id = org.organizer_id\n"
        + "LEFT JOIN Vouchers v ON o.voucher_id = v.voucher_id\n"
        + "LEFT JOIN Ticket t ON od.order_detail_id = t.order_detail_id\n"
        + "LEFT JOIN (\n"
        + "    SELECT event_id, MIN(image_url) AS image_url\n"
        + "    FROM EventImages\n"
        + "    GROUP BY event_id\n"
        + ") ei ON e.event_id = ei.event_id\n"
        + "WHERE org.organizer_id = ? \n"
        + "  AND o.order_id = ?\n"
        + "GROUP BY \n"
        + "    o.order_id,\n"
        + "    o.order_date,\n"
        + "    c.full_name,\n"
        + "    c.email,\n"
        + "    e.event_name,\n"
        + "    e.location,\n"
        + "    o.total_price,\n"
        + "    v.code,\n"
        + "    v.discount_type,\n"
        + "    v.discount_value,\n"
        + "    ei.image_url,\n"
        + "    o.payment_status;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, organizerId);
            ps.setInt(2, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    detail = new OrderDetailDTO();
                    detail.setOrderId(rs.getInt("order_id"));
                    detail.setOrderDate(rs.getTimestamp("order_date"));
                    detail.setCustomerName(rs.getString("customerName"));
                    detail.setCustomerEmail(rs.getString("customerEmail"));
                    detail.setEventName(rs.getString("event_name"));
                    detail.setLocation(rs.getString("location"));
                    detail.setGrandTotal(rs.getDouble("grandTotal"));
                    detail.setVoucherCode(rs.getString("voucherCode"));
                    detail.setDiscount_type(rs.getString("discount_type"));
                    detail.setDiscount_value(rs.getDouble("discount_value"));
                    detail.setDiscountAmount(rs.getDouble("discountAmount"));
                    detail.setTotalAfterDiscount(rs.getDouble("totalAfterDiscount"));
                    detail.setSeatList(rs.getString("seatList"));
                    detail.setImage_url(rs.getString("image_url"));
                    // Set the new payment status field
                    detail.setPaymentStatus(rs.getString("payment_status"));
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return detail;
    }

}
