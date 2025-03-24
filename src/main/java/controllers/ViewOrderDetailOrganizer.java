package controllers;

import dals.OrderDetailDAO;
import viewModels.OrderDetailDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/viewOrderDetailOrganizer")
public class ViewOrderDetailOrganizer extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public ViewOrderDetailOrganizer() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy orderId từ request
        String orderIdStr = request.getParameter("orderId");
        if (orderIdStr == null || orderIdStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing orderId parameter.");
            return;
        }
        int orderId;
        try {
            orderId = Integer.parseInt(orderIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid orderId parameter.");
            return;
        }
        
        // Gọi DAO để lấy chi tiết đơn hàng theo orderId
        OrderDetailDAO dao = new OrderDetailDAO();
        OrderDetailDTO orderDetail = dao.getOrderDetailByOrderId(orderId);
        if (orderDetail == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found.");
            return;
        }
        
        request.setAttribute("orderDetail", orderDetail);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/viewOrderDetailOrganizer.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
