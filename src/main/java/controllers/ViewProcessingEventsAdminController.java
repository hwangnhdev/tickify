package controllers;

import dals.AdminDAO;
import models.Event;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class ViewProcessingEventsAdminController extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        String searchKeyword = request.getParameter("search");
        String processingStatus = "processing";

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
            events = dao.searchEventsByNameAndStatus(searchKeyword, processingStatus, page, PAGE_SIZE);
            totalEvents = dao.getTotalSearchEventsByNameAndStatus(searchKeyword, processingStatus);
            request.setAttribute("searchKeyword", searchKeyword);
        } else {
            events = dao.getEventsByStatus(processingStatus, page, PAGE_SIZE);
            totalEvents = dao.getTotalEventsByStatus(processingStatus);
        }

        int totalPages = (int) Math.ceil((double) totalEvents / PAGE_SIZE);

        request.setAttribute("events", events);
        request.setAttribute("page", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("selectedStatus", processingStatus);

        request.getRequestDispatcher("/pages/adminPage/viewProcessingEventsAdmin.jsp").forward(request, response);
    }
}
