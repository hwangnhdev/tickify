package controllers;

import dals.OrderDAO;
import dals.TicketDAO;
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
        // Lấy customerId từ parameter (hoặc có thể lấy từ session nếu đã lưu)
        String customerIdParam = request.getParameter("customerId");
        int customerId = 2; // Giá trị mặc định (nên thay thế bằng logic lấy từ session)
        if (customerIdParam != null) {
            try {
                customerId = Integer.parseInt(customerIdParam);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        // Lấy tham số status để lọc: "all", "paid", "pending", "upcoming", "past"
        String statusFilter = request.getParameter("status");
        if (statusFilter == null || statusFilter.isEmpty()) {
            statusFilter = "all";
        }

        TicketDAO ticketDAO = new TicketDAO();
        // Gọi phương thức lấy vé đã mua của customer theo customerId và status filter
        List<CustomerTicketDTO> tickets = ticketDAO.getTicketsByCustomer(customerId, statusFilter);

        // Đặt dữ liệu vào request attribute để hiển thị trên JSP
        request.setAttribute("tickets", tickets);
        request.setAttribute("statusFilter", statusFilter);

        // Forward sang trang JSP hiển thị danh sách vé (View All Tickets)
        RequestDispatcher rd = request.getRequestDispatcher("/pages/ticketPage/viewAllTickets.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
