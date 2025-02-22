/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.EventSummaryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
        int organizerId = 2; // ID của Organizer (ví dụ)
        int eventId = 2;     // ID của sự kiện "Birthday" (ví dụ)

        // Tạo đối tượng DAO
        EventSummaryDAO dao = new EventSummaryDAO();

        // Lấy thông tin vé đã bán
        List<TicketSummary> ticketSummaries = dao.getSoldTicketsSummary(organizerId, eventId);
        request.setAttribute("ticketSummaries", ticketSummaries);

        // Lấy thông tin doanh thu
        EventSalesSummary salesSummary = dao.getGrossSalesSummary(organizerId, eventId);
        request.setAttribute("salesSummary", salesSummary);

        // Lấy lịch sử doanh thu (ví dụ: 30 ngày gần nhất)
        java.util.Date startDate = new java.util.Date(System.currentTimeMillis() - 30L * 24 * 60 * 60 * 1000); // 30 ngày trước
        java.util.Date endDate = new java.util.Date(); // Hôm nay
        List<SalesHistory> salesHistory = dao.getSalesHistory(organizerId, eventId, startDate, endDate);
        request.setAttribute("salesHistory", salesHistory);

        // Chuyển tiếp đến JSP để hiển thị
        request.getRequestDispatcher("/pages/organizerPage/eventStatistic.jsp").forward(request, response);
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
