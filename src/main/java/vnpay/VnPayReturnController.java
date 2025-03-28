/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package vnpay;

import com.google.zxing.WriterException;
import configs.CloudinaryConfig;
import dals.OrderDAO;
import dals.OrderDetailDAO;
import dals.SeatDAO;
import dals.TicketDAO;
import dals.TicketTypeDAO;
import dals.VoucherDAO;
import jakarta.mail.MessagingException;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Customer;
import models.Event;
import models.Order;
import models.OrderDetail;
import models.Ticket;
import models.TicketType;
import utils.EmailUtility;
import static utils.QRCodeGenerator.generateQRCodeAsBytes;
import utils.VnPayUtils;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class VnPayReturnController extends HttpServlet {

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
            out.println("<title>Servlet VnPayReturnController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VnPayReturnController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    public boolean updateSeatStatusBatch(String seat, int seatId, String newStatus) {
        SeatDAO seatDao = new SeatDAO();
        boolean allUpdated = true; // Kiểm tra tất cả ghế có cập nhật thành công không

        if (seatId > 0) {
            boolean updated = seatDao.updateSeatStatus(seatId, newStatus);
            if (!updated) {
                allUpdated = false;
                System.out.println("Failed to update seat: " + seat);
            }
        } else {
            allUpdated = false;
            System.out.println("Seat not found: " + seat);
        }
        return allUpdated;
    }

    protected void vnPayReturn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, MessagingException, WriterException {
        SeatDAO seatDao = new SeatDAO();
        TicketTypeDAO ticketTypeDao = new TicketTypeDAO();
        TicketDAO ticketDao = new TicketDAO();
        OrderDAO orderDao = new OrderDAO();
        OrderDetailDAO orderDetailDao = new OrderDetailDAO();
        VoucherDAO voucherDao = new VoucherDAO();

        HttpSession session = request.getSession();
        Customer customer = (Customer) session.getAttribute("customer");
        String selectedSeats = (String) session.getAttribute("selectedSeats");
        String subtotalStr = (String) session.getAttribute("subtotal");
        System.out.println(subtotalStr);
        double subtotal = (subtotalStr != null && !subtotalStr.isEmpty()) ? Double.parseDouble(subtotalStr) : 0.0;
        System.out.println(subtotal);

        Object totalObj = session.getAttribute("total");
        double total = (totalObj != null) ? Double.parseDouble(totalObj.toString()) : subtotal; // Fallback to subtotal if total is not set
        System.out.println("Total from session: " + total);

        // Retrieve voucherId from session
        Object voucherIdObj = session.getAttribute("voucherId");
        Integer voucherId = (voucherIdObj != null) ? Integer.parseInt(voucherIdObj.toString()) : null;
        System.out.println("Voucher ID from session: " + (voucherId != null ? voucherId : "None"));

        List<Map<String, Object>> seatDataList = (List<Map<String, Object>>) session.getAttribute("seatDataList");
        Event event = (Event) session.getAttribute("event");

        String transactionId = request.getParameter("vnp_TransactionNo");
        String transactionStatus = request.getParameter("vnp_TransactionStatus").equals("00") ? "paid" : "unsuccessful";

        // Kiểm tra xem giao dịch đã được xử lý chưa
        Boolean isProcessed = (Boolean) session.getAttribute("paymentProcessed");
        if (Boolean.TRUE.equals(isProcessed)) {
            System.out.println("Payment already processed, skipping duplicate processing.");
            return; // Dừng xử lý nếu đã xử lý trước đó
        }

        //Begin process return from VNPAY
        Map fields = new HashMap();
        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }

        // Kiểm tra tính hợp lệ của chữ ký
        VnPayUtils vnPayUtil = new VnPayUtils();
        String signValue = vnPayUtil.hashAllFields(fields);

        Order existingOrder = orderDao.getOrderByTransactionId(transactionId);
        if (existingOrder != null) {
            System.out.println("Order with transactionId " + transactionId + " already exists. Skipping duplicate processing.");
            request.getRequestDispatcher("pages/vnPay/vnpay_return.jsp").forward(request, response);
        }

        // Xử lý sau khi thanh toán thành công
        if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
            List<String> ticketCodes = new ArrayList<>();

            // Insert order
            Order newOrder = new Order(0, customer.getCustomerId(), voucherId != null ? voucherId : 0, total, null, transactionStatus, transactionId, null, null);
            orderDao.insertOrder(newOrder);

            // Decrement voucher quantity if a voucher was used
            if (voucherId != null) {
                boolean voucherUpdated = voucherDao.decrementVoucherQuantity(voucherId);
                if (voucherUpdated) {
                    System.out.println("Voucher ID " + voucherId + " quantity decremented successfully.");
                } else {
                    System.out.println("Failed to decrement quantity for Voucher ID " + voucherId + " (possibly already at 0).");
                }
            }

            // Insert orderDetail
            for (Map<String, Object> seatData : seatDataList) {
                int ticketTypeId = (int) Double.parseDouble(seatData.get("ticketTypeId").toString());
                String nameTicketType = seatData.get("name").toString();
                double price = Double.parseDouble(seatData.get("price").toString());
                int count = (int) Double.parseDouble(seatData.get("count").toString());

                List<Map<String, String>> seats = (List<Map<String, String>>) seatData.get("seats");

                Order latestOrder = orderDao.getLatestOrder(customer.getCustomerId());

                orderDetailDao.insertOrderDetail(new OrderDetail(0, latestOrder.getOrderId(), ticketTypeId, count, (count * price)));
                // Update seat status
                List<Integer> updatedSeatIds = new ArrayList<>();
                for (Map<String, String> seat : seats) {
                    String newStatus = "unavailable";
                    int seatId = Integer.parseInt(seat.get("id"));

                    boolean result = updateSeatStatusBatch(seat.get("name"), seatId, newStatus);

                    if (result) {
                        updatedSeatIds.add(seatId); // Chỉ thêm vào danh sách nếu cập nhật thành công
                    } else {
                        System.out.println("Failed to update seat: " + seatId);
                    }
                }

                // Nếu có ghế được cập nhật thành công, tiến hành tạo ticket
                if (!updatedSeatIds.isEmpty()) {
                    OrderDetail latestOrderDetail = orderDetailDao.getLatestOrderDetail(latestOrder.getOrderId(), ticketTypeId);

                    for (int seatId : updatedSeatIds) {
                        String ticketCode = customer.getCustomerId() + "-" + latestOrder.getOrderId() + "-" + seatId;

                        String qrData = "ticketCode=" + ticketCode;

                        // Tạo QR code dưới dạng byte[]
                        byte[] qrCodeBytes = generateQRCodeAsBytes(qrData);

                        // Upload lên Cloudinary và lấy URL
                        String cloudinaryUrl = CloudinaryConfig.uploadQRCode(qrCodeBytes, ticketCode);

                        boolean ticketInserted = ticketDao.insertTicket(new Ticket(
                                0,
                                latestOrderDetail.getOrderDetailId(),
                                seatId,
                                ticketCode,
                                price, // Giá vé
                                "active", // Trạng thái ban đầu
                                null,
                                null,
                                cloudinaryUrl
                        ));

                        if (!ticketInserted) {
                            System.out.println("Failed to create ticket for seat: " + seatId);
                            continue;
                            // Có thể rollback hoặc log để xử lý sau
                        }

                        // Send QR to Email 
                        String recipient = customer.getEmail();
                        String subject = "Tickify - Your Ticket Confirmation";
                        String content = "Dear " + customer.getFullName() + ",\n\n"
                                + "Thank you for your purchase! Your ticket details are as follows:\n\n"
                                + "🎟 Ticket Code: " + ticketCode + "\n"
                                + "📍 Event: " + event.getEventName() + "\n"
                                //                                + "📅 Date & Time: " + eventDateTime + "\n"
                                //                                + "💺 Seat: " + seatName + "\n"
                                + "💰 Price: $" + price + "\n\n"
                                + "Please present the attached QR code at the venue for entry.\n"
                                + "If you have any questions, feel free to contact our support team.\n\n"
                                + "Best regards,\n"
                                + "🎫 Tickify Team";

                        EmailUtility.sendEmailWithQRCode(recipient, subject, content, cloudinaryUrl);
                    }
                }
            }
            session.setAttribute("paymentProcessed", true);
        }

        // Chuyển các giá trị sang request để dùng trong JSP
        request.setAttribute("signValue", signValue);
        request.setAttribute("vnp_SecureHash", vnp_SecureHash);
        request.setAttribute("vnp_TxnRef", request.getParameter("vnp_TxnRef"));
        request.setAttribute("vnp_Amount", request.getParameter("vnp_Amount"));
        request.setAttribute("vnp_OrderInfo", request.getParameter("vnp_OrderInfo"));
        request.setAttribute("vnp_ResponseCode", request.getParameter("vnp_ResponseCode"));
        request.setAttribute("vnp_TransactionNo", request.getParameter("vnp_TransactionNo"));
        request.setAttribute("vnp_BankCode", request.getParameter("vnp_BankCode"));
        request.setAttribute("vnp_TransactionStatus", request.getParameter("vnp_TransactionStatus"));
        request.setAttribute("vnp_PayDate", request.getParameter("vnp_PayDate"));

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("pages/vnPay/vnpay_return.jsp").forward(request, response);
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
        try {
            //        processRequest(request, response);
            vnPayReturn(request, response);
        } catch (MessagingException ex) {
            Logger.getLogger(VnPayReturnController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (WriterException ex) {
            Logger.getLogger(VnPayReturnController.class.getName()).log(Level.SEVERE, null, ex);
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
//        processRequest(request, response);

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
