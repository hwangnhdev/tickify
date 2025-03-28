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
            System.out.println("Remaining Usage Limit: " + voucher.getUsageLimit());
        } else {
            System.out.println("Voucher not found for code: " + voucherCode);
        }

        if (voucher != null && voucher.getEventId() == eventId && voucher.isStatus() && !voucher.isDeleted()) {
            java.util.Date currentDate = new java.util.Date();
            System.out.println("Current Date: " + currentDate);
            if (currentDate.after(voucher.getStartDate()) && currentDate.before(voucher.getEndDate())) {
                if (voucher.getUsageLimit() > 0) { // Check if usageLimit > 0
                    double discount = 0;
                    double newTotal = subtotal;

                    if ("Percentage".equalsIgnoreCase(voucher.getDiscountType())) {
                        discount = subtotal * (voucher.getDiscountValue() / 100.0);
                        System.out.println("Calculated Percentage Discount: " + discount);
                        newTotal = subtotal - discount; // Percentage discount inherently capped at subtotal
                    } else if ("Fixed".equalsIgnoreCase(voucher.getDiscountType())) {
                        discount = voucher.getDiscountValue();
                        System.out.println("Fixed Discount: " + discount);
                        // If fixed discount exceeds subtotal, set total to 5000 VND (minimum payment)
                        newTotal = (discount >= subtotal) ? 5000 : subtotal - discount;
                    } else {
                        System.out.println("Unknown discount type: " + voucher.getDiscountType());
                    }

                    // Ensure newTotal is at least 5000 VND (minimum payment requirement)
                    newTotal = Math.max(newTotal, 5000);
                    System.out.println("New Total after discount (min 5000 VND): " + newTotal);

                    // Update session with new total and voucherId
                    session.setAttribute("total", newTotal);
                    session.setAttribute("voucherId", voucher.getVoucherId());
                    System.out.println("Voucher ID stored in session: " + voucher.getVoucherId());

                    jsonResponse.put("success", true);
                    jsonResponse.put("discount", discount);
                    jsonResponse.put("total", newTotal);
                } else {
                    jsonResponse.put("success", false);
                    jsonResponse.put("message", "Voucher has reached its usage limit (0 remaining)");
                    session.removeAttribute("voucherId");
                    System.out.println("Voucher usage limit reached: Usage Limit = " + voucher.getUsageLimit());
                }
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("message", "Voucher has expired");
                session.removeAttribute("voucherId");
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
