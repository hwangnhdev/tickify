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
        
        // Lấy customerId từ session (để kiểm tra quyền truy cập)
        HttpSession session = request.getSession();
        Object customerIdObj = session.getAttribute("customerId");
        int customerId = 0;
        if (customerIdObj == null) {
            request.setAttribute("errorMessage", "Bạn chưa đăng nhập!");
            RequestDispatcher rd = request.getRequestDispatcher("/pages/ticketPage/ticketDetail.jsp");
            rd.forward(request, response);
            return;
        }
        if (customerIdObj instanceof Integer) {
            customerId = (Integer) customerIdObj;
        } else if (customerIdObj instanceof String) {
            try {
                customerId = Integer.parseInt((String) customerIdObj);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Customer ID không hợp lệ!");
                RequestDispatcher rd = request.getRequestDispatcher("/pages/ticketPage/ticketDetail.jsp");
                rd.forward(request, response);
                return;
            }
        } else {
            request.setAttribute("errorMessage", "Customer ID không hợp lệ hoặc chưa được set trong session.");
            RequestDispatcher rd = request.getRequestDispatcher("/pages/ticketPage/ticketDetail.jsp");
            rd.forward(request, response);
            return;
        }
        
        TicketDAO ticketDAO = new TicketDAO();
        OrderDetailDTO orderDetail = null;
        try {
            // Gọi phương thức với cả orderId và customerId
            orderDetail = ticketDAO.getTicketDetailByOrderId(orderId, customerId);
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình truy xuất dữ liệu!");
        }
        
        if (orderDetail == null || orderDetail.getOrderSummary() == null) {
            request.setAttribute("errorMessage", "Không tìm thấy chi tiết vé hoặc bạn không có quyền truy cập đơn hàng này!");
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
