/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.PrintWriter;
import dals.VoucherDAO;
import models.Voucher;
import java.io.IOException;
import java.text.SimpleDateFormat;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;

/**
 *
 * @author Dinh Minh Tien CE190701
 */
public class VoucherController extends HttpServlet {

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
            out.println("<title>Servlet VoucherController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VoucherController at " + request.getContextPath() + "</h1>");
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
        VoucherDAO dao = new VoucherDAO();
        int voucherId = Integer.parseInt(request.getParameter("voucherId"));
        Voucher voucher = dao.getVoucherById(voucherId);
        request.setAttribute("voucher", voucher);
        request.getRequestDispatcher("pages/voucherPage/editVoucher.jsp").forward(request, response);
//        SimpleDateFormat displayFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
//        System.out.println(displayFormat.format(voucher.getEndDate()));
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
            int voucherId = Integer.parseInt(request.getParameter("voucherId"));
            int eventId = Integer.parseInt(request.getParameter("eventId"));
            String code = request.getParameter("code");
            String description = request.getParameter("description");
            String discountType = request.getParameter("discountType");
            int discountValue = Integer.parseInt(request.getParameter("discountValue"));

            // Convert datetime-local input (yyyy-MM-ddTHH:mm) to Timestamp format (yyyy-MM-dd HH:mm:ss)
            String startDateStr = request.getParameter("startDate").replace("T", " ") + ":00";
            String endDateStr = request.getParameter("endDate").replace("T", " ") + ":00";
            Timestamp startDate = Timestamp.valueOf(startDateStr);
            Timestamp endDate = Timestamp.valueOf(endDateStr);

            int usageLimit = Integer.parseInt(request.getParameter("usageLimit"));
            if (usageLimit < 0) {
                throw new IllegalArgumentException("Usage limit must be greater than 0");
            }

            // Get the status from the form (checkbox or dropdown)
            boolean status = Boolean.parseBoolean(request.getParameter("status")); // Expect "true" or "false"
            boolean isDeleted = Boolean.parseBoolean(request.getParameter("isDeleted"));

            Voucher voucher = new Voucher(voucherId, eventId, code, description, discountType,
                    discountValue, startDate, endDate, usageLimit, status, null, null, isDeleted);

            VoucherDAO voucherDAO = new VoucherDAO();
            boolean success = voucherDAO.updateVoucher(voucher);

            if (success) {
                response.sendRedirect("VoucherController?voucherId=" + voucherId);
            } else {
                request.setAttribute("error", "Failed to update voucher");
                request.setAttribute("voucher", voucher);
                request.getRequestDispatcher("pages/voucherPage/editVoucher.jsp").forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Invalid date format or input. Please use valid values.");
            request.getRequestDispatcher("pages/voucherPage/editVoucher.jsp").forward(request, response);
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
