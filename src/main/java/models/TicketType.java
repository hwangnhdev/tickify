
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class TicketType extends Showtime {

    private int ticketTypeId;
    private int showtimeId;
    private String name;
    private String description;
    private double price;
    private String color;
    private int totalQuantity;
    private int soldQuantity;
    private double totalRevenuePerTicketType;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public TicketType() {
    }

    public TicketType(int ticketTypeId, int showtimeId, String name, String description, double price, String color, int totalQuantity, int soldQuantity, Timestamp createdAt, Timestamp updatedAt) {
        this.ticketTypeId = ticketTypeId;
        this.showtimeId = showtimeId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.color = color;
        this.totalQuantity = totalQuantity;
        this.soldQuantity = soldQuantity;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public TicketType(int ticketTypeId, int showtimeId, String name, String description, double price, String color, int totalQuantity, int soldQuantity, Timestamp createdAt, Timestamp updatedAt, int eventId, Timestamp startDate, Timestamp endDate, String status) {
        super(showtimeId, eventId, startDate, endDate, status, createdAt, updatedAt);
        this.ticketTypeId = ticketTypeId;
        this.showtimeId = showtimeId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.color = color;
        this.totalQuantity = totalQuantity;
        this.soldQuantity = soldQuantity;
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public int getSoldQuantity() {
        return soldQuantity;
    }

    public void setSoldQuantity(int soldQuantity) {
        this.soldQuantity = soldQuantity;
    }

    public double getTotalRevenuePerTicketType() {
        return totalRevenuePerTicketType;
    }

    public void setTotalRevenuePerTicketType(double totalRevenuePerTicketType) {
        this.totalRevenuePerTicketType = totalRevenuePerTicketType;
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

}
