package models;

import java.util.Date;

/**
 * DTO hiển thị chi tiết vé (View Ticket Detail) cho khách hàng. Lớp này được
 * xây dựng từ các entity Ticket, Event, OrderDetail, User,... Chỉ chứa những
 * thông tin cần thiết cho hiển thị.
 */
public class TicketDetailDTO {

    // Thông tin cơ bản của vé & đơn hàng
    private String orderCode;          // Mã đơn hàng (có thể trùng hoặc khác với ticketCode tùy nghiệp vụ)
    private String ticketStatus;       // Trạng thái của vé (lấy từ Ticket.status)
    private String paymentStatus;      // Trạng thái thanh toán (lấy từ hệ thống thanh toán)

    // Thông tin sự kiện
    private Date startDate;            // Ngày bắt đầu sự kiện
    private Date endDate;              // Ngày kết thúc sự kiện
    private String location;           // Địa điểm sự kiện
    private String eventName;          // Tên sự kiện
    private double ticketPrice;        // Giá vé (tương ứng với Ticket.price)
    private String eventImage;         // URL hình ảnh của sự kiện

    // Thông tin ghế (nếu áp dụng)
    private String seat;               // Ghế (kết hợp của seat_row và seat_col)

    // Thông tin người mua (nếu cần hiển thị)
    private String buyerName;          // Tên người mua
    private String buyerEmail;         // Email người mua
    private String buyerPhone;         // Số điện thoại người mua
    private String buyerAddress;       // Địa chỉ người mua

    // Thông tin giao dịch / voucher (nếu cần)
    private String ticketType;         // Loại vé (ví dụ: Regular, VIP,...)
    private int quantity;              // Số lượng vé
    private double amount;             // Tổng tiền của chi tiết vé (có thể bằng ticketPrice * quantity)
    private double originalTotalAmount;// Tổng tiền ban đầu của đơn hàng (trước giảm giá)
    private String voucherApplied;     // Có áp dụng voucher hay không (Yes/No)
    private String voucherCode;        // Mã voucher (nếu có)
    private double discount;           // Số tiền giảm giá
    private double finalTotalAmount;   // Tổng tiền sau giảm giá

    // Getters and Setters
    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(String ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public double getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(double ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    public String getEventImage() {
        return eventImage;
    }

    public void setEventImage(String eventImage) {
        this.eventImage = eventImage;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getBuyerEmail() {
        return buyerEmail;
    }

    public void setBuyerEmail(String buyerEmail) {
        this.buyerEmail = buyerEmail;
    }

    public String getBuyerPhone() {
        return buyerPhone;
    }

    public void setBuyerPhone(String buyerPhone) {
        this.buyerPhone = buyerPhone;
    }

    public String getBuyerAddress() {
        return buyerAddress;
    }

    public void setBuyerAddress(String buyerAddress) {
        this.buyerAddress = buyerAddress;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public double getOriginalTotalAmount() {
        return originalTotalAmount;
    }

    public void setOriginalTotalAmount(double originalTotalAmount) {
        this.originalTotalAmount = originalTotalAmount;
    }

    public String getVoucherApplied() {
        return voucherApplied;
    }

    public void setVoucherApplied(String voucherApplied) {
        this.voucherApplied = voucherApplied;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }

    public double getFinalTotalAmount() {
        return finalTotalAmount;
    }

    public void setFinalTotalAmount(double finalTotalAmount) {
        this.finalTotalAmount = finalTotalAmount;
    }
}
