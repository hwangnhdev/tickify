package controllers;

import dals.OrderDAO;
import dals.TicketDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.TicketDetailDTO;
import java.io.IOException;

@WebServlet(name = "TicketDetailController", urlPatterns = {"/viewTicketDetail"})
public class TicketDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ticketCode từ request (giả sử truyền qua URL)
        String ticketCode = request.getParameter("ticketCode");
        // Giả sử customerId được lấy từ session (hoặc request parameter) - ví dụ: 2
        int customerId = 2; // Thay thế bằng logic lấy customerId từ session nếu cần

        TicketDAO ticketDAO = new TicketDAO();
        TicketDetailDTO ticketDetail = ticketDAO.getTicketDetail(ticketCode, customerId);

        if (ticketDetail == null) {
            request.setAttribute("errorMessage", "Không tìm thấy chi tiết vé!");
        } else {
            request.setAttribute("ticketDetail", ticketDetail);
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
