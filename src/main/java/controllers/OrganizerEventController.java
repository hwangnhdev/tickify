package controllers;

import dals.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import viewModels.EventSummaryDTO;

public class OrganizerEventController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy customerId từ session hoặc dùng mặc định (ở đây mặc định là 1)
        int customerId = 1;
        String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "all";
        }

        OrganizerDAO organizerDAO = new OrganizerDAO();
        List<EventSummaryDTO> events = organizerDAO.getEventsByCustomer(customerId, filter);

        // Đặt danh sách sự kiện và bộ lọc hiện tại vào request để JSP hiển thị
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
        return "OrganizerEventController retrieves filtered events and forwards to organizerEvents.jsp";
    }
}
