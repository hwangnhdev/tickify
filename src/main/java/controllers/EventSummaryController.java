/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import dals.EventSummaryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import models.EventSalesSummary;
import models.SalesHistory;
import models.TicketSummary;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventSummaryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EventStatisticController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventStatisticController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int organizerId = 2; // Replace with session or request data
        int eventId = 2;     // Replace with request parameter

        if (organizerId <= 0 || eventId <= 0) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid organizer or event ID");
            return;
        }

        String period = request.getParameter("period") != null ? request.getParameter("period") : "24h";
        EventSummaryDAO dao = new EventSummaryDAO();

        // Fetch summary data
        List<TicketSummary> ticketSummaries = dao.getSoldTicketsSummary(organizerId, eventId);
        EventSalesSummary salesSummary = dao.getGrossSalesSummary(organizerId, eventId);

        // Fetch chart data based on the period
        List<EventSalesSummary> chartData;
        switch (period) {
            case "24h":
                chartData = dao.getRevenueBy24Hours(organizerId, eventId);
                break;
            case "7d":
                chartData = dao.getRevenueBy7Days(organizerId, eventId);
                break;
            case "30d":
                chartData = dao.getRevenueBy30Days(organizerId, eventId);
                break;
            case "365d":
                chartData = dao.getRevenueByYearFull(organizerId, eventId, 2025); // Assuming year 2025 for this example
                System.out.println("Chart Data for 365d: " + chartData); // Debug print
                break;
            default:
                chartData = dao.getRevenueBy24Hours(organizerId, eventId); // Default to 24h
                break;
        }

        // If no chart data, return a list with zeros for each period's expected labels
        if (chartData == null || chartData.isEmpty()) {
            chartData = generateDefaultChartData(period);
            System.out.println("Generated default chart data for period " + period + ": " + chartData);
        }

        // Set attributes for JSP
        request.setAttribute("ticketSummaries", ticketSummaries != null ? ticketSummaries : new ArrayList<>());
        request.setAttribute("salesSummary", salesSummary);
        request.setAttribute("chartData", chartData);

        // Convert chart data to JSON for the chart
        Gson gson = new Gson();
        String chartDataJson = gson.toJson(chartData);
        System.out.println("Chart Data JSON for period " + period + ": " + chartDataJson); // Debug print
        request.setAttribute("chartDataJson", chartDataJson);

        // Handle AJAX request
        if ("json".equals(request.getParameter("format"))) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(chartDataJson);
            return;
        }

        // Forward to JSP
        request.getRequestDispatcher("/pages/organizerPage/eventStatistic.jsp").forward(request, response);
    }

    /**
     * Generate default chart data with zeros for each period if no real data
     * exists.
     */
    private List<EventSalesSummary> generateDefaultChartData(String period) {
        List<EventSalesSummary> defaultData = new ArrayList<>();
        List<String> labels = getLabelsForPeriod(period);

        for (String label : labels) {
            EventSalesSummary summary = new EventSalesSummary();
            summary.setDate(label); // Use setDate instead of a non-existent setDate method
            summary.setRevenue(0.0); // Default revenue to 0
            summary.setTotalTicketsSold(0); // Default tickets sold to 0
            defaultData.add(summary);
        }
        return defaultData;
    }

    /**
     * Get labels based on the period (simulating the existing label structure).
     */
    private List<String> getLabelsForPeriod(String period) {
        List<String> labels = new ArrayList<>();
        switch (period) {
            case "24h":
                for (int i = 8; i <= 22; i++) {
                    labels.add(String.format("%02d:00", i));
                }
                break;
            case "7d":
                for (int i = 1; i <= 7; i++) {
                    labels.add(String.format("01/02/%d", i + 1)); // Example: Feb 1-7, 2025
                }
                break;
            case "30d":
                for (int i = 24; i <= 21; i += 2) { // Example: Jan 24 to Feb 21, 2025
                    labels.add(String.format("%02d/01", i)); // Adjust for actual dates
                }
                break;
            case "365d":
                for (int i = 1; i <= 12; i++) { // Example: Monthly for 2024-2025
                    labels.add(String.format("01/%02d/2024", i));
                }
                labels.add("01/01/2025"); // Add Feb 1, 2025
                labels.add("01/02/2025");
                break;
            default:
                for (int i = 8; i <= 22; i++) {
                    labels.add(String.format("%02d:00", i));
                }
        }
        return labels;
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
