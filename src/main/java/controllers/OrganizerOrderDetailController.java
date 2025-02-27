package controllers;

import dals.OrderDAO;
import models.OrganizerOrderDetailDTO;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

@WebServlet(name = "OrganizerOrderDetailController", urlPatterns = {"/OrganizerOrderDetailController"})
public class OrganizerOrderDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            OrderDAO orderDAO = new OrderDAO();
            OrganizerOrderDetailDTO dto = orderDAO.getOrderDetailForOrganizer(orderId);
            if (dto == null || dto.getOrderHeader() == null) {
                request.setAttribute("errorMessage", "Không tìm thấy đơn hàng với mã: " + orderId);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/error.jsp");
                dispatcher.forward(request, response);
                return;
            }
            request.setAttribute("organizerOrderDetailDTO", dto);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/viewOrderDetail.jsp");
            dispatcher.forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi lấy chi tiết đơn hàng: " + e.getMessage());
            request.getRequestDispatcher("/pages/organizerPage/error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ.");
            request.getRequestDispatcher("/pages/organizerPage/error.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
