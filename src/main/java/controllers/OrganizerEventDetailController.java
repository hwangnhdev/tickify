package controllers;

import dals.EventDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.OrganizerEventDetail;

@WebServlet(name = "OrganizerEventDetailController", urlPatterns = {"/organizerEventDetail"})
public class OrganizerEventDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số eventId từ URL
        String eventIdStr = request.getParameter("eventId");
        // Nếu không có eventId, sử dụng giá trị mặc định (cho mục đích test)
        if (eventIdStr == null || eventIdStr.trim().isEmpty()) {
            eventIdStr = "1";
        }

        try {
            int eventId = Integer.parseInt(eventIdStr);
            // Lấy customerId (ví dụ sử dụng 1 cho mục đích test, hoặc lấy từ session)
            int customerId = 1;
            
            EventDAO eventDAO = new EventDAO();
            // Gọi phương thức truy vấn với eventId và customerId
            OrganizerEventDetail detail = eventDAO.getOrganizerEventDetail(eventId, customerId);

            if (detail != null) {
                // Set attribute để chuyển sang view JSP
                request.setAttribute("organizerEventDetail", detail);
                request.getRequestDispatcher("pages/organizerPage/viewOrganizerEventDetail.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event not found");
            }
        } catch (NumberFormatException ex) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Event ID");
        }
    }
}
