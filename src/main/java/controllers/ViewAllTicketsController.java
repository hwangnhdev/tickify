package controllers;

import dals.TicketDAO;
import viewModels.CustomerTicketDTO;
import com.google.gson.Gson;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ViewAllTicketsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy customerId từ parameter hoặc session (ví dụ đơn giản)
        HttpSession session = request.getSession();
        System.out.println(session.getAttribute("customerId"));
        int customerId = (int) session.getAttribute("customerId");

        // Lấy trạng thái lọc vé
        String statusFilter = request.getParameter("status");
        if (statusFilter == null || statusFilter.isEmpty()) {
            statusFilter = "all";
        }

        TicketDAO ticketDAO = new TicketDAO();
        List<CustomerTicketDTO> tickets = ticketDAO.getTicketsByCustomer(customerId, statusFilter);

        // Nếu là AJAX request, trả về JSON
        if ("true".equals(request.getParameter("ajax"))) {
            response.setContentType("application/json;charset=UTF-8");
            Map<String, Object> jsonMap = new HashMap<>();
            jsonMap.put("tickets", tickets);
            Gson gson = new Gson();
            String json = gson.toJson(jsonMap);
            PrintWriter out = response.getWriter();
            out.write(json);
            out.flush();
            return;
        }

        // Nếu không, forward sang JSP
        request.setAttribute("tickets", tickets);
        request.setAttribute("statusFilter", statusFilter);
        RequestDispatcher rd = request.getRequestDispatcher("/pages/ticketPage/viewAllTickets.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
