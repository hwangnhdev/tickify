//package controllers;
//
//import dals.EventAdminDAO;
//import models.EventAdmin;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.Arrays;
//import java.util.List;
//
//@WebServlet("/admin/event/detail")
//public class ViewEventDetailAdminController extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//
//        int eventId = 1; // Giá trị mặc định
//        String eventIdParam = request.getParameter("eventId");
//
//        if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
//            try {
//                eventId = Integer.parseInt(eventIdParam);
//            } catch (NumberFormatException e) {
//                eventId = 1; // Mặc định nếu có lỗi
//            }
//        }
//
//        EventAdminDAO dao = new EventAdminDAO();
//        EventAdmin event = dao.getEventDetailById(eventId);
//
//        // Tách danh sách hình ảnh từ chuỗi thành danh sách List<String>
//        List<String> imageUrls = null;
//        if (event.getImageUrls() != null && !event.getImageUrls().isEmpty()) {
//            imageUrls = Arrays.asList(event.getImageUrls().split(", "));
//        }
//
//        request.setAttribute("event", event);
//        request.setAttribute("imageUrls", imageUrls);
//
//        // Giữ lại số trang để quay về đúng trang danh sách
//        String currentPage = request.getParameter("page");
//        if (currentPage != null && !currentPage.trim().isEmpty()) {
//            request.setAttribute("currentPage", currentPage);
//        }
//
//        request.getRequestDispatcher("/pages/adminPage/viewEventDetailAdmin.jsp").forward(request, response);
//    }
//}
