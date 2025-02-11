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
public class Events {
    private int eventId;
    private int categoryId;
    private String eventName;
    private String location;
    private String eventType;
    private String status;
    private String description;
    private Date startDate;
    private Date endDate;
    private Date createdAt;
    private Date updatedAt;

    public Events() {
    }

    public Events(int eventId, int categoryId, String eventName, String location, String eventType, String status, String description, Date startDate, Date endDate, Date createdAt, Date updatedAt) {
        this.eventId = eventId;
        this.categoryId = categoryId;
        this.eventName = eventName;
        this.location = location;
        this.eventType = eventType;
        this.status = status;
        this.description = description;
        this.startDate = startDate;
        this.endDate = endDate;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    
}
