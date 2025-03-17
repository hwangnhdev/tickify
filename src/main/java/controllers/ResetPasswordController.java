/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.CustomerAuthDAO;
import dals.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class ResetPasswordController extends HttpServlet {

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
            out.println("<title>Servlet ResetPasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ResetPasswordController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // Kiểm tra độ mạnh của mật khẩu
    private boolean isValidPassword(String password) {
        return password.matches("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,}$");
    }

    private void resetPassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        System.out.println(email);
        System.out.println(newPassword);
        System.out.println(confirmPassword);

        // Kiểm tra mật khẩu có khớp không
        if (!newPassword.equals(confirmPassword)) {
            System.out.println("Mật khẩu xác nhận không khớp!");
            request.setAttribute("errorMessage", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("pages/changePasswordPage/changePassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra độ mạnh của mật khẩu
        if (!isValidPassword(newPassword)) {
            System.out.println("Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường và số!");
            request.setAttribute("errorMessage", "Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường và số!");
            request.getRequestDispatcher("pages/changePasswordPage/changePassword.jsp").forward(request, response);
            return;
        }

        // Mã hóa mật khẩu bằng BCrypt
        String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());

        String provider = "email";

        // Cập nhật mật khẩu vào database
        CustomerDAO customerDao = new CustomerDAO();
        CustomerAuthDAO customerAuthDao = new CustomerAuthDAO();
        Customer customer = customerDao.selectCustomerByEmail(email);
        boolean updateSuccess = customerAuthDao.updateCustomerAuthPasswordByCustomerId(hashedPassword, customer.getCustomerId(), provider);

        if (updateSuccess) {
            HttpSession session = request.getSession();
            session.removeAttribute("email");
            response.sendRedirect("pages/signUpPage/signUp.jsp");
        } else {
            request.setAttribute("errorMessage", "Cập nhật mật khẩu thất bại!");
            request.getRequestDispatcher("pages/changePasswordPage/changePassword.jsp").forward(request, response);
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
        processRequest(request, response);
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
//        processRequest(request, response);
        resetPassword(request, response);
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
