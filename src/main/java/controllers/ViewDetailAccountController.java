package controllers;

import dals.CustomerDAO;
import models.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ViewDetailAccountController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    @Override
    public void init() {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số id từ request; nếu không hợp lệ, dùng giá trị mặc định là 47
        String customerIdStr = request.getParameter("id");
        int customerId = 202;
        try {
            customerId = Integer.parseInt(customerIdStr);
        } catch (NumberFormatException e) {
            // Sử dụng giá trị mặc định
        }
        Customer customer = customerDAO.getCustomerProfile(customerId);
        System.out.println("Customer profilePicture: " + customer.getProfilePicture());
        request.setAttribute("customer", customer);
        request.getRequestDispatcher("/pages/adminPage/ViewAccountDetailAdmin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
