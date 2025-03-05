package models;

import com.google.gson.annotations.Expose;
import java.sql.Timestamp;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class EventImage extends Event {

    @Expose
    private int imageId;
    private int eventId;
    @Expose
    private String imageUrl;
    @Expose
    private String imageTitle;

    public EventImage() {
    }

    public EventImage(int imageId, int eventId, String imageUrl, String image_title) {
        this.imageId = imageId;
        this.eventId = eventId;
        this.imageUrl = imageUrl;
        this.imageTitle = image_title;
    }

    public EventImage(int imageId, String imageUrl, String imageTitle, int eventId, int categoryId, int organizerId, String eventName, String location, String eventType, String status, String description, Timestamp createdAt, Timestamp updatedAt) {
        super(eventId, categoryId, organizerId, eventName, location, eventType, status, description, createdAt, updatedAt);
        this.imageId = imageId;
        this.imageUrl = imageUrl;
        this.imageTitle = imageTitle;
    }

    public EventImage(String imageUrl, String imageTitle, int eventId, int categoryId, int organizerId, String eventName, String location, String eventType, String status, String description, Timestamp createdAt, Timestamp updatedAt) {
        super(eventId, categoryId, organizerId, eventName, location, eventType, status, description, createdAt, updatedAt);
        this.eventId = eventId;
        this.imageUrl = imageUrl;
        this.imageTitle = imageTitle;
    }

    public int getImageId() {
        return imageId;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    @Override
    public int getEventId() {
        return eventId;
    }

    @Override
    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getImageTitle() {
        return imageTitle;
    }

    public void setImageTitle(String imageTitle) {
        this.imageTitle = imageTitle;
    }
}
