package dals;

import models.Ticket;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TicketDAO {

    /**
     * Lấy danh sách vé theo order_id.
     */
    public List<Ticket> getTicketsByOrderId(int orderId) {
        List<Ticket> tickets = new ArrayList<>();
        String query = "SELECT ticket_id, order_detail_id, seat_id, ticket_code, price, status, check_in_datetime, created_at, updated_at " +
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
                ticket.setCheckInDatetime(rs.getDate("check_in_datetime"));
                ticket.setCreatedAt(rs.getDate("created_at"));
                ticket.setUpdatedAt(rs.getDate("updated_at"));
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
        String query = "SELECT ticket_id, order_detail_id, seat_id, ticket_code, price, status, check_in_datetime, created_at, updated_at " +
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
                ticket.setCheckInDatetime(rs.getDate("check_in_datetime"));
                ticket.setCreatedAt(rs.getDate("created_at"));
                ticket.setUpdatedAt(rs.getDate("updated_at"));
            }
        } catch(SQLException e) {
            e.printStackTrace();
        }
        return ticket;
    }
}
