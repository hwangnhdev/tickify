//package controllers;
//
//import dals.OrderDAO;
//import dals.TicketDAO;
//import models.Order;
//import models.Ticket;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.ArrayList;
//import java.util.List;
//
//@WebServlet(name = "ViewAllTicketsController", urlPatterns = {"/viewalltickets", "/my-tickets"})
//public class ViewAllTicketsController extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        int customerId = 1; // Ví dụ: lấy từ session, ở đây dùng giá trị cố định
//        String statusParam = request.getParameter("status"); // Nếu cần lọc theo trạng thái
//        
//        OrderDAO orderDAO = new OrderDAO();
//        TicketDAO ticketDAO = new TicketDAO();
//        
//        List<Order> orders = orderDAO.getOrdersByCustomerId(customerId);
//        List<Ticket> ticketList = new ArrayList<>();
//        
//        // Với mỗi đơn hàng, lấy các vé tương ứng
//        for (Order order : orders) {
//            // Nếu có lọc theo trạng thái, bạn có thể bổ sung điều kiện kiểm tra tại đây
//            List<Ticket> tickets = ticketDAO.getTicketsByOrderId(order.getOrderId());
//            // Có thể bạn muốn gán thêm thông tin đơn hàng vào mỗi vé (nếu model Ticket có các trường đó)
//            // Ví dụ: ticket.setOrderCode(order.getOrderCode());
//            ticketList.addAll(tickets);
//        }
//        
//        if (ticketList.isEmpty()) {
//            request.setAttribute("message", "Không có vé nào được tìm thấy!");
//        } else {
//            request.setAttribute("ticketList", ticketList);
//        }
//        request.setAttribute("currentStatus", statusParam);
//        request.getRequestDispatcher("/pages/ticket/listTickets.jsp").forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        doGet(request, response);
//    }
//}
