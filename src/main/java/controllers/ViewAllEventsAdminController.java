package controllers;

import dals.AdminDAO;
import models.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ViewAllEventsAdminController extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        String status = request.getParameter("status");
        if (status == null) {
            status = "";
        }
        String searchKeyword = request.getParameter("search");
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        AdminDAO dao = new AdminDAO();
        List<Event> events;
        int totalEvents;

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Search by name without filtering by status
            events = dao.searchEventsByName(searchKeyword, page, PAGE_SIZE);
            totalEvents = dao.getTotalSearchEventsByName(searchKeyword);
            request.setAttribute("searchKeyword", searchKeyword);
        } else if (status.isEmpty()) {
            events = dao.getAllEvents(page, PAGE_SIZE);
            totalEvents = dao.getTotalEvents();
        } else {
            // When status parameter is provided (e.g., "Pending")
            events = dao.getEventsByStatus(status, page, PAGE_SIZE);
            totalEvents = dao.getTotalEventsByStatus(status);
        }

        int totalPages = (int) Math.ceil((double) totalEvents / PAGE_SIZE);

        request.setAttribute("events", events);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("selectedStatus", status);

        request.getRequestDispatcher("/pages/adminPage/viewAllEventsAdmin.jsp").forward(request, response);
    }
}
