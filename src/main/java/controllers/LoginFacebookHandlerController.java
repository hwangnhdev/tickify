/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import configs.AuthConfig;
import dals.CustomerAuthDAO;
import dals.CustomerDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import models.Customer;
import models.CustomerAuth;
import viewModels.UserFacebookDTO;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.fluent.Request;
import org.apache.http.client.fluent.Form;
import utils.EmailUtility;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class LoginFacebookHandlerController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginFacebookHandlerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginFacebookHandlerController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    public static String getToken(String code) throws ClientProtocolException, IOException {
        String response = Request.Post(AuthConfig.FACEBOOK_LINK_GET_TOKEN)
                .bodyForm(
                        Form.form()
                                .add("client_id", AuthConfig.FACEBOOK_CLIENT_ID)
                                .add("client_secret", AuthConfig.FACEBOOK_CLIENT_SECRET)
                                .add("redirect_uri", AuthConfig.FACEBOOK_REDIRECT_URI)
                                .add("code", code)
                                .build())
                .execute().returnContent().asString();
        JsonObject jobj = new Gson().fromJson(response, JsonObject.class);
        String accessToken = jobj.get("access_token").toString().replaceAll("\"", "");
        return accessToken;
    }

    public static UserFacebookDTO getUserInfo(String accessToken) throws ClientProtocolException, IOException {
        String link = AuthConfig.FACEBOOK_LINK_GET_USER_INFO + accessToken;
        String response = Request.Get(link).execute().returnContent().asString();
        System.out.println("Facebook API Response: " + response);
        UserFacebookDTO fbAccount = new Gson().fromJson(response, UserFacebookDTO.class);
        return fbAccount;
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String code = request.getParameter("code");
            String accessToken = getToken(code);
            UserFacebookDTO user = getUserInfo(accessToken);
            System.out.println(user);
            System.out.println(user.getPicture());

            CustomerDAO customerDao = new CustomerDAO();
            CustomerAuthDAO customerAuthDao = new CustomerAuthDAO();
            Customer customerSendRedirect = new Customer();
            String provider = "facebook";

            if (user.getEmail() == null)
                user.setEmail(user.getId() + "@temp.com");

            Customer existingCustomer = customerDao.selectCustomerByEmail(user.getEmail());

            int existingCustomerId;
            if (existingCustomer != null) {
                existingCustomerId = existingCustomer.getCustomerId();
                customerSendRedirect = existingCustomer;

                if (!existingCustomer.getStatus()) {
                    request.setAttribute("errorMessage", "This account has been banned!");
                    System.out.println("This account has been banned!");
                    response.sendRedirect("pages/signUpPage/signUp.jsp");
                    return;
                }
            } else {
                existingCustomerId = 0;
            }

            CustomerAuth existingCustomerAuth = customerAuthDao.selectCustomerAuthByIdProvider(existingCustomerId,
                    provider);

            // TH2: Có customer nhưng chưa có customer_auth trong DB
            if (existingCustomer != null && existingCustomerAuth == null) {
                // Lấy customer_id đã có trong Customers thêm 1 thằng Customer_auths
                CustomerAuth customerAuth = new CustomerAuth(0, existingCustomer.getCustomerId(), provider, null,
                        user.getId());
                customerAuthDao.insertCustomerAuth(customerAuth);
            }

            // TH1: Chưa có customer và customer_auth trong DB
            if (existingCustomer == null && existingCustomerAuth == null) {
                Customer customer = new Customer(0, user.getName(), user.getEmail(), null, null, user.getPicture(),
                        Boolean.TRUE);
                customerDao.insertCustomer(customer);

                int insertedCustomerId = customerDao.selectCustomerByEmail(user.getEmail()).getCustomerId();

                CustomerAuth customerAuth = new CustomerAuth(0, insertedCustomerId, provider, null, user.getId());
                customerAuthDao.insertCustomerAuth(customerAuth);

                customerSendRedirect = customer;
            }

            System.out.println(customerSendRedirect);

            // Login
            HttpSession session = request.getSession();
            session.setMaxInactiveInterval(7 * 24 * 60 * 60); // 7days
            session.setAttribute("customerImage", customerSendRedirect.getProfilePicture());
            session.setAttribute("customerId", customerSendRedirect.getCustomerId());
            request.getRequestDispatcher("").forward(request, response);
            // response.sendRedirect(request.getContextPath());
        } catch (Exception e) {
            request.setAttribute("error", "Login fail!");
            request.getRequestDispatcher("pages/signUpPage/signUp.jsp").forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
        handleLogin(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * 
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // processRequest(request, response);
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
