package controllers;

import dals.TicketDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.TicketDetailDTO;
import java.io.IOException;

@WebServlet(name = "TicketDetailController", urlPatterns = {"/viewticketdetail"})
public class TicketDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderId");
        int orderId = 2;
        try {
            orderId = Integer.parseInt(orderIdParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        
        TicketDAO ticketDAO = new TicketDAO();
        TicketDetailDTO ticketDetail = ticketDAO.getTicketDetailByOrderId(orderId);
        
        if (ticketDetail == null) {
            request.setAttribute("message", "Không tìm thấy vé!");
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
