package dals;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import viewModels.EventDetailDTO;
import viewModels.EventSummaryDTO;
import viewModels.OrderDetailDTO;
import viewModels.OrderSummaryDTO;
import viewModels.ShowtimeDTO;
import viewModels.TicketTypeDTO;
import utils.DBContext;

public class OrganizerDAO extends DBContext {

    // Lấy thông tin chi tiết của event mà customer đã mua vé (nếu cần)
    public EventDetailDTO getCustomerEventDetail(int customerId, int eventId) {
        EventDetailDTO detail = null;
        String sql = "SELECT "
                + "    e.event_id AS eventId, "
                + "    e.event_name AS eventName, "
                + "    MIN(s.start_date) AS startDate, "
                + "    MAX(s.end_date) AS endDate, "
                + "    e.location AS location, "
                + "    e.status AS eventStatus, "
                + "    e.description AS description, "
                + "    ( "
                + "        SELECT TOP 1 image_url "
                + "        FROM EventImages "
                + "        WHERE event_id = e.event_id "
                + "        ORDER BY image_id "
                + "    ) AS imageURL, "
                + "    org.organization_name AS organizationName "
                + "FROM Events e "
                + "JOIN Organizers org ON e.organizer_id = org.organizer_id "
                + "JOIN Showtimes s ON e.event_id = s.event_id "
                + "WHERE e.event_id = ? "
                // Đảm bảo event chỉ được lấy khi customer có đặt vé liên quan
                + "  AND EXISTS ( "
                + "      SELECT 1 "
                + "      FROM Orders o "
                + "      JOIN OrderDetails od ON o.order_id = od.order_id "
                + "      JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "      JOIN Showtimes s2 ON tt.showtime_id = s2.showtime_id "
                + "      WHERE s2.event_id = e.event_id "
                + "        AND o.customer_id = ? "
                + "  ) "
                + "GROUP BY e.event_id, e.event_name, e.location, e.status, e.description, org.organization_name";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ps.setInt(2, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    detail = new EventDetailDTO();
                    detail.setEventId(rs.getInt("eventId"));
                    detail.setEventName(Objects.toString(rs.getString("eventName"), ""));
                    detail.setStartDate(rs.getTimestamp("startDate"));
                    detail.setEndDate(rs.getTimestamp("endDate"));
                    detail.setLocation(Objects.toString(rs.getString("location"), ""));
                    detail.setEventStatus(Objects.toString(rs.getString("eventStatus"), ""));
                    detail.setDescription(Objects.toString(rs.getString("description"), ""));
                    detail.setImageUrl(Objects.toString(rs.getString("imageURL"), ""));
                    detail.setOrganizationName(Objects.toString(rs.getString("organizationName"), ""));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detail;
    }

    // Lấy danh sách event theo customer (theo organizer được liên kết với customer)
    public List<EventSummaryDTO> getEventsByCustomer(int customerId, String filter, String eventName) {
        List<EventSummaryDTO> events = new ArrayList<>();
        // Lưu ý: Stored procedure được tạo với tên dbo.GetCustomerEvents
        String sql = "{call dbo.GetCustomerEvents(?, ?, ?)}";

        try (CallableStatement cs = connection.prepareCall(sql)) {
            // Thiết lập tham số cho stored procedure
            cs.setInt(1, customerId);
            cs.setString(2, filter);
            if (eventName != null && !eventName.trim().isEmpty()) {
                cs.setString(3, eventName);
            } else {
                cs.setNull(3, java.sql.Types.NVARCHAR);
            }

            // Thực thi stored procedure và lấy kết quả
            try (ResultSet rs = cs.executeQuery()) {
                while (rs.next()) {
                    EventSummaryDTO event = new EventSummaryDTO();
                    event.setEventId(rs.getInt("EventID"));
                    event.setEventName(rs.getString("EventName"));
                    event.setStartDate(rs.getTimestamp("StartDate"));
                    event.setEndDate(rs.getTimestamp("EndDate"));
                    event.setLocation(rs.getString("location"));
                    event.setEventStatus(rs.getString("status"));
                    event.setImageUrl(rs.getString("ImageURL"));
                    events.add(event);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return events;
    }

    /**
     * Lấy danh sách OrderDetail theo eventId, paymentStatus và tìm kiếm tên
     * khách hàng. Phương thức này sử dụng phân trang theo offset và pageSize.
     */
    public List<OrderDetailDTO> getOrderDetailsByEventAndPaymentStatus(
            int eventId, String paymentStatus, String searchOrder, int offset, int pageSize) {
        List<OrderDetailDTO> orders = new ArrayList<>();
        String sql = "SELECT \n"
                + "    o.order_id, \n"
                + "    o.order_date, \n"
                + "    o.total_price, \n"
                + "    o.payment_status, \n"
                + "    c.full_name AS customerName, \n"
                + "    MIN(e.event_name) AS eventName, \n"
                + "    MIN(e.location) AS location \n"
                + "FROM Orders o \n"
                + "JOIN Customers c ON o.customer_id = c.customer_id \n"
                + "JOIN OrderDetails od ON o.order_id = od.order_id \n"
                + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id \n"
                + "JOIN Showtimes s ON tt.showtime_id = s.showtime_id \n"
                + "JOIN Events e ON s.event_id = e.event_id \n"
                + "WHERE e.event_id = ? \n"
                + "  AND (LOWER(?) = 'all' OR LOWER(o.payment_status) = LOWER(?)) \n"
                + "  AND ( ? IS NULL OR c.full_name LIKE ? ) \n"
                + "GROUP BY \n"
                + "    o.order_id, \n"
                + "    o.order_date, \n"
                + "    o.total_price, \n"
                + "    o.payment_status, \n"
                + "    c.full_name \n"
                + "ORDER BY o.order_date DESC \n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            int index = 1;
            st.setInt(index++, eventId);
            st.setString(index++, paymentStatus);
            st.setString(index++, paymentStatus);
            if (searchOrder == null || searchOrder.trim().isEmpty()) {
                st.setNull(index++, java.sql.Types.VARCHAR);
                st.setNull(index++, java.sql.Types.VARCHAR);
            } else {
                st.setString(index++, searchOrder);
                st.setString(index++, "%" + searchOrder.toLowerCase() + "%");
            }
            st.setInt(index++, offset);
            st.setInt(index++, pageSize);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    OrderSummaryDTO summary = new OrderSummaryDTO();
                    summary.setOrderId(rs.getInt("order_id"));
                    summary.setOrderDate(rs.getTimestamp("order_date"));
                    // total_price được sử dụng làm grandTotal
                    summary.setGrandTotal(rs.getBigDecimal("total_price"));
                    summary.setPaymentStatus(rs.getString("payment_status"));
                    summary.setCustomerName(rs.getString("customerName"));
                    // Mapping thông tin event từ kết quả truy vấn
                    summary.setEventName(rs.getString("eventName"));
                    summary.setLocation(rs.getString("location"));

                    // Tạo OrderDetailDTO và set OrderSummaryDTO
                    OrderDetailDTO orderDetail = new OrderDetailDTO();
                    orderDetail.setOrderSummary(summary);
                    orders.add(orderDetail);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching order details: " + e.getMessage());
        }
        return orders;
    }

    public int countOrdersByEventAndPaymentStatus(
            int eventId, String paymentStatus, String searchOrder) {
        int count = 0;
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) ");
        sql.append("FROM Orders o ");
        sql.append("JOIN OrderDetails od ON o.order_id = od.order_id ");
        sql.append("JOIN Customers c ON o.customer_id = c.customer_id ");
        sql.append("JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id ");
        sql.append("JOIN Showtimes s ON tt.showtime_id = s.showtime_id ");
        sql.append("JOIN Events e ON s.event_id = e.event_id ");
        sql.append("WHERE e.event_id = ? ");
        if (!"all".equalsIgnoreCase(paymentStatus)) {
            sql.append("AND LOWER(o.payment_status) = ? ");
        }
        if (searchOrder != null && !searchOrder.isEmpty()) {
            sql.append("AND c.full_name LIKE ? ");
        }
        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int index = 1;
            st.setInt(index++, eventId);
            if (!"all".equalsIgnoreCase(paymentStatus)) {
                st.setString(index++, paymentStatus.toLowerCase());
            }
            if (searchOrder != null && !searchOrder.isEmpty()) {
                st.setString(index++, "%" + searchOrder + "%");
            }
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error counting orders: " + e.getMessage());
        }
        return count;
    }

    public int countOrdersByEventAndPaymentStatus(int eventId, String paymentStatus) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total "
                + "FROM Orders o "
                + "JOIN OrderDetails od ON o.order_id = od.order_id "
                + "JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "JOIN Showtimes st ON tt.showtime_id = st.showtime_id "
                + "JOIN Events e ON st.event_id = e.event_id "
                + "WHERE e.event_id = ? "
                + "  AND ( ? = 'all' OR LOWER(o.payment_status) = ? )";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, eventId);
            st.setString(2, paymentStatus.toLowerCase());
            st.setString(3, paymentStatus.toLowerCase());
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error counting orders (simple version): " + e.getMessage());
        }
        return count;
    }

    public int countOrdersByOrganizerAndPaymentStatus(int organizerId, String paymentStatus) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total "
                + "FROM Orders o "
                + "INNER JOIN OrderDetails od ON o.order_id = od.order_id "
                + "INNER JOIN TicketTypes tt ON od.ticket_type_id = tt.ticket_type_id "
                + "INNER JOIN Showtimes st ON tt.showtime_id = st.showtime_id "
                + "INNER JOIN Events e ON st.event_id = e.event_id "
                + "INNER JOIN Organizers org ON e.organizer_id = org.organizer_id "
                + "WHERE org.organizer_id = ? "
                + "  AND ( ? = 'all' OR LOWER(o.payment_status) = ? )";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, organizerId);
            stmt.setString(2, paymentStatus.toLowerCase());
            stmt.setString(3, paymentStatus.toLowerCase());
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public EventDetailDTO getEventDetail(int eventId) {
        EventDetailDTO detail = null;
        String sql = "WITH BannerImages AS ( "
                + "    SELECT event_id, image_url, "
                + "           ROW_NUMBER() OVER (PARTITION BY event_id "
                + "                              ORDER BY CASE WHEN LOWER(image_title) LIKE '%banner%' THEN 0 ELSE 1 END, image_id) AS rn "
                + "    FROM EventImages "
                + ") "
                + "SELECT "
                + "    e.event_id AS eventId, "
                + "    e.event_name AS eventName, "
                + "    MIN(s.start_date) AS startDate, "
                + "    MAX(s.end_date) AS endDate, "
                + "    e.location AS location, "
                + "    e.status AS eventStatus, "
                + "    e.description AS description, "
                + "    ISNULL(bi.image_url, 'https://your-cloud-storage.com/path/to/default-banner.jpg') AS imageURL, "
                + "    org.organization_name AS organizationName, "
                + "    org.account_holder AS accountHolder, "
                + "    org.account_number AS accountNumber, "
                + "    org.bank_name AS bankName, "
                + "    c.category_name AS categoryName, "
                + "    e.event_type AS eventType "
                + "FROM Events e "
                + "JOIN Organizers org ON e.organizer_id = org.organizer_id "
                + "JOIN Categories c ON e.category_id = c.category_id "
                + "JOIN Showtimes s ON e.event_id = s.event_id "
                + "LEFT JOIN BannerImages bi ON e.event_id = bi.event_id AND bi.rn = 1 "
                + "WHERE e.event_id = ? "
                + "GROUP BY e.event_id, e.event_name, e.location, e.status, e.description, "
                + "         org.organization_name, org.account_holder, org.account_number, org.bank_name, "
                + "         bi.image_url, c.category_name, e.event_type";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    detail = new EventDetailDTO();
                    detail.setEventId(rs.getInt("eventId"));
                    detail.setEventName(rs.getString("eventName") != null ? rs.getString("eventName") : "");
                    detail.setStartDate(rs.getTimestamp("startDate"));
                    detail.setEndDate(rs.getTimestamp("endDate"));
                    detail.setLocation(rs.getString("location") != null ? rs.getString("location") : "");
                    detail.setEventStatus(rs.getString("eventStatus") != null ? rs.getString("eventStatus") : "");
                    detail.setDescription(rs.getString("description") != null ? rs.getString("description") : "");
                    detail.setImageUrl(rs.getString("imageURL") != null ? rs.getString("imageURL")
                            : "https://your-cloud-storage.com/path/to/default-banner.jpg");
                    detail.setOrganizationName(rs.getString("organizationName") != null ? rs.getString("organizationName") : "");
                    detail.setAccountHolder(rs.getString("accountHolder") != null ? rs.getString("accountHolder") : "");
                    detail.setAccountNumber(rs.getString("accountNumber") != null ? rs.getString("accountNumber") : "");
                    detail.setBankName(rs.getString("bankName") != null ? rs.getString("bankName") : "");
                    detail.setCategoryName(rs.getString("categoryName") != null ? rs.getString("categoryName") : "");
                    detail.setEventType(rs.getString("eventType") != null ? rs.getString("eventType") : "");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return detail;
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
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ShowtimeDTO dto = new ShowtimeDTO();
                dto.setShowtimeId(rs.getInt("showtime_id"));
                dto.setStartDate(rs.getTimestamp("start_date"));
                dto.setEndDate(rs.getTimestamp("end_date"));
                dto.setShowtimeStatus(rs.getString("showtime_status"));
                dto.setTotalSeats(rs.getInt("total_seats"));
                showtimes.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    public List<TicketTypeDTO> getTicketTypesByEventId(int eventId) {
        List<TicketTypeDTO> ticketTypes = new ArrayList<>();
        String sql = "SELECT tt.ticket_type_id, tt.name, tt.description, tt.price, tt.color, tt.total_quantity, "
                + "COALESCE(SUM(od.quantity), 0) AS sold_quantity, tt.created_at, tt.updated_at "
                + "FROM TicketTypes tt "
                + "LEFT JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id "
                + "WHERE tt.showtime_id IN ( "
                + "    SELECT showtime_id FROM Showtimes WHERE event_id = ? "
                + ") "
                + "GROUP BY tt.ticket_type_id, tt.name, tt.description, tt.price, tt.color, tt.total_quantity, tt.created_at, tt.updated_at";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, eventId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                TicketTypeDTO dto = new TicketTypeDTO();
                dto.setTicketTypeId(rs.getInt("ticket_type_id"));
                dto.setName(rs.getString("name"));
                dto.setDescription(rs.getString("description"));
                dto.setPrice(rs.getDouble("price"));
                dto.setColor(rs.getString("color"));
                dto.setTotalQuantity(rs.getInt("total_quantity"));
                dto.setSoldQuantity(rs.getInt("sold_quantity"));
                dto.setCreatedAt(rs.getTimestamp("created_at"));
                dto.setUpdatedAt(rs.getTimestamp("updated_at"));
                ticketTypes.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ticketTypes;
    }
}
