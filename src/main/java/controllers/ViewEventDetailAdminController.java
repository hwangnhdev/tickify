package controllers;

import dals.EventAdminDAO;
import models.EventAdmin;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet("/admin/event/detail")
public class ViewEventDetailAdminController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy eventId từ request, nếu không có thì dùng giá trị mặc định là 1
        int eventId = 1;
        String eventIdParam = request.getParameter("eventId");
        if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
            try {
                eventId = Integer.parseInt(eventIdParam);
            } catch (NumberFormatException e) {
                eventId = 1; // Nếu lỗi, sử dụng giá trị mặc định
            }
        }

        // Lấy chi tiết sự kiện từ DAO
        EventAdminDAO dao = new EventAdminDAO();
        EventAdmin event = dao.getEventDetailById(eventId);

        // Tách chuỗi hình ảnh từ DB thành danh sách List<String>
        List<String> imageUrls = null;
        if (event.getImageUrls() != null && !event.getImageUrls().isEmpty()) {
            imageUrls = Arrays.asList(event.getImageUrls().split("\\s*,\\s*"));
        } else {
            // Nếu không có dữ liệu ảnh, sử dụng hình ảnh mặc định (banner)
            imageUrls = Arrays.asList("images/default_banner.png");
        }

        request.setAttribute("event", event);
        request.setAttribute("imageUrls", imageUrls);

        // Giữ lại thông tin trang hiện tại để quay lại danh sách
        String currentPage = request.getParameter("page");
        if (currentPage != null && !currentPage.trim().isEmpty()) {
            request.setAttribute("currentPage", currentPage);
        }

        request.getRequestDispatcher("/pages/adminPage/viewEventDetailAdmin.jsp").forward(request, response);
    }
}
