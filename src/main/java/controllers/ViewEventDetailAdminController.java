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
import models.EventDetailDTO;
import models.EventImage;


public class ViewEventDetailAdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy eventId từ request, nếu không có thì dùng mặc định là 1
        int eventId = 1;
        String eventIdParam = request.getParameter("eventId");
        if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
            try {
                eventId = Integer.parseInt(eventIdParam);
            } catch (NumberFormatException e) {
                eventId = 1;
            }
        }

        // Lấy chi tiết sự kiện từ DAO
        AdminDAO adminDao = new AdminDAO();
        EventDetailDTO event = adminDao.getEventDetailById(eventId);

        // Lấy danh sách hình ảnh từ DAO (không dùng STRING_AGG)
        EventDAO eventDao = new EventDAO(); // Hoặc bạn có thể thêm phương thức này vào AdminDAO
        List<EventImage> listEventImages = eventDao.getImageEventsByEventId(eventId);

        // Khai báo biến để chứa URL cho từng loại ảnh
        String logoBannerImage = "";
        String logoEventImage = "";
        String logoOrganizerImage = "";

        // Duyệt qua danh sách hình ảnh để gán theo image_title
        for (EventImage image : listEventImages) {
            if (image.getImageTitle().equalsIgnoreCase("logo_banner")) {
                logoBannerImage = image.getImageUrl();
            } else if (image.getImageTitle().equalsIgnoreCase("logo_event")) {
                logoEventImage = image.getImageUrl();
            } else if (image.getImageTitle().equalsIgnoreCase("logo_organizer")) {
                logoOrganizerImage = image.getImageUrl();
            }
        }

        // Nếu không có ảnh nào, gán ảnh mặc định (URL đầy đủ từ Cloudinary hoặc URL local)
        if (logoBannerImage.isEmpty()) {
            logoBannerImage = "https://res.cloudinary.com/dnvpphtov/image/upload/default_banner.png";
        }
        if (logoEventImage.isEmpty()) {
            logoEventImage = "https://res.cloudinary.com/dnvpphtov/image/upload/default_event.png";
        }
        if (logoOrganizerImage.isEmpty()) {
            logoOrganizerImage = "https://res.cloudinary.com/dnvpphtov/image/upload/default_organizer.png";
        }

        // Set các attribute cho JSP
        request.setAttribute("event", event);
        request.setAttribute("logoBannerImage", logoBannerImage);
        request.setAttribute("logoEventImage", logoEventImage);
        request.setAttribute("logoOrganizerImage", logoOrganizerImage);

        // Giữ lại thông tin trang hiện tại để quay lại danh sách nếu có
        String currentPage = request.getParameter("page");
        if (currentPage != null && !currentPage.trim().isEmpty()) {
            request.setAttribute("currentPage", currentPage);
        }

        request.getRequestDispatcher("/pages/adminPage/viewEventDetailAdmin.jsp").forward(request, response);
    }
}
