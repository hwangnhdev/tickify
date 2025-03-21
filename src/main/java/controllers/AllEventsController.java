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
import viewModels.EventDTO;
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
            out.println("<title>Servlet AllEventsController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AllEventsController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        FilterEventDAO filterEventDAO = new FilterEventDAO();
        EventDAO eventDAO = new EventDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Load categories
        List<Category> listCategories = categoryDAO.getAllCategories();
        session.setAttribute("listCategories", listCategories);

        // Get filter parameters
        String[] categoryIds = request.getParameterValues("category");
        String location = request.getParameter("location");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String price = request.getParameter("price");
        String searchQuery = request.getParameter("query");

        // Convert category IDs
        List<Integer> categories = new ArrayList<>();
        if (categoryIds != null) {
            for (String id : categoryIds) {
                categories.add(Integer.parseInt(id));
            }
        }

        // Convert dates
        Date startDate = (startDateStr != null && !startDateStr.isEmpty()) ? Date.valueOf(startDateStr) : null;
        Date endDate = (endDateStr != null && !endDateStr.isEmpty()) ? Date.valueOf(endDateStr) : null;

        // Create filter object
        FilterEvent filters = new FilterEvent(categories, location, startDate, endDate, price, false, searchQuery);

        // Store filters in session (for persistence across requests)
        session.setAttribute("searchQuery", searchQuery);
        session.setAttribute("selectedCategories", categories);
        session.setAttribute("selectedLocation", location);
        session.setAttribute("selectedStartDate", startDateStr);
        session.setAttribute("selectedEndDate", endDateStr);
        session.setAttribute("selectedPrice", price);

        // Pagination parameters
        int page = 1;
        int pageSize = 20;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Get filtered events
        List<EventDTO> filteredEvents = filterEventDAO.getFilteredEvents(filters);
        int totalEvents = filteredEvents.size();
        int totalPages = (int) Math.ceil((double) totalEvents / pageSize);
        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalEvents);
        List<EventDTO> paginatedFilteredEvents = (List<EventDTO>) ((totalEvents > 0) ? filteredEvents.subList(startIndex, endIndex) : new ArrayList<>());

        // Get all events for fallback
        int totalEventsAll = eventDAO.getTotalEvents();
        int totalPagesAll = (int) Math.ceil((double) totalEventsAll / pageSize);
        List<EventDTO> paginatedEventsAll = eventDAO.getEventsByPage(page, pageSize);

        // Check if this is an Ajax request
        String ajaxHeader = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(ajaxHeader)) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            if (totalEvents == 0) {
                out.print(toJson(paginatedEventsAll, totalPagesAll, page));
            } else {
                out.print(toJson(paginatedFilteredEvents, totalPages, page));
            }
            out.flush();
            return;
        }

        // Normal request: Forward to JSP with all filter params preserved
        request.setAttribute("filteredEvents", paginatedFilteredEvents);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("paginatedEventsAll", paginatedEventsAll);
        request.setAttribute("pageAll", page);
        request.setAttribute("totalPagesAll", totalPagesAll);
        // Preserve original query string for pagination links
        request.setAttribute("queryString", request.getQueryString());

        request.getRequestDispatcher("pages/listEventsPage/allEvents.jsp").forward(request, response);
    }

    private String toJson(List<EventDTO> events, int totalPages, int currentPage) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"events\":[");
        for (int i = 0; i < events.size(); i++) {
            EventDTO event = events.get(i);
            json.append("{");
            json.append("\"id\":").append(event.getEvent().getEventId()).append(",");
            String escapedName = event.getEvent().getEventName().replace("\"", "\\\"");
            json.append("\"name\":\"").append(escapedName).append("\",");
            String escapedImageUrl = event.getEventImage().getImageUrl().replace("\"", "\\\"");
            String escapedImageTitle = event.getEventImage().getImageTitle().replace("\"", "\\\"");
            json.append("\"imageUrl\":\"").append(escapedImageUrl).append("\",");
            json.append("\"imageTitle\":\"").append(escapedImageTitle).append("\",");
            json.append("\"minPrice\":").append(event.getMinPrice()).append(",");
            json.append("\"firstStartDate\":\"").append(event.getFirstStartDate()).append("\"");
            json.append("}");
            if (i < events.size() - 1) {
                json.append(",");
            }
        }
        json.append("],");
        json.append("\"totalPages\":").append(totalPages).append(",");
        json.append("\"currentPage\":").append(currentPage);
        json.append("}");
        return json.toString();
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
