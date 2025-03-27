package dals;

import models.Ticket;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import viewModels.CustomerTicketDTO;
import viewModels.TicketDetailDTO;
import viewModels.TicketItemDTO;
import viewModels.TicketSeatDTO;

public class TicketDAO extends DBContext {

    private static final String INSERT_TICKET = "INSERT INTO Ticket (order_detail_id, seat_id, ticket_code, price, status, created_at, updated_at) "
            + "VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String CHECK_TICKET_EXIST = "SELECT COUNT(*) FROM Ticket WHERE ticket_code = ?";
    private static final String CHECK_TICKET_STATUS = "SELECT t.status AS ticket_status "
            + "FROM Orders o "
            + "JOIN OrderDetails od ON o.order_id = od.order_id "
            + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
            + "JOIN Ticket t ON od.order_detail_id = t.order_detail_id "
            + "JOIN Seats s ON t.seat_id = s.seat_id "
            + "WHERE o.order_id = ? and s.seat_id = ?";
    private static final String UPDATE_TICKET_STATUS = "UPDATE Ticket SET status = 'used', updated_at = GETDATE() WHERE seat_id = ?";

    public boolean insertTicket(Ticket ticket) {
        try (PreparedStatement st = connection.prepareStatement(INSERT_TICKET)) {
            st.setInt(1, ticket.getOrderDetailId());
            st.setInt(2, ticket.getSeatId());
            st.setString(3, ticket.getTicketCode());
            st.setDouble(4, ticket.getPrice());
            st.setString(5, ticket.getStatus());
            st.setTimestamp(6, ticket.getCreatedAt());
            st.setTimestamp(7, ticket.getUpdatedAt());

            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean isTicketExist(String ticketCode) {
        try (PreparedStatement st = connection.prepareStatement(CHECK_TICKET_EXIST)) {
            st.setString(1, ticketCode);
            ResultSet rs = st.executeQuery();
            return rs.next() && rs.getInt(1) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public String getTicketStatus(int orderId, int seatId) {
        try (PreparedStatement st = connection.prepareStatement(CHECK_TICKET_STATUS)) {
            st.setInt(1, orderId);
            st.setInt(2, seatId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getString("ticket_status");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Không tìm thấy vé
    }

    public boolean updateTicketStatus(int seatId) {
        try (PreparedStatement st = connection.prepareStatement(UPDATE_TICKET_STATUS)) {
            st.setInt(1, seatId);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy danh sách vé của khách hàng cho view all ticket (nhóm theo order_id).
     */
    public List<CustomerTicketDTO> getTicketsByCustomer(int customerId, String filter) {
        List<CustomerTicketDTO> tickets = new ArrayList<>();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT ");
        sql.append("  MIN(T.ticket_code) AS orderCode, ");
        sql.append("  MIN(T.status) AS ticketStatus, ");
        sql.append("  O.payment_status AS paymentStatus, ");
        sql.append("  S.start_date AS startDate, ");
        sql.append("  S.end_date AS endDate, ");
        sql.append("  E.location AS location, ");
        sql.append("  E.event_name AS eventName ");
        sql.append("FROM Customers C ");
        sql.append("JOIN Orders O ON C.customer_id = O.customer_id ");
        sql.append("JOIN OrderDetails OD ON O.order_id = OD.order_id ");
        sql.append("JOIN Ticket T ON OD.order_detail_id = T.order_detail_id ");
        sql.append("JOIN Seats SE ON T.seat_id = SE.seat_id ");
        sql.append("JOIN TicketTypes TT ON SE.ticket_type_id = TT.ticket_type_id ");
        sql.append("JOIN Showtimes S ON TT.showtime_id = S.showtime_id ");
        sql.append("JOIN Events E ON S.event_id = E.event_id ");
        sql.append("WHERE C.customer_id = ? ");

        // Điều kiện lọc nếu không phải 'all'
        if (filter != null && !filter.equalsIgnoreCase("all")) {
            if (filter.equalsIgnoreCase("paid") || filter.equalsIgnoreCase("pending")) {
                sql.append("AND LOWER(O.payment_status) = ? ");
            } else if (filter.equalsIgnoreCase("upcoming")) {
                sql.append("AND S.start_date > CURRENT_TIMESTAMP ");
            } else if (filter.equalsIgnoreCase("past")) {
                sql.append("AND S.start_date < CURRENT_TIMESTAMP ");
            }
        }

        // Nhóm theo đơn hàng (order_id) để không tách thành nhiều card
        sql.append("GROUP BY O.order_id, O.payment_status, S.start_date, S.end_date, E.location, E.event_name ");
        sql.append("ORDER BY S.start_date");

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            stmt.setInt(1, customerId);
            if (filter != null && (filter.equalsIgnoreCase("paid") || filter.equalsIgnoreCase("pending"))) {
                stmt.setString(2, filter.toLowerCase());
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                CustomerTicketDTO ticket = new CustomerTicketDTO();
                ticket.setOrderCode(rs.getString("orderCode"));
                ticket.setTicketStatus(rs.getString("ticketStatus"));
                ticket.setPaymentStatus(rs.getString("paymentStatus"));
                ticket.setStartDate(rs.getTimestamp("startDate"));
                ticket.setEndDate(rs.getTimestamp("endDate"));
                ticket.setLocation(rs.getString("location"));
                ticket.setEventName(rs.getString("eventName"));
                tickets.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

}
