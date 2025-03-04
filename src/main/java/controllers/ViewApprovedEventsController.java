//package controllers;
//
//import dals.EventAdminDAO;
//import models.Event;
//import java.io.IOException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.util.List;
//
//
//public class ViewApprovedEventsController extends HttpServlet {
//
//    private static final long serialVersionUID = 1L;
//    private static final int PAGE_SIZE = 10;
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int page = 1;
//        String pageParam = request.getParameter("page");
//        if (pageParam != null) {
//            try {
//                page = Integer.parseInt(pageParam);
//            } catch (NumberFormatException e) {
//                page = 1;
//            }
//        }
//
//        // Gọi DAO để lấy danh sách sự kiện có trạng thái 'Active'
//        EventAdminDAO dao = new EventAdminDAO();
//        List<Event> approvedEvents = dao.getEventsByStatus("Active", page, PAGE_SIZE);
//
//        // Tính số trang dựa trên tổng số bản ghi sự kiện với trạng thái 'Active'
//        int totalRecords = dao.getTotalEventsByStatus("Active");
//        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
//
//        request.setAttribute("events", approvedEvents);
//        request.setAttribute("totalPages", totalPages);
//        request.setAttribute("page", page);
//        request.getRequestDispatcher("/pages/adminPage/viewApprovedEvents.jsp").forward(request, response);
//    }
//}
