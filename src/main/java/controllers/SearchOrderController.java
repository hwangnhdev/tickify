//package controllers;
//
//import dals.OrderDAO;
//import dals.OrganizerDAO;
//import models.Order;
//import java.io.IOException;
//import java.util.List;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//@WebServlet(name = "SearchOrderController", urlPatterns = {"/SearchOrderController"})
//public class SearchOrderController extends HttpServlet {
//
//    private static final long serialVersionUID = 1L;
//    private OrganizerDAO OrganizerDAO;
//
//    @Override
//    public void init() throws ServletException {
//        OrganizerDAO = new OrganizerDAO();
//    }
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Lấy organizerId từ request (hoặc từ session nếu cần)
//        String orgIdStr = request.getParameter("organizerId");
//        int organizerId = 1;
//        if (orgIdStr != null && !orgIdStr.isEmpty()) {
//            organizerId = Integer.parseInt(orgIdStr);
//        }
//        // Lấy từ khóa tìm kiếm từ form
//        String keyword = request.getParameter("searchOrder");
//        if (keyword == null) {
//            keyword = "";
//        }
//        // Gọi DAO để tìm kiếm đơn hàng theo organizer và từ khóa, sử dụng đối tượng Order của package models
//        List<Order> orders = OrganizerDAO.searchOrders(organizerId, keyword);
//        // Đưa kết quả tìm kiếm vào request attribute
//        request.setAttribute("orders", orders);
//        // Chuyển tiếp đến trang hiển thị kết quả (organizerOrders.jsp)
//        RequestDispatcher dispatcher = request.getRequestDispatcher("pages/organizerPage/organizerOrders.jsp");
//        dispatcher.forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        doGet(request, response);
//    }
//}
