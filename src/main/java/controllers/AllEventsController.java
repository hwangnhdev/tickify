/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.CategoryDAO;
import dals.EventDAO;
import dals.FilterEventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import models.Category;
import models.Event;
import models.EventImage;<<<<<<<HEAD=======
import viewModels.EventDTO;>>>>>>>9 b2899d5bc5fd14442f22e5d9a22f2eb30cdef66
import viewModels.FilterEvent;

/**
 * import dals.FilterEventDAO; import java.io.IOException; import
 * java.io.PrintWriter; import jakarta.servlet.ServletException; import
 * jakarta.servlet.http.HttpServlet;
 *
 * @author Tang Thanh Vui - CE180901
 */
public class AllEventsController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AllEventsController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AllEventsController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        FilterEventDAO filterEventDAO = new FilterEventDAO();
        EventDAO eventDAO = new EventDAO();

        // Call all DAO to get methods in it
        CategoryDAO categoryDAO = new CategoryDAO();
        // Get all category and store it in list categories
        List<Category> listCategories = categoryDAO.getAllCategories();
        // Set attribute for DAO
        session.setAttribute("listCategories", listCategories);

        // Get filter parameters
        String[] categoryIds = request.getParameterValues("category");
        String location = request.getParameter("location");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String price = request.getParameter("price");
        String searchQuery = request.getParameter("query");

        // Convert category ID list
        List<Integer> categories = new ArrayList<>();
        if (categoryIds != null) {
            for (String id : categoryIds) {
                categories.add(Integer.parseInt(id));
            }
        }

        // Convert date parameters
        Date startDate = (startDateStr != null && !startDateStr.isEmpty()) ? Date.valueOf(startDateStr) : null;
        Date endDate = (endDateStr != null && !endDateStr.isEmpty()) ? Date.valueOf(endDateStr) : null;

        // Create filter object
        FilterEvent filters = new FilterEvent(categories, location, startDate, endDate, price, false, searchQuery);

        // Store filters in session to persist state across pages
        session.setAttribute("searchQuery", searchQuery);
        session.setAttribute("selectedCategories", categories);
        session.setAttribute("selectedLocation", location);
        session.setAttribute("selectedStartDate", startDateStr);
        session.setAttribute("selectedEndDate", endDateStr);
        session.setAttribute("selectedPrice", price);

        // Get filtered events
<<<<<<< HEAD
        List<EventImage> filteredEvents = filterEventDAO.getFilteredEvents(filters);
        System.out.println("Filtered Events Count: " + filteredEvents.size()); // Debug log
=======
        List<EventDTO> filteredEvents = filterEventDAO.getFilteredEvents(filters);
//        System.out.println("Filtered Events Count: " + filteredEvents.size()); // Debug log
>>>>>>> 9b2899d5bc5fd14442f22e5d9a22f2eb30cdef66

        // Pagination logic
        int page = 1;
        int pageSize = 20; // Show 10 events per page
        int totalEvents = filteredEvents.size();
        int totalPages = (int) Math.ceil((double) totalEvents / pageSize);

        // Get requested page number
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1 || page > totalPages) {
                    page = 1; // Reset to page 1 if invalid
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Get events for the requested page
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalEvents);
<<<<<<< HEAD
        List<EventImage> paginatedEvents = filteredEvents.subList(startIndex, endIndex);
=======
        List<EventDTO> paginatedEvents = filteredEvents.subList(startIndex, endIndex);
>>>>>>> 9b2899d5bc5fd14442f22e5d9a22f2eb30cdef66

        // Send attributes to JSP
        request.setAttribute("filteredEvents", paginatedEvents);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        // <!--All Event For You-->  Get the requested page number, default to 1 if not provided 
        int pageAll = 1;
        int pageSizeAll = 20;
        if (request.getParameter("page") != null) {
            try {
                pageAll = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                pageAll = 1; // Fallback to page 1 in case of an invalid input
            }
        }

        // Get total number of events and calculate total pages
        int totalEventsAll = eventDAO.getTotalEvents();
        int totalPagesAll = (int) Math.ceil((double) totalEventsAll / pageSizeAll);

        // Fetch paginated list of events
        List<EventDTO> paginatedEventsAll = eventDAO.getEventsByPage(pageAll, pageSizeAll);
        request.setAttribute("paginatedEventsAll", paginatedEventsAll);
        request.setAttribute("pageAll", pageAll);
        request.setAttribute("totalPagesAll", totalPagesAll);

        // Forward to JSP
        request.getRequestDispatcher("pages/listEventsPage/allEvents.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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
