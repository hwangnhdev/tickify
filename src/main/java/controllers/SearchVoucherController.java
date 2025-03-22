/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.List;
import models.Voucher;

/**
 *
 * @author Dinh Minh Tien CE190701
 */
@WebServlet(name = "SearchVoucherController", urlPatterns = {"/searchVoucher"})
public class SearchVoucherController extends HttpServlet {

    private static final int PAGE_SIZE = 20;

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
            out.println("<title>Servlet SearchVoucherController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SearchVoucherController at " + request.getContextPath() + "</h1>");
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
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        String keyword = request.getParameter("searchVoucher");
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;

        VoucherDAO voucherDAO = new VoucherDAO();
        List<Voucher> vouchers = voucherDAO.searchVoucher(eventId, keyword, page, PAGE_SIZE);
        int totalVouchers = voucherDAO.getTotalSearchVouchers(eventId, keyword);
        int totalPages = (int) Math.ceil((double) totalVouchers / PAGE_SIZE);

        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        for (Voucher v : vouchers) {
            v.setFormattedExpirationTime(dateFormat.format(v.getStartDate()) + " - " + dateFormat.format(v.getEndDate()));
            v.setStatusLabel(v.getEndDate().getTime() >= System.currentTimeMillis() ? "Ongoing" : "Expired");
            v.setFormattedDiscount("percentage".equalsIgnoreCase(v.getDiscountType()) ? v.getDiscountValue() + "%" : String.format("%d VND", v.getDiscountValue()));
        }

        request.setAttribute("vouchers", vouchers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("eventId", eventId);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("/pages/voucherPage/listVoucher.jsp").forward(request, response);
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
        processRequest(request, response);
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
