/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Admin;
import dals.AdminDAO;

public class AdminProfileController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Check if admin is logged in
        Integer adminId = (Integer) session.getAttribute("adminId");
        if (adminId == null) {
            response.sendRedirect("adminLogin");
            return;
        }

        AdminDAO dao = new AdminDAO();
        Admin admin = dao.selectAdminById(adminId);

        if (admin == null) {
            System.out.println("Admin not found!");
            response.sendRedirect("adminLogin");
            return;
        }

        request.setAttribute("profile", admin);
        request.getRequestDispatcher("pages/adminPage/adminProfile.jsp").forward(request, response);
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
            AdminDAO adminDAO = new AdminDAO();
            String name = request.getParameter("name");
            String picture = request.getParameter("profile_picture");
            Admin existingAdmin = adminDAO.selectAdminById(adminId);
            String email = existingAdmin.getEmail();    

            Admin admin = new Admin();
            admin.setName(name);
            admin.setEmail(email);
            admin.setProfilePicture(picture);

            boolean updated = adminDAO.updateAdmin(admin);

            if (updated) {
                request.setAttribute("message", "Profile updated successfully");
                request.setAttribute("profile", admin);
            } else {
                request.setAttribute("error", "Failed to update profile");
                request.setAttribute("profile", admin);
            }

            request.getRequestDispatcher("pages/adminPage/adminProfile.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            request.getRequestDispatcher("pages/adminPage/adminProfile.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Admin Profile Controller - Handles viewing and updating admin profile information";
    }
}
