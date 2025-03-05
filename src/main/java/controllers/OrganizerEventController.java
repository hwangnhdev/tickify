package controllers;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
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
import models.EventImage;

public class OrganizerEventController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int organizerId = 2; // Nên lấy từ session
            String filter = request.getParameter("filter");
            if (filter == null || filter.trim().isEmpty()) {
                filter = "all";
            }

            EventDAO eventDAO = new EventDAO();
            List<EventDTO> events = eventDAO.getEventsByOrganizer(organizerId, filter);

            request.setAttribute("events", events);
            request.setAttribute("currentFilter", filter);

            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/organizerEvents.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log lỗi
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Integer organizerId = (Integer) request.getSession().getAttribute("organizerId");
            if (organizerId == null) {
                organizerId = 98;
            }

            String eventName = request.getParameter("eventName");
            if (eventName == null || eventName.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Event name is required.");
                return;
            }

            EventDAO eventDAO = new EventDAO();
            List<EventImage> listEventImages = eventDAO.searchEventByNameImage(eventName, organizerId);

            Gson gson = new GsonBuilder()
                    .excludeFieldsWithoutExposeAnnotation()// Chỉ serialize các trường có @Expose
                    .create();
            String json = gson.toJson(listEventImages);

            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace(); // Ghi log lỗi
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing search request: " + e.getMessage());
        }
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "OrganizerEventController retrieves filtered events and forwards to /pages/organizerPage/organizerEventsorganizerEvents.jsp";
    }
}
