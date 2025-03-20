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


public class ViewOrderDetailOrganizer extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public ViewOrderDetailOrganizer() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve orderId from the request
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
        
        // Set organizerId (defaulted to 1; adjust as needed)
        int organizerId = 18;
        
        // Call DAO to retrieve the order details
        OrderDetailDAO dao = new OrderDetailDAO();
        OrderDetailDTO orderDetail = dao.getOrderDetailForOrganizer(organizerId, orderId);
        
        if (orderDetail == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found.");
            return;
        }
        
        // Set orderDetail as a request attribute and forward to JSP view
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
