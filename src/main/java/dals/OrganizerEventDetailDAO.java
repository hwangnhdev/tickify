<<<<<<< HEAD
//package dals;
//
//
//import utils.DBContext;
//import java.sql.*;
//import models.OrganizerEventDetailDTO;
//
//public class OrganizerEventDetailDAO extends DBContext {
//
//    /**
//     * Retrieves event detail for a given organizer and event.
//     *
//     * @param organizerId the organizer's ID.
//     * @param eventId the event's ID.
//     * @return OrganizerEventDetailDTO containing event detail, or null if not found.
//     */
//    public OrganizerEventDetailDTO getOrganizerEventDetail(int organizerId, int eventId) {
//        OrganizerEventDetailDTO detail = null;
//        String sql = "SELECT " +
//                     "    e.event_id AS eventId, " +
//                     "    e.event_name AS eventName, " +
//                     "    MIN(s.start_date) AS startDate, " +
//                     "    MAX(s.end_date) AS endDate, " +
//                     "    e.location AS location, " +
//                     "    ( " +
//                     "        SELECT TOP 1 o.payment_status " +
//                     "        FROM Orders o " +
//                     "        JOIN OrderDetails od ON o.order_id = od.order_id " +
//                     "        JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id " +
//                     "        JOIN Showtimes s2 ON tt.showtime_id = s2.showtime_id " +
//                     "        WHERE s2.event_id = e.event_id " +
//                     "        ORDER BY o.created_at DESC " +
//                     "    ) AS paymentStatus, " +
//                     "    e.status AS status, " +
//                     "    e.description AS description, " +
//                     "    ( " +
//                     "        SELECT TOP 1 image_url " +
//                     "        FROM EventImages " +
//                     "        WHERE event_id = e.event_id " +
//                     "        ORDER BY image_id " +
//                     "    ) AS imageURL, " +
//                     "    org.organization_name AS organizationName " +
//                     "FROM Events e " +
//                     "JOIN Organizers org ON e.organizer_id = org.organizer_id " +
//                     "JOIN Showtimes s ON e.event_id = s.event_id " +
//                     "WHERE org.organizer_id = ? AND e.event_id = ? " +
//                     "GROUP BY e.event_id, e.event_name, e.location, e.status, e.description, org.organization_name";
//        
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, organizerId);
//            ps.setInt(2, eventId);
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                detail = new OrganizerEventDetailDTO();
//                detail.setEventId(rs.getInt("eventId"));
//                detail.setEventName(rs.getString("eventName"));
//                detail.setStartDate(rs.getDate("startDate"));
//                detail.setEndDate(rs.getDate("endDate"));
//                detail.setLocation(rs.getString("location"));
//                detail.setPaymentStatus(rs.getString("paymentStatus"));
//                detail.setStatus(rs.getString("status"));
//                detail.setDescription(rs.getString("description"));
//                detail.setImageURL(rs.getString("imageURL"));
//                detail.setOrganizationName(rs.getString("organizationName"));
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//        }
//        return detail;
//    }
//}
=======
package dals;


import utils.DBContext;
import java.sql.*;
import models.OrganizerEventDetailDTO;

public class OrganizerEventDetailDAO extends DBContext {

    /**
     * Retrieves event detail for a given organizer and event.
     *
     * @param organizerId the organizer's ID.
     * @param eventId the event's ID.
     * @return OrganizerEventDetailDTO containing event detail, or null if not found.
     */
    public OrganizerEventDetailDTO getOrganizerEventDetail(int organizerId, int eventId) {
        OrganizerEventDetailDTO detail = null;
        String sql = "SELECT " +
                     "    e.event_id AS eventId, " +
                     "    e.event_name AS eventName, " +
                     "    MIN(s.start_date) AS startDate, " +
                     "    MAX(s.end_date) AS endDate, " +
                     "    e.location AS location, " +
                     "    ( " +
                     "        SELECT TOP 1 o.payment_status " +
                     "        FROM Orders o " +
                     "        JOIN OrderDetails od ON o.order_id = od.order_id " +
                     "        JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id " +
                     "        JOIN Showtimes s2 ON tt.showtime_id = s2.showtime_id " +
                     "        WHERE s2.event_id = e.event_id " +
                     "        ORDER BY o.created_at DESC " +
                     "    ) AS paymentStatus, " +
                     "    e.status AS status, " +
                     "    e.description AS description, " +
                     "    ( " +
                     "        SELECT TOP 1 image_url " +
                     "        FROM EventImages " +
                     "        WHERE event_id = e.event_id " +
                     "        ORDER BY image_id " +
                     "    ) AS imageURL, " +
                     "    org.organization_name AS organizationName " +
                     "FROM Events e " +
                     "JOIN Organizers org ON e.organizer_id = org.organizer_id " +
                     "JOIN Showtimes s ON e.event_id = s.event_id " +
                     "WHERE org.organizer_id = ? AND e.event_id = ? " +
                     "GROUP BY e.event_id, e.event_name, e.location, e.status, e.description, org.organization_name";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, organizerId);
            ps.setInt(2, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                detail = new OrganizerEventDetailDTO();
                detail.setEventId(rs.getInt("eventId"));
                detail.setEventName(rs.getString("eventName"));
                detail.setStartDate(rs.getDate("startDate"));
                detail.setEndDate(rs.getDate("endDate"));
                detail.setLocation(rs.getString("location"));
                detail.setPaymentStatus(rs.getString("paymentStatus"));
                detail.setStatus(rs.getString("status"));
                detail.setDescription(rs.getString("description"));
                detail.setImageURL(rs.getString("imageURL"));
                detail.setOrganizationName(rs.getString("organizationName"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detail;
    }
}
>>>>>>> 585b0290f07709a285fc8c831893312cd6e42e68
