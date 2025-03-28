package controllers;

import dals.AdminDAO;
import dals.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import models.Event;
import viewModels.EventDetailDTO;

@WebServlet(name = "ApproveEventController", urlPatterns = {"/admin/approveEvent"})
public class ApproveEventController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventIdParam = request.getParameter("eventId");
        String newStatus = request.getParameter("newStatus");

        if (eventIdParam != null && !eventIdParam.trim().isEmpty()
                && newStatus != null && !newStatus.trim().isEmpty()) {
            try {
                int eventId = Integer.parseInt(eventIdParam);

                if (!newStatus.equals("Approved") && !newStatus.equals("Rejected")) {
                    response.getWriter().write("invalid");
                    return;
                }
                AdminDAO dao = new AdminDAO();
                EventDetailDTO updatedEvent = dao.updateEventStatus(eventId, newStatus);
                if (updatedEvent != null) {
                    response.getWriter().write("success");
                } else {
                    response.getWriter().write("fail");
                }
            } catch (NumberFormatException e) {
                response.getWriter().write("invalid");
            }
        } else {
            response.getWriter().write("invalid");
        }
    }
}
