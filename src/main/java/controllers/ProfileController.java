package controllers;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;

import configs.CloudinaryConfig;
import models.Customer;
import dals.CustomerDAO;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.sql.Date;

@MultipartConfig(
    maxFileSize = 1024 * 1024 * 5,    // 5MB
    maxRequestSize = 1024 * 1024 * 10 // 10MB
)
public class ProfileController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(ProfileController.class.getName());
    private Cloudinary cloudinary;

    @Override
    public void init() throws ServletException {
        cloudinary = CloudinaryConfig.getInstance();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        int customerId = -1;

        // Robust customer ID extraction
        try {
            Object customerIdObj = (session != null) ? session.getAttribute("customerId") : null;

            if (customerIdObj instanceof Integer) {
                customerId = (Integer) customerIdObj;
            } else if (customerIdObj instanceof String) {
                customerId = Integer.parseInt((String) customerIdObj);
            }

            // Validate customer ID
            if (customerId <= 0) {
                System.out.println("Invalid customer ID: " + customerId);
                response.sendRedirect(request.getContextPath() + "/event");
                return;
            }

            // Fetch and validate customer
            CustomerDAO dao = new CustomerDAO();
            Customer customer = dao.selectCustomerById(customerId);

            if (customer == null) {
                System.out.println("No customer found for ID: " + customerId);
                response.sendRedirect(request.getContextPath() + "/event");
                return;
            }

            // Set customer profile and forward
            request.setAttribute("profile", customer);
            request.getRequestDispatcher("pages/profile/profile.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid customer ID format", e);
            response.sendRedirect(request.getContextPath() + "/event");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Unexpected error in doGet", e);
            response.sendRedirect(request.getContextPath() + "/event");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Extract and validate customer ID
            int customerId = -1;
            HttpSession session = request.getSession(false);
            Object customerIdObj = (session != null) ? session.getAttribute("customerId") : null;

            if (customerIdObj instanceof Integer) {
                customerId = (Integer) customerIdObj;
            } else if (customerIdObj instanceof String) {
                customerId = Integer.parseInt((String) customerIdObj);
            }

            if (customerId <= 0) {
                LOGGER.warning("Invalid customer ID in update request: " + customerId);
                response.sendRedirect(request.getContextPath() + "/event");
                return;
            }

            // Fetch existing customer
            CustomerDAO customerDAO = new CustomerDAO();
            Customer existingCustomer = customerDAO.selectCustomerById(customerId);

            if (existingCustomer == null) {
                LOGGER.warning("No customer found for ID: " + customerId);
                response.sendRedirect(request.getContextPath() + "/event");
                return;
            }

            // Sanitize and validate inputs
            String fullname = request.getParameter("fullname");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");
            Date dob = Date.valueOf(request.getParameter("dob"));
            String gender = request.getParameter("gender");

            String picture = existingCustomer.getProfilePicture();
            Part filePart = request.getPart("profile_picture");
            if (filePart != null && filePart.getSize() > 0) {
                LOGGER.log(Level.INFO, "Uploading file: {0}, Size: {1}", new Object[]{filePart.getSubmittedFileName(), filePart.getSize()});
                try ( InputStream inputStream = filePart.getInputStream()) {
                    // Convert InputStream to byte array as a fallback for Cloudinary 2.0.0
                    ByteArrayOutputStream baos = new ByteArrayOutputStream();
                    byte[] buffer = new byte[1024];
                    int bytesRead;
                    while ((bytesRead = inputStream.read(buffer)) != -1) {
                        baos.write(buffer, 0, bytesRead);
                    }
                    byte[] fileBytes = baos.toByteArray();

                    if (fileBytes.length > 0) {
                        Map uploadResult = cloudinary.uploader().upload(
                                fileBytes,
                                ObjectUtils.asMap(
                                        "folder", "profile_pictures",
                                        "overwrite", true,
                                        "resource_type", "image" // Explicitly specify resource type
                                )
                        );
                        picture = (String) uploadResult.get("url");
                        LOGGER.log(Level.INFO, "Upload successful, URL: {0}", picture);
                    } else {
                        LOGGER.warning("Empty file content for profile picture upload");
                    }
                } catch (IOException e) {
                    LOGGER.log(Level.WARNING, "Profile picture upload failed for customer ID: " + customerId, e);
                    // Keep existing picture on upload failure
                }
            } else {
                LOGGER.log(Level.INFO, "No profile picture uploaded for customer ID: {0}", customerId);
            }

            // Create updated customer
            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            customer.setFullName(fullname);
            customer.setEmail(existingCustomer.getEmail());
            customer.setAddress(address);
            customer.setPhone(phone);
            customer.setProfilePicture(picture);
            customer.setDob(dob);
            customer.setGender(gender);

            // Perform update
            boolean isUpdated = customerDAO.updateCustomer(customer);

            // Set response attributes
            if (isUpdated) {
                request.setAttribute("successMessage", "Profile updated successfully");
                request.setAttribute("profile", customer);
            } else {
                request.setAttribute("errorMessage", "Failed to update profile");
                request.setAttribute("profile", existingCustomer);
            }

            // Forward to profile page
            request.getRequestDispatcher("pages/profile/profile.jsp").forward(request, response);

        } catch (ServletException | IOException | NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Error in profile update", e);
            request.setAttribute("errorMessage", "An unexpected error occurred");
            request.getRequestDispatcher("pages/profile/profile.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Profile Management Servlet";
    }
}
