package controllers;

import dals.CustomerDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Customer;

public class ViewAllCustomersController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số tìm kiếm, lọc trạng thái và phân trang từ request
        String searchTerm = request.getParameter("search");
        String selectedStatus = request.getParameter("status");
        String sortColumn = request.getParameter("sortColumn");
        String sortOrder = request.getParameter("sortOrder");
        String pageNumberStr = request.getParameter("page");

        int pageNumber = (pageNumberStr != null && !pageNumberStr.isEmpty())
                ? Integer.parseInt(pageNumberStr) : 1;
        int pageSize = 10; // Số bản ghi mỗi trang

        // Nếu searchTerm rỗng, set nó thành null để trả về tất cả
        if (searchTerm != null && searchTerm.trim().isEmpty()) {
            searchTerm = null;
        }

        // Thiết lập giá trị mặc định cho sort
        if (sortColumn == null || sortColumn.trim().isEmpty()) {
            sortColumn = "full_name";
        }
        if (sortOrder == null || sortOrder.trim().isEmpty()) {
            sortOrder = "ASC";
        }

        // Gọi DAO để lấy danh sách khách hàng theo từ khóa, trạng thái, sắp xếp và phân trang
        CustomerDAO customerDAO = new CustomerDAO();
        List<Customer> customers = customerDAO.getAllCustomers(searchTerm, selectedStatus, sortColumn, sortOrder, pageNumber, pageSize);
        int totalRecords = customerDAO.getTotalCustomerCount(searchTerm, selectedStatus);
        int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

        // Đặt các thuộc tính vào request
        request.setAttribute("customers", customers);
        request.setAttribute("page", pageNumber);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("searchTerm", searchTerm);
        request.setAttribute("selectedStatus", selectedStatus);

        // Chuyển tiếp sang trang JSP hiển thị danh sách tài khoản
        request.getRequestDispatcher("/pages/adminPage/viewAllAccount.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
