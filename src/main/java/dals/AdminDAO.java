/*
 * =============================================================================
 * AdminDAO.java
 * =============================================================================
 * Mô tả: Data Access Object (DAO) xử lý các thao tác truy vấn dữ liệu liên quan đến 
 *        các sự kiện (Events) và chi tiết sự kiện (EventDetailDTO) cho quản trị.
 * 
 * Tác giả: Duong Minh Kiet - CE180166
 * =============================================================================
 */
package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import models.Event;
import models.EventDetailDTO;
import models.EventImage;
import utils.DBContext;

public class AdminDAO extends DBContext {

    /////////////////////////////////////////////////////////////////////////
    //                      EVENT DETAIL SECTION                         //
    /////////////////////////////////////////////////////////////////////////
    /**
     * Lấy chi tiết sự kiện theo ID (bao gồm thông tin các ảnh liên quan)
     *
     * @param eventId ID của sự kiện
     * @return đối tượng EventDetailDTO chứa thông tin chi tiết của sự kiện
     */
    public EventDetailDTO getEventDetailById(int eventId) {
        EventDetailDTO eventDetail = new EventDetailDTO();
        // Truy vấn lấy thông tin sự kiện, join thêm các bảng liên quan: Categories, Organizers, Showtimes và EventImages
        String sql = "SELECT E.event_id, E.event_name, C.category_name, O.organization_name, E.location, "
                + "E.event_type, E.status, E.description, "
                + "MIN(ST.start_date) AS startDate, MAX(ST.end_date) AS endDate, "
                + "E.created_at AS createdAt, E.updated_at AS updatedAt, "
                // Nối các URL ảnh bằng dấu phẩy nếu có nhiều ảnh
                + "STRING_AGG(EI.image_url, ',') AS image_urls "
                + "FROM Events E "
                + "LEFT JOIN Categories C ON E.category_id = C.category_id "
                + "LEFT JOIN Organizers O ON E.organizer_id = O.organizer_id "
                + "LEFT JOIN Showtimes ST ON E.event_id = ST.event_id "
                + "LEFT JOIN EventImages EI ON E.event_id = EI.event_id "
                + "WHERE E.event_id = ? "
                + "GROUP BY E.event_id, E.event_name, C.category_name, O.organization_name, "
                + "E.location, E.event_type, E.status, E.description, E.created_at, E.updated_at";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                // Gán các giá trị từ ResultSet vào DTO
                eventDetail.setEventId(rs.getInt("event_id"));
                eventDetail.setEventName(rs.getString("event_name"));
                eventDetail.setCategoryName(rs.getString("category_name"));
                eventDetail.setOrganizationName(rs.getString("organization_name"));
                eventDetail.setLocation(rs.getString("location"));
                eventDetail.setEventType(rs.getString("event_type"));
                eventDetail.setStatus(rs.getString("status"));
                eventDetail.setDescription(rs.getString("description"));
                eventDetail.setStartDate(rs.getTimestamp("startDate"));
                eventDetail.setEndDate(rs.getTimestamp("endDate"));
                eventDetail.setCreatedAt(rs.getTimestamp("createdAt"));
                eventDetail.setUpdatedAt(rs.getTimestamp("updated_at"));
                // Chuyển đổi chuỗi image_urls thành danh sách List<String>
                String imageUrlsStr = rs.getString("image_urls");
                if (imageUrlsStr != null && !imageUrlsStr.trim().isEmpty()) {
                    List<String> imageUrls = Arrays.asList(imageUrlsStr.split(","));
                    eventDetail.setImageUrls(imageUrls);
                }
                // Chưa có dữ liệu cho approvedAt, thiết lập tạm null (có thể cập nhật theo nghiệp vụ)
                eventDetail.setApprovedAt(null);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return eventDetail;
    }

