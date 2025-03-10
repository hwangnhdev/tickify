package controllers;

import dals.CustomerDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Customer;


public class UpdateAccountController extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();

    // Xử lý GET: Hiển thị form cập nhật thông tin cá nhân
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        Customer customer = customerDAO.getCustomerById(customerId);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/pages/adminPage/updateAccount.jsp").forward(request, response);
    }

    // Xử lý POST: Nhận dữ liệu từ form và cập nhật thông tin nếu hợp lệ
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> errors = new ArrayList<>();

        // Lấy dữ liệu từ form
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // Validation cho Full Name: bắt buộc, chỉ cho phép chữ cái và một số ký tự hợp lệ, độ dài 2-50 ký tự.
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.add("Full name is required.");
        } else if (!fullName.matches("^[\\p{L} .'-]{2,50}$")) {
            errors.add("Full name must contain only letters and valid punctuation (2-50 characters).");
        }

        // Validation cho Email: bắt buộc, định dạng phải đúng và phải là Gmail.
        if (email == null || email.trim().isEmpty()) {
            errors.add("Email is required.");
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@gmail\\.com$")) {
            errors.add("Email must be a valid Gmail address (e.g., user@gmail.com).");
        }

        // Validation cho Phone: nếu nhập, phải chỉ chứa chữ số và có độ dài từ 7 đến 15 ký tự.
        if (phone != null && !phone.trim().isEmpty()) {
            if (!phone.matches("\\d{7,15}")) {
                errors.add("Phone number must contain 7 to 15 digits.");
            }
        }

        // Nếu có lỗi, giữ lại dữ liệu vừa nhập và forward lại form cùng danh sách lỗi
        if (!errors.isEmpty()) {
            Customer tempCustomer = new Customer();
            tempCustomer.setCustomerId(customerId);
            tempCustomer.setFullName(fullName);
            tempCustomer.setEmail(email);
            tempCustomer.setAddress(address);
            tempCustomer.setPhone(phone);
            
            request.setAttribute("errors", errors);
            request.setAttribute("customer", tempCustomer);
            request.getRequestDispatcher("/pages/adminPage/updateAccount.jsp").forward(request, response);
            return;
        }

        // Nếu dữ liệu hợp lệ, tạo đối tượng Customer và cập nhật thông tin
        Customer customer = new Customer();
        customer.setCustomerId(customerId);
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setAddress(address);
        customer.setPhone(phone);

        customerDAO.updateCustomerInfo(customer);

        // Chuyển hướng về trang xem chi tiết tài khoản sau khi cập nhật thành công
        response.sendRedirect(request.getContextPath() + "/ViewDetailAccountController?id=" + customerId);
    }
}
