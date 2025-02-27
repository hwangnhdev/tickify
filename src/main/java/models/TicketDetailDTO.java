package models;

import java.util.Date;

public class TicketDetailDTO {
    private Date orderDate;
    private String paymentStatus;
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String customerAddress;
    private String eventName;
    private String ticketType;
    private double ticketPrice;
    private int ticketQuantity;
    private double orderTotalPrice;
    
    // Các trường voucher
    private String voucherCode;
    private String voucherDiscountType;
    private double voucherDiscountValue;

    // Trường lưu URL ảnh (lấy từ EventImages.image_url)
    private String ticketImage;

    // Getters and Setters
    public Date getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    public String getPaymentStatus() {
        return paymentStatus;
    }
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    public String getCustomerName() {
        return customerName;
    }
    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }
    public String getCustomerEmail() {
        return customerEmail;
    }
    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
    public String getCustomerPhone() {
        return customerPhone;
    }
    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }
    public String getCustomerAddress() {
        return customerAddress;
    }
    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }
    public String getEventName() {
        return eventName;
    }
    public void setEventName(String eventName) {
        this.eventName = eventName;
    }
    public String getTicketType() {
        return ticketType;
    }
    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }
    public double getTicketPrice() {
        return ticketPrice;
    }
    public void setTicketPrice(double ticketPrice) {
        this.ticketPrice = ticketPrice;
    }
    public int getTicketQuantity() {
        return ticketQuantity;
    }
    public void setTicketQuantity(int ticketQuantity) {
        this.ticketQuantity = ticketQuantity;
    }
    public double getOrderTotalPrice() {
        return orderTotalPrice;
    }
    public void setOrderTotalPrice(double orderTotalPrice) {
        this.orderTotalPrice = orderTotalPrice;
    }
    public String getVoucherCode() {
        return voucherCode;
    }
    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }
    public String getVoucherDiscountType() {
        return voucherDiscountType;
    }
    public void setVoucherDiscountType(String voucherDiscountType) {
        this.voucherDiscountType = voucherDiscountType;
    }
    public double getVoucherDiscountValue() {
        return voucherDiscountValue;
    }
    public void setVoucherDiscountValue(double voucherDiscountValue) {
        this.voucherDiscountValue = voucherDiscountValue;
    }
    public String getTicketImage() {
        return ticketImage;
    }
    public void setTicketImage(String ticketImage) {
        this.ticketImage = ticketImage;
    }
}
