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
public class Organizer {
    private int organizerId;
    private int customerId;
    private int eventId;
    private String organizationName;
    private Date createdAt;
    private Date updatedAt;

    public Organizer() {
    }

    public Organizer(int organizerId, int customerId, int eventId, String organizationName, Date createdAt, Date updatedAt) {
        this.organizerId = organizerId;
        this.customerId = customerId;
        this.eventId = eventId;
        this.organizationName = organizationName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    
}
