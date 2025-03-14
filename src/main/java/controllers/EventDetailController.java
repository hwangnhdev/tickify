/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.EventDAO;
import dals.FilterEventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import models.Category;
import models.EventImage;
import models.Event;
import viewModels.FilterEvent;
import models.Organizer;
import models.Showtime;
import models.TicketType;

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
        FilterEventDAO filterEventDAO = new FilterEventDAO();

        /* Get ID of Event */
        String id = request.getParameter("id");
        int eventId = 0;
        try {
            eventId = Integer.parseInt(id);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        Event eventDetail = eventDAO.selectEventByID(eventId);
        Category eventCategories = eventDAO.selectEventCategoriesID(eventId);
        List<EventImage> listEventImages = eventDAO.getImageEventsByEventId(eventId);
        Organizer organizer = eventDAO.getOrganizerByEventId(eventId);
        List<Showtime> listShowtimes = eventDAO.getShowTimesByEventId(eventId);

        // Populate ticket types for each showtime
        for (Showtime showtime : listShowtimes) {
            List<TicketType> ticketTypes = eventDAO.getTicketTypesByShowtimeId(showtime.getShowtimeId());
            showtime.setTicketTypes(ticketTypes);
        }

        // Set event image attributes
        for (EventImage image : listEventImages) {
            if (image.getImageTitle().equalsIgnoreCase("logo_event")) {
                request.setAttribute("logoEventImage", image.getImageUrl());
                request.setAttribute("titleEventImage", image.getImageTitle());
            }
            if (image.getImageTitle().equalsIgnoreCase("logo_banner")) {
                request.setAttribute("logoBannerImage", image.getImageUrl());
                request.setAttribute("titleBannerImage", image.getImageTitle());
            }
            if (image.getImageTitle().equalsIgnoreCase("logo_organizer")) {
                request.setAttribute("logoOrganizerImage", image.getImageUrl());
                request.setAttribute("titleOrganizerImage", image.getImageTitle());
            }
        }

        request.setAttribute("eventID", eventId);
        request.setAttribute("eventDetail", eventDetail);
        request.setAttribute("eventCategories", eventCategories);
        request.setAttribute("organizer", organizer);
        request.setAttribute("listShowtimes", listShowtimes);

        // Filter and pagination logic (unchanged)
        String[] categoryIds = request.getParameterValues("categoryId");
        String location = request.getParameter("location");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String price = request.getParameter("price");
        String searchQuery = request.getParameter("query");

        List<Integer> categories = new ArrayList<>();
        if (categoryIds != null) {
            for (String idCat : categoryIds) {
                categories.add(Integer.parseInt(idCat));
            }
        }

        Date startDate = (startDateStr != null && !startDateStr.isEmpty()) ? Date.valueOf(startDateStr) : null;
        Date endDate = (endDateStr != null && !endDateStr.isEmpty()) ? Date.valueOf(endDateStr) : null;

        FilterEvent filters = new FilterEvent(categories, null, null, null, null, false, null);
        List<EventImage> filteredEvents = filterEventDAO.getFilteredEvents(filters);

        int page = 1;
        int pageSize = 20;
        int totalEvents = filteredEvents.size();
        int totalPages = (int) Math.ceil((double) totalEvents / pageSize);

        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
                if (page < 1 || page > totalPages) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalEvents);
        List<EventImage> paginatedEvents = filteredEvents.subList(startIndex, endIndex);

        request.setAttribute("filteredEvents", paginatedEvents);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

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
