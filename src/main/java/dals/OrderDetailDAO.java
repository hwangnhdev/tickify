package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBContext;
import viewModels.CalculationDTO;
import viewModels.EventSummaryDTO;
import viewModels.OrderDetailDTO;
import viewModels.OrderSummaryDTO;
import viewModels.TicketItemDTO;

public class OrderDetailDAO extends DBContext {

    // Query Header: Lấy thông tin đơn hàng, khách hàng, voucher, tổng tính toán và event liên quan
    // Query Header: Lấy thông tin đơn hàng, khách hàng, voucher, tổng tính toán và event liên quan
    private static final String SQL_GET_ORDER_HEADER
            = "SELECT "
            + "    o.order_id, "
            + "    o.order_date, "
            + "    o.payment_status, "
            + "    c.full_name AS customerName, "
            + "    c.email AS customerEmail, "
            + "    v.code AS voucherCode, "
            + "    v.discount_type, "
            + "    v.discount_value, "
            + "    CASE "
            + "        WHEN v.discount_type = 'percentage' THEN "
            + "            CONVERT(DECIMAL(10,2), o.total_price / (1 - (v.discount_value / 100.0))) "
            + "        WHEN v.discount_type = 'Fixed' THEN "
            + "            CONVERT(DECIMAL(10,2), o.total_price + v.discount_value) "
            + "        ELSE "
            + "            o.total_price "
            + "    END AS total_subtotal, "
            + "    CASE "
            + "        WHEN v.discount_type = 'percentage' THEN "
            + "            CONVERT(DECIMAL(10,2), (o.total_price / (1 - (v.discount_value / 100.0))) - o.total_price) "
            + "        WHEN v.discount_type = 'Fixed' THEN "
            + "            CONVERT(DECIMAL(10,2), v.discount_value) "
            + "        ELSE "
            + "            0 "
            + "    END AS discount_amount, "
            + "    o.total_price AS final_total, "
            + "    e.event_id, "
            + "    e.event_name, "
            + "    e.location, "
            + "    s.start_date, "
            + "    s.end_date, "
            + "    ei.image_url AS eventImage "
            + "FROM Orders o "
            + "JOIN Customers c ON o.customer_id = c.customer_id "
            + "LEFT JOIN Vouchers v ON o.voucher_id = v.voucher_id "
            + "CROSS APPLY ( "
            + "    SELECT TOP 1 tt.showtime_id "
            + "    FROM OrderDetails od2 "
            + "    JOIN TicketTypes tt ON od2.ticket_type_id = tt.ticket_type_id "
            + "    WHERE od2.order_id = o.order_id "
            + "    ORDER BY od2.order_detail_id "
            + ") ot "
            + "JOIN Showtimes s ON s.showtime_id = ot.showtime_id "
            + "JOIN Events e ON s.event_id = e.event_id "
            + "OUTER APPLY ( "
            + "    SELECT TOP 1 image_url "
            + "    FROM EventImages ei "
            + "    WHERE ei.event_id = e.event_id "
            + "    ORDER BY ei.image_id "
            + ") ei "
            + "WHERE o.order_id = ?";

    // Query Order Items: Lấy thông tin chi tiết các order items theo từng loại vé
    private static final String SQL_GET_ORDER_ITEMS
            = "SELECT "
            + "    od.ticket_type_id, "
            + "    tt.name AS ticketType, "
            + "    tt.price AS unitPrice, "
            + "    STRING_AGG('(' + se.seat_row + '-' + se.seat_col + ')', ', ') WITHIN GROUP (ORDER BY se.seat_row, TRY_CAST(se.seat_col AS INT)) AS seats, "
            + "    od.quantity AS Quantity, "
            + "    od.quantity * tt.price AS subtotal_per_type "
            + "FROM OrderDetails od "
            + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
            + "LEFT JOIN Ticket t ON od.order_detail_id = t.order_detail_id "
            + "LEFT JOIN Seats se ON t.seat_id = se.seat_id "
            + "WHERE od.order_id = ? "
            + "GROUP BY od.ticket_type_id, tt.name, tt.price, od.quantity";

