package controllers;

import dals.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import viewModels.OrderDetailDTO;


public class OrganizerOrdersController extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy số trang từ tham số 'page', mặc định là 1
        String pageParam = request.getParameter("page");
        int currentPage = (pageParam != null && !pageParam.trim().isEmpty()) ? Integer.parseInt(pageParam) : 1;
        int offset = (currentPage - 1) * PAGE_SIZE;
        
        // Lấy tham số lọc trạng thái thanh toán từ request, nếu không có thì mặc định là "all"
        String paymentStatus = request.getParameter("paymentStatus");
        if (paymentStatus == null || paymentStatus.trim().isEmpty()) {
            paymentStatus = "all";
        }
        
        // Lấy tham số tìm kiếm theo tên khách hàng từ request
        String searchOrder = request.getParameter("searchOrder");
        if (searchOrder != null && searchOrder.trim().isEmpty()) {
            searchOrder = null;
        }
        
        // Lấy organizerId từ session (giả sử đã được lưu khi đăng nhập)
        int organizerId = 1; // Giá trị mặc định cho test
        Object orgIdObj = request.getSession().getAttribute("organizerId");
        if (orgIdObj != null) {
            organizerId = Integer.parseInt(orgIdObj.toString());
        }
        
        OrganizerDAO organizerDAO = new OrganizerDAO();
        // Lấy danh sách order sử dụng model OrderDetailDTO với phân trang và điều kiện lọc
        List<OrderDetailDTO> orders = organizerDAO.getOrderDetailsByOrganizerAndPaymentStatus(organizerId, paymentStatus, searchOrder, offset, PAGE_SIZE);
        int totalRecords = organizerDAO.countOrdersByOrganizerAndPaymentStatus(organizerId, paymentStatus, searchOrder);
        int totalPages = (int) Math.ceil(totalRecords / (double) PAGE_SIZE);
        
        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("paymentStatus", paymentStatus);
        request.setAttribute("searchOrder", searchOrder);
        
        RequestDispatcher rd = request.getRequestDispatcher("/pages/organizerPage/organizerOrders.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
