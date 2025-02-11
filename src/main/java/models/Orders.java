/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class Orders {
    private int orderId;
    private int customerId;
    private int voucherId;
    private double totalPrice;
    private Date orderDate;
    private String paymentStatus;
    private String transactionId;
    private Date createdAt;
    private Date updatedAt;

    public Orders() {
    }

    public Orders(int orderId, int customerId, int voucherId, double totalPrice, Date orderDate, String paymentStatus, String transactionId, Date createdAt, Date updatedAt) {
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
    
    
}
