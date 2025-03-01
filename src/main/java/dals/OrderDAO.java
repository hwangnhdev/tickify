//package dals;
//
//import models.Order;
//import utils.DBContext;
//import java.sql.*;
//import java.util.ArrayList;
//import java.util.List;
//
//public class OrderDAO {
//
//    /**
//     * Lấy danh sách đơn hàng của khách hàng theo customerId.
//     */
//    public List<Order> getOrdersByCustomerId(int customerId) {
//        List<Order> orders = new ArrayList<>();
//        String query = "SELECT order_id, customer_id, voucherId, totalPrice, order_date, paymentStatus, transactionId, createdAt, updatedAt " +
//                       "FROM Orders WHERE customer_id = ?";
//        try (Connection conn = new DBContext().connection;
//             PreparedStatement ps = conn.prepareStatement(query)) {
//             
//            ps.setInt(1, customerId);
//            ResultSet rs = ps.executeQuery();
//            while(rs.next()){
//                Order order = new Order();
//                order.setOrderId(rs.getInt("order_id"));
//                order.setCustomerId(rs.getInt("customer_id"));
//                order.setVoucherId(rs.getInt("voucherId"));
//                order.setTotalPrice(rs.getDouble("totalPrice"));
//                order.setOrderDate(rs.getDate("order_date"));
//                order.setPaymentStatus(rs.getString("paymentStatus"));
//                order.setTransactionId(rs.getString("transactionId"));
//                order.setCreatedAt(rs.getDate("createdAt"));
//                order.setUpdatedAt(rs.getDate("updatedAt"));
//                orders.add(order);
//            }
//        } catch(SQLException e) {
//            e.printStackTrace();
//        }
//        return orders;
//    }
//    
//    /**
//     * Lấy đơn hàng theo orderId.
//     */
//    public Order getOrderById(int orderId) {
//        Order order = null;
//        String query = "SELECT order_id, customer_id, voucherId, totalPrice, order_date, paymentStatus, transactionId, createdAt, updatedAt " +
//                       "FROM Orders WHERE order_id = ?";
//        try (Connection conn = new DBContext().connection;
//             PreparedStatement ps = conn.prepareStatement(query)) {
//             
//            ps.setInt(1, orderId);
//            ResultSet rs = ps.executeQuery();
//            if(rs.next()){
//                order = new Order();
//                order.setOrderId(rs.getInt("order_id"));
//                order.setCustomerId(rs.getInt("customer_id"));
//                order.setVoucherId(rs.getInt("voucherId"));
//                order.setTotalPrice(rs.getDouble("totalPrice"));
//                order.setOrderDate(rs.getDate("order_date"));
//                order.setPaymentStatus(rs.getString("paymentStatus"));
//                order.setTransactionId(rs.getString("transactionId"));
//                order.setCreatedAt(rs.getDate("createdAt"));
//                order.setUpdatedAt(rs.getDate("updatedAt"));
//            }
//        } catch(SQLException e) {
//            e.printStackTrace();
//        }
//        return order;
//    }
//}
