package controllers;

import dals.OrderDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;    
import models.CustomerTicketDTO;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ViewAllTicketsController", urlPatterns = {"/viewAllTickets"})

public class ViewAllTicketsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy customerId từ request (có thể thay đổi lấy từ session nếu cần)
        String customerIdStr = request.getParameter("customerId");
        int customerId = 2; // Default nếu không có tham số
        if (customerIdStr != null && !customerIdStr.trim().isEmpty()) {
            try {
                customerId = Integer.parseInt(customerIdStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Lấy tham số status từ request để lọc theo payment_status
        String status = request.getParameter("status");

        // Gọi DAO lấy dữ liệu vé theo customerId và (nếu có) theo payment_status
        OrderDAO orderDAO = new OrderDAO();
        List<CustomerTicketDTO> tickets;
        if (status == null || status.trim().isEmpty()) {
            tickets = orderDAO.getPurchasedTicketsByCustomer(customerId);
        } else {
            tickets = orderDAO.getPurchasedTicketsByCustomerAndStatus(customerId, status);
        }

        // Đưa dữ liệu vào request và forward sang JSP
        request.setAttribute("tickets", tickets);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/ticketPage/viewAllTickets.jsp");
        rd.forward(request, response);
    }
}
