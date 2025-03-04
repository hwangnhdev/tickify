////package controllers;
////
////import dals.OrderDAO;
////import jakarta.servlet.RequestDispatcher;
////import jakarta.servlet.ServletException;
////import jakarta.servlet.annotation.WebServlet;
////import jakarta.servlet.http.HttpServlet;
////import jakarta.servlet.http.HttpServletRequest;
////import jakarta.servlet.http.HttpServletResponse;
////import models.Order;
////import java.io.IOException;
////import java.util.List;
////
////@WebServlet(name = "OrganizerOrdersController", urlPatterns = {"/organizer/viewOrders"})
////public class OrganizerOrdersController extends HttpServlet {
////
////    @Override
////    protected void doGet(HttpServletRequest request, HttpServletResponse response)
////            throws ServletException, IOException {
////        // Lấy số trang từ tham số 'page', mặc định là 1
////        String pageParam = request.getParameter("page");
////        int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
////        int pageSize = 10; // 10 order mỗi trang
////        int offset = (currentPage - 1) * pageSize;
////        
////        // Lấy tham số lọc trạng thái thanh toán từ request, nếu không có thì mặc định là "all"
////        String paymentStatus = request.getParameter("paymentStatus");
////        if (paymentStatus == null || paymentStatus.trim().isEmpty()) {
////            paymentStatus = "all";
////        }
////        
////        // Lấy organizerId từ session (giả sử đã được lưu khi đăng nhập)
////        int organizerId = 1; // giá trị mặc định dùng cho mục đích test
////        Object orgIdObj = request.getSession().getAttribute("organizerId");
////        if (orgIdObj != null) {
////            organizerId = Integer.parseInt(orgIdObj.toString());
////        }
////        
////        OrderDAO orderDAO = new OrderDAO();
////        List<Order> orders = orderDAO.getOrdersByOrganizerAndPaymentStatus(organizerId, paymentStatus, offset, pageSize);
////        int totalRecords = orderDAO.countOrdersByOrganizerAndPaymentStatus(organizerId, paymentStatus);
////        int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);
////        
////        request.setAttribute("orders", orders);
////        request.setAttribute("currentPage", currentPage);
////        request.setAttribute("totalPages", totalPages);
////        request.setAttribute("paymentStatus", paymentStatus);
////        
////        RequestDispatcher rd = request.getRequestDispatcher("/pages/organizerPage/organizerOrders.jsp");
////        rd.forward(request, response);
////    }
////
////    @Override
////    protected void doPost(HttpServletRequest request, HttpServletResponse response)
////            throws ServletException, IOException {
////        doGet(request, response);
////    }
////}
//package controllers;
//
//import dals.OrderDAO;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import models.Order;
//import java.io.IOException;
//import java.util.List;
//
//@WebServlet(name = "OrganizerOrdersController", urlPatterns = {"/organizer/viewOrders"})
//public class OrganizerOrdersController extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Lấy số trang từ tham số 'page', mặc định là 1
//        String pageParam = request.getParameter("page");
//        int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
//        int pageSize = 10; // 10 order mỗi trang
//        int offset = (currentPage - 1) * pageSize;
//        
//        // Lấy tham số lọc trạng thái thanh toán từ request, nếu không có thì mặc định là "all"
//        String paymentStatus = request.getParameter("paymentStatus");
//        if (paymentStatus == null || paymentStatus.trim().isEmpty()) {
//            paymentStatus = "all";
//        }
//        
//        // Lấy organizerId từ session (giả sử đã được lưu khi đăng nhập)
//        int organizerId = 1; // giá trị mặc định dùng cho mục đích test
//        Object orgIdObj = request.getSession().getAttribute("organizerId");
//        if (orgIdObj != null) {
//            organizerId = Integer.parseInt(orgIdObj.toString());
//        }
//        
//        OrderDAO orderDAO = new OrderDAO();
//        List<Order> orders = orderDAO.getOrdersByOrganizerAndPaymentStatus(organizerId, paymentStatus, offset, pageSize);
//        int totalRecords = orderDAO.countOrdersByOrganizerAndPaymentStatus(organizerId, paymentStatus);
//        int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);
//        
//        request.setAttribute("orders", orders);
//        request.setAttribute("currentPage", currentPage);
//        request.setAttribute("totalPages", totalPages);
//        request.setAttribute("paymentStatus", paymentStatus);
//        
//        RequestDispatcher rd = request.getRequestDispatcher("/pages/organizerPage/organizerOrders.jsp");
//        rd.forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        doGet(request, response);
//    }
//}