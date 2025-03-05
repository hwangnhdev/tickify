/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import dals.CustomerDAO;
import java.sql.Date;

/**
 *
 * @author Dinh Minh Tien CE190701
 */
public class ProfileController extends HttpServlet {

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
            out.println("<title>Servlet ProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProfileController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        int id = (int) session.getAttribute("customerId");
        CustomerDAO dao = new CustomerDAO();
        Customer customer = dao.getCustomerById(id);
        request.setAttribute("profile", customer);
        request.getRequestDispatcher("pages/profile/profile.jsp").forward(request, response);

        if (customer == null) {
            System.out.println("Customer not found!");
        }
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
        int customerId = Integer.parseInt(request.getParameter("customerId"));
        String fullname = request.getParameter("fullname");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String picture = request.getParameter("profile_picture");
//        Date dob = Date.valueOf(request.getParameter("dob")); // Convert string to SQL Date
//        String gender = request.getParameter("gender");

        // Fetch customer email from the database (since it's not editable)
        CustomerDAO customerDAO = new CustomerDAO();
        Customer existingCustomer = customerDAO.getCustomerById(1);
        String email = existingCustomer.getEmail(); // Retain the original email

        Customer customer = new Customer();
        customer.setCustomerId(customerId);
        customer.setFullName(fullname);
        customer.setEmail(email);
        customer.setAddress(address);
        customer.setPhone(phone);

        customer.setProfilePicture(picture);

        boolean isUpdated = customerDAO.updateCustomer(customer);

        if (isUpdated == true) {
            request.setAttribute("successMessage", "Profile updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Update profile failed.");
        }
        request.setAttribute("profile", customer);
        request.getRequestDispatcher("pages/profile/profile.jsp").forward(request, response);
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
