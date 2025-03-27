/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.AdminDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Admin;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Dinh Minh Tien CE190701
 */
public class AdminChangePasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Object adminIdObj = session.getAttribute("adminId");
        int adminId = 0;
        if (adminIdObj instanceof Integer) {
            adminId = (Integer) adminIdObj;
            System.out.println("admin ID: " + adminId);
        } else if (adminIdObj instanceof String) {
            try {
                adminId = Integer.parseInt((String) adminIdObj);
                System.out.println("admin ID: " + adminId);
            } catch (NumberFormatException e) {
                System.out.println("Lỗi chuyển đổi String sang Integer: " + e.getMessage());
            }
        } else {
            System.out.println("admin ID không hợp lệ hoặc chưa được set trong session.");
            response.sendRedirect("adminLogin");
        }

        AdminDAO dao = new AdminDAO();
        Admin admin = dao.selectAdminById(adminId);
        request.setAttribute("profile", admin);

        if (admin == null) {
            response.sendRedirect("adminLogin");
            return;
        }

        // Forward to change password page
        request.getRequestDispatcher("pages/adminPage/settings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer adminId = (Integer) session.getAttribute("adminId");

        // Check if admin is logged in
        if (adminId == null) {
            response.sendRedirect("adminLogin");
            return;
        }

        try {
            // Get password parameters
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");

            AdminDAO adminDAO = new AdminDAO();
            Admin admin = adminDAO.selectAdminById(adminId);

            if (admin == null) {
                request.setAttribute("error", "Admin account not found");
                request.getRequestDispatcher("pages/adminPage/settings.jsp").forward(request, response);
                return;
            }

            // Validate current password
            if (!BCrypt.checkpw(currentPassword, admin.getPassword())) {
                request.setAttribute("error", "Current password is incorrect");
                request.getRequestDispatcher("pages/adminPage/settings.jsp").forward(request, response);
                return;
            }

            // Validate new password match
            if (!newPassword.equals(confirmPassword)) {
                request.setAttribute("error", "New passwords do not match");
                request.getRequestDispatcher("pages/adminPage/settings.jsp").forward(request, response);
                return;
            }

            // Optional: Add password strength validation
            if (newPassword.length() < 8) {
                request.setAttribute("error", "New password must be at least 8 characters long");
                request.getRequestDispatcher("pages/adminPage/settings.jsp").forward(request, response);
                return;
            }

            // Hash new password and update
            String hashedNewPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            admin.setPassword(hashedNewPassword);

            // Update admin in database
            boolean updated = adminDAO.updateAdmin(admin);

            if (updated) {
                request.setAttribute("message", "Password changed successfully");
            } else {
                request.setAttribute("error", "Failed to change password");
            }

            request.getRequestDispatcher("pages/adminPage/settings.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("pages/adminPage/settings.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Admin Change Password Controller - Handles admin password changes";
    }
}
