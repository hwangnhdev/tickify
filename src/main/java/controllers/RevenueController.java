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

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class RevenueController extends HttpServlet {
    
    private static final int PAGE_SIZE = 30;
   
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
            out.println("<title>Servlet RevenueController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RevenueController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 
    
    protected void revenue(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        int page = 1;
        String status = request.getParameter("status");
        if (status == null) {
            status = "";
        }
        String searchKeyword = request.getParameter("search");
//        try {
//            String pageParam = request.getParameter("page");
//            if (pageParam != null && !pageParam.trim().isEmpty()) {
//                page = Integer.parseInt(pageParam);
//            }
//        } catch (NumberFormatException e) {
//            page = 1;
//        }

        AdminDAO adminDao = new AdminDAO();
        List<Event> revenues = adminDao.selectAllRevenues();
//        int totalEvents;

//        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
//            // Search by name without filtering by status
//            events = dao.searchEventsByName(searchKeyword, page, PAGE_SIZE);
//            totalEvents = dao.getTotalSearchEventsByName(searchKeyword);
//            request.setAttribute("searchKeyword", searchKeyword);
//        } else if (status.isEmpty()) {
//            events = dao.getAllEvents(page, PAGE_SIZE);
//            totalEvents = dao.getTotalEvents();
//        } else {
//            // When status parameter is provided (e.g., "Pending")
//            events = dao.getEventsByStatus(status, page, PAGE_SIZE);
//            totalEvents = dao.getTotalEventsByStatus(status);
//        }
//
//        int totalPages = (int) Math.ceil((double) totalEvents / PAGE_SIZE);

        request.setAttribute("revenues", revenues);
//        request.setAttribute("page", page);
//        request.setAttribute("totalPages", totalPages);
//        request.setAttribute("selectedStatus", status);

        request.getRequestDispatcher("/pages/adminPage/revenue.jsp").forward(request, response);
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
        revenue(request, response);
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
