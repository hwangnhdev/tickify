package controllers;

import dals.TicketDAO;
import models.Tickets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author Duong Minh Kiet - CE180166
 */
@WebServlet(name = "ViewAllTicketsController", urlPatterns = {"/viewalltickets"})
public class ViewAllTicketsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int customerId = 1; // Ví dụ: ID khách hàng được cố định
        String statusParam = request.getParameter("status"); // Lấy tham số trạng thái từ URL

        TicketDAO ticketDAO = new TicketDAO();
        List<Tickets> tickets;

        // Nếu không có tham số status hoặc status = ALL thì lấy toàn bộ vé
        if (statusParam == null || statusParam.equalsIgnoreCase("ALL")) {
            tickets = ticketDAO.getTicketsByCustomerId(customerId);
        } else {
            tickets = ticketDAO.getTicketsByCustomerIdAndStatus(customerId, statusParam);
        }

        if (tickets.isEmpty()) {
            request.setAttribute("message", "Không có vé nào được tìm thấy!");
        } else {
            request.setAttribute("ticketList", tickets);
        }

        request.getRequestDispatcher("/pages/ticket/listTickets.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
