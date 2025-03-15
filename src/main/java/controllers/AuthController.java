/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dals.CustomerAuthDAO;
import dals.CustomerDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import models.CustomerAuth;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */

@WebServlet(name = "AuthController", urlPatterns = {"/auth"})
public class AuthController extends HttpServlet {
   
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
            out.println("<title>Servlet AuthController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AuthController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 
    
    // Xử lý đăng ký
    private void handleSignUp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");
        String fullName = (String) session.getAttribute("name");
        String password = (String) session.getAttribute("pass");

        CustomerDAO customerDao = new CustomerDAO();
        CustomerAuthDAO customerAuthDao = new CustomerAuthDAO();
        String provider = "email";

        Customer existingCustomer = customerDao.selectCustomerByEmail(email);

        int existingCustomerId;
        if (existingCustomer != null) {
            existingCustomerId = existingCustomer.getCustomerId();
        } else {
            existingCustomerId = 0;
        }

        CustomerAuth existingCustomerAuth = customerAuthDao.selectCustomerAuthByIdProvider(existingCustomerId, provider);

        //TH0: Chưa có customer_auth trong DB 
        if (existingCustomerAuth == null) {
            //TH1: Chưa có customer trong DB 
            Customer customer = null;
            if (existingCustomer == null) {
                customer = new Customer(0, fullName, email, null, null, null, Boolean.TRUE);
                customerDao.insertCustomer(customer);
            }
            //TH2: Nếu có customer_auth set cho customer thành customer đã có 
            else {
                customer = existingCustomer;
            }
            
            // Mã hóa mật khẩu
            String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

            int insertedCustomerId = customerDao.selectCustomerByEmail(email).getCustomerId();

            CustomerAuth customerAuth = new CustomerAuth(0, insertedCustomerId, provider, hashedPassword, null);
            customerAuthDao.insertCustomerAuth(customerAuth);

            session.setAttribute("customerId", customer.getCustomerId());
            response.sendRedirect("pages/homePage/home.jsp");
        } else{
            request.setAttribute("errorMessage", "Existing email");
            RequestDispatcher dispatcher = request.getRequestDispatcher("pages/signUpPage/signUp.jsp");
            dispatcher.forward(request, response);
        }
    }

    // Xử lý đăng nhập
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        CustomerDAO customerDao = new CustomerDAO();
        CustomerAuthDAO customerAuthDao = new CustomerAuthDAO();
        
        Customer customer = customerDao.selectCustomerByEmail(email);
        CustomerAuth customerAuth = customerAuthDao.selectCustomerAuthById(customer.getCustomerId());
        
        if (customer != null && BCrypt.checkpw(password, customerAuth.getPassword())) {
            HttpSession session = request.getSession();
            session.setAttribute("customerImage", customer.getProfilePicture());
            session.setAttribute("customerId", customer.getCustomerId());
            response.sendRedirect("pages/homePage/home.jsp");
        } else {
            request.setAttribute("errorMessage", "Invalid email or password");
            RequestDispatcher dispatcher = request.getRequestDispatcher("pages/signUpPage/signUp.jsp");
            dispatcher.forward(request, response);
        }
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
//        System.out.println("halo");
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
        HttpSession session = request.getSession();
        String action = (String) session.getAttribute("action");
        if (action == null || action.isEmpty())
            action = request.getParameter("action");
        System.out.println(action);

        if ("signup".equals(action)) {
            handleSignUp(request, response);
            session.removeAttribute("action");
        } else if ("login".equals(action)) {
            handleLogin(request, response);
            session.removeAttribute("action");
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
