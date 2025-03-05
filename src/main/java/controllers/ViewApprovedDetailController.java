package controllers;

import dals.EventAdminDAO;
import models.EventAdmin;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "ViewApprovedDetailController", urlPatterns = {"/admin/viewApprovedDetail"})
public class ViewApprovedDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventIdStr = request.getParameter("eventId");
        int eventId;
        try {
            eventId = Integer.parseInt(eventIdStr);
            System.out.println("Fetching event with ID: " + eventId); // Thêm log
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid event ID.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        EventAdminDAO dao = new EventAdminDAO();
        EventAdmin event = dao.getApprovedEventDetailById(eventId);
        if (event == null) {
            System.out.println("Event not found or not approved for ID: " + eventId); // Thêm log
            request.setAttribute("error", "Event not found or not approved.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } else {
            System.out.println("Event found: " + event.getEventName()); // Thêm log
            request.setAttribute("event", event);
            request.getRequestDispatcher("/pages/adminPage/viewApprovedDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}