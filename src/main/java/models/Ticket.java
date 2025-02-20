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
public class Ticket {
    private int ticketId;
    private int orderDetailId;
    private int seatId;
    private String ticketCode;
    private double price;
    private String status;
    private Date checkInDatetime;
    private Date createdAt;
    private Date updatedAt;

    public Ticket() {
    }

    public Ticket(int ticketId, int orderDetailId, int seatId, String ticketCode, double price, String status, Date checkInDatetime, Date createdAt, Date updatedAt) {
        this.ticketId = ticketId;
        this.orderDetailId = orderDetailId;
        this.seatId = seatId;
        this.ticketCode = ticketCode;
        this.price = price;
        this.status = status;
        this.checkInDatetime = checkInDatetime;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    
}
