package dals;

import java.sql.Connection;
import viewModels.OrderDetailDTO;
import utils.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.OrderDetail;
import viewModels.TicketItemDTO;

public class OrderDetailDAO extends DBContext {

    private static final String INSERT_ORDER_DETAIL = "INSERT INTO OrderDetails (order_id, ticket_type_id, quantity, price) VALUES (?, ?, ?, ?)";
    private static final String GET_LATEST_ORDER_DETAIL = "SELECT order_detail_id, order_id, ticket_type_id, quantity, price "
            + "FROM OrderDetails WHERE order_id = ? AND ticket_type_id = ? ORDER BY order_detail_id DESC";

    /**
     * Lấy chi tiết đơn hàng theo orderId (không cần organizerId)
     *
     * @param orderId ID của đơn hàng
     * @return OrderDetailDTO chứa thông tin đơn hàng và danh sách vé (order
     * items)
     */
    public OrderDetailDTO getOrderDetailByOrderId(int orderId) {
    OrderDetailDTO detail = null;
    String sqlMain = "SELECT \n"
            + "    O.order_id AS orderId,\n"
            + "    O.order_date AS orderDate,\n"
            + "    O.payment_status AS paymentStatus,\n"
            + "    CAST(ROUND(O.total_price, 2) AS DECIMAL(10,2)) AS originalTotalAmount,\n"
            + "    CASE WHEN O.voucher_id IS NOT NULL THEN 'Yes' ELSE 'No' END AS voucherApplied,\n"
            + "    V.code AS voucherCode,\n"
            + "    V.discount_type AS discountType,\n"
            + "    CAST(ISNULL(V.discount_value, 0) AS DECIMAL(10,2)) AS discountValue,\n"
            + "    CAST(ROUND(\n"
            + "        CASE \n"
            + "            WHEN LOWER(V.discount_type) = 'percentage' THEN O.total_price * (ISNULL(V.discount_value, 0) / 100.0)\n"
            + "            WHEN LOWER(V.discount_type) = 'fixed' THEN ISNULL(V.discount_value, 0)\n"
            + "            ELSE 0 \n"
            + "        END, 2) AS DECIMAL(10,2)) AS discountAmount,\n"
            + "    CAST(ROUND(\n"
            + "        O.total_price - CASE \n"
            + "            WHEN LOWER(V.discount_type) = 'percentage' THEN O.total_price * (ISNULL(V.discount_value, 0) / 100.0)\n"
            + "            WHEN LOWER(V.discount_type) = 'fixed' THEN ISNULL(V.discount_value, 0)\n"
            + "            ELSE 0 \n"
            + "        END, 2) AS DECIMAL(10,2)) AS finalTotalAmount,\n"
            + "    C.full_name AS customerName,\n"
            + "    C.email AS customerEmail,\n"
            + "    C.phone AS customerPhone,\n"
            + "    C.address AS customerAddress,\n"
            + "    E.event_name AS eventName,\n"
            + "    E.location AS location,\n"
            + "    S.start_date AS startDate,\n"
            + "    S.end_date AS endDate,\n"
            + "    ISNULL(EI.image_url, 'https://your-cloud-storage.com/path/to/default-banner.jpg') AS eventImage\n"
            + "FROM Orders O\n"
            + "JOIN Customers C ON O.customer_id = C.customer_id\n"
            + "JOIN OrderDetails OD ON O.order_id = OD.order_id\n"
            + "JOIN Ticket T ON OD.order_detail_id = T.order_detail_id\n"
            + "JOIN Seats S2 ON T.seat_id = S2.seat_id\n"
            + "JOIN TicketTypes TT ON OD.ticket_type_id = TT.ticket_type_id\n"
            + "JOIN Showtimes S ON TT.showtime_id = S.showtime_id\n"
            + "JOIN Events E ON S.event_id = E.event_id\n"
            + "LEFT JOIN Vouchers V ON O.voucher_id = V.voucher_id\n"
            + "LEFT JOIN ( \n"
            + "    SELECT event_id, image_url\n"
            + "    FROM ( \n"
            + "        SELECT event_id, image_url,\n"
            + "               ROW_NUMBER() OVER (PARTITION BY event_id \n"
            + "                                  ORDER BY CASE WHEN LOWER(image_title) LIKE '%banner%' THEN 0 ELSE 1 END, image_id) AS rn\n"
            + "        FROM EventImages\n"
            + "    ) t\n"
            + "    WHERE rn = 1\n"
            + ") EI ON E.event_id = EI.event_id\n"
            + "WHERE O.order_id = ?\n"
            + "GROUP BY \n"
            + "    O.order_id, O.order_date, O.payment_status, O.total_price, O.voucher_id,\n"
            + "    C.full_name, C.email, C.phone, C.address,\n"
            + "    E.event_name, E.location, S.start_date, S.end_date, EI.image_url,\n"
            + "    V.code, V.discount_type, V.discount_value";
    
    try (PreparedStatement ps = connection.prepareStatement(sqlMain)) {
        ps.setInt(1, orderId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                detail = new OrderDetailDTO();
                detail.setOrderId(rs.getInt("orderId"));
                detail.setOrderDate(rs.getTimestamp("orderDate"));
                detail.setPaymentStatus(rs.getString("paymentStatus"));
                detail.setGrandTotal(rs.getDouble("originalTotalAmount"));
                detail.setVoucherCode(rs.getString("voucherCode"));
                detail.setDiscountType(rs.getString("discountType"));
                detail.setDiscountPercentage(rs.getDouble("discountAmount"));
                detail.setTotalAfterDiscount(rs.getDouble("finalTotalAmount"));
                detail.setCustomerName(rs.getString("customerName"));
                detail.setCustomerEmail(rs.getString("customerEmail"));
                detail.setEventName(rs.getString("eventName"));
                detail.setLocation(rs.getString("location"));
                detail.setImage_url(rs.getString("eventImage"));
                detail.setStartDate(rs.getTimestamp("startDate"));
                detail.setEndDate(rs.getTimestamp("endDate"));
            }
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return detail;
}


    public boolean insertOrderDetail(models.OrderDetail orderDetail) {
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

    public models.OrderDetail getLatestOrderDetail(int orderId, int ticketTypeId) {
        try (PreparedStatement ps = connection.prepareStatement(GET_LATEST_ORDER_DETAIL)) {
            ps.setInt(1, orderId);
            ps.setInt(2, ticketTypeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new models.OrderDetail(
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
        return null;
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
