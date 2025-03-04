package dals;

import models.Event;
import models.EventAdmin;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventAdminDAO extends DBContext {

    public EventAdmin getEventDetailById(int eventId) {
        EventAdmin event = null;
        String sql = "SELECT E.event_id, E.event_name, C.category_name, O.organization_name, E.location, "
                + "E.event_type, E.status, E.description, MIN(ST.start_date) AS start_date, MIN(ST.end_date) AS end_date, "
                + "E.created_at AS createdAt, E.updated_at AS updatedAt, "
                + "STRING_AGG(CONVERT(varchar, EI.image_id), ',') WITHIN GROUP (ORDER BY EI.image_id) AS image_ids, "
                + "STRING_AGG(EI.image_url, ', ') WITHIN GROUP (ORDER BY EI.image_id) AS image_urls, "
                + "STRING_AGG(EI.image_title, ', ') WITHIN GROUP (ORDER BY EI.image_id) AS image_titles "
                + "FROM Events E "
                + "LEFT JOIN Categories C ON E.category_id = C.category_id "
                + "LEFT JOIN Organizers O ON E.organizer_id = O.organizer_id "
                + "LEFT JOIN Showtimes ST ON E.event_id = ST.event_id "
                + "LEFT JOIN EventImages EI ON E.event_id = EI.event_id "
                + "WHERE E.event_id = ? "
                + "GROUP BY E.event_id, E.event_name, C.category_name, O.organization_name, E.location, E.event_type, "
                + "E.status, E.description, E.created_at, E.updated_at";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                event = new EventAdmin();
                event.setEventId(rs.getInt("event_id"));
                event.setEventName(rs.getString("event_name"));
                event.setCategoryName(rs.getString("category_name"));
                event.setOrganizationName(rs.getString("organization_name"));
                event.setLocation(rs.getString("location"));
                event.setEventType(rs.getString("event_type"));
                event.setStatus(rs.getString("status"));
                event.setDescription(rs.getString("description"));
                event.setStartDate(rs.getDate("start_date"));
                event.setEndDate(rs.getDate("end_date"));
                event.setCreatedAt(rs.getDate("createdAt"));
                event.setUpdatedAt(rs.getDate("updatedAt"));
                event.setImageIds(rs.getString("image_ids"));
                event.setImageUrls(rs.getString("image_urls"));
                event.setImageTitles(rs.getString("image_titles"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return event;
    }

    public List<Event> getAllEvents(int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }

        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "ei.image_url AS imageURL, ei.image_title AS imageTitle "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "ORDER BY e.event_name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi lấy danh sách sự kiện: " + e.getMessage());
        }
        return events;
    }

    public List<Event> getEventsByStatus(String status, int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }

        // Nếu trạng thái là "Active" (đã duyệt), sắp xếp theo updated_at giảm dần (ngày duyệt gần nhất)
        String orderByClause = "ORDER BY e.event_name ";
        if ("Active".equals(status)) {
            orderByClause = "ORDER BY e.updated_at DESC ";
        }

        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "ei.image_url AS imageURL, ei.image_title AS imageTitle "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = ? "
                + orderByClause
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi lấy sự kiện theo trạng thái: " + e.getMessage());
        }
        return events;
    }

    public int getTotalEvents() {
        String sql = "SELECT COUNT(*) FROM Events";
        return getTotalCount(sql);
    }

    public int getTotalEventsByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM Events WHERE status = ?";
        return getTotalCountWithParam(sql, status);
    }

    private int getTotalCount(String sql) {
        if (connection == null) {
            return 0;
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi đếm sự kiện: " + e.getMessage());
        }
        return 0;
    }

    private int getTotalCountWithParam(String sql, String param) {
        if (connection == null) {
            return 0;
        }
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, param);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi đếm sự kiện theo trạng thái: " + e.getMessage());
        }
        return 0;
    }

    private Event mapResultSetToEvent(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setEventId(rs.getInt("event_id"));
        event.setEventName(rs.getString("event_name"));
        event.setLocation(rs.getString("location"));
        event.setEventType(rs.getString("event_type"));
        event.setStatus(rs.getString("status"));
        event.setImageURL(rs.getString("imageURL"));
        event.setImageTitle(rs.getString("imageTitle"));
        return event;
    }

    // Phương thức cập nhật trạng thái sự kiện (chỉ cập nhật nếu sự kiện đang ở trạng thái 'Pending')
    // newStatus: "Active" (Accept) hoặc "Rejected" (Reject)
    public EventAdmin updateEventStatus(int eventId, String newStatus) {
        String sql = "UPDATE Events SET status = ?, updated_at = GETDATE() WHERE event_id = ? AND status = 'Pending'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, eventId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected); // Debug log
            if (rowsAffected > 0) {
                // Sau khi cập nhật thành công, lấy lại chi tiết sự kiện dưới dạng EventAdmin
                return getEventDetailById(eventId);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi cập nhật trạng thái sự kiện: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }
}
