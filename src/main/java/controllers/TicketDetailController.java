package controllers;

import dals.TicketDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import viewModels.OrderDetailDTO;

public class TicketDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy orderId từ request; nếu không có "orderId" (chữ I hoa) thì thử "orderid"
        String orderIdParam = request.getParameter("orderId");
        if(orderIdParam == null || orderIdParam.isEmpty()){
            orderIdParam = request.getParameter("orderid");
        }
        
        int orderId = 0;
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Order ID không hợp lệ!");
            RequestDispatcher rd = request.getRequestDispatcher("/pages/ticketPage/ticketDetail.jsp");
            rd.forward(request, response);
            return;
        }
        
        // Lấy customerId từ session (có thể kiểm tra quyền truy cập)
        HttpSession session = request.getSession();
        Object customerIdObj = session.getAttribute("customerId");
        int customerId = 0;
        if (customerIdObj instanceof Integer) {
            customerId = (Integer) customerIdObj;
        } else if (customerIdObj instanceof String) {
            try {
                customerId = Integer.parseInt((String) customerIdObj);
            } catch (NumberFormatException e) {
                System.out.println("Lỗi chuyển đổi Customer ID: " + e.getMessage());
            }
        } else {
            System.out.println("Customer ID không hợp lệ hoặc chưa được set trong session.");
        }
        
        TicketDAO ticketDAO = new TicketDAO();
        OrderDetailDTO orderDetail = null;
        try {
            orderDetail = ticketDAO.getTicketDetailByOrderId(orderId);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        
        if (orderDetail == null) {
            request.setAttribute("errorMessage", "Không tìm thấy chi tiết vé!");
        } else {
            // Set đối tượng orderDetail vào request để JSP sử dụng
            request.setAttribute("orderDetail", orderDetail);
            request.setAttribute("ticketDetail", orderDetail); // Để tương thích với EL trong JSP
        }
        
        RequestDispatcher rd = request.getRequestDispatcher("/pages/ticketPage/ticketDetail.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
