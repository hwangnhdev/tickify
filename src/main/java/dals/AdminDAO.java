package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Admin;
import models.Event;
import viewModels.EventDetailDTO;
import models.EventImage;
import models.Showtime;
import models.Ticket;
import models.TicketType;
import utils.DBContext;
import viewModels.ShowtimeDTO;
import viewModels.TicketTypeDTO;

public class AdminDAO extends DBContext {

    private static final String SELECT_ALL_ADMINS = "SELECT * FROM Admins";
    private static final String SELECT_ADMIN_BY_ID = "SELECT * FROM Admins WHERE admin_id = ?";
    private static final String SELECT_ADMIN_BY_EMAIL = "SELECT * FROM Admins WHERE email = ?";
    private static final String UPDATE_ADMIN = "UPDATE Admins SET name = ?, email = ?, password = ?, profile_picture = ? WHERE admin_id = ?";
    private static final String SELECT_ALL_REVENUES
            = "SELECT \n"
            + "	e.event_id,\n"
            + "    e.event_name,\n"
            + "    COUNT(e.event_id) AS total_tickets_sold,\n"
            + "    SUM(tt.price) AS total_revenue,\n"
            + "    MIN(st.start_date) AS start_date,\n"
            + "    MAX(st.end_date) AS end_date\n"
            + "FROM Orders o\n"
            + "JOIN OrderDetails od ON o.order_id = od.order_id\n"
            + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id\n"
            + "JOIN Showtimes st ON st.showtime_id = tt.showtime_id\n"
            + "JOIN Events e ON e.event_id =st.event_id\n"
            + "JOIN Ticket t ON od.order_detail_id = t.order_detail_id\n"
            + "JOIN Seats s ON t.seat_id = s.seat_id\n"
            + "GROUP BY e.event_id, e.event_name\n"
            + "ORDER BY e.event_id ASC;";

    private static final String SELECT_REVENUE_DETAIL_BY_EVENT_ID
            = "SELECT \n"
            + "    e.event_id,\n"
            + "    e.event_name,\n"
            + "    tt.name AS ticket_type_name,\n"
            + "    tt.total_quantity,"
            + "    tt.price AS ticket_price,\n"
            + "    SUM(od.quantity) AS total_tickets_sold,\n"
            + "    tt.sold_quantity,"
            + "    SUM(od.price * od.quantity) AS revenue_per_ticket_type\n"
            + "FROM Events e\n"
            + "JOIN Showtimes s ON e.event_id = s.event_id\n"
            + "JOIN TicketTypes tt ON s.showtime_id = tt.showtime_id\n"
            + "JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id\n"
            + "JOIN Orders o ON od.order_id = o.order_id\n"
            + "WHERE e.event_id = ?\n"
            + "GROUP BY e.event_id, e.event_name, tt.name, tt.price, tt.total_quantity, tt.sold_quantity;";

    private Admin mapResultSetToAdmin(ResultSet rs) throws SQLException {
        Admin admin = new Admin();
        admin.setAdminId(rs.getInt("admin_id"));
        admin.setName(rs.getString("name"));
        admin.setEmail(rs.getString("email"));
        admin.setPassword(rs.getString("password"));
        admin.setProfilePicture(rs.getString("profile_picture"));
        return admin;
    }

    public List<Admin> selectAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        try ( PreparedStatement st = connection.prepareStatement(SELECT_ALL_ADMINS);  ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                admins.add(mapResultSetToAdmin(rs));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return admins;
    }

