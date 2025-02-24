/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import models.EventSalesSummary;
import models.SalesHistory;
import models.TicketSummary;
import utils.DBContext;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventSummaryDAO extends DBContext {

    public List<TicketSummary> getSoldTicketsSummary(int organizerId, int eventId) {
        List<TicketSummary> ticketSummaries = new ArrayList<>();
        String sql = "SELECT e.event_id, e.event_name, tt.name AS ticket_type_name, "
                + "tt.total_quantity AS total_tickets, tt.sold_quantity AS tickets_sold, "
                + "(tt.total_quantity - tt.sold_quantity) AS tickets_remaining, "
                + "CAST((tt.sold_quantity * 100.0 / tt.total_quantity) AS DECIMAL(5,2)) AS sold_percentage "
                + "FROM Events e "
                + "INNER JOIN Organizers o ON e.event_id = o.event_id "
                + "INNER JOIN TicketTypes tt ON e.event_id = tt.event_id "
                + "WHERE o.customer_id = ? AND e.event_id = ? "
                + "ORDER BY tt.name";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, organizerId);
            ps.setInt(2, eventId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TicketSummary summary = new TicketSummary(
                        rs.getInt("event_id"),
                        rs.getString("event_name"),
                        rs.getString("ticket_type_name"),
                        rs.getInt("total_tickets"),
                        rs.getInt("tickets_sold"),
                        rs.getInt("tickets_remaining"),
                        rs.getDouble("sold_percentage")
                );
                ticketSummaries.add(summary);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving sold tickets summary: " + e.getMessage());
        }
        return ticketSummaries;
    }

    // 2. Lấy thông tin tóm tắt doanh thu và số vé đã bán cho một sự kiện cụ thể
    public EventSalesSummary getGrossSalesSummary(int organizerId, int eventId) {
        EventSalesSummary summary = null;
        String sql = "SELECT e.event_id, e.event_name, "
                + "COUNT(t.ticket_id) AS total_tickets_sold, "
                + "SUM(t.price * od.quantity) AS gross_sales "
                + "FROM Events e "
                + "INNER JOIN Organizers o ON e.event_id = o.event_id "
                + "INNER JOIN TicketTypes tt ON e.event_id = tt.event_id "
                + "INNER JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id "
                + "INNER JOIN Tickets t ON od.order_detail_id = t.order_detail_id "
                + "WHERE o.customer_id = ? AND e.event_id = ? AND t.status = 'Sold' "
                + "GROUP BY e.event_id, e.event_name";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, organizerId);
            ps.setInt(2, eventId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                summary = new EventSalesSummary(
                        rs.getInt("event_id"),
                        rs.getString("event_name"),
                        rs.getInt("total_tickets_sold"),
                        rs.getDouble("gross_sales")
                );
                System.out.println("Gross Sales: " + rs.getDouble("gross_sales"));
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving gross sales summary: " + e.getMessage());
        }
        return summary;
    }

    // 3. Lấy dữ liệu lịch sử để vẽ biểu đồ (doanh thu và số vé theo ngày)
    public List<SalesHistory> getSalesHistory(int organizerId, int eventId, java.util.Date startDate, java.util.Date endDate) {
        List<SalesHistory> history = new ArrayList<>();
        String sql = "SELECT CONVERT(DATE, o.order_date) AS sale_date, "
                + "COUNT(t.ticket_id) AS tickets_sold, "
                + "SUM(t.price) AS daily_sales "
                + "FROM Events e "
                + "INNER JOIN Organizers org ON e.event_id = org.event_id "
                + "INNER JOIN TicketTypes tt ON e.event_id = tt.event_id "
                + "INNER JOIN OrderDetails od ON tt.ticket_type_id = od.ticket_type_id "
                + "INNER JOIN Tickets t ON od.order_detail_id = t.order_detail_id "
                + "INNER JOIN Orders o ON od.order_id = o.order_id "
                + "WHERE org.customer_id = ? AND e.event_id = ? AND t.status = 'Sold' "
                + "AND o.order_date >= ? AND o.order_date <= ? "
                + "GROUP BY CONVERT(DATE, o.order_date) "
                + "ORDER BY sale_date";

        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, organizerId);
            ps.setInt(2, eventId);
            ps.setDate(3, new java.sql.Date(startDate.getTime()));
            ps.setDate(4, new java.sql.Date(endDate.getTime()));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                SalesHistory entry = new SalesHistory(
                        rs.getDate("sale_date"),
                        rs.getInt("tickets_sold"),
                        rs.getDouble("daily_sales")
                );
                history.add(entry);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving sales history: " + e.getMessage());
            // Không throw exception, chỉ log và trả về danh sách rỗng
        }
        return history; // Luôn trả về danh sách (có thể rỗng)
    }

    // 1. Lấy doanh thu và số vé bán được theo năm (12 tháng)
    public List<EventSalesSummary> getRevenueBy24Hours(int organizerId, int eventId) {
        List<EventSalesSummary> summaries = new ArrayList<>();
        String sql = "{CALL GetEventRevenueBy24Hours(?, ?, NULL)}"; // NULL to use default end_date

        try ( CallableStatement cs = connection.prepareCall(sql)) {
            cs.setInt(1, eventId);
            cs.setInt(2, organizerId);
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                EventSalesSummary summary = new EventSalesSummary();
                summary.setEventId(eventId);
                summary.setEventName("Event " + eventId);
                summary.setRevenue(rs.getDouble("Revenue"));
                summary.setTotalTicketsSold(rs.getInt("TotalTicketsSold"));
                summary.setPeriod(rs.getTimestamp("DateTime")); // Keep period as Timestamp
                // Set date for chart labels (format as HH:00)
                summary.setDate(rs.getString("DateTime") != null
                        ? new java.text.SimpleDateFormat("HH:00").format(rs.getTimestamp("DateTime")) : "00:00");
                summaries.add(summary);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving revenue by 24 hours: " + e.getMessage());
        }
        return summaries.isEmpty() ? null : summaries;
    }

    // Update other methods (getRevenueBy7Days, getRevenueBy30Days, getRevenueByYearFull) similarly
    public List<EventSalesSummary> getRevenueBy7Days(int organizerId, int eventId) {
        List<EventSalesSummary> summaries = new ArrayList<>();
        String sql = "{CALL GetEventRevenueBy7Days(?, ?, NULL)}";

        try ( CallableStatement cs = connection.prepareCall(sql)) {
            cs.setInt(1, eventId);
            cs.setInt(2, organizerId);
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                EventSalesSummary summary = new EventSalesSummary();
                summary.setEventId(eventId);
                summary.setEventName("Event " + eventId);
                summary.setRevenue(rs.getDouble("Revenue"));
                summary.setTotalTicketsSold(rs.getInt("TotalTicketsSold"));
                summary.setPeriodDate(rs.getDate("Date")); // Use periodDate for date-based periods
                // Set date for chart labels (format as MM/DD)
                summary.setDate(rs.getDate("Date") != null
                        ? new java.text.SimpleDateFormat("dd/MM").format(rs.getDate("Date")) : "01/01");
                summaries.add(summary);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving revenue by 7 days: " + e.getMessage());
        }
        return summaries.isEmpty() ? null : summaries;
    }

    public List<EventSalesSummary> getRevenueBy30Days(int organizerId, int eventId) {
        List<EventSalesSummary> summaries = new ArrayList<>();
        String sql = "{CALL GetEventRevenueBy30Days(?, ?, NULL)}";

        try ( CallableStatement cs = connection.prepareCall(sql)) {
            cs.setInt(1, eventId);
            cs.setInt(2, organizerId);
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                EventSalesSummary summary = new EventSalesSummary();
                summary.setEventId(eventId);
                summary.setEventName("Event " + eventId);
                summary.setRevenue(rs.getDouble("Revenue"));
                summary.setTotalTicketsSold(rs.getInt("TotalTicketsSold"));
                summary.setPeriodDate(rs.getDate("Date"));
                // Set date for chart labels (format as DD/MM)
                summary.setDate(rs.getDate("Date") != null
                        ? new java.text.SimpleDateFormat("dd/MM").format(rs.getDate("Date")) : "01/01");
                summaries.add(summary);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving revenue by 30 days: " + e.getMessage());
        }
        return summaries.isEmpty() ? null : summaries;
    }

    public List<EventSalesSummary> getRevenueByYearFull(int organizerId, int eventId, int year) {
        List<EventSalesSummary> summaries = new ArrayList<>();
        String sql = "{CALL GetEventRevenueByYearFull(?, ?, ?)}";

        try ( CallableStatement cs = connection.prepareCall(sql)) {
            cs.setInt(1, eventId);
            cs.setInt(2, organizerId);
            cs.setInt(3, year);
            ResultSet rs = cs.executeQuery();

            while (rs.next()) {
                EventSalesSummary summary = new EventSalesSummary();
                summary.setEventId(eventId);
                summary.setEventName("Event " + eventId);
                summary.setRevenue(rs.getDouble("Revenue"));
                summary.setTotalTicketsSold(rs.getInt("TotalTicketsSold"));
                // Set periodDate for the month (e.g., first day of the month)
                java.util.Calendar cal = java.util.Calendar.getInstance();
                cal.set(year, rs.getInt("Month") - 1, 1);
                summary.setPeriodDate(new java.sql.Date(cal.getTimeInMillis()));
                // Set date for chart labels (format as MM/DD/YYYY)
                summary.setDate(String.format("01/%02d/%d", rs.getInt("Month"), year));
                summaries.add(summary);
            }
        } catch (SQLException e) {
            System.out.println("Error retrieving revenue by year: " + e.getMessage());
        }
        return summaries.isEmpty() ? null : summaries;
    }

    public static void main(String[] args) {
//        // Tạo đối tượng DAO
//        EventSummaryDAO dao = new EventSummaryDAO();
//
//        // 1. Test getSoldTicketsSummary
//        int organizerId = 2; // ID của Organizer (ví dụ)
//        int eventId = 2;     // ID của sự kiện "Birthday" (ví dụ)
//
//        System.out.println("Testing getSoldTicketsSummary...");
//        List<TicketSummary> ticketSummaries = dao.getSoldTicketsSummary(organizerId, eventId);
//        if (ticketSummaries != null && !ticketSummaries.isEmpty()) {
//            System.out.println("Ticket Summaries for Event ID " + eventId + ":");
//            for (TicketSummary summary : ticketSummaries) {
//                System.out.printf("Event: %s, Ticket Type: %s, Total: %d, Sold: %d, Remaining: %d, Percentage: %.2f%%\n",
//                        summary.getEventName(), summary.getTicketTypeName(), summary.getTotalTickets(),
//                        summary.getTicketsSold(), summary.getTicketsRemaining(), summary.getSoldPercentage());
//            }
//        } else {
//            System.out.println("No ticket summaries found for Organizer ID " + organizerId + " and Event ID " + eventId);
//        }
//        System.out.println("-----------------------------------");
//
//        // 2. Test getGrossSalesSummary
//        System.out.println("Testing getGrossSalesSummary...");
//        EventSalesSummary salesSummary = dao.getGrossSalesSummary(organizerId, eventId);
//        if (salesSummary != null) {
//            System.out.printf("Event: %s, Total Tickets Sold: %d, Gross Sales: %.2f VND\n",
//                    salesSummary.getEventName(), salesSummary.getTotalTicketsSold(), salesSummary.getGrossSales());
//        } else {
//            System.out.println("No sales summary found for Organizer ID " + organizerId + " and Event ID " + eventId);
//        }
//        System.out.println("-----------------------------------");
//
//        // 3. Test getSalesHistory
//        System.out.println("Testing getSalesHistory...");
//        Date startDate = new Date(System.currentTimeMillis() - 30L * 24 * 60 * 60 * 1000); // 30 ngày trước
//        Date endDate = new Date(); // Hôm nay
//
//        List<SalesHistory> salesHistory = dao.getSalesHistory(organizerId, eventId, startDate, endDate);
//        if (salesHistory != null && !salesHistory.isEmpty()) {
//            System.out.println("Sales History for Event ID " + eventId + " (Last 30 days):");
//            for (SalesHistory entry : salesHistory) {
//                System.out.printf("Date: %s, Tickets Sold: %d, Daily Sales: %.2f VND\n",
//                        entry.getSaleDate(), entry.getTicketsSold(), entry.getDailySales());
//            }
//        } else {
//            System.out.println("No sales history found for Organizer ID " + organizerId + " and Event ID " + eventId);
//        }

        EventSummaryDAO dao = new EventSummaryDAO();
        int organizerId = 2;
        int eventId = 2;

        // Test getRevenueByYearFull
        System.out.println("Testing getRevenueByYearFull...");
        List<EventSalesSummary> yearSummary = dao.getRevenueByYearFull(organizerId, eventId, 2025);
        if (yearSummary.isEmpty()) {
            System.out.println("No data found for getRevenueByYearFull.");
        } else {
            for (EventSalesSummary summary : yearSummary) {
                System.out.printf("Month: %d, Revenue: %.2f, Tickets Sold: %d\n",
                        summary.getPeriodDate().getMonth() + 1, summary.getRevenue(), summary.getTotalTicketsSold());
            }
        }

        // Test getRevenueBy30Days
        System.out.println("Testing getRevenueBy30Days...");
        List<EventSalesSummary> thirtyDaysSummary = dao.getRevenueBy30Days(organizerId, eventId);
        if (thirtyDaysSummary.isEmpty()) {
            System.out.println("No data found for getRevenueBy30Days.");
        } else {
            for (EventSalesSummary summary : thirtyDaysSummary) {
                System.out.printf("Date: %s, Revenue: %.2f, Tickets Sold: %d\n",
                        summary.getPeriodDate(), summary.getRevenue(), summary.getTotalTicketsSold());
            }
        }

        // Test getRevenueBy7Days
        System.out.println("Testing getRevenueBy7Days...");
        List<EventSalesSummary> sevenDaysSummary = dao.getRevenueBy7Days(organizerId, eventId);
        if (sevenDaysSummary.isEmpty()) {
            System.out.println("No data found for getRevenueBy7Days.");
        } else {
            for (EventSalesSummary summary : sevenDaysSummary) {
                System.out.printf("Date: %s, Revenue: %.2f, Tickets Sold: %d\n",
                        summary.getPeriodDate(), summary.getRevenue(), summary.getTotalTicketsSold());
            }
        }

        // Test getRevenueBy24Hours
        System.out.println("Testing getRevenueBy24Hours...");
        List<EventSalesSummary> twentyFourHoursSummary = dao.getRevenueBy24Hours(organizerId, eventId);
        if (twentyFourHoursSummary.isEmpty()) {
            System.out.println("No data found for getRevenueBy24Hours.");
        } else {
            for (EventSalesSummary summary : twentyFourHoursSummary) {
                System.out.printf("DateTime: %s, Revenue: %.2f, Tickets Sold: %d\n",
                        summary.getPeriod(), summary.getRevenue(), summary.getTotalTicketsSold());
            }
        }
    }
}
