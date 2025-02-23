/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customers;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Dinh Minh Tien CE190701
 */
public class ChangePasswordController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangePasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CustomerDAO dao = new CustomerDAO();
        Customers customer = dao.getCustomerById(1);
        request.setAttribute("profile", customer);
        request.getRequestDispatcher("pages/profile/change-password.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

//        HttpSession session = request.getSession();
//        Integer customerId = (Integer) session.getAttribute("customerId");
//        if (customerId == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        CustomerDAO dao = new CustomerDAO();
        Customers existingCustomer = dao.getCustomerById(1);
        System.out.println("Stored Password: " + existingCustomer.getPassword()); // Print current password in DB
        System.out.println("Entered Current Password: " + currentPassword);

        Customers customer = new Customers();
        customer.setPassword(newPassword);

//        if (customer == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
        // Check if current password is correct
//        if (!BCrypt.checkpw(currentPassword, customer.getPassword())) {
//            request.setAttribute("errorMessage", "Current password is incorrect.");
//            request.getRequestDispatcher("pages/profile/change-password.jsp").forward(request, response);
//        } // Check if new password and confirm password match
//        else if (!newPassword.equals(confirmPassword)) {
//            request.setAttribute("errorMessage", "New passwords do not match.");
//            request.getRequestDispatcher("pages/profile/change-password.jsp").forward(request, response);
//        } // Update password
//        else if (dao.updatePassword(1, newPassword)) {
//            request.setAttribute("successMessage", "Password changed successfully.");
//            request.getRequestDispatcher("pages/profile/change-password.jsp").forward(request, response);
//        } else {
//            request.setAttribute("errorMessage", "Error changing password. Please try again.");
//            request.getRequestDispatcher("pages/profile/change-password.jsp").forward(request, response);
//        }

        if (!currentPassword.equals(existingCustomer.getPassword())) {
            request.setAttribute("errorMessage", "Current password is incorrect.");
        } else if (currentPassword.equals(existingCustomer.getPassword()) && !newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New passwords do not match.");
        } else if (dao.updatePassword(1, newPassword)) {
            request.setAttribute("successMessage", "Password changed successfully.");
        }

        request.getRequestDispatcher("pages/profile/change-password.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
