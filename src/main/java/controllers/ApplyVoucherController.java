package controllers;

import dals.VoucherDAO;
import models.Voucher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;

public class ApplyVoucherController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        JSONObject jsonResponse = new JSONObject();

        String voucherCode = request.getParameter("voucherCode");
        int eventId = Integer.parseInt(request.getParameter("eventId"));

        VoucherDAO voucherDAO = new VoucherDAO();
        Voucher voucher = voucherDAO.getVoucherByCode(voucherCode);

        HttpSession session = request.getSession();
        double subtotal = Double.parseDouble(session.getAttribute("subtotal").toString());

        System.out.println("Voucher Code: " + voucherCode);
        System.out.println("Event ID: " + eventId);
        System.out.println("Subtotal: " + subtotal);

        if (voucher != null) {
            System.out.println("Voucher Found: " + voucher.getCode());
            System.out.println("Voucher ID: " + voucher.getVoucherId());
            System.out.println("Voucher Event ID: " + voucher.getEventId());
            System.out.println("Discount Type: " + voucher.getDiscountType());
            System.out.println("Discount Value: " + voucher.getDiscountValue());
            System.out.println("Status: " + voucher.isStatus());
            System.out.println("Deleted: " + voucher.isDeleted());
            System.out.println("Start Date: " + voucher.getStartDate());
            System.out.println("End Date: " + voucher.getEndDate());
        } else {
            System.out.println("Voucher not found for code: " + voucherCode);
        }

        if (voucher != null && voucher.getEventId() == eventId && voucher.isStatus() && !voucher.isDeleted()) {
            java.util.Date currentDate = new java.util.Date();
            System.out.println("Current Date: " + currentDate);
            if (currentDate.after(voucher.getStartDate()) && currentDate.before(voucher.getEndDate())) {
                double discount = 0;

                if ("Percentage".equals(voucher.getDiscountType())) {
                    discount = subtotal * (voucher.getDiscountValue() / 100.0);
                    System.out.println("Calculated Percentage Discount: " + discount);
                } else if ("Fixed".equals(voucher.getDiscountType())) {
                    discount = voucher.getDiscountValue();
                    System.out.println("Fixed Discount: " + discount);
                } else {
                    System.out.println("Unknown discount type: " + voucher.getDiscountType());
                }

                // Ensure discount doesn't exceed subtotal
                discount = Math.min(discount, subtotal);
                double newTotal = subtotal - discount;

                // Update session with new total
                session.setAttribute("total", newTotal);
                session.setAttribute("voucherId", voucher.getVoucherId()); // Store voucherId in session
                System.out.println("New Total after discount: " + newTotal);
                System.out.println("Voucher ID stored in session: " + voucher.getVoucherId());

                jsonResponse.put("success", true);
                jsonResponse.put("discount", discount);
                jsonResponse.put("total", newTotal); // Optionally send total back to client
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Voucher has expired");
                System.out.println("Voucher expired: Start=" + voucher.getStartDate() + ", End=" + voucher.getEndDate());
            }
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid or unavailable voucher code");
            session.removeAttribute("voucherId");
        }

        System.out.println("Response: " + jsonResponse.toString());
        response.getWriter().write(jsonResponse.toString());
    }
}