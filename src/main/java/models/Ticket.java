/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Duong Minh Kiet - CE180166
 */
public class Ticket {

    private int ticketId;
    private int orderDetailId;
    private int seatId;
    private String ticketCode;
    private double price;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String ticketQRCode;

    public Ticket() {
    }

    public Ticket(int ticketId, int orderDetailId, int seatId, String ticketCode, double price, String status, Timestamp createdAt, Timestamp updatedAt) {
        this.ticketId = ticketId;
        this.orderDetailId = orderDetailId;
        this.seatId = seatId;
        this.ticketCode = ticketCode;
        this.price = price;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    public Ticket(int ticketId, String ticketCode, double price, String status) {
        this.ticketId = ticketId;
        this.ticketCode = ticketCode;
        this.price = price;
        this.status = status;
    }

    public Ticket(int ticketId, int orderDetailId, int seatId, String ticketCode, double price, String status, Timestamp createdAt, Timestamp updatedAt, String ticketQRCode) {
        this.ticketId = ticketId;
        this.orderDetailId = orderDetailId;
        this.seatId = seatId;
        this.ticketCode = ticketCode;
        this.price = price;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.ticketQRCode = ticketQRCode;
    }
    
    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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

    public String getTicketQRCode() {
        return ticketQRCode;
    }

    public void setTicketQRCode(String ticketQRCode) {
        this.ticketQRCode = ticketQRCode;
    }
    
    @Override
    public String toString() {
        return "Ticket{id=" + ticketId + ", code='" + ticketCode + "', price=" + price + ", status='" + status + "'}";
    }

}
