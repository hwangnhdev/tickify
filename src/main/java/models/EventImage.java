/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class EventImage {
    private int imageId;
    private int eventId;
    private String imageUrl;

    public EventImage() {
    }

    public EventImage(int imageId, int eventId, String imageUrl) {
        this.imageId = imageId;
        this.eventId = eventId;
        this.imageUrl = imageUrl;
    }
    
    
}
