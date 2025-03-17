/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dals.AdminDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.Event;
import models.TicketType;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class RevenueDetailController extends HttpServlet {
    
    private final AdminDAO adminDao = new AdminDAO();
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RevenueDetailController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueDetailController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);
        String eventIdParam = request.getParameter("eventId");
        String eventNameParam = request.getParameter("eventName");
        String totalRevenueParam = request.getParameter("totalRevenue");
        
        if (eventIdParam == null || eventIdParam.isEmpty()) {
            response.sendRedirect("/admin/revenue");
            return;
        }

        int eventId = Integer.parseInt(eventIdParam);
        double totalRevenue = Double.parseDouble(totalRevenueParam);
        List<TicketType> revenueDetails = adminDao.getRevenueDetailByEventId(eventId);
        
        request.setAttribute("revenueDetails", revenueDetails);
        request.setAttribute("eventId", eventId);
        request.setAttribute("eventName", eventNameParam);
        request.setAttribute("totalRevenue", totalRevenue);
        request.getRequestDispatcher("/pages/adminPage/revenueDetail.jsp").forward(request, response);
    
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
