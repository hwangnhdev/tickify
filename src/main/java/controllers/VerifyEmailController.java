/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dals.CustomerDAO;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Customer;
import utils.EmailUtility;
import utils.OTPService;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class VerifyEmailController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet VerifyEmailController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyEmailController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
    
    private void sendOtp(HttpServletRequest request, HttpServletResponse response, String email) throws MessagingException {
            // Tạo mã OTP 6 chữ số
        Random random = new Random();
        int verificationCode = 100000 + random.nextInt(900000);
        System.out.println("Verification OTP: " + verificationCode);

        // Lưu OTP vào database hoặc Redis (nếu dùng Redis thì xóa dòng session bên dưới)
        OTPService otpService = new OTPService();
        otpService.saveOTP(email, String.valueOf(verificationCode));

        // Gửi email
        String recipient = email;
        String subject = "Email verification";
        String content = "Your verification code is: " + verificationCode;
        EmailUtility.sendEmail(recipient, subject, content);
        
//        HttpSession session = request.getSession();
//        session.setAttribute("verificationCode", verificationCode); // Lưu OTP vào session
    }
    
    private void moveToOtp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, MessagingException {
        String action = request.getParameter("action");
        System.out.println("Email: " + action);
        
        if (action.equalsIgnoreCase("signup")) {
            String fullName = request.getParameter("name");
            String email = request.getParameter("email");
            String pass = request.getParameter("password");

            sendOtp(request, response, email);
    
            HttpSession session = request.getSession();
            session.setAttribute("name", fullName); // Lưu Email vào session
            session.setAttribute("email", email); // Lưu Email vào session
            session.setAttribute("pass", pass); // Lưu Email vào session
            session.setAttribute("action", action); // Lưu Email vào session
        }
        
        if (action.equalsIgnoreCase("forgetPassword")) {
            String email = request.getParameter("email");
            
            CustomerDAO customerDao = new CustomerDAO();
            Customer existingCustomer = customerDao.selectCustomerByEmail(email);
            
            if (existingCustomer == null) {
                request.setAttribute("errorMessage", "Email không tồn tại!");
                request.getRequestDispatcher("pages/forgetPasswordPage/forgetPassword.jsp").forward(request, response);
            } else {
                sendOtp(request, response, email);
                
                HttpSession session = request.getSession();
                session.setAttribute("email", email); // Lưu Email vào session
                session.setAttribute("action", action); // Lưu action vào session
            }
        }
        
        request.setAttribute("successMessage", "Mã OTP đã được gửi!");
        response.sendRedirect("pages/submitOTPPage/submitOTP.jsp"); // Chuyển người dùng đến trang nhập OTP
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            moveToOtp(request, response);
        } catch (MessagingException ex) {
            Logger.getLogger(VerifyEmailController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
