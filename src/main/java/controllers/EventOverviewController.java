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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import org.json.JSONObject;

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
//        int eventId = Integer.parseInt(request.getParameter("eventId"));
//        int organizerId = Integer.parseInt(request.getParameter("organizerId"));

        EventDAO eventDAO = new EventDAO();

        // Lấy dữ liệu tổng quan
        List<Double> totals = eventDAO.getTotalRevenueOfEventById(1, 1); // Cho eventId, organizerId là 1 to test
        double totalRevenue = totals.get(0);
        int ticketsSold = totals.get(1).intValue();
        int ticketsRemaining = totals.get(2).intValue();
        double fillRate = totals.get(3);

        request.setAttribute("totalRevenue", totalRevenue);
        request.setAttribute("ticketsSold", ticketsSold);
        request.setAttribute("ticketsRemaining", ticketsRemaining);
        request.setAttribute("fillRate", fillRate);

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
        EventDAO eventDAO = new EventDAO();
//        int eventId = Integer.parseInt(request.getParameter("eventId"));
//        int organizerId = Integer.parseInt(request.getParameter("organizerId"));
//        int year = Integer.parseInt(request.getParameter("year"));

        List<Double> monthlyRevenue = eventDAO.getTotalRevenueChartOfEventById(1, 1, 2025); // Set value of eventid, organizer, year are 1, 1, 2025
        if (monthlyRevenue == null || monthlyRevenue.isEmpty()) {
            monthlyRevenue = new ArrayList<>(Arrays.asList(0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0));
        }

        JSONObject jsonResponse = new JSONObject();
        StringBuilder monthlyRevenueArray = new StringBuilder("[");
        for (int i = 0; i < monthlyRevenue.size(); i++) {
            monthlyRevenueArray.append(monthlyRevenue.get(i));
            if (i < monthlyRevenue.size() - 1) {
                monthlyRevenueArray.append(",");
                System.out.println(monthlyRevenue.get(i));
            }
        }
        monthlyRevenueArray.append("]");
        jsonResponse.put("monthlyRevenue", new org.json.JSONArray(monthlyRevenue));

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
