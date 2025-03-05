package models;

import java.math.BigDecimal;
import java.util.Date;

public class Order {
    private int orderId;
    private Date orderDate;
    private BigDecimal totalPrice;
    private String paymentStatus;
    private String customerName;
    private String eventName;
    private String location;
    private String ticketCode;

    public Order() {}

    public Order(int orderId, Date orderDate, BigDecimal totalPrice, String paymentStatus,
                 String customerName, String eventName, String location, String ticketCode) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.paymentStatus = paymentStatus;
        this.customerName = customerName;
        this.eventName = eventName;
        this.location = location;
        this.ticketCode = ticketCode;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public Date getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    public BigDecimal getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
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
    public String getTicketCode() {
        return ticketCode;
    }
    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }
}
