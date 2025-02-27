package models;

import java.sql.Date;

/**
 * Model đại diện cho đơn hàng trong hệ thống. Cập nhật bởi: [Tên bạn]
 */
public class Order {

    private int orderId;
    private int customerId;
    private String customerName;  // Mới thêm - Lưu tên khách hàng
    private int voucherId;
    private double totalPrice;
    private Date orderDate;
    private String paymentStatus;
    private String transactionId;
    private Date createdAt;
    private Date updatedAt;
    private int totalTickets;  // Mới thêm - Số lượng vé trong đơn hàng

    /**
     * Constructor mặc định.
     */
    public Order() {
    }

    /**
     * Constructor đầy đủ thông tin.
     */
    public Order(int orderId, int customerId, String customerName, int voucherId, double totalPrice,
            Date orderDate, String paymentStatus, String transactionId, Date createdAt, Date updatedAt, int totalTickets) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.customerName = customerName;
        this.voucherId = voucherId;
        this.totalPrice = totalPrice;
        this.orderDate = orderDate;
        this.paymentStatus = paymentStatus;
        this.transactionId = transactionId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.totalTickets = totalTickets;
    }

    // GETTER & SETTER
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

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

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getTotalTickets() {
        return totalTickets;
    }

    public void setTotalTickets(int totalTickets) {
        this.totalTickets = totalTickets;
    }
}
