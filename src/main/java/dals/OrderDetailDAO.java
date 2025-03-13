package dals;

import viewModels.OrderDetailDTO;
import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.OrderDetail;

public class OrderDetailDAO extends DBContext {

    private static final String INSERT_ORDER_DETAIL = "INSERT INTO OrderDetails (order_id, ticket_type_id, quantity, price) VALUES (?, ?, ?, ?)";
    private static final String GET_LATEST_ORDER_DETAIL
            = "SELECT order_detail_id, order_id, ticket_type_id, quantity, price "
            + "FROM OrderDetails "
            + "WHERE order_id = ? AND ticket_type_id = ? "
            + "ORDER BY order_detail_id DESC";

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
            + "    ei.image_url,\n"
            + "    o.payment_status,\n"
            + "    MIN(CONCAT(s.seat_row, '-', s.seat_col)) AS seat\n"
            + "FROM Orders o\n"
            + "JOIN Customers c ON o.customer_id = c.customer_id\n"
            + "JOIN OrderDetails od ON o.order_id = od.order_id\n"
            + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id\n"
            + "JOIN Showtimes st ON tt.showtime_id = st.showtime_id\n"
            + "JOIN Events e ON st.event_id = e.event_id\n"
            + "JOIN Organizers org ON e.organizer_id = org.organizer_id\n"
            // Thay JOIN bằng LEFT JOIN để không bắt buộc có dữ liệu ở Ticket và Seats
            + "LEFT JOIN Ticket t ON od.order_detail_id = t.order_detail_id\n"
            + "LEFT JOIN Seats s ON t.seat_id = s.seat_id\n"
            + "LEFT JOIN Vouchers v ON o.voucher_id = v.voucher_id\n"
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
            + "    o.payment_status";

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
                detail.setImage_url(rs.getString("image_url"));
                detail.setPaymentStatus(rs.getString("payment_status"));
                detail.setSeat(rs.getString("seat")); // Lấy thông tin seat từ kết quả MIN(...)
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return detail;
}


    public boolean insertOrderDetail(OrderDetail orderDetail) {
        try (PreparedStatement st = connection.prepareStatement(INSERT_ORDER_DETAIL)) {
            st.setInt(1, orderDetail.getOrderId());
            st.setInt(2, orderDetail.getTicketTypeId());
            st.setInt(3, orderDetail.getQuantity());
            st.setDouble(4, orderDetail.getPrice());
            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public OrderDetail getLatestOrderDetail(int orderId, int ticketTypeId) {
        try (PreparedStatement ps = connection.prepareStatement(GET_LATEST_ORDER_DETAIL)) {

            ps.setInt(1, orderId);
            ps.setInt(2, ticketTypeId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new OrderDetail(
                            rs.getInt("order_detail_id"),
                            rs.getInt("order_id"),
                            rs.getInt("ticket_type_id"),
                            rs.getInt("quantity"),
                            rs.getDouble("price")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy dữ liệu
    }

    /**
     * Lấy danh sách OrderDetail theo orderId.
     */
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String query = "SELECT order_detail_id, order_id, ticketTypeId, quantity, price "
                + "FROM OrderDetails WHERE order_id = ?";
        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                OrderDetail od = new OrderDetail();
                od.setOrderDetailId(rs.getInt("order_detail_id"));
                od.setOrderId(rs.getInt("order_id"));
                od.setTicketTypeId(rs.getInt("ticketTypeId"));
                od.setQuantity(rs.getInt("quantity"));
                od.setPrice(rs.getDouble("price"));
                orderDetails.add(od);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    /**
     * Lấy OrderDetail theo order_detail_id.
     */
    public OrderDetail getOrderDetailById(int orderDetailId) {
        OrderDetail od = null;
        String query = "SELECT order_detail_id, order_id, ticketTypeId, quantity, price "
                + "FROM OrderDetails WHERE order_detail_id = ?";
        try (Connection conn = new DBContext().connection; PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderDetailId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                od = new OrderDetail();
                od.setOrderDetailId(rs.getInt("order_detail_id"));
                od.setOrderId(rs.getInt("order_id"));
                od.setTicketTypeId(rs.getInt("ticketTypeId"));
                od.setQuantity(rs.getInt("quantity"));
                od.setPrice(rs.getDouble("price"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return od;
    }

}
