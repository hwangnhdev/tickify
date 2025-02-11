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
public class TicketTypes {
    private int ticketTypeId;
    private int eventId;
    private String name;
    private String description;
    private double price;
    private int totalQuantity;
    private int soldQuantity;
    private Date createdAt;
    private Date updatedAt;

    public TicketTypes() {
    }

    public TicketTypes(int ticketTypeId, int eventId, String name, String description, double price, int totalQuantity, int soldQuantity, Date createdAt, Date updatedAt) {
        this.ticketTypeId = ticketTypeId;
        this.eventId = eventId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.totalQuantity = totalQuantity;
        this.soldQuantity = soldQuantity;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    
}
