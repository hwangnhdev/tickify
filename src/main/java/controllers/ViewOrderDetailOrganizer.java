package controllers;

import dals.OrderDetailDAO;
import viewModels.OrderDetailDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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

        // Lấy customerId từ session
        HttpSession session = request.getSession();
        Object customerIdObj = session.getAttribute("customerId");
        int customerId = 0;
        if (customerIdObj == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Customer is not logged in.");
            return;
        }
        try {
            customerId = Integer.parseInt(customerIdObj.toString());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid customerId in session.");
            return;
        }

        // Gọi DAO để lấy chi tiết đơn hàng theo orderId và customerId
        OrderDetailDAO dao = new OrderDetailDAO();
        OrderDetailDTO orderDetail = dao.getOrderDetailByOrderId(orderId, customerId);
        if (orderDetail == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found or you do not have permission to view it.");
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
