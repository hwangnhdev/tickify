package controllers;

import dals.EventDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import models.EventDTO;

public class OrganizerEventController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy organizerId từ session hoặc đặt mặc định
        int organizerId = 2; // ví dụ, lấy từ session nếu cần
        String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "all";
        }

        EventDAO eventDAO = new EventDAO();
        List<EventDTO> events = eventDAO.getEventsByOrganizer(organizerId, filter);

        // Set danh sách sự kiện và filter hiện tại vào request để JSP hiển thị
        request.setAttribute("events", events);
        request.setAttribute("currentFilter", filter);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/organizerEvents.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "OrganizerEventController retrieves filtered events and forwards to /pages/organizerPage/organizerEventsorganizerEvents.jsp";
    }
}
