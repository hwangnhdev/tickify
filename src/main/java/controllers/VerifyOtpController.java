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
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import utils.OTPService;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class VerifyOtpController extends HttpServlet {

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
            out.println("<title>Servlet VerifyOtpController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyOtpController at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession();
        String email = (String) request.getSession().getAttribute("email");
        String inputOtp = request.getParameter("otp");
        String action = (String) session.getAttribute("action");
        
        // Nếu không sử dụng Redis
//        String verificationCode = String.valueOf(session.getAttribute("verificationCode"));

        // So sánh mã OTP từ Redis và mã OTP từ người dùng input
        boolean isOtpValid;
        OTPService otpService = new OTPService();
        if (otpService.isValidOTP(email, inputOtp)) {
            otpService.deleteOTP(email); // Xóa OTP sau khi xác thực thành công
            isOtpValid = true;
        } else {
            isOtpValid = false;
            request.setAttribute("errorMessage", "Mã OTP không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("pages/submitOTPPage/submitOTP.jsp").forward(request, response);
        }
        
        System.out.println("OTP: " + action);
        System.out.println("OTP valid: " + isOtpValid);

        //Sign Up
        if (isOtpValid && "signup".equals(action)) {
            // Lấy session hiện tại
            String sessionId = session.getId(); // Lấy JSESSIONID

            // Kiểm tra email có null không
            if (email == null || email.trim().isEmpty()) {
                throw new ServletException("Lỗi: Email bị null hoặc rỗng");
            }

            // Mở kết nối HTTP đến AuthController
            URL url = new URL("http://localhost:8080/Tickify/auth");
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setDoOutput(true);

            // **Thêm JSESSIONID vào request header**
            conn.setRequestProperty("Cookie", "JSESSIONID=" + sessionId);

            // Gửi dữ liệu email
            try ( OutputStream os = conn.getOutputStream()) {
                os.write(("email=" + URLEncoder.encode(email, "UTF-8")).getBytes());
                os.flush();
            }

            // Đọc phản hồi từ AuthController
            StringBuilder responseContent;
            try ( BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()))) {
                String output;
                responseContent = new StringBuilder();
                while ((output = in.readLine()) != null) {
                    responseContent.append(output);
                }
            }

            // Gửi phản hồi về client
            response.getWriter().write(responseContent.toString());
        } 

        //Foget Password
        if (isOtpValid && "forgetPassword".equals(action)) {
            response.sendRedirect("pages/changePasswordPage/changePassword.jsp");
        }
        
//        else {
//            // Nếu OTP sai, quay lại trang nhập OTP với thông báo lỗi
//            request.setAttribute("error", "Invalid OTP, please try again.");
//            request.getRequestDispatcher("otpForm.jsp").forward(request, response);
//        }
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
