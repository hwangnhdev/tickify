package models;

import java.math.BigDecimal;

public class OrganizerOrderDetail {
    private int orderDetailId;
    private int orderId;
    private String ticketType;
    private int quantity;
    private java.math.BigDecimal unitPrice;
    private java.math.BigDecimal detailTotalPrice;

    // Getters & Setters
    public int getOrderDetailId() {
        return orderDetailId;
    }
    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
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
    public java.math.BigDecimal getUnitPrice() {
        return unitPrice;
    }
    public void setUnitPrice(java.math.BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }
    public java.math.BigDecimal getDetailTotalPrice() {
        return detailTotalPrice;
    }
    public void setDetailTotalPrice(java.math.BigDecimal detailTotalPrice) {
        this.detailTotalPrice = detailTotalPrice;
    }
}
