package controllers;

import dals.AdminDAO;
import dals.EventDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import models.Event;
import models.EventImage;


public class ViewApprovedDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String eventIdStr = request.getParameter("eventId");
        int eventId;
        try {
            eventId = Integer.parseInt(eventIdStr);
            System.out.println("Fetching event with ID: " + eventId); // Log
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid event ID.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        }

        // Lấy chi tiết sự kiện đã duyệt
        AdminDAO adminDao = new AdminDAO();
        Event event = adminDao.getApprovedEventDetailById(eventId);
        if (event == null) {
            System.out.println("Event not found or not approved for ID: " + eventId); // Log
            request.setAttribute("error", "Event not found or not approved.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
            return;
        } else {
            System.out.println("Event found: " + event.getEventName());
        }

        // Lấy danh sách hình ảnh của event (không dùng STRING_AGG)
        EventDAO eventDao = new EventDAO(); // Phương thức getImageEventsByEventId phải được định nghĩa trong EventDAO
        List<EventImage> listEventImages = eventDao.getImageEventsByEventId(eventId);

        // Tách các ảnh theo image_title
        String logoBannerImage = "";
        String logoEventImage = "";
        String logoOrganizerImage = "";

        for (EventImage image : listEventImages) {
            if (image.getImageTitle().equalsIgnoreCase("logo_banner")) {
                logoBannerImage = image.getImageUrl();
            } else if (image.getImageTitle().equalsIgnoreCase("logo_event")) {
                logoEventImage = image.getImageUrl();
            } else if (image.getImageTitle().equalsIgnoreCase("logo_organizer")) {
                logoOrganizerImage = image.getImageUrl();
            }
        }

        // Nếu không có ảnh nào, dùng ảnh mặc định (URL đầy đủ từ Cloudinary)
        if (logoBannerImage.isEmpty()) {
            logoBannerImage = "https://res.cloudinary.com/dnvpphtov/image/upload/default_banner.png";
        }
        if (logoEventImage.isEmpty()) {
            logoEventImage = "https://res.cloudinary.com/dnvpphtov/image/upload/default_event.png";
        }
        if (logoOrganizerImage.isEmpty()) {
            logoOrganizerImage = "https://res.cloudinary.com/dnvpphtov/image/upload/default_organizer.png";
        }

        request.setAttribute("event", event);
        request.setAttribute("logoBannerImage", logoBannerImage);
        request.setAttribute("logoEventImage", logoEventImage);
        request.setAttribute("logoOrganizerImage", logoOrganizerImage);

        request.getRequestDispatcher("/pages/adminPage/viewApprovedDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
