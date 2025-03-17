package controllers;

import dals.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import viewModels.EventSummaryDTO;

public class OrganizerEventController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        System.out.println(session.getAttribute("customerId"));
        int customerId = (int) session.getAttribute("customerId");
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
