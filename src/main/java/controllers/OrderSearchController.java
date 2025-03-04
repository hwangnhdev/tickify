<<<<<<< HEAD
package controllers;

=======
>>>>>>> 585b0290f07709a285fc8c831893312cd6e42e68
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
//import models.OrderSearchDTO;
//import java.io.IOException;
//import java.sql.SQLException;
//import java.util.ArrayList;
//import java.util.List;
//
//@WebServlet(name = "OrderSearchController", urlPatterns = {"/searchOrders"})
//public class OrderSearchController extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Lấy từ khóa tìm kiếm từ request
//        String keyword = request.getParameter("keyword");
//        if (keyword == null) {
//            keyword = "";
//        }
//        // Organizer_id cố định (ví dụ: 2)
//        int organizerId = 2;
//        
//        // Phân trang: lấy số trang hiện tại, mặc định là 1
//        String pageParam = request.getParameter("page");
//        int currentPage = (pageParam != null) ? Integer.parseInt(pageParam) : 1;
//        int pageSize = 5;
//        int offset = (currentPage - 1) * pageSize;
//        
//        OrderDAO orderDAO = new OrderDAO();
//        List<OrderSearchDTO> orders = new ArrayList<>();
//        int totalRecords;
//        try {
//            if (keyword.trim().isEmpty()) {
//                // Nếu từ khóa rỗng, lấy tất cả đơn hàng theo phân trang và chuyển đổi kiểu
//                List<Order> orderList = orderDAO.getOrdersWithPagination(offset, pageSize);
//                totalRecords = orderDAO.countOrders();
//                
//                // Chuyển đổi từ Order sang OrderSearchDTO
//                for (Order o : orderList) {
//                    OrderSearchDTO dto = new OrderSearchDTO();
//                    dto.setOrderId(o.getOrderId());
//                    dto.setOrderDate(o.getOrderDate());
//                    dto.setTotalPrice(o.getTotalPrice());
//                    dto.setPaymentStatus(o.getPaymentStatus());
//                    dto.setTransactionId(o.getTransactionId());
//                    dto.setCustomerName(o.getCustomerName());
//                    orders.add(dto);
//                }
//            } else {
//                // Nếu có từ khóa, tìm kiếm đơn hàng (không áp dụng phân trang)
//                orders = orderDAO.searchOrders(organizerId, keyword);
//                totalRecords = orders.size();
//            }
//            int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);
//            
//            request.setAttribute("orders", orders);
//            request.setAttribute("currentPage", currentPage);
//            request.setAttribute("totalPages", totalPages);
//            request.setAttribute("keyword", keyword);
//            
//            RequestDispatcher rd = request.getRequestDispatcher("/pages/organizerPage/viewAllOrders.jsp");
//            rd.forward(request, response);
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//            request.setAttribute("errorMessage", "Lỗi khi lấy danh sách đơn hàng: " + ex.getMessage());
//            RequestDispatcher rd = request.getRequestDispatcher("/pages/organizerPage/error.jsp");
//            rd.forward(request, response);
//        }
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        doGet(request, response);
//    }
//}
