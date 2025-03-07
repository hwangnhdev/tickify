package dals;

import models.Order;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

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
     * Lấy danh sách đơn hàng của khách hàng theo customerId.
     */
    public List<Order> getOrdersByCustomerId(int customerId) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT order_id, customer_id, voucherId, totalPrice, order_date, paymentStatus, transactionId, createdAt, updatedAt "
                + "FROM Orders WHERE customer_id = ?";
        try ( Connection conn = new DBContext().connection;  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setVoucherId(rs.getInt("voucherId"));
                order.setTotalPrice(rs.getDouble("totalPrice"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setPaymentStatus(rs.getString("paymentStatus"));
                order.setTransactionId(rs.getString("transactionId"));
                order.setCreatedAt(rs.getTimestamp("createdAt"));
                order.setUpdatedAt(rs.getTimestamp("updatedAt"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    /**
     * Lấy đơn hàng theo orderId.
     */
    public Order getOrderById(int orderId) {
        Order order = null;
        String query = "SELECT order_id, customer_id, voucherId, totalPrice, order_date, paymentStatus, transactionId, createdAt, updatedAt "
                + "FROM Orders WHERE order_id = ?";
        try ( Connection conn = new DBContext().connection;  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setCustomerId(rs.getInt("customer_id"));
                order.setVoucherId(rs.getInt("voucherId"));
                order.setTotalPrice(rs.getDouble("totalPrice"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setPaymentStatus(rs.getString("paymentStatus"));
                order.setTransactionId(rs.getString("transactionId"));
                order.setCreatedAt(rs.getTimestamp("createdAt"));
                order.setUpdatedAt(rs.getTimestamp("updatedAt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }
}