    public OrderDetailDTO getOrderDetailByOrderId(int orderId) {
        OrderDetailDTO detail = new OrderDetailDTO();
        PreparedStatement psHeader = null;
        PreparedStatement psItems = null;
        ResultSet rsHeader = null;
        ResultSet rsItems = null;

        try {
            // --- Query Header ---
            psHeader = connection.prepareStatement(SQL_GET_ORDER_HEADER);
            psHeader.setInt(1, orderId);
            rsHeader = psHeader.executeQuery();
            if (rsHeader.next()) {
                OrderSummaryDTO summary = new OrderSummaryDTO();
                summary.setOrderId(rsHeader.getInt("order_id"));
                summary.setOrderDate(rsHeader.getTimestamp("order_date"));
                summary.setPaymentStatus(rsHeader.getString("payment_status"));
                summary.setCustomerName(rsHeader.getString("customerName"));
                summary.setCustomerEmail(rsHeader.getString("customerEmail"));
                summary.setVoucherCode(rsHeader.getString("voucherCode"));
                summary.setDiscountType(rsHeader.getString("discount_type"));
                summary.setDiscountValue(rsHeader.getBigDecimal("discount_value"));

                CalculationDTO calc = new CalculationDTO();
                calc.setTotalSubtotal(rsHeader.getBigDecimal("total_subtotal"));
                calc.setDiscountAmount(rsHeader.getBigDecimal("discount_amount"));
                calc.setFinalTotal(rsHeader.getBigDecimal("final_total"));

                EventSummaryDTO eventInfo = new EventSummaryDTO();
                eventInfo.setEventId(rsHeader.getInt("event_id"));
                eventInfo.setEventName(rsHeader.getString("event_name"));
                eventInfo.setLocation(rsHeader.getString("location"));
                eventInfo.setStartDate(rsHeader.getTimestamp("start_date"));
                eventInfo.setEndDate(rsHeader.getTimestamp("end_date"));
                eventInfo.setImageUrl(rsHeader.getString("eventImage"));

                detail.setOrderSummary(summary);
                detail.setCalculation(calc);
                detail.setEventSummary(eventInfo);
            } else {
                System.err.println("No header data found for order_id = " + orderId);
                return null;
            }

            // --- Query Order Items ---
            psItems = connection.prepareStatement(SQL_GET_ORDER_ITEMS);
            psItems.setInt(1, orderId);
            rsItems = psItems.executeQuery();
            List<TicketItemDTO> ticketItems = new ArrayList<>();
            while (rsItems.next()) {
                TicketItemDTO item = new TicketItemDTO();
                item.setTicketTypeId(rsItems.getInt("ticket_type_id"));
                item.setTicketType(rsItems.getString("ticketType"));
                item.setUnitPrice(rsItems.getBigDecimal("unitPrice"));
                item.setSeats(rsItems.getString("seats"));
                item.setQuantity(rsItems.getInt("Quantity"));
                item.setSubtotalPerType(rsItems.getBigDecimal("subtotal_per_type"));
                ticketItems.add(item);
            }
            detail.setOrderItems(ticketItems);

        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        } finally {
            close(rsHeader);
            close(psHeader);
            close(rsItems);
            close(psItems);
        }
        return detail;
    }

    // Các phương thức insertOrderDetail, getLatestOrderDetail, getOrderDetailsByOrderId, getOrderDetailById giữ nguyên...
    public boolean insertOrderDetail(models.OrderDetail orderDetail) {
        try (PreparedStatement st = connection.prepareStatement("INSERT INTO OrderDetails (order_id, ticket_type_id, quantity, price) VALUES (?, ?, ?, ?)")) {
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
        try (PreparedStatement ps = connection.prepareStatement(
                "SELECT order_detail_id, order_id, ticket_type_id, quantity, price FROM OrderDetails WHERE order_id = ? AND ticket_type_id = ? ORDER BY order_detail_id DESC")) {
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

    public List<models.OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<models.OrderDetail> orderDetails = new ArrayList<>();
        String query = "SELECT order_detail_id, order_id, ticketTypeId, quantity, price FROM OrderDetails WHERE order_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    models.OrderDetail od = new models.OrderDetail();
                    od.setOrderDetailId(rs.getInt("order_detail_id"));
                    od.setOrderId(rs.getInt("order_id"));
                    od.setTicketTypeId(rs.getInt("ticketTypeId"));
                    od.setQuantity(rs.getInt("quantity"));
                    od.setPrice(rs.getDouble("price"));
                    orderDetails.add(od);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public models.OrderDetail getOrderDetailById(int orderDetailId) {
        models.OrderDetail od = null;
        String query = "SELECT order_detail_id, order_id, ticketTypeId, quantity, price FROM OrderDetails WHERE order_detail_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderDetailId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    od = new models.OrderDetail();
                    od.setOrderDetailId(rs.getInt("order_detail_id"));
                    od.setOrderId(rs.getInt("order_id"));
                    od.setTicketTypeId(rs.getInt("ticketTypeId"));
                    od.setQuantity(rs.getInt("quantity"));
                    od.setPrice(rs.getDouble("price"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return od;
    }

    private void close(AutoCloseable ac) {
        if (ac != null) {
            try {
                ac.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}