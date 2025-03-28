/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;
import viewModels.TicketRevenueDTO;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventOverviewController extends HttpServlet {

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
            out.println("<title>Servlet EventOverviewController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventOverviewController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        EventDAO eventDAO = new EventDAO();

        List<Double> totals = eventDAO.getTotalRevenueOfEventById(eventId);

        // Kiểm tra totals có rỗng hoặc không đủ phần tử
        double totalRevenue = 0.0;
        int ticketsSold = 0;
        int totalTickets = 0;
        int ticketsRemaining = 0;
        double fillRate = 0.0;

        if (totals != null && totals.size() >= 5) {
            totalRevenue = totals.get(0);
            ticketsSold = totals.get(1).intValue();
            totalTickets = totals.get(2).intValue();
            ticketsRemaining = totals.get(3).intValue();
            fillRate = totals.get(4);
        } else {
            // Log lỗi nếu cần
            System.out.println("No data found for eventId: " + eventId);
            // Có thể thêm thông báo lỗi cho người dùng nếu cần
        }

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("ticketsSold", ticketsSold);
        request.setAttribute("totalTickets", totalTickets);
        request.setAttribute("ticketsRemaining", ticketsRemaining);
        request.setAttribute("fillRate", String.format("%.2f", fillRate));
        request.setAttribute("eventId", eventId);

        Map<Integer, List<TicketRevenueDTO>> showtimeTicketMap = eventDAO.getTicketRevenueByEventId(eventId);
        request.setAttribute("showtimeTicketMap", showtimeTicketMap);

        request.getRequestDispatcher("pages/organizerPage/eventOverviewStatistic.jsp").forward(request, response);
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
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Đọc dữ liệu từ request body
        StringBuilder jb = new StringBuilder();
        String line;
        try {
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                jb.append(line);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Parse JSON từ request
        JSONObject jsonRequest = new JSONObject(jb.toString());
        int eventId = jsonRequest.getInt("eventId");
        int year = jsonRequest.getInt("year");
        String timeRange = jsonRequest.getString("timeRange");

        EventDAO eventDAO = new EventDAO();
        JSONObject jsonResponse = new JSONObject();

        if ("year".equals(timeRange)) {
            List<Double> monthlyRevenue = eventDAO.getTotalRevenueChartOfEventById(eventId, year);
            List<Double> monthlyTickets = eventDAO.getTotalTicketsChartOfEventById(eventId, year);

            if (monthlyRevenue == null || monthlyRevenue.isEmpty()) {
                monthlyRevenue = new ArrayList<>(
                        Arrays.asList(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
            }
            if (monthlyTickets == null || monthlyTickets.isEmpty()) {
                monthlyTickets = new ArrayList<>(
                        Arrays.asList(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
            }

            jsonResponse.put("monthlyRevenue", new org.json.JSONArray(monthlyRevenue));
            jsonResponse.put("monthlyTickets", new org.json.JSONArray(monthlyTickets));
        } else if ("30days".equals(timeRange)) {
            List<Double> revenueLast30Days = eventDAO.getTotalRevenueLast30DaysOfEvent(eventId);
            List<Double> ticketsLast30Days = eventDAO.getTotalTicketsLast30DaysOfEvent(eventId);

            if (revenueLast30Days == null || revenueLast30Days.isEmpty()) {
                revenueLast30Days = new ArrayList<>(Collections.nCopies(30, 0.0));
            }
            if (ticketsLast30Days == null || ticketsLast30Days.isEmpty()) {
                ticketsLast30Days = new ArrayList<>(Collections.nCopies(30, 0.0));
            }

            jsonResponse.put("revenueLast30Days", new org.json.JSONArray(revenueLast30Days));
            jsonResponse.put("ticketsLast30Days", new org.json.JSONArray(ticketsLast30Days));
        } else if ("24hours".equals(timeRange)) {
            List<Double> revenueLast24Hours = eventDAO.getTotalRevenueLast24HoursOfEvent(eventId);
            List<Double> ticketsLast24Hours = eventDAO.getTotalTicketsLast24HoursOfEvent(eventId);

            if (revenueLast24Hours == null || revenueLast24Hours.isEmpty()) {
                revenueLast24Hours = new ArrayList<>(Collections.nCopies(24, 0.0));
            }
            if (ticketsLast24Hours == null || ticketsLast24Hours.isEmpty()) {
                ticketsLast24Hours = new ArrayList<>(Collections.nCopies(24, 0.0));
            }

            jsonResponse.put("revenueLast24Hours", new org.json.JSONArray(revenueLast24Hours));
            jsonResponse.put("ticketsLast24Hours", new org.json.JSONArray(ticketsLast24Hours));
        }

        try ( PrintWriter out = response.getWriter()) {
            out.print(jsonResponse.toString());
            out.flush();
        }
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
