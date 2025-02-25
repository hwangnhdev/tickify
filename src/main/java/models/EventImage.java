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
    private String imageTitle;

    public EventImage() {
    }

    public EventImage(int imageId, int eventId, String imageUrl, String imageTitle) {
        this.imageId = imageId;
        this.eventId = eventId;
        this.imageUrl = imageUrl;
        this.imageTitle = imageTitle;
    }

    public EventImage(String imageUrl, String imageTitle) {
        this.imageUrl = imageUrl;
        this.imageTitle = imageTitle;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getImage_title() {
        return imageTitle;
    }

    public void setImage_title(String image_title) {
        this.imageTitle = image_title;
    }

}
