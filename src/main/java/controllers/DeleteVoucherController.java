/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.VoucherDAO;
import java.io.PrintWriter;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Dinh Minh Tien CE190701
 */
@WebServlet(name = "DeleteVoucherController", urlPatterns = {"/DeleteVoucherController"})
public class DeleteVoucherController extends HttpServlet {

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
            out.println("<title>Servlet DeleteVoucher</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteVoucher at " + request.getContextPath() + "</h1>");
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
        try {
            // Get voucher ID and event ID from request
            int voucherId = Integer.parseInt(request.getParameter("voucherId"));
            int eventId = Integer.parseInt(request.getParameter("eventId"));

            // Create DAO and delete the voucher
            VoucherDAO voucherDAO = new VoucherDAO();
            boolean success = voucherDAO.deleteVoucher(voucherId);

            // Set success/error message as attribute
            String message = success ? "Voucher deleted successfully!" : "Failed to delete voucher.";
            request.getSession().setAttribute("deleteMessage", message);
            request.getSession().setAttribute("deleteSuccess", success);

            // Redirect back to the voucher list
            response.sendRedirect(request.getContextPath() + "/listVoucher" + "?eventId=" + eventId);
        } catch (NumberFormatException e) {
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            // Handle invalid parameters    
            request.getSession().setAttribute("deleteMessage", "Invalid voucher ID.");
            request.getSession().setAttribute("deleteSuccess", false);
            response.sendRedirect(request.getContextPath() + "/listVoucher" + "?eventId=" + eventId);
        }
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
