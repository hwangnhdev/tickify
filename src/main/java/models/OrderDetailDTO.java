package models;

import java.sql.Timestamp;

public class OrderDetailDTO {

    private int orderId;
    private Timestamp orderDate;
    private String customerName;
    private String customerEmail;
    private String eventName;
    private String location;
    private double grandTotal;
    private String voucherCode;
    private String discount_type;
    private double discount_value;
    private double discountAmount;
    private double totalAfterDiscount;
    private String image_url;
    private String paymentStatus;
    // Trường mới cho thông tin Seat
    private String seat;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(int orderId, Timestamp orderDate, String customerName, String customerEmail,
            String eventName, String location, double grandTotal, String voucherCode,
            String discount_type, double discount_value, double discountAmount,
            double totalAfterDiscount, String image_url, String paymentStatus, String seat) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.eventName = eventName;
        this.location = location;
        this.grandTotal = grandTotal;
        this.voucherCode = voucherCode;
        this.discount_type = discount_type;
        this.discount_value = discount_value;
        this.discountAmount = discountAmount;
        this.totalAfterDiscount = totalAfterDiscount;
        this.image_url = image_url;
        this.paymentStatus = paymentStatus;
        this.seat = seat;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
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

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getGrandTotal() {
        return grandTotal;
    }

    public void setGrandTotal(double grandTotal) {
        this.grandTotal = grandTotal;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getDiscount_type() {
        return discount_type;
    }

    public void setDiscount_type(String discount_type) {
        this.discount_type = discount_type;
    }

    public double getDiscount_value() {
        return discount_value;
    }

    public void setDiscount_value(double discount_value) {
        this.discount_value = discount_value;
    }

    public double getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(double discountAmount) {
        this.discountAmount = discountAmount;
    }

    public double getTotalAfterDiscount() {
        return totalAfterDiscount;
    }

    public void setTotalAfterDiscount(double totalAfterDiscount) {
        this.totalAfterDiscount = totalAfterDiscount;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }
}
