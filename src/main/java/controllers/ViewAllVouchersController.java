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
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Dinh Minh Tien CE190701
 */
public class ViewAllVouchersController extends HttpServlet {

    private static final int PAGE_SIZE = 10;

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
            out.println("<title>Servlet ViewAllVouchersController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewAllVouchersController at " + request.getContextPath() + "</h1>");
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
        // Get event ID from request parameter
        int eventId = 1;
        int page = 1;
        String voucherStatus = request.getParameter("voucherStatus");

        // Default to "all" if no status provided
        if (voucherStatus == null || voucherStatus.trim().isEmpty()) {
            voucherStatus = "all";
        }
        try {
//            eventId = Integer.parseInt(request.getParameter("eventId"));
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("error.jsp");
            return;
        }
        // Validate event ID
//        if (eventId <= 0) {
//            response.sendRedirect("pages/profile/profile.jsp"); // Redirect if no event ID is provided
//            return;
//        }

        try {
//            int eventId = Integer.parseInt(eventIdStr);
            VoucherDAO voucherDAO = new VoucherDAO();
            List<Voucher> vouchers;
            int totalVouchers;
            
            // Filter vouchers based on status
            switch (voucherStatus.toLowerCase()) {
                case "active":
                    vouchers = voucherDAO.getVouchersByEventAndStatus(1, page, PAGE_SIZE, true, false);
                    totalVouchers = voucherDAO.getTotalVouchersByEventAndStatus(1, true);
                    break;
                case "inactive":
                    vouchers = voucherDAO.getVouchersByEventAndStatus(1, page, PAGE_SIZE, false, false);
                    totalVouchers = voucherDAO.getTotalVouchersByEventAndStatus(1, false);
                    break;
                case "all":
                default:
                    vouchers = voucherDAO.getVouchersByEvent(1, page, PAGE_SIZE);
                    totalVouchers = voucherDAO.getTotalVouchersByEvent(1);
                    break;
            }
            int totalPages = (int) Math.ceil((double) totalVouchers / PAGE_SIZE);

            // Format expiration time and determine status
            SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            for (Voucher v : vouchers) {
                String start = dateFormat.format(v.getStartDate());
                String end = dateFormat.format(v.getEndDate());
                v.setFormattedExpirationTime(start + " - " + end);

                // Check if the voucher is expired
                v.setStatusLabel(v.getEndDate().getTime() >= System.currentTimeMillis() ? "Ongoing" : "Expired");

                // Format discount based on type
                if ("percentage".equalsIgnoreCase(v.getDiscountType())) {
                    v.setFormattedDiscount(v.getDiscountValue() + "%");
                } else {
                    v.setFormattedDiscount(String.format("%d VND", v.getDiscountValue()));
                }
            }

            for (Voucher v : vouchers) {
                System.out.println("Voucher " + v.getVoucherId() + " status: " + v.isStatus());
            }

            // Send vouchers to JSP
            request.setAttribute("vouchers", vouchers);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("eventId", eventId);
            request.setAttribute("status", eventId);
            request.getRequestDispatcher("pages/voucherPage/listVoucher.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/event"); // Handle invalid event ID
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
        doGet(request, response);
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
