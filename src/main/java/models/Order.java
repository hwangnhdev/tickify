package models;

import java.sql.Timestamp;

public class Order {

    private int orderId;
    private Timestamp orderDate;
    private double totalPrice;
    private Timestamp orderDate;
    private String paymentStatus;
    private String transactionId;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Order() {
    }

    public Order(int orderId, int customerId, int voucherId, double totalPrice, Timestamp orderDate, String paymentStatus, String transactionId, Timestamp createdAt, Timestamp updatedAt) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.voucherId = voucherId;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.paymentStatus = paymentStatus;
        this.transactionId = transactionId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Kiet add attributes
    public Order(int orderId, Timestamp orderDate, double totalPrice, String paymentStatus,
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

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    @Override
    public String toString() {
        return "Order{"
                + "orderId=" + orderId
                + ", customerId=" + customerId
                + ", voucherId=" + voucherId
                + ", totalPrice=" + totalPrice
                + ", orderDate=" + orderDate
                + ", paymentStatus='" + paymentStatus + '\''
                + ", transactionId='" + transactionId + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