    public Admin selectAdminById(int id) {
        Admin admin = null;
        try ( PreparedStatement st = connection.prepareStatement(SELECT_ADMIN_BY_ID)) {
            st.setInt(1, id);
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    admin = mapResultSetToAdmin(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return admin;
    }

    public Admin selectAdminByEmail(String email) {
        Admin admin = null;
        try ( PreparedStatement st = connection.prepareStatement(SELECT_ADMIN_BY_EMAIL)) {
            st.setString(1, email);
            try ( ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    admin = mapResultSetToAdmin(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return admin;
    }

    public boolean updateAdmin(Admin admin) {
        try ( PreparedStatement st = connection.prepareStatement(UPDATE_ADMIN)) {
            st.setString(1, admin.getName());
            st.setString(2, admin.getEmail());
            st.setString(3, admin.getPassword());
            st.setString(4, admin.getProfilePicture());
            st.setInt(5, admin.getAdminId());
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public List<Event> selectAllRevenues() {
        List<Event> revenues = new ArrayList<>();
        try ( PreparedStatement st = connection.prepareStatement(SELECT_ALL_REVENUES);  ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Event revenue = new Event();
                revenue.setEventId(rs.getInt("event_id"));
                revenue.setEventName(rs.getString("event_name"));
                revenue.setTotalTicketsSold(rs.getInt("total_tickets_sold"));
                revenue.setTotalRevenue(rs.getDouble("total_revenue"));
                revenue.setStartDate(rs.getTimestamp("start_date"));
                revenue.setEndDate(rs.getTimestamp("end_date"));
                revenues.add(revenue);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return revenues;
    }

    public List<TicketType> getRevenueDetailByEventId(int eventId) {
        List<TicketType> revenueDetails = new ArrayList<>();
        try ( PreparedStatement st = connection.prepareStatement(SELECT_REVENUE_DETAIL_BY_EVENT_ID)) {
            st.setInt(1, eventId);
            try ( ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    TicketType revenueDetail = new TicketType();
                    revenueDetail.setEventId(rs.getInt("event_id"));
                    revenueDetail.setEventName(rs.getString("event_name"));
                    revenueDetail.setName(rs.getString("ticket_type_name"));

                    revenueDetail.setTotalQuantity(rs.getInt("total_quantity"));
                    revenueDetail.setPrice(rs.getInt("ticket_price"));

//                    revenueDetail.setSoldQuantity(rs.getInt("total_tickets_sold"));
                    revenueDetail.setSoldQuantity(rs.getInt("sold_quantity"));
                    revenueDetail.setTotalRevenuePerTicketType(rs.getDouble("revenue_per_ticket_type"));
                    revenueDetails.add(revenueDetail);
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return revenueDetails;
    }

    /**
     * Lấy chi tiết sự kiện bao gồm thông tin từ Categories, Organizers,
     * Showtimes và EventImages. Tổng hợp image_url và image_title (ở đây lấy
     * image_url là danh sách hình ảnh).
     */
    public EventDetailDTO getEventDetailById(int eventId) {
        EventDetailDTO eventDetail = new EventDetailDTO();
        String sql = "SELECT e.event_id, e.event_name, e.description, "
                + "       MIN(s.start_date) AS start_date, "
                + "       MAX(s.end_date) AS end_date, "
                + "       e.approved_at, "
                + "       e.location, e.event_type, e.status AS event_status, "
                + "       c.category_name, o.organization_name, o.account_holder, o.account_number, o.bank_name "
                + "FROM Events e "
                + "JOIN Categories c ON e.category_id = c.category_id "
                + "JOIN Organizers o ON e.organizer_id = o.organizer_id "
                + "JOIN Showtimes s ON e.event_id = s.event_id "
                + "WHERE e.status IN ('Processing', 'Approved', 'Rejected') "
                + "  AND e.event_id = ? "
                + "GROUP BY e.event_id, e.event_name, e.description, e.approved_at, "
                + "         e.location, e.event_type, e.status, c.category_name, o.organization_name, o.account_holder, o.account_number, o.bank_name";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                eventDetail.setEventId(rs.getInt("event_id"));
                eventDetail.setEventName(rs.getString("event_name"));
                eventDetail.setDescription(rs.getString("description"));
                // Lấy giá trị start_date và end_date từ bảng Showtimes
                eventDetail.setStartDate(rs.getTimestamp("start_date"));
                eventDetail.setEndDate(rs.getTimestamp("end_date"));
                eventDetail.setApprovedAt(rs.getTimestamp("approved_at"));
                eventDetail.setLocation(rs.getString("location"));
                eventDetail.setEventType(rs.getString("event_type"));
                eventDetail.setEventStatus(rs.getString("event_status"));
                eventDetail.setCategoryName(rs.getString("category_name"));
                eventDetail.setOrganizationName(rs.getString("organization_name"));
                eventDetail.setAccountHolder(rs.getString("account_holder"));
                eventDetail.setAccountNumber(rs.getString("account_number"));
                eventDetail.setBankName(rs.getString("bank_name"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return eventDetail;
    }

    public List<ShowtimeDTO> getShowtimesByEventId(int eventId) {
        List<ShowtimeDTO> showtimes = new ArrayList<>();
        String sql = "SELECT s.showtime_id, s.start_date, s.end_date, s.status AS showtime_status, "
                + "COALESCE(sc.seat_count, 0) AS total_seats "
                + "FROM Showtimes s "
                + "LEFT JOIN ( "
                + "    SELECT tt.showtime_id, COUNT(*) AS seat_count "
                + "    FROM TicketTypes tt "
                + "    JOIN Seats se ON tt.ticket_type_id = se.ticket_type_id "
                + "    GROUP BY tt.showtime_id "
                + ") sc ON s.showtime_id = sc.showtime_id "
                + "WHERE s.event_id = ? "
                + "ORDER BY s.start_date";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ShowtimeDTO showtime = new ShowtimeDTO();
                showtime.setShowtimeId(rs.getInt("showtime_id"));
                showtime.setStartDate(rs.getTimestamp("start_date"));
                showtime.setEndDate(rs.getTimestamp("end_date"));
                showtime.setShowtimeStatus(rs.getString("showtime_status"));
                showtime.setTotalSeats(rs.getInt("total_seats"));
                showtimes.add(showtime);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    public List<TicketTypeDTO> getTicketTypesByEventId(int eventId) {
        List<TicketTypeDTO> ticketTypes = new ArrayList<>();
        String sql = "SELECT tt.ticket_type_id, tt.showtime_id, tt.name, tt.description, "
                + "tt.price, tt.color, tt.total_quantity, "
                + "COALESCE(SUM(od.quantity), 0) AS sold_quantity, "
                + "tt.created_at, tt.updated_at "
                + "FROM TicketTypes tt "
                + "LEFT JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id "
                + "WHERE tt.showtime_id IN ( "
                + "    SELECT showtime_id FROM Showtimes WHERE event_id = ? "
                + ") "
                + "GROUP BY tt.ticket_type_id, tt.showtime_id, tt.name, tt.description, "
                + "tt.price, tt.color, tt.total_quantity, tt.created_at, tt.updated_at";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TicketTypeDTO ticketType = new TicketTypeDTO();
                ticketType.setTicketTypeId(rs.getInt("ticket_type_id"));
                ticketType.setShowtimeId(rs.getInt("showtime_id"));
                ticketType.setName(rs.getString("name"));
                ticketType.setDescription(rs.getString("description"));
                ticketType.setPrice(rs.getDouble("price"));
                ticketType.setColor(rs.getString("color"));
                ticketType.setTotalQuantity(rs.getInt("total_quantity"));
                ticketType.setSoldQuantity(rs.getInt("sold_quantity"));
                ticketType.setCreatedAt(rs.getTimestamp("created_at"));
                ticketType.setUpdatedAt(rs.getTimestamp("updated_at"));
                ticketTypes.add(ticketType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ticketTypes;
    }

    public List<EventImage> getImageEventsByEventId(int eventId) {
        List<EventImage> list = new ArrayList<>();
        String sql = "SELECT image_url, image_title FROM EventImages WHERE event_id = ?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            try ( ResultSet rs = ps.executeQuery()) {
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
        // Sử dụng approved_at thay vì updated_at để cập nhật thời gian duyệt
        String sql = "UPDATE Events SET status = ?, approved_at = GETDATE() WHERE event_id = ? AND status = 'Processing'";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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
                + "E.created_at AS createdAt, E.updated_at AS updatedAt, E.approved_at AS approvedAt, "
                + "STRING_AGG(EI.image_url, ',') AS image_urls "
                + "FROM Events E "
                + "LEFT JOIN Categories C ON E.category_id = C.category_id "
                + "LEFT JOIN Organizers O ON E.organizer_id = O.organizer_id "
                + "LEFT JOIN Showtimes ST ON E.event_id = ST.event_id "
                + "LEFT JOIN EventImages EI ON E.event_id = EI.event_id "
                + "WHERE E.event_id = ? AND E.status = 'approved' "
                + "GROUP BY E.event_id, E.event_name, C.category_name, O.organization_name, "
                + "E.location, E.event_type, E.status, E.description, E.created_at, E.updated_at, E.approved_at";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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
                Timestamp approvedTs = rs.getTimestamp("approvedAt");
                if (approvedTs != null) {
                    eventDetail.setApprovedAt(new Timestamp(approvedTs.getTime()));
                }
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
            orderByClause = "ORDER BY e.approved_at DESC ";
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

    /**
     * Lấy danh sách các sự kiện đã duyệt (Active) với thông tin approvedAt lấy
     * từ approved_at
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
                + "e.approved_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = 'approved' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.approved_at "
                + "ORDER BY e.approved_at DESC "
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
                + "e.approved_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = 'approved' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.approved_at "
                + "ORDER BY e.approved_at DESC "
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

    /**
     * Đếm tổng số sự kiện đã duyệt (Active)
     *
     * @return số lượng sự kiện đã duyệt
     */
    public int getTotalApprovedEvents() {
        String sql = "SELECT COUNT(*) FROM Events WHERE status = 'approved'";
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

    /**
     * Đếm tổng số sự kiện tìm kiếm được theo tên
     *
     * @param keyword từ khóa tìm kiếm
     * @return số lượng sự kiện tìm được
     */
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

    /**
     * Tìm kiếm sự kiện đã duyệt theo tên (chỉ lấy các sự kiện có status =
     * 'approved')
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
                + "e.approved_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.event_name LIKE ? AND e.status = 'approved' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.approved_at "
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

    /**
     * Đếm tổng số sự kiện đã duyệt theo từ khóa tìm kiếm
     *
     * @param keyword từ khóa tìm kiếm
     * @return số lượng sự kiện đã duyệt tìm được
     */
    public int getTotalSearchApprovedEventsByName(String keyword) {
        String sql = "SELECT COUNT(*) FROM Events WHERE event_name LIKE ? AND status = 'approved'";
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
                + "e.approved_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.event_name LIKE ? AND e.status = 'active' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.approved_at "
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

    public List<Event> getHistoryEventsByStatus(String status, int page, int pageSize) {
        List<Event> events = new ArrayList<>();
        if (connection == null) {
            return events;
        }
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.approved_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                + "WHERE e.status = 'active' "
                + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.approved_at "
                + "ORDER BY e.approved_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
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
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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
            sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                    + "e.approved_at AS approvedAt, "
                    + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                    + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                    + "FROM Events e "
                    + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                    + "WHERE e.event_name LIKE ? "
                    + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.approved_at "
                    + "ORDER BY e.approved_at DESC "
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        } else {
            sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                    + "e.approved_at AS approvedAt, "
                    + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                    + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                    + "FROM Events e "
                    + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id "
                    + "WHERE e.event_name LIKE ? AND e.status = ? "
                    + "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.approved_at "
                    + "ORDER BY e.approved_at DESC "
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        }

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
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

        // Xây dựng câu truy vấn cơ bản
        String sql = "SELECT e.event_id, e.event_name, e.location, e.event_type, e.status, "
                + "e.approved_at AS approvedAt, "
                + "STRING_AGG(ei.image_url, ',') AS imageURLs, "
                + "STRING_AGG(ei.image_title, ',') AS imageTitles "
                + "FROM Events e "
                + "LEFT JOIN EventImages ei ON e.event_id = ei.event_id ";

        // Nếu không lấy tất cả, thêm điều kiện lọc theo trạng thái
        if (!"all".equalsIgnoreCase(status)) {
            sql += "WHERE e.status = ? ";
        }

        sql += "GROUP BY e.event_id, e.event_name, e.location, e.event_type, e.status, e.approved_at "
                + "ORDER BY e.approved_at DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            // Nếu status khác "all", set giá trị cho placeholder
            if (!"all".equalsIgnoreCase(status)) {
                ps.setString(paramIndex++, status);
            }
            ps.setInt(paramIndex++, (page - 1) * pageSize);
            ps.setInt(paramIndex, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                events.add(mapResultSetToApprovedEvent(rs));
            }
        } catch (SQLException e) {
            System.out.println("Lỗi khi lọc lịch sử sự kiện theo trạng thái: " + e.getMessage());
        }
        return events;
    }

    public List<Showtime> getShowtimeRevenueByEventId(int eventId) {
        List<Showtime> showtimeList = new ArrayList<>();

        String sql = "SELECT e.event_id, st.showtime_id, "
                + "tt.name AS ticket_type_name, tt.price AS ticket_type_price, "
                + "t.ticket_id, t.ticket_code, t.price AS ticket_price, "
                + "s.seat_row, s.seat_col, s.status AS seat_status "
                + "FROM Orders o "
                + "JOIN OrderDetails od ON o.order_id = od.order_id "
                + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "JOIN Showtimes st ON st.showtime_id = tt.showtime_id "
                + "JOIN Events e ON e.event_id = st.event_id "
                + "JOIN Ticket t ON od.order_detail_id = t.order_detail_id "
                + "JOIN Seats s ON t.seat_id = s.seat_id "
                + "WHERE e.event_id = ?";

        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            ResultSet rs = stmt.executeQuery();

            Map<Integer, Showtime> showtimeMap = new HashMap<>();
            Map<String, TicketType> ticketTypeMap;

            while (rs.next()) {
                int showtimeId = rs.getInt("showtime_id");
                String ticketTypeName = rs.getString("ticket_type_name");
                double ticketTypePrice = rs.getDouble("ticket_type_price");

                int ticketId = rs.getInt("ticket_id");
                String ticketCode = rs.getString("ticket_code");
                double ticketPrice = rs.getDouble("ticket_price");
                String seatRow = rs.getString("seat_row");
                int seatCol = rs.getInt("seat_col");
                String seatStatus = rs.getString("seat_status");

                Ticket ticket = new Ticket(ticketId, ticketCode, ticketPrice, seatStatus);

                // Nếu showtime chưa có, thêm vào danh sách
                if (!showtimeMap.containsKey(showtimeId)) {
                    showtimeMap.put(showtimeId, new Showtime(showtimeId));
                }

                Showtime showtimeDTO = showtimeMap.get(showtimeId);
                ticketTypeMap = new HashMap<>();

                // Kiểm tra nếu TicketType đã có trong Showtime
                for (TicketType tt : showtimeDTO.getTicketTypes()) {
                    ticketTypeMap.put(tt.getName(), tt);
                }

                if (!ticketTypeMap.containsKey(ticketTypeName)) {
                    ticketTypeMap.put(ticketTypeName, new TicketType(ticketTypeName, ticketTypePrice));
                    showtimeDTO.addTicketType(ticketTypeMap.get(ticketTypeName));
                }

                ticketTypeMap.get(ticketTypeName).addTicket(ticket);
            }

            showtimeList.addAll(showtimeMap.values());

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return showtimeList;
    }
}
