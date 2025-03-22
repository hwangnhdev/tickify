package controllers;

import dals.TicketDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import viewModels.TicketDetailDTO;
import java.io.IOException;

public class TicketDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy ticketCode từ request (giả sử truyền qua URL)
        String ticketCode = request.getParameter("ticketCode");
        // Giả sử customerId được lấy từ session (hoặc request parameter) - ví dụ: 2
        HttpSession session = request.getSession();
        Object customerIdObj = session.getAttribute("customerId");
        int customerId = 0;
        if (customerIdObj instanceof Integer) {
            customerId = (Integer) customerIdObj;
            System.out.println("Customer ID: " + customerId);
        } else if (customerIdObj instanceof String) {
            try {
                customerId = Integer.parseInt((String) customerIdObj);
                System.out.println("Customer ID: " + customerId);
            } catch (NumberFormatException e) {
                System.out.println("Lỗi chuyển đổi String sang Integer: " + e.getMessage());
            }
        } else {
            System.out.println("Customer ID không hợp lệ hoặc chưa được set trong session.");
        }

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
