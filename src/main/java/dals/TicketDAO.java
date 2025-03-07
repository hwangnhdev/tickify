package dals;

import models.Ticket;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TicketDAO extends DBContext{
    
    private static final String INSERT_TICKET = 
        "INSERT INTO Ticket (order_detail_id, seat_id, ticket_code, price, status, created_at, updated_at) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?)";

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

    /**
     * Lấy danh sách vé theo order_id.
     */
    public List<Ticket> getTicketsByOrderId(int orderId) {
        List<Ticket> tickets = new ArrayList<>();
        String query = "SELECT ticket_id, order_detail_id, seat_id, ticket_code, price, status, created_at, updated_at " +
                       "FROM Tickets WHERE order_detail_id = ?";
        try (Connection conn = new DBContext().connection;
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Ticket ticket = new Ticket();
                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setOrderDetailId(rs.getInt("order_detail_id"));
                ticket.setSeatId(rs.getInt("seat_id"));
                ticket.setTicketCode(rs.getString("ticket_code"));
                ticket.setPrice(rs.getDouble("price"));
                ticket.setStatus(rs.getString("status"));
                ticket.setCreatedAt(rs.getTimestamp("created_at"));
                ticket.setUpdatedAt(rs.getTimestamp("updated_at"));
                tickets.add(ticket);
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }
    
    /**
     * Lấy chi tiết vé theo ticketId.
     */
    public Ticket getTicketById(int ticketId) {
        Ticket ticket = null;
        String query = "SELECT ticket_id, order_detail_id, seat_id, ticket_code, price, status, created_at, updated_at " +
                       "FROM Tickets WHERE ticket_id = ?";
        try (Connection conn = new DBContext().connection;
             PreparedStatement ps = conn.prepareStatement(query)) {
             
            ps.setInt(1, ticketId);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                ticket = new Ticket();
                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setOrderDetailId(rs.getInt("order_detail_id"));
                ticket.setSeatId(rs.getInt("seat_id"));
                ticket.setTicketCode(rs.getString("ticket_code"));
                ticket.setPrice(rs.getDouble("price"));
                ticket.setStatus(rs.getString("status"));
                ticket.setCreatedAt(rs.getTimestamp("created_at"));
                ticket.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return ticket;
    }
}
