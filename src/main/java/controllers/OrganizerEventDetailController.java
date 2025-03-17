package controllers;

import dals.AdminDAO;
import dals.EventDAO;
import dals.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import viewModels.EventDetailDTO;

public class OrganizerEventDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Organizer ID lấy từ session hoặc mặc định (ở đây sử dụng 2)
        int customerId = 4;

        // Lấy eventId từ request parameter, mặc định là 2 nếu không có
        String eventIdParam = request.getParameter("eventId");
        int eventId = 2;
        if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
            try {
                eventId = Integer.parseInt(eventIdParam);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID: must be an integer.");
                return;
            }
        }

        // Sử dụng DAO để lấy chi tiết sự kiện của organizer
        OrganizerDAO OrganizerDAO = new OrganizerDAO();
        EventDetailDTO detail = OrganizerDAO.getCustomerEventDetail(customerId, eventId);

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
        return "OrganizerEventDetailController retrieves event detail for an organizer";
    }
}
