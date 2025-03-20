package controllers;

import dals.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import viewModels.EventDetailDTO;

@WebServlet("/organizer/eventDetail")
public class OrganizerEventDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        HttpSession session = request.getSession();

        // Lấy eventId từ request parameter, nếu không có thì lấy từ session
        String eventIdParam = request.getParameter("eventId");
        int eventId;
        if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
            try {
                eventId = Integer.parseInt(eventIdParam);
                session.setAttribute("eventId", eventId);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID: must be an integer.");
                return;
            }
        } else {
            Object eventIdObj = session.getAttribute("eventId");
            if (eventIdObj != null) {
                try {
                    eventId = Integer.parseInt(eventIdObj.toString());
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID in session.");
                    return;
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Event ID is required.");
                return;
            }
        }

        OrganizerDAO organizerDAO = new OrganizerDAO();
        // Lấy chi tiết event chỉ dựa trên eventId
        EventDetailDTO detail = organizerDAO.getEventDetail(eventId);
        if (detail == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event detail not found.");
            return;
        }

        // Set attribute để JSP hiển thị
        request.setAttribute("organizerEventDetail", detail);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/viewOrganizerEventDetail.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "OrganizerEventDetailController retrieves event detail by event ID";
    }
}
