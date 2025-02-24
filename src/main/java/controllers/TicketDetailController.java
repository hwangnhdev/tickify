package controllers;

import dals.TicketDAO;
import models.Tickets;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 *
 * @author Duong Minh Kiet - CE180166
 */
@WebServlet(name = "TicketDetailController", urlPatterns = {"/viewticketdetail"})
public class TicketDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ticketId từ request (ví dụ: ?ticketId=5)
        String ticketIdParam = request.getParameter("ticketId");
        int ticketId = 0;
        try {
            ticketId = Integer.parseInt(ticketIdParam);
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }

        TicketDAO ticketDAO = new TicketDAO();
        Tickets ticket = ticketDAO.getTicketById(ticketId);

        if (ticket == null) {
            request.setAttribute("message", "Không tìm thấy vé!");
        } else {
            request.setAttribute("ticket", ticket);
        }
        request.getRequestDispatcher("/pages/ticket/ticketDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