    public List<EventImage> getImageEventsByEventId(int eventId) {
        List<EventImage> list = new ArrayList<>();
        String sql = "SELECT image_url, image_title FROM EventImages WHERE event_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    EventImage image = new EventImage();
                    image.setImageUrl(rs.getString("image_url"));
                    image.setImageTitle(rs.getString("image_title"));
                    list.add(image);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Cập nhật trạng thái của sự kiện (chỉ cập nhật nếu trạng thái hiện tại là
     * 'Pending')
     *
     * @param eventId ID của sự kiện
     * @param newStatus Trạng thái mới ("Active" hoặc "Rejected")
     * @return đối tượng EventDetailDTO sau khi cập nhật trạng thái, hoặc null
     * nếu thất bại
     */
    public EventDetailDTO updateEventStatus(int eventId, String newStatus) {
        String sql = "UPDATE Events SET status = ?, updated_at = GETDATE() WHERE event_id = ? AND status = 'Pending'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, eventId);
            int rowsAffected = ps.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);
            if (rowsAffected > 0) {
                // Nếu cập nhật thành công, lấy lại chi tiết sự kiện
                return getEventDetailById(eventId);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi cập nhật trạng thái sự kiện: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Lấy chi tiết sự kiện đã duyệt (Active) theo ID
     *
     * @param eventId ID của sự kiện
     * @return đối tượng EventDetailDTO chứa thông tin chi tiết của sự kiện đã
     * duyệt
     */
    public EventDetailDTO getApprovedEventDetailById(int eventId) {
        EventDetailDTO eventDetail = null;
        String sql = "SELECT E.event_id, E.event_name, C.category_name, O.organization_name, E.location, "
                + "E.event_type, E.status, E.description, "
                + "MIN(ST.start_date) AS startDate, MAX(ST.end_date) AS endDate, "
                + "E.created_at AS createdAt, E.updated_at AS updatedAt, E.updated_at AS approvedAt, "
                + "STRING_AGG(EI.image_url, ',') AS image_urls "
                + "FROM Events E "
                + "LEFT JOIN Categories C ON E.category_id = C.category_id "
                + "LEFT JOIN Organizers O ON E.organizer_id = O.organizer_id "
                + "LEFT JOIN Showtimes ST ON E.event_id = ST.event_id "
                + "LEFT JOIN EventImages EI ON E.event_id = EI.event_id "
                + "WHERE E.event_id = ? AND E.status = 'active' "
                + "GROUP BY E.event_id, E.event_name, C.category_name, O.organization_name, "
                + "E.location, E.event_type, E.status, E.description, E.created_at, E.updated_at";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                eventDetail = new EventDetailDTO();
                eventDetail.setEventId(rs.getInt("event_id"));
                eventDetail.setEventName(rs.getString("event_name"));
                eventDetail.setCategoryName(rs.getString("category_name"));
                eventDetail.setOrganizationName(rs.getString("organization_name"));
                eventDetail.setLocation(rs.getString("location"));
                eventDetail.setEventType(rs.getString("event_type"));
                eventDetail.setStatus(rs.getString("status"));
                eventDetail.setDescription(rs.getString("description"));
                eventDetail.setStartDate(rs.getTimestamp("startDate"));
                eventDetail.setEndDate(rs.getTimestamp("endDate"));
                eventDetail.setCreatedAt(rs.getTimestamp("createdAt"));
                eventDetail.setUpdatedAt(rs.getTimestamp("updatedAt"));
                // Chuyển đổi approvedAt từ Timestamp sang Date
                Timestamp approvedTs = rs.getTimestamp("approvedAt");
                if (approvedTs != null) {
                    eventDetail.setApprovedAt(new Timestamp(approvedTs.getTime()));
                }
                // Xử lý chuỗi image_urls thành List<String>
                String imageUrlsStr = rs.getString("image_urls");
                if (imageUrlsStr != null && !imageUrlsStr.trim().isEmpty()) {
                    List<String> imageUrls = Arrays.asList(imageUrlsStr.split(","));
                    eventDetail.setImageUrls(imageUrls);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return eventDetail;
    }

    /////////////////////////////////////////////////////////////////////////
    //                        VIEW ALL EVENTS SECTION                      //
    /////////////////////////////////////////////////////////////////////////
    /**
     * Lấy danh sách tất cả sự kiện (dùng cho chức năng View All)
     *
     * @param page Số trang hiện tại
     * @param pageSize Số bản ghi trên mỗi trang
     * @return danh sách các sự kiện
     */
    public List<Event> getAllEvents(int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "  (SELECT STRING_AGG(image_url, ',') "
                + "   FROM (SELECT DISTINCT image_url FROM EventImages WHERE event_id = e.event_id) AS imgUrls) AS imageURLs, "
                + "  (SELECT STRING_AGG(image_title, ',') "
                + "   FROM (SELECT DISTINCT image_title FROM EventImages WHERE event_id = e.event_id) AS imgTitles) AS imageTitles "
                + "FROM Events e "
                + "ORDER BY e.event_name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /////////////////////////////////////////////////////////////////////////
    //                    FILTER EVENTS BY STATUS SECTION                //
    /////////////////////////////////////////////////////////////////////////
    /**
     * Lấy danh sách sự kiện theo trạng thái (dùng cho chức năng Filter)
     *
     * @param status Trạng thái của sự kiện (ví dụ: Active)
     * @param page Số trang hiện tại
     * @param pageSize Số bản ghi trên mỗi trang
     * @return danh sách các sự kiện theo trạng thái
     */
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
                + "  (SELECT STRING_AGG(image_url, ',') "
                + "   FROM (SELECT DISTINCT image_url FROM EventImages WHERE event_id = e.event_id) AS imgUrls) AS imageURLs, "
                + "  (SELECT STRING_AGG(image_title, ',') "
                + "   FROM (SELECT DISTINCT image_title FROM EventImages WHERE event_id = e.event_id) AS imgTitles) AS imageTitles "
                + "FROM Events e "
                + "WHERE LOWER(e.status) = LOWER(?) "
                + orderByClause
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /////////////////////////////////////////////////////////////////////////
    //                   APPROVED & HISTORY EVENTS SECTION               //
    /////////////////////////////////////////////////////////////////////////
    /**
     * Lấy danh sách các sự kiện đã duyệt (Active) với thông tin approvedAt lấy
     * từ updated_at
     *
     * @param page Số trang hiện tại
     * @param pageSize Số bản ghi trên mỗi trang
     * @return danh sách các sự kiện đã duyệt
     */
    public List<Event> getApprovedEvents(int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.updated_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = 'active' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.updated_at "
                + "ORDER BY e.updated_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /**
     * Lấy danh sách lịch sử sự kiện đã duyệt (giả sử trạng thái 'active' thể
     * hiện lịch sử đã duyệt)
     *
     * @param page Số trang hiện tại
     * @param pageSize Số bản ghi trên mỗi trang
     * @return danh sách lịch sử các sự kiện đã duyệt
     */
    public List<Event> getHistoryApprovedEvents(int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.updated_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = 'active' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.updated_at "
                + "ORDER BY e.updated_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /**
     * Đếm tổng số sự kiện đã duyệt (Active)
     *
     * @return số lượng sự kiện đã duyệt
     */
    public int getTotalApprovedEvents() {
        String sql = "SELECT COUNT(*) FROM Events WHERE status = 'active'";
        return getTotalCount(sql);
    }

    /**
     * Đếm tổng số lịch sử sự kiện đã duyệt (Completed)
     *
     * @return số lượng lịch sử sự kiện đã duyệt
     */
    public int getTotalHistoryApprovedEvents() {
        String sql = "SELECT COUNT(*) FROM Events WHERE status = 'active'";
        return getTotalCount(sql);
    }

    /////////////////////////////////////////////////////////////////////////
    //                          COUNT METHODS SECTION                      //
    /////////////////////////////////////////////////////////////////////////
    /**
     * Đếm tổng số sự kiện có banner (Distinct Events)
     *
     * @return số lượng sự kiện
     */
    public int getTotalDistinctEvents() {
        String sql = "SELECT COUNT(DISTINCT e.event_id) \n"
                + "FROM Events e\n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%banner%';";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting distinct events: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Đếm tổng số sự kiện trong bảng Events
     *
     * @return số lượng tất cả sự kiện
     */
    public int getTotalAllEvents() {
        String sql = "SELECT COUNT(*) FROM Events";
        return getTotalCount(sql);
    }

    /**
     * Đếm tổng số sự kiện theo trạng thái (cho chức năng Filter)
     *
     * @param status trạng thái của sự kiện
     * @return số lượng sự kiện theo trạng thái
     */
    public int getTotalEventsByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM Events WHERE status = ?";
        return getTotalCountWithParam(sql, status);
    }

    /**
     * Đếm tổng số sự kiện có banner (trước đây là getTotalEvents)
     *
     * @return số lượng sự kiện có banner
     */
    public int getTotalEvents() {
        String sql = "SELECT COUNT(DISTINCT e.event_id) \n"
                + "FROM Events e\n"
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id AND ei.image_title LIKE '%banner%';";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting events: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Phương thức chung đếm số bản ghi (không có tham số)
     *
     * @param sql truy vấn đếm
     * @return số lượng bản ghi
     */
    private int getTotalCount(String sql) {
        if (connection == null) {
            return 0;
        }
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi đếm sự kiện: " + e.getMessage());
        }
        return 0;
    }

    /**
     * Phương thức chung đếm số bản ghi với tham số
     *
     * @param sql truy vấn đếm
     * @param param tham số cho truy vấn
     * @return số lượng bản ghi
     */
    private int getTotalCountWithParam(String sql, String param) {
        if (connection == null) {
            return 0;
        }
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /////////////////////////////////////////////////////////////////////////
    //                        MAPPING METHODS SECTION                      //
    /////////////////////////////////////////////////////////////////////////
    /**
     * Mapping kết quả truy vấn (ResultSet) sang đối tượng Event (không có
     * trường approvedAt)
     *
     * @param rs ResultSet từ truy vấn
     * @return đối tượng Event được ánh xạ
     * @throws SQLException nếu có lỗi trong quá trình mapping
     */
    private Event mapResultSetToEvent(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setEventId(rs.getInt("event_id"));
        event.setEventName(rs.getString("event_name"));
        event.setLocation(rs.getString("location"));
        event.setEventType(rs.getString("event_type"));
        event.setStatus(rs.getString("status"));
        // Có thể bổ sung thêm các trường như description, createdAt, updatedAt nếu cần
        return event;
    }

    /**
     * Mapping kết quả truy vấn (ResultSet) sang đối tượng Event (có trường
     * approvedAt)
     *
     * @param rs ResultSet từ truy vấn
     * @return đối tượng Event được ánh xạ với trường approvedAt
     * @throws SQLException nếu có lỗi trong quá trình mapping
     */
    private Event mapResultSetToApprovedEvent(ResultSet rs) throws SQLException {
        Event event = new Event();
        event.setEventId(rs.getInt("event_id"));
        event.setEventName(rs.getString("event_name"));
        event.setLocation(rs.getString("location"));
        event.setEventType(rs.getString("event_type"));
        event.setStatus(rs.getString("status"));
        event.setApprovedAt(rs.getTimestamp("approvedAt"));
        // Nếu cần, có thể ánh xạ thêm các trường ảnh từ ResultSet
        return event;
    }

    /////////////////////////////////////////////////////////////////////////
    //                         SEARCH METHODS SECTION                      //
    /////////////////////////////////////////////////////////////////////////
    /**
     * Tìm kiếm sự kiện theo tên (không phân biệt trạng thái)
     *
     * @param keyword từ khóa tìm kiếm trong tên sự kiện
     * @param page số trang hiện tại
     * @param pageSize số bản ghi trên mỗi trang
     * @return danh sách các sự kiện thỏa mãn từ khóa tìm kiếm
     */
    public List<Event> searchEventsByName(String keyword, int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "  (SELECT STRING_AGG(image_url, ',') "
                + "   FROM (SELECT DISTINCT image_url FROM EventImages WHERE event_id = e.event_id) AS imgUrls) AS imageURLs, "
                + "  (SELECT STRING_AGG(image_title, ',') "
                + "   FROM (SELECT DISTINCT image_title FROM EventImages WHERE event_id = e.event_id) AS imgTitles) AS imageTitles "
                + "FROM Events e "
                + "WHERE e.event_name LIKE ? "
                + "ORDER BY e.event_name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /**
     * Đếm tổng số sự kiện tìm kiếm được theo tên
     *
     * @param keyword từ khóa tìm kiếm
     * @return số lượng sự kiện tìm được
     */
    public int getTotalSearchEventsByName(String keyword) {
        String sql = "SELECT COUNT(*) FROM Events WHERE event_name LIKE ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /**
     * Tìm kiếm sự kiện đã duyệt theo tên (chỉ lấy các sự kiện có status =
     * 'active')
     *
     * @param keyword từ khóa tìm kiếm
     * @param page số trang hiện tại
     * @param pageSize số bản ghi trên mỗi trang
     * @return danh sách các sự kiện đã duyệt thỏa mãn từ khóa tìm kiếm
     */
    public List<Event> searchApprovedEventsByName(String keyword, int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.updated_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.event_name LIKE ? AND e.status = 'active' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.updated_at "
                + "ORDER BY e.event_name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /**
     * Đếm tổng số sự kiện đã duyệt theo từ khóa tìm kiếm
     *
     * @param keyword từ khóa tìm kiếm
     * @return số lượng sự kiện đã duyệt tìm được
     */
    public int getTotalSearchApprovedEventsByName(String keyword) {
        String sql = "SELECT COUNT(*) FROM Events WHERE event_name LIKE ? AND status = 'active'";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /**
     * Tìm kiếm lịch sử sự kiện theo tên (chỉ lấy các sự kiện có status =
     * 'active')
     *
     * @param keyword từ khóa tìm kiếm
     * @param page số trang hiện tại
     * @param pageSize số bản ghi trên mỗi trang
     * @return danh sách lịch sử sự kiện thỏa mãn từ khóa tìm kiếm
     */
    public List<Event> searchHistoryEventsByName(String keyword, int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.updated_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.event_name LIKE ? AND e.status = 'active' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.updated_at "
                + "ORDER BY e.event_name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    /**
     * Đếm tổng số lịch sử sự kiện theo từ khóa tìm kiếm
     *
     * @param keyword từ khóa tìm kiếm
     * @return số lượng lịch sử sự kiện tìm được
     */
    public int getTotalSearchHistoryApprovedEventsByName(String keyword) {
        // Lưu ý: truy vấn này đang so sánh với trạng thái rỗng (''),
        // bạn có thể điều chỉnh lại điều kiện nếu cần thiết (ví dụ: 'completed')
        String sql = "SELECT COUNT(*) FROM Events WHERE event_name LIKE ? AND status = ''";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
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

    public List<Event> getHistoryEventsByStatus(String status, int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.updated_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = 'active' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.updated_at "
                + "ORDER BY e.updated_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                events.add(mapResultSetToApprovedEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi lấy danh sách sự kiện theo trạng thái: " + e.getMessage());
        }
        return events;
    }

    public int getTotalHistoryEventsByStatus(String status) {
        String sql = "SELECT COUNT(*) FROM Events WHERE status = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi đếm số lịch sử sự kiện theo trạng thái: " + e.getMessage());
        }
        return 0;
    }

    public List<Event> searchHistoryEventsByNameAndStatus(String keyword, String status, int page, int pageSize) {
    List<Event> events = new ArrayList<>();
    if (connection == null) {
        return events;
    }
    
    String sql;
    if ("all".equalsIgnoreCase(status)) {
        sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, " +
              "e.updated_at AS approvedAt, " +
              "STRING_AGG(ei.image_url, ',') AS imageURLs, " +
              "STRING_AGG(ei.image_title, ',') AS imageTitles " +
              "FROM Events e " +
              "LEFT JOIN EventImages ei ON e.event_id = ei.event_id " +
              "WHERE e.event_name LIKE ? " +
              "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.updated_at " +
              "ORDER BY e.updated_at DESC " +
              "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    } else {
        sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, " +
              "e.updated_at AS approvedAt, " +
              "STRING_AGG(ei.image_url, ',') AS imageURLs, " +
              "STRING_AGG(ei.image_title, ',') AS imageTitles " +
              "FROM Events e " +
              "LEFT JOIN EventImages ei ON e.event_id = ei.event_id " +
              "WHERE e.event_name LIKE ? AND e.status = ? " +
              "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.updated_at " +
              "ORDER BY e.updated_at DESC " +
              "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    }
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, "%" + keyword + "%");
        if ("all".equalsIgnoreCase(status)) {
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
        } else {
            ps.setString(2, status);
            ps.setInt(3, (page - 1) * pageSize);
            ps.setInt(4, pageSize);
        }
        
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            // Lưu ý: Phương thức mapResultSetToApprovedEvent cần chuyển đổi chuỗi imageURLs và imageTitles thành List<String>
            events.add(mapResultSetToApprovedEvent(rs));
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi tìm kiếm lịch sử sự kiện: " + e.getMessage());
    }
    return events;
}


    public int getTotalSearchHistoryEventsByNameAndStatus(String keyword, String status) {
    String sql;
    if ("all".equalsIgnoreCase(status)) {
        sql = "SELECT COUNT(DISTINCT event_id) FROM Events WHERE event_name LIKE ?";
    } else {
        sql = "SELECT COUNT(DISTINCT event_id) FROM Events WHERE event_name LIKE ? AND status = ?";
    }
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, "%" + keyword + "%");
        if (!"all".equalsIgnoreCase(status)) {
            ps.setString(2, status);
        }
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException e) {
        System.out.println("Lỗi đếm số lịch sử sự kiện theo tên và trạng thái: " + e.getMessage());
    }
    return 0;
}


    public List<Event> searchEventsByNameAndStatus(String keyword, String status, int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "  (SELECT STRING_AGG(image_url, ',') "
                + "   FROM (SELECT DISTINCT image_url FROM EventImages WHERE event_id = e.event_id) AS imgUrls) AS imageURLs, "
                + "  (SELECT STRING_AGG(image_title, ',') "
                + "   FROM (SELECT DISTINCT image_title FROM EventImages WHERE event_id = e.event_id) AS imgTitles) AS imageTitles "
                + "FROM Events e "
                + "WHERE e.event_name LIKE ? AND LOWER(e.status) = LOWER(?) "
                + "ORDER BY e.event_name "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, status);
            ps.setInt(3, (page - 1) * pageSize);
            ps.setInt(4, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                events.add(mapResultSetToEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi tìm kiếm sự kiện theo tên và trạng thái: " + e.getMessage());
        }
        return events;
    }

    /**
     * Đếm tổng số sự kiện thỏa mãn cả từ khóa tìm kiếm và trạng thái (phép AND)
     *
     * @param keyword từ khóa tìm kiếm
     * @param status trạng thái của sự kiện
     * @return số lượng sự kiện tìm được
     */
    public int getTotalSearchEventsByNameAndStatus(String keyword, String status) {
        String sql = "SELECT COUNT(*) FROM Events WHERE event_name LIKE ? AND LOWER(status) = LOWER(?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Lỗi đếm số sự kiện theo tên và trạng thái: " + e.getMessage());
        }
        return 0;
    }
public List<Event> filterHistoryEventsByStatus(String status, int page, int pageSize) {
    List<Event> events = new ArrayList<>();
    if (connection == null) {
        return events;
    }
    
    String sql;
    if ("all".equalsIgnoreCase(status)) {
        sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, " +
              "e.updated_at AS approvedAt, " +
              "STRING_AGG(ei.image_url, ',') AS imageURLs, " +
              "STRING_AGG(ei.image_title, ',') AS imageTitles " +
              "FROM Events e " +
              "LEFT JOIN EventImages ei ON e.event_id = ei.event_id " +
              "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.updated_at " +
              "ORDER BY e.updated_at DESC " +
              "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    } else {
        sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, " +
              "e.updated_at AS approvedAt, " +
              "STRING_AGG(ei.image_url, ',') AS imageURLs, " +
              "STRING_AGG(ei.image_title, ',') AS imageTitles " +
              "FROM Events e " +
              "LEFT JOIN EventImages ei ON e.event_id = ei.event_id " +
              "WHERE e.status = ? " +
              "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.updated_at " +
              "ORDER BY e.updated_at DESC " +
              "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    }
    
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        if ("all".equalsIgnoreCase(status)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
        } else {
            ps.setString(1, status);
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            events.add(mapResultSetToApprovedEvent(rs));
        }
    } catch (SQLException e) {
        System.out.println("Lỗi khi lọc lịch sử sự kiện theo trạng thái: " + e.getMessage());
    }
    return events;
}

}
