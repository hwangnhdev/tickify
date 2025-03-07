package dals;

import models.OrderDetail;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO extends DBContext{

    private static final String INSERT_ORDER_DETAIL = "INSERT INTO OrderDetails (order_id, ticket_type_id, quantity, price) VALUES (?, ?, ?, ?)";
    
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
    
    private static final String GET_LATEST_ORDER_DETAIL = 
        "SELECT order_detail_id, order_id, ticket_type_id, quantity, price " +
        "FROM OrderDetails " +
        "WHERE order_id = ? AND ticket_type_id = ? " +
        "ORDER BY order_detail_id DESC";

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
        String query = "SELECT order_detail_id, order_id, ticketTypeId, quantity, price " +
                       "FROM OrderDetails WHERE order_id = ?";
        try (Connection conn = new DBContext().connection;
             PreparedStatement ps = conn.prepareStatement(query)) {

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
        String query = "SELECT order_detail_id, order_id, ticketTypeId, quantity, price " +
                       "FROM OrderDetails WHERE order_detail_id = ?";
        try (Connection conn = new DBContext().connection;
             PreparedStatement ps = conn.prepareStatement(query)) {

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
