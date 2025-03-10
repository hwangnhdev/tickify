package controllers;

import dals.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class DeactivateAccountController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy tham số "id" và "action" từ request
        String idParam = request.getParameter("id");
        String action = request.getParameter("action"); // "activate" hoặc "inactive"

        if (idParam != null && !idParam.isEmpty() && action != null && !action.isEmpty()) {
            try {
                int customerId = Integer.parseInt(idParam);
                // Nếu action là "activate" thì active = true, nếu "inactive" thì active = false
                boolean active = action.equals("activate");
                boolean success = customerDAO.updateAccountStatus(customerId, active);
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/ViewAllCustomersController?message=" + action);
                } else {
                    response.sendRedirect(request.getContextPath() + "/ViewAllCustomersController?error=" + action + "Failed");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/ViewAllCustomersController?error=invalidId");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/ViewAllCustomersController");
        }
    }
}
