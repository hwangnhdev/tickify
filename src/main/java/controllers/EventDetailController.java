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
import java.util.List;
import models.Categories;
import models.EventImages;
import models.Events;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventDetailController extends HttpServlet {

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
            out.println("<title>Servlet EventDetailController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventDetailController at " + request.getContextPath() + "</h1>");
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
        EventDAO eventDAO = new EventDAO();

        /*Get ID of Event*/
        String id = request.getParameter("id");
        int eventId = 0;
        try {
            eventId = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        Events eventDetail = eventDAO.selectEventByID(eventId);
        EventImages eventImage = eventDAO.selectEventImagesByID(eventId);
        Categories eventCategories = eventDAO.selectEventCategoriesID(eventId);
        request.setAttribute("eventDetail", eventDetail);
        request.setAttribute("eventImage", eventImage);
        request.setAttribute("eventCategories", eventCategories);

        /*Pagination list of events*/
        // Get the requested page number, default to 1 if not provided
        int page = 1;
        int pageSize = 20;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1; // Fallback to page 1 in case of an invalid input
            }
        }
        // Get total number of events and calculate total pages
        int totalEvents = eventDAO.getTotalEvents();
        int totalPages = (int) Math.ceil((double) totalEvents / pageSize);
        // Fetch paginated list of events
        List<Events> paginatedEvents = eventDAO.getEventsByPage(page, pageSize);
        request.setAttribute("paginatedEvents", paginatedEvents);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // Forward the request and response to the home.jsp page to display the events
        request.getRequestDispatcher("pages/listEventsPage/eventDetail.jsp").forward(request, response);
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
