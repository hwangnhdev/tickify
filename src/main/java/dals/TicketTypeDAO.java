package dals;

import models.TicketType;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TicketTypeDAO extends DBContext {

    private static final String SELECT_TICKETTYPE_BY_SHOWTIME_ID = "SELECT * FROM TicketTypes tt WHERE tt.showtime_id = ?;";

    public List<TicketType> selectTicketTypeByShowtimeId(int showtimeId) {

        List<TicketType> ticketTypes = new ArrayList<>();

        try ( PreparedStatement st = connection.prepareStatement(SELECT_TICKETTYPE_BY_SHOWTIME_ID)) {
            st.setInt(1, showtimeId);

            try ( ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    TicketType ticketType = new TicketType();
                    ticketType.setTicketTypeId(rs.getInt("ticket_type_id"));
                    ticketType.setShowtimeId(rs.getInt("showtime_id"));
                    ticketType.setName(rs.getString("name"));
                    ticketType.setDescription(rs.getString("description"));
                    ticketType.setPrice(rs.getDouble("price"));
                    ticketType.setColor(rs.getString("color"));
                    ticketType.setTotalQuantity(rs.getInt("total_quantity"));
                    ticketType.setSoldQuantity(rs.getInt("sold_quantity"));

                    ticketTypes.add(ticketType);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ticketTypes;
    }

    public TicketType getTicketTypeByName(String name) {
        TicketType ticketType = new TicketType();
        String sql = "SELECT * FROM TicketTypes WHERE name = ?";

        try ( PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, name);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                ticketType.setTicketTypeId(rs.getInt("ticket_type_id"));
                ticketType.setShowtimeId(rs.getInt("showtime_id"));
                ticketType.setName(rs.getString("name"));
                ticketType.setDescription(rs.getString("description"));
                ticketType.setPrice(rs.getDouble("price"));
                ticketType.setColor(rs.getString("color"));
                ticketType.setTotalQuantity(rs.getInt("total_quantity"));
                ticketType.setSoldQuantity(rs.getInt("sold_quantity"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return ticketType;
    }

}

//    /**
//     * Lấy thông tin TicketType theo ticketTypeId.
//     */
//    public TicketType getTicketTypeById(int ticketTypeId) {
//        TicketType ticketType = null;
//        String query = "SELECT ticket_type_id, event_id, name, description, price, totalQuantity, soldQuantity, createdAt, updatedAt " +
//                       "FROM TicketTypes WHERE ticket_type_id = ?";
//        try (Connection conn = new DBContext().connection;
//             PreparedStatement ps = conn.prepareStatement(query)) {
//             
//            ps.setInt(1, ticketTypeId);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                ticketType = new TicketType();
//                ticketType.setTicketTypeId(rs.getInt("ticket_type_id"));
//                ticketType.setShowtimeId(rs.getInt("showtime_id"));
//                ticketType.setName(rs.getString("name"));
//                ticketType.setDescription(rs.getString("description"));
//                ticketType.setPrice(rs.getDouble("price"));
//                ticketType.setTotalQuantity(rs.getInt("totalQuantity"));
//                ticketType.setSoldQuantity(rs.getInt("soldQuantity"));
//                ticketType.setCreatedAt(rs.getDate("createdAt"));
//                ticketType.setUpdatedAt(rs.getDate("updatedAt"));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return ticketType;
//    }
//    
//    /**
//     * Lấy danh sách TicketTypes theo eventId.
//     */
//    public List<TicketType> getTicketTypesByEventId(int eventId) {
//        List<TicketType> list = new ArrayList<>();
//        String query = "SELECT ticket_type_id, showtime_id, name, description, price, totalQuantity, soldQuantity, createdAt, updatedAt " +
//                       "FROM TicketTypes WHERE event_id = ?";
//        try (Connection conn = new DBContext().connection;
//             PreparedStatement ps = conn.prepareStatement(query)) {
//             
//            ps.setInt(1, eventId);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                TicketType tt = new TicketType();
//                tt.setTicketTypeId(rs.getInt("ticket_type_id"));
//                tt.setShowtimeId(rs.getInt("showtime_id"));
//                tt.setName(rs.getString("name"));
//                tt.setDescription(rs.getString("description"));
//                tt.setPrice(rs.getDouble("price"));
//                tt.setTotalQuantity(rs.getInt("totalQuantity"));
//                tt.setSoldQuantity(rs.getInt("soldQuantity"));
//                tt.setCreatedAt(rs.getDate("createdAt"));
//                tt.setUpdatedAt(rs.getDate("updatedAt"));
//                list.add(tt);
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return list;
//    }

