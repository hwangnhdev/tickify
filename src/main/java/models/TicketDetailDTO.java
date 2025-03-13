package models;

import java.util.Date;

/**
 * DTO hiển thị chi tiết vé (View Ticket Detail) cho khách hàng.
 */
public class TicketDetailDTO {

    // Thông tin cơ bản của vé & đơn hàng
    private String orderCode;
    private String ticketStatus;
    private String paymentStatus;

    // Thông tin sự kiện
    private Date startDate;
    private Date endDate;
    private String location;
    private String eventName;
    private double ticketPrice;
    private String eventImage;

    // Thông tin ghế (nếu áp dụng)
    private String seat;

    // Thông tin người mua
    private String buyerName;
    private String buyerEmail;
    private String buyerPhone;
    private String buyerAddress;

    // Thông tin vé & giao dịch
    private String ticketType;
    private int quantity;
    private double amount;
    private double originalTotalAmount;
    private String voucherApplied;     // Yes/No

    // Voucher kiểu phần trăm
    private String voucherPercentageCode;
    private double discountPercentage;

    // Voucher kiểu tiền cố định
    private String voucherFixedCode;
    private double discountFixed;

    private double finalTotalAmount;

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
    public String getVoucherPercentageCode() {
        return voucherPercentageCode;
    }
    public void setVoucherPercentageCode(String voucherPercentageCode) {
        this.voucherPercentageCode = voucherPercentageCode;
    }
    public double getDiscountPercentage() {
        return discountPercentage;
    }
    public void setDiscountPercentage(double discountPercentage) {
        this.discountPercentage = discountPercentage;
    }
    public String getVoucherFixedCode() {
        return voucherFixedCode;
    }
    public void setVoucherFixedCode(String voucherFixedCode) {
        this.voucherFixedCode = voucherFixedCode;
    }
    public double getDiscountFixed() {
        return discountFixed;
    }
    public void setDiscountFixed(double discountFixed) {
        this.discountFixed = discountFixed;
    }
    public double getFinalTotalAmount() {
        return finalTotalAmount;
    }
    public void setFinalTotalAmount(double finalTotalAmount) {
        this.finalTotalAmount = finalTotalAmount;
    }
}
