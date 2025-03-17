package controllers;

import dals.CustomerDAO;
import models.Customer;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class UpdateAccountController extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();

    // Hiển thị form cập nhật thông tin cá nhân (với dữ liệu hợp lệ từ DB)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        Customer customer = customerDAO.getCustomerById(customerId);
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/pages/adminPage/updateAccount.jsp").forward(request, response);
    }

    // Xử lý POST: Kiểm tra dữ liệu và cập nhật nếu hợp lệ
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> errors = new ArrayList<>();

        // Lấy và trim dữ liệu nhập
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String fullName = request.getParameter("fullName").trim();
        String email = request.getParameter("email").trim();
        String address = request.getParameter("address").trim();
        String phone = request.getParameter("phone").trim();

        // --- Validation cho Full Name ---
        if (fullName == null || fullName.isEmpty()) {
            errors.add("Full name is required.");
        } else {
            String fullNamePattern = "^[\\p{L} .,'-]{2,50}$";
            if (!fullName.matches(fullNamePattern)) {
                errors.add("Full name must contain only letters and valid punctuation (2-50 characters).");
            }
        }

        // --- Validation cho Email ---
        if (email == null || email.isEmpty()) {
            errors.add("Email is required.");
        } else {
            String emailPattern = "^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$";
            if (!email.matches(emailPattern)) {
                errors.add("Email must be a valid email address (e.g., user@example.com).");
            }
        }

        // --- Validation cho Phone ---
        if (phone != null && !phone.isEmpty()) {
            if (!phone.matches("^\\d{7,15}$")) {
                errors.add("Phone number must contain 7 to 15 digits.");
            }
        }

        // Nếu có lỗi, không update dữ liệu:
        if (!errors.isEmpty()) {
            // Lấy dữ liệu hợp lệ từ DB để hiển thị ở giao diện chính
            Customer validCustomer = customerDAO.getCustomerById(customerId);
            request.setAttribute("customer", validCustomer);
            // Đối tượng tạm chứa dữ liệu nhập (có thể sai) để điền vào form modal
            Customer tempCustomer = new Customer();
            tempCustomer.setCustomerId(customerId);
            tempCustomer.setFullName(fullName);
            tempCustomer.setEmail(email);
            tempCustomer.setAddress(address);
            tempCustomer.setPhone(phone);
            request.setAttribute("tempCustomer", tempCustomer);
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/pages/adminPage/updateAccount.jsp").forward(request, response);
            return;  // Dừng xử lý, không cập nhật DB
        }

        // Nếu dữ liệu hợp lệ, update dữ liệu
        Customer customer = new Customer();
        customer.setCustomerId(customerId);
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setAddress(address);
        customer.setPhone(phone);
        customerDAO.updateCustomerInfo(customer);

        response.sendRedirect(request.getContextPath() + "/ViewDetailAccountController?id=" + customerId);
    }
}
