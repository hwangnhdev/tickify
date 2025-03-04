package controllers;

import com.google.gson.Gson;
import dals.EventDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import models.Event;
import models.EventDTO;

public class OrganizerEventController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy organizerId từ session hoặc đặt mặc định
        int organizerId = 98; // ví dụ, lấy từ session nếu cần
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
        // Lấy organizerId từ session hoặc đặt mặc định
        int organizerId = 98; // Ví dụ, nên lấy từ session nếu có: (int) request.getSession().getAttribute("organizerId");

        // Kiểm tra xem có tham số eventName không (dành cho AJAX)
        String eventName = request.getParameter("eventName");
        EventDAO eventDAO = new EventDAO();

        // Xử lý yêu cầu AJAX tìm kiếm theo tên
        List<Event> events = eventDAO.searchEventByName(eventName, organizerId);

        // Chuyển đổi danh sách sự kiện thành JSON
        Gson gson = new Gson();
        String json = gson.toJson(events);

        // Thiết lập phản hồi JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(json);
    }

    @Override
    public String getServletInfo() {
        return "OrganizerEventController retrieves filtered events and forwards to /pages/organizerPage/organizerEventsorganizerEvents.jsp";
    }
}
