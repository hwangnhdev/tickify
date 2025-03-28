package controllers;

import dals.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import viewModels.OrderDetailDTO;

public class OrganizerOrdersController extends HttpServlet {

        private static final int PAGE_SIZE = 10;

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                HttpSession session = request.getSession();

        // Lấy customerId từ session (để đảm bảo rằng customer đang đăng nhập mới được truy xuất dữ liệu)
        Object customerIdObj = session.getAttribute("customerId");
        int customerId = 0;
        if (customerIdObj != null) {
            try {
                customerId = Integer.parseInt(customerIdObj.toString());
            } catch (NumberFormatException e) {
                // Nếu chuyển đổi thất bại, có thể set giá trị mặc định hoặc thông báo lỗi
                customerId = 0;
            }
        }

        // Lấy số trang từ tham số 'page', mặc định là 1
        String pageParam = request.getParameter("page");
        int currentPage = (pageParam != null && !pageParam.trim().isEmpty()) ? Integer.parseInt(pageParam) : 1;
        int offset = (currentPage - 1) * PAGE_SIZE;

        // Lấy tham số lọc trạng thái thanh toán, mặc định là "all"
        String paymentStatus = request.getParameter("paymentStatus");
        if (paymentStatus == null || paymentStatus.trim().isEmpty()) {
            paymentStatus = "all";
        }

                // Lấy tham số tìm kiếm theo tên khách hàng
                String searchOrder = request.getParameter("searchOrder");
                if (searchOrder != null && searchOrder.trim().isEmpty()) {
                        searchOrder = null;
                }

        // Lấy eventId từ request hoặc từ session nếu không có
        String eventIdParam = request.getParameter("eventId");
        int eventId = -1;
        if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
            eventId = Integer.parseInt(eventIdParam);
            // Lưu eventId vào session để sử dụng cho các request sau
            session.setAttribute("eventId", eventId);
        } else {
            Object eventIdObj = session.getAttribute("eventId");
            if (eventIdObj != null) {
                eventId = Integer.parseInt(eventIdObj.toString());
            }
        }

        OrganizerDAO organizerDAO = new OrganizerDAO();
        // Gọi các phương thức DAO đã được cập nhật để lọc theo eventId và customerId
        List<OrderDetailDTO> orders = organizerDAO.getOrderDetailsByEventAndPaymentStatus(
                eventId, customerId, paymentStatus, searchOrder, offset, PAGE_SIZE);
        int totalRecords = organizerDAO.countOrdersByEventAndPaymentStatus(
                eventId, customerId, paymentStatus, searchOrder);
        int totalPages = (int) Math.ceil(totalRecords / (double) PAGE_SIZE);

        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("paymentStatus", paymentStatus);
        request.setAttribute("searchOrder", searchOrder);
        request.setAttribute("eventId", eventId);

                RequestDispatcher rd = request.getRequestDispatcher("/pages/organizerPage/organizerOrders.jsp");
                rd.forward(request, response);
        }

        @Override
        protected void doPost(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                doGet(request, response);
        }

        @Override
        public String getServletInfo() {
                return "OrganizerOrdersController retrieves orders for a specific event and forwards to organizerOrders.jsp";
        }
}
