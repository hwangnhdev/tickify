package controllers;

import dals.OrganizerDAO;
import dals.EventDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import models.EventImage;
import viewModels.EventDetailDTO;
import viewModels.ShowtimeDTO;
import viewModels.TicketTypeDTO;

public class OrganizerEventDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
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
        EventDetailDTO detail = organizerDAO.getEventDetail(eventId);
        if (detail == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event detail not found.");
            return;
        }

        // Lấy danh sách hình ảnh phụ của sự kiện
        EventDAO eventDAO = new EventDAO();
        List<EventImage> listImages = eventDAO.getImageEventsByEventId(eventId);

        // Lấy danh sách lịch diễn và loại vé từ OrganizerDAO
        List<ShowtimeDTO> listShowtimes = organizerDAO.getShowtimesByEventId(eventId);
        List<TicketTypeDTO> listTicketTypes = organizerDAO.getTicketTypesByEventId(eventId);

        // Set các attribute cần thiết cho JSP
        request.setAttribute("organizerEventDetail", detail);
        request.setAttribute("listEventImages", listImages);
        request.setAttribute("listShowtimes", listShowtimes);
        request.setAttribute("listTicketTypes", listTicketTypes);

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
        return "OrganizerEventDetailController retrieves event detail along with showtimes and ticket types.";
    }
}
