/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class OrderDetail {
    private int orderDetailId;
    private int orderId;
    private int ticketTypeId;
    private int quantity;
    private double price;

    public OrderDetail() {
    }

    public OrderDetail(int orderDetailId, int orderId, int ticketTypeId, int quantity, double price) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.ticketTypeId = ticketTypeId;
        this.quantity = quantity;
        this.price = price;
    }
    
}
