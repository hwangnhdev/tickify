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
import org.json.JSONObject;

public class UpdateAccountController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO = new CustomerDAO();

    // Validate fields and return a list of error messages if any.
    private List<String> validateFields(HttpServletRequest request, int customerId) {
        List<String> errors = new ArrayList<>();

        String fullName = request.getParameter("fullName") != null ? request.getParameter("fullName").trim() : "";
        String email = request.getParameter("email") != null ? request.getParameter("email").trim() : "";
        String address = request.getParameter("address") != null ? request.getParameter("address").trim() : "";
        String phone = request.getParameter("phone") != null ? request.getParameter("phone").trim() : "";
        String dobStr = request.getParameter("dob") != null ? request.getParameter("dob").trim() : "";
        String gender = request.getParameter("gender") != null ? request.getParameter("gender").trim() : "";

        if (fullName.isEmpty()) {
            errors.add("Full name is required.");
        } else if (fullName.length() < 2 || fullName.length() > 30) {
            errors.add("Full name must be between 2 and 30 characters.");
        } else if (!fullName.matches("^[\\p{L} .,'-]+$")) {
            errors.add("Full name can only contain letters and valid punctuation.");
        }

        // Validate Email: proper format and unique check.
        if (email.isEmpty() || !email.matches("^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[A-Za-z0-9-]+\\.)+[A-Za-z]{2,}$")) {
            errors.add("Email is not valid.");
        } else {
            Customer existing = customerDAO.selectCustomerByEmail(email);
            if (existing != null && existing.getCustomerId() != customerId) {
                errors.add("Email is already used by another account.");
            }
        }
        // Check maximum length for email.
        if (email.length() > 100) {
            errors.add("Email must not exceed 100 characters.");
        }

        // Validate Address length (max 255 characters).
        if (address.length() > 255) {
            errors.add("Address must not exceed 255 characters.");
        }

        // Validate Phone: if provided, must contain 7 to 15 digits.
        if (!phone.isEmpty() && !phone.matches("^\\d{7,15}$")) {
            errors.add("Phone number must contain 7 to 15 digits.");
        }
        if (phone.length() > 15) {
            errors.add("Phone number must not exceed 15 digits.");
        }

        // Validate Birth Date: if provided, must be in yyyy-MM-dd format and not in the future.
        if (!dobStr.isEmpty()) {
            try {
                java.sql.Date dob = java.sql.Date.valueOf(dobStr);
                if (dob.after(new java.sql.Date(System.currentTimeMillis()))) {
                    errors.add("Birth date cannot be in the future.");
                }
            } catch (IllegalArgumentException e) {
                errors.add("Birth date format is invalid.");
            }
        }

        // Validate Gender: must be one of: Male, Female, or Other.
        if (gender.isEmpty() || !(gender.equals("Male") || gender.equals("Female") || gender.equals("Other"))) {
            errors.add("Gender must be one of: Male, Female, or Other.");
        }
        return errors;
    }

    // To avoid HTTP 405 for GET requests, forward GET to POST.
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    // Process POST: validate (action=validate) and update (action=update).
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check customerId parameter to avoid NumberFormatException.
        String customerIdStr = request.getParameter("customerId");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONObject json = new JSONObject();

        if (customerIdStr == null || customerIdStr.isEmpty()) {
            json.put("valid", false);
            json.put("message", "Customer ID is missing.");
            response.getWriter().write(json.toString());
            return;
        }
        int customerId = Integer.parseInt(customerIdStr);

        // Get action from request: validate or update.
        String action = request.getParameter("action");
        List<String> errors = validateFields(request, customerId);

        if ("validate".equalsIgnoreCase(action)) {
            if (!errors.isEmpty()) {
                json.put("valid", false);
                json.put("message", errors.get(0));
            } else {
                json.put("valid", true);
                json.put("message", "");
            }
            response.getWriter().write(json.toString());
            return;
        } else if ("update".equalsIgnoreCase(action)) {
            if (!errors.isEmpty()) {
                json.put("valid", false);
                json.put("message", errors.get(0));
                response.getWriter().write(json.toString());
                return;
            }
            // If no errors, update the customer information.
            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            customer.setFullName(request.getParameter("fullName").trim());
            customer.setEmail(request.getParameter("email").trim());
            customer.setAddress(request.getParameter("address").trim());
            customer.setPhone(request.getParameter("phone").trim());
            String dobStrParam = request.getParameter("dob") != null ? request.getParameter("dob").trim() : "";
            Customer current = customerDAO.getCustomerById(customerId); // Get current data from the database.
            if (!dobStrParam.isEmpty()) {
                try {
                    customer.setDob(java.sql.Date.valueOf(dobStrParam)); // Update if new date provided.
                } catch (IllegalArgumentException e) {
                    customer.setDob(current.getDob()); // Keep old date if format is incorrect.
                }
            } else {
                customer.setDob(current.getDob()); // Keep old date if not provided.
            }
            customer.setGender(request.getParameter("gender").trim());

            customerDAO.updateCustomerInfo(customer);

            // Retrieve updated info after update.
            Customer updated = customerDAO.getCustomerById(customerId);
            json.put("valid", true);
            json.put("message", "Update successful.");
            JSONObject data = new JSONObject();
            data.put("fullName", updated.getFullName());
            data.put("email", updated.getEmail());
            data.put("address", updated.getAddress());
            data.put("phone", updated.getPhone());
            data.put("dob", updated.getDob() != null ? updated.getDob().toString() : "");
            data.put("gender", updated.getGender());
            json.put("data", data);
            response.getWriter().write(json.toString());
            return;
        }
    }
}
