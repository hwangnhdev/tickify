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
import java.util.Iterator;
import java.util.List;
import models.Category;
import models.EventImage;
import models.Event;
import viewModels.FilterEvent;
import models.Organizer;
import models.Showtime;
import models.TicketType;
import viewModels.EventDTO;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventDetailController extends HttpServlet {

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
            out.println("<title>Servlet EventDetailController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventDetailController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
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
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID");
            return;
        }

        // Lấy thông tin chi tiết của sự kiện
        Event eventDetail = eventDAO.selectEventByID(eventId);
        if (eventDetail == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found");
            return;
        }

        Category eventCategories = eventDAO.selectEventCategoriesID(eventId);
        List<EventImage> listEventImages = eventDAO.getImageEventsByEventId(eventId);
        Organizer organizer = eventDAO.getOrganizerByEventId(eventId);
        List<Showtime> listShowtimes = eventDAO.getShowTimesByEventId(eventId);

        for (Showtime showtime : listShowtimes) {
            List<TicketType> ticketTypes = eventDAO.getTicketTypesByShowtimeId(showtime.getShowtimeId());
            showtime.setTicketTypes(ticketTypes);
        }

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

        request.setAttribute("eventId", eventId); // Sửa eventID thành eventId để đồng bộ với JSP
        request.setAttribute("eventDetail", eventDetail);
        request.setAttribute("eventCategories", eventCategories);
        request.setAttribute("organizer", organizer);
        request.setAttribute("listShowtimes", listShowtimes);

        // Pagination parameters for Relevant Events
        int page = 1;
        int pageSize = 20; // Đặt pageSize là 1 để đồng bộ với giao diện (1 sự kiện mỗi trang)
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Relevant Events
        List<Integer> categories = new ArrayList<>();
        categories.add(eventDetail.getCategoryId());
        FilterEvent filters = new FilterEvent(categories, null, null, null, null, false, null);
        List<EventDTO> relevantEvents = filterEventDAO.getFilteredEvents(filters);

        // Loại bỏ sự kiện hiện tại
        Iterator<EventDTO> iterator = relevantEvents.iterator();
        while (iterator.hasNext()) {
            EventDTO event = iterator.next();
            if (event.getEvent().getEventId() == eventId) {
                iterator.remove();
            }
        }

        // Tính toán phân trang cho Relevant Events
        int totalRelevantEvents = relevantEvents.size();
        int totalPages = (int) Math.ceil((double) totalRelevantEvents / pageSize);

        // Đảm bảo page không vượt quá totalPages
        if (page > totalPages && totalPages > 0) {
            page = totalPages; // Nếu page vượt quá totalPages, đặt lại về trang cuối
        } else if (page < 1) {
            page = 1; // Nếu page nhỏ hơn 1, đặt về trang 1
        }

        int startIndex = (page - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, totalRelevantEvents);
        List<EventDTO> paginatedRelevantEvents = (List<EventDTO>) ((totalRelevantEvents > 0)
                ? relevantEvents.subList(startIndex, endIndex)
                : new ArrayList<>());

        // Pagination parameters for All Events
        int pageAll = 1;
        int pageSizeAll = 20; // pageSize cho All Events có thể giữ nguyên 20
        if (request.getParameter("pageAll") != null) {
            try {
                pageAll = Integer.parseInt(request.getParameter("pageAll"));
            } catch (NumberFormatException e) {
                pageAll = 1;
            }
        }

        // All Events
        int totalEventsAll = eventDAO.getTotalEvents();
        int totalPagesAll = (int) Math.ceil((double) totalEventsAll / pageSizeAll);
        if (pageAll > totalPagesAll && totalPagesAll > 0) {
            pageAll = totalPagesAll; // Đảm bảo pageAll không vượt quá totalPagesAll
        } else if (pageAll < 1) {
            pageAll = 1;
        }
        List<EventDTO> paginatedEventsAll = eventDAO.getEventsByPage(pageAll, pageSizeAll);

        // Ajax request
        String ajaxHeader = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(ajaxHeader)) {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            if (!paginatedRelevantEvents.isEmpty()) {
                out.print(toJson(paginatedRelevantEvents, totalPages, page, "relevant"));
            } else {
                out.print(toJson(paginatedEventsAll, totalPagesAll, pageAll, "all"));
            }
            out.flush();
            return;
        }

        // Normal request
        request.setAttribute("relevantEvents", paginatedRelevantEvents);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("paginatedEventsAll", paginatedEventsAll);
        request.setAttribute("pageAll", pageAll);
        request.setAttribute("totalPagesAll", totalPagesAll);

        request.getRequestDispatcher("pages/listEventsPage/eventDetail.jsp").forward(request, response);
    }

    // Hàm trả về JSON với thêm type để phân biệt "relevant" hay "all"
    private String toJson(List<EventDTO> events, int totalPages, int currentPage, String type) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"type\":\"").append(type).append("\",");
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
