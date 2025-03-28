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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int customerId = 0;
        try {
            customerId = Integer.parseInt(session.getAttribute("customerId").toString());
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String filter = request.getParameter("filter");
        if (filter == null || filter.trim().isEmpty()) {
            filter = "all";
        }
        String eventName = request.getParameter("eventName");
        if (eventName != null && eventName.trim().isEmpty()) {
            eventName = null;
        }

        OrganizerDAO organizerDAO = new OrganizerDAO();
        List<EventSummaryDTO> events = organizerDAO.getEventsByCustomer(customerId, filter, eventName);
        request.setAttribute("events", events);
        request.setAttribute("filter", filter); // Để fragment có thể biết bộ lọc hiện tại

        // Nếu là AJAX request, forward đến JSP fragment để chỉ render phần danh sách sự kiện
        if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/_eventsFragment.jsp");
            dispatcher.forward(request, response);
        } else {
            // Nếu không phải AJAX thì forward toàn bộ trang
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/organizerEvents.jsp");
            dispatcher.forward(request, response);
        }
    }
}
