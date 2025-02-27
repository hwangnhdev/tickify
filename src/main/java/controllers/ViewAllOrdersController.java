package controllers;

import dals.OrderDAO;
import models.Order;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

@WebServlet(name = "ViewAllOrdersController", urlPatterns = {"/ViewAllOrdersController"})
public class ViewAllOrdersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy số trang từ tham số 'page', nếu không có thì mặc định là 1
            String pageParam = request.getParameter("page");
            int page = (pageParam != null) ? Integer.parseInt(pageParam) : 1;

            // Số đơn hàng mỗi trang
            int pageSize = 5;
            int offset = (page - 1) * pageSize;

            // Lấy danh sách đơn hàng theo phân trang
            OrderDAO orderDAO = new OrderDAO();
            List<Order> orders = orderDAO.getOrdersWithPagination(offset, pageSize);

            // Lấy tổng số đơn hàng để tính tổng số trang
            int totalRecords = orderDAO.countOrders();
            int totalPages = (int) Math.ceil(totalRecords / (double) pageSize);

            // Đặt dữ liệu vào request
            request.setAttribute("orders", orders);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);

            // Chuyển tiếp sang JSP hiển thị
            RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/viewAllOrders.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi khi lấy danh sách đơn hàng: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("pages/organizerPage/error.jsp");
            dispatcher.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet để hiển thị danh sách đơn hàng với phân trang";
    }
}
