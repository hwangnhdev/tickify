package dals;

import models.Event;
import models.EventAdmin;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EventAdminDAO extends DBContext {

    //////////////////////////
    // Event Detail Section //
    //////////////////////////
    // Lấy chi tiết sự kiện dưới dạng EventAdmin (dùng cho admin)
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
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /////////////////////////////
    // View All Events Section //
    /////////////////////////////
    // Lấy danh sách tất cả sự kiện (dùng cho chức năng view all)
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
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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

    ////////////////////////////////
    // Filter Events by Status Section //
    ////////////////////////////////
    // Lấy danh sách sự kiện theo trạng thái (dùng cho chức năng filter)
    public List<Event> getEventsByStatus(String status, int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String orderByClause = "ORDER BY e.event_name ";
        if ("Active".equalsIgnoreCase(status)) {
            orderByClause = "ORDER BY e.updated_at DESC ";
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "ei.image_url AS imageURL, ei.image_title AS imageTitle "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = ? "
                + orderByClause
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /////////////////////////////////////
    // Approved Events (View Approved) //
    /////////////////////////////////////
    // Lấy danh sách sự kiện đã duyệt (Active)
    // Trả về danh sách đối tượng EventAdmin với trường approvedAt lấy từ updated_at
    public List<EventAdmin> getApprovedEvents(int page, int pageSize) {
        List<EventAdmin> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.updated_at AS approvedAt, "
                + "ei.image_url AS imageURL, ei.image_title AS imageTitle "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = 'active' "
                + "ORDER BY e.updated_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                events.add(mapResultSetToApprovedEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi lấy danh sách sự kiện approved: " + e.getMessage());
        }
        return events;
    }

    // Đếm tổng số sự kiện đã duyệt (Active)
    public int getTotalApprovedEvents() {
        String sql = "SELECT COUNT(*) FROM Events WHERE status = 'active'";
        return getTotalCount(sql);
    }

    /////////////////////////////////
    // History Approved Events Section //
    /////////////////////////////////
    // Lấy danh sách lịch sử sự kiện đã duyệt (Completed)
    public List<EventAdmin> getHistoryApprovedEvents(int page, int pageSize) {
        List<EventAdmin> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        // Giả sử trạng thái 'active' thể hiện lịch sử sự kiện đã duyệt
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.updated_at AS approvedAt, "
                + "ei.image_url AS imageURL, ei.image_title AS imageTitle "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = 'active' "
                + "ORDER BY e.updated_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                events.add(mapResultSetToApprovedEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi lấy danh sách lịch sử sự kiện approved: " + e.getMessage());
        }
        return events;
    }

    // Đếm tổng số lịch sử sự kiện đã duyệt (Completed)
    public int getTotalHistoryApprovedEvents() {
        String sql = "SELECT COUNT(*) FROM Events WHERE status = 'active'";
        return getTotalCount(sql);
    }

    ///////////////////////////////
    // Count Methods Section       //
    ///////////////////////////////
    // Đếm tổng số sự kiện (cho view all)
    public int getTotalEvents() {
        String sql = "SELECT COUNT(*) FROM Events";
        return getTotalCount(sql);
    }

    // Đếm tổng số sự kiện theo trạng thái (cho filter)
    public int getTotalEventsByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM Events WHERE status = ?";
        return getTotalCountWithParam(sql, status);
    }

    // Phương thức chung đếm số bản ghi
    private int getTotalCount(String sql) {
        if (connection == null) {
            return 0;
        }
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi đếm sự kiện: " + e.getMessage());
        }
        return 0;
    }

    // Phương thức chung đếm số bản ghi với tham số
    private int getTotalCountWithParam(String sql, String param) {
        if (connection == null) {
            return 0;
        }
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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

    ////////////////////////
    // Mapping Methods    //
    ////////////////////////
    // Mapping cho các truy vấn không trả về approvedAt (dành cho đối tượng Event)
    private Event mapResultSetToEvent(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setEventId(rs.getInt("event_id"));
        event.setEventName(rs.getString("event_name"));
        event.setLocation(rs.getString("location"));
        event.setEventType(rs.getString("event_type"));
        event.setStatus(rs.getString("status"));
        return event;
    }

    // Mapping cho truy vấn trả về approvedAt (dành cho đối tượng EventAdmin)
    private EventAdmin mapResultSetToApprovedEvent(ResultSet rs) throws SQLException {
        EventAdmin event = new EventAdmin();
        event.setEventId(rs.getInt("event_id"));
        event.setEventName(rs.getString("event_name"));
        event.setLocation(rs.getString("location"));
        event.setEventType(rs.getString("event_type"));
        event.setStatus(rs.getString("status"));
        event.setApprovedAt(rs.getTimestamp("approvedAt"));
        // Nếu cần, thiết lập thêm các trường ảnh từ result set
        return event;
    }

    ///////////////////////////////
    // Update Status Section     //
    ///////////////////////////////
    // Phương thức cập nhật trạng thái sự kiện (chỉ cập nhật nếu sự kiện đang ở trạng thái 'Pending')
    // newStatus: "Active" (Accept) hoặc "Rejected" (Reject)
    public EventAdmin updateEventStatus(int eventId, String newStatus) {
        String sql = "UPDATE Events SET status = ?, updated_at = GETDATE() WHERE event_id = ? AND status = 'Pending'";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, eventId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            if (rowsAffected > 0) {
                return getEventDetailById(eventId);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi cập nhật trạng thái sự kiện: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    ///////////////////////////////
    // Search Methods Section      //
    ///////////////////////////////
    // Tìm kiếm sự kiện theo tên (không phân biệt trạng thái)
    public List<Event> searchEventsByName(String keyword, int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "ei.image_url AS imageURL, ei.image_title AS imageTitle "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.event_name LIKE ? "
                + "ORDER BY e.event_name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm kiếm sự kiện theo tên: " + e.getMessage());
        }
        return events;
    }

    // Đếm tổng số sự kiện tìm kiếm được theo tên
    public int getTotalSearchEventsByName(String keyword) {
        String sql = "SELECT COUNT(*) FROM Events WHERE event_name LIKE ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi đếm số sự kiện theo tên: " + e.getMessage());
        }
        return 0;
    }

    // Tìm kiếm sự kiện đã duyệt theo tên (chỉ lấy các sự kiện có status = 'active')
    public List<EventAdmin> searchApprovedEventsByName(String keyword, int page, int pageSize) {
        List<EventAdmin> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.updated_at AS approvedAt, "
                + "ei.image_url AS imageURL, ei.image_title AS imageTitle "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.event_name LIKE ? AND e.status = 'active' "
                + "ORDER BY e.event_name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                events.add(mapResultSetToApprovedEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm kiếm sự kiện đã duyệt: " + e.getMessage());
        }
        return events;
    }

    // Đếm tổng số sự kiện đã duyệt theo từ khóa tìm kiếm
    public int getTotalSearchApprovedEventsByName(String keyword) {
        String sql = "SELECT COUNT(*) FROM Events WHERE event_name LIKE ? AND status = 'active'";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi đếm số sự kiện đã duyệt: " + e.getMessage());
        }
        return 0;
    }

    // Tìm kiếm lịch sử sự kiện theo tên (chỉ lấy các sự kiện có status = 'completed')
    public List<EventAdmin> searchHistoryEventsByName(String keyword, int page, int pageSize) {
        List<EventAdmin> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.updated_at AS approvedAt, "
                + "ei.image_url AS imageURL, ei.image_title AS imageTitle "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.event_name LIKE ? AND e.status = 'active' "
                + "ORDER BY e.event_name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                events.add(mapResultSetToApprovedEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm kiếm lịch sử sự kiện: " + e.getMessage());
        }
        return events;
    }

    // Đếm tổng số lịch sử sự kiện theo từ khóa tìm kiếm
    public int getTotalSearchHistoryApprovedEventsByName(String keyword) {
        String sql = "SELECT COUNT(*) FROM Events WHERE event_name LIKE ? AND status = ''";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi đếm số lịch sử sự kiện: " + e.getMessage());
        }
        return 0;
    }

    public EventAdmin getApprovedEventDetailById(int eventId) {
        EventAdmin event = null;
        String sql = "SELECT E.event_id, E.event_name, C.category_name, O.organization_name, E.location, "
                + "E.event_type, E.status, E.description, MIN(ST.start_date) AS start_date, MIN(ST.end_date) AS end_date, "
                + "E.created_at AS createdAt, E.updated_at AS updatedAt, E.updated_at AS approvedAt, " // Thêm approvedAt
                + "STRING_AGG(CONVERT(varchar, EI.image_id), ',') WITHIN GROUP (ORDER BY EI.image_id) AS image_ids, "
                + "STRING_AGG(EI.image_url, ',') WITHIN GROUP (ORDER BY EI.image_id) AS image_urls, " // Loại bỏ khoảng trắng thừa
                + "STRING_AGG(EI.image_title, ',') WITHIN GROUP (ORDER BY EI.image_id) AS image_titles " // Loại bỏ khoảng trắng thừa
                + "FROM Events E "
                + "LEFT JOIN Categories C ON E.category_id = C.category_id "
                + "LEFT JOIN Organizers O ON E.organizer_id = O.organizer_id "
                + "LEFT JOIN Showtimes ST ON E.event_id = ST.event_id "
                + "LEFT JOIN EventImages EI ON E.event_id = EI.event_id "
                + "WHERE E.event_id = ? AND E.status = 'active' "
                + "GROUP BY E.event_id, E.event_name, C.category_name, O.organization_name, E.location, E.event_type, "
                + "E.status, E.description, E.created_at, E.updated_at";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            System.out.println("Executing query for event ID: " + eventId); // Thêm log
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
                event.setApprovedAt(rs.getTimestamp("approvedAt")); // Sử dụng Timestamp cho approvedAt
                event.setImageIds(rs.getString("image_ids"));
                event.setImageUrls(rs.getString("image_urls"));
                event.setImageTitles(rs.getString("image_titles"));
                System.out.println("Event found: " + event.getEventName()); // Thêm log
            } else {
                System.out.println("No event found for ID: " + eventId); // Thêm log
            }
        } catch (SQLException e) {
            System.out.println("SQL Error for event ID " + eventId + ": " + e.getMessage());
            e.printStackTrace();
        }
        return event;
    }

}
