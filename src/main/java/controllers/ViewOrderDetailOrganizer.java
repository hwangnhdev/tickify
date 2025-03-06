package controllers;

import dals.OrderDetailDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.OrderDetail;
import java.io.IOException;

public class ViewOrderDetailOrganizer extends HttpServlet {

    /**
     * Xử lý yêu cầu GET: lấy thông tin chi tiết đơn hàng theo orderId. Nếu
     * không truyền tham số orderId, mặc định là 1 để test.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdStr = request.getParameter("orderId");
        int orderId = 1; // Mặc định là 1 để test

        if (orderIdStr != null && !orderIdStr.isEmpty()) {
            try {
                orderId = Integer.parseInt(orderIdStr);
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Mã đơn hàng không hợp lệ.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
        }

        // Gọi DAO để lấy thông tin đơn hàng
        OrderDetailDAO dao = new OrderDetailDAO();
        OrderDetail orderDetail = null;
        try {
            orderDetail = dao.getOrderDetail(orderId);
        } catch (Exception e) {
            throw new ServletException("Lỗi truy xuất dữ liệu đơn hàng", e);
        }

        if (orderDetail == null) {
            request.setAttribute("errorMessage", "Không tìm thấy đơn hàng có mã: " + orderId);
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } else {
            request.setAttribute("orderDetail", orderDetail);
            request.getRequestDispatcher("/pages/organizerPage/viewOrderDetailOrganizer.jsp").forward(request, response);
        }
    }
}
