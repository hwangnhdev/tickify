/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.VoucherDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.sql.Timestamp;
import models.Voucher;

/**
 *
 * @author Dinh Minh Tien CE190701
 */
public class CreateVoucherController extends HttpServlet {

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
            out.println("<title>Servlet CreateVoucherController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateVoucherController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
        Object eventIdObj = session.getAttribute("eventId");
        int eventId = 0;

        if (eventIdObj instanceof Integer) {
            eventId = (Integer) eventIdObj;
            System.out.println("Event ID: " + eventId);
        } else if (eventIdObj instanceof String) {
            try {
                eventId = Integer.parseInt((String) eventIdObj);
                System.out.println("Event ID: " + eventId);
            } catch (NumberFormatException e) {
                System.out.println("Lỗi chuyển đổi String sang Integer: " + e.getMessage());
            }
        } else {
            System.out.println("Event ID không hợp lệ hoặc chưa được set trong session.");
        }
        request.setAttribute("eventId", eventId);
        request.getRequestDispatcher("pages/voucherPage/createVoucher.jsp").forward(request, response);

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
            HttpSession session = request.getSession();
            Object eventIdObj = session.getAttribute("eventId");
            Integer eventId = null;

            // Handle eventId retrieval
            if (eventIdObj instanceof Integer) {
                eventId = (Integer) eventIdObj;
            } else if (eventIdObj instanceof String) {
                try {
                    eventId = Integer.parseInt((String) eventIdObj);
                } catch (NumberFormatException e) {
                    request.setAttribute("error", "Invalid event ID format in session.");
                    request.getRequestDispatcher("pages/voucherPage/createVoucher.jsp").forward(request, response);
                    return;
                }
            }

            if (eventId == null) {
                response.sendRedirect("OrganizerEventController");
                return;
            }

            VoucherDAO voucherDAO = new VoucherDAO();
            Voucher voucher = new Voucher();
            voucher.setEventId(eventId);
            voucher.setCode(request.getParameter("code"));
            voucher.setDescription(request.getParameter("description"));
            voucher.setDiscountType(request.getParameter("discountType"));
            voucher.setDiscountValue(Integer.parseInt(request.getParameter("discountValue")));
            voucher.setStartDate(Timestamp.valueOf(request.getParameter("startDate").replace("T", " ") + ":00"));
            voucher.setEndDate(Timestamp.valueOf(request.getParameter("endDate").replace("T", " ") + ":00"));
            voucher.setUsageLimit(Integer.parseInt(request.getParameter("usageLimit")));
            voucher.setStatus("true".equals(request.getParameter("status")));
            voucher.setDeleted("true".equals(request.getParameter("isDeleted")));

            boolean success = voucherDAO.insertVoucher(voucher);

            if (success) {
                response.sendRedirect("listVoucher");
            } else {
                request.setAttribute("error", "Failed to create voucher");
                request.getRequestDispatcher("pages/voucherPage/createVoucher.jsp").forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Validation error: " + e.getMessage());
            request.getRequestDispatcher("pages/voucherPage/createVoucher.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("pages/voucherPage/createVoucher.jsp").forward(request, response);
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
