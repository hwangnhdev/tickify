package models;

import java.util.Date;

public class EventAdmin {
    private int eventId;
    private String eventName;
    private String categoryName;
    private String organizationName;
    private String location;
    private String eventType;
    private String status;
    private String description;
    private Date startDate;
    private Date endDate;
    private Date createdAt;
    private Date updatedAt;
    private String imageIds;
    private String imageUrls;
    private String imageTitles;
    
    // Getters & Setters
    public int getEventId() {
        return eventId;
    }
    public void setEventId(int eventId) {
        this.eventId = eventId;
    }
    public String getEventName() {
        return eventName;
    }
    public void setEventName(String eventName) {
        this.eventName = eventName;
    }
    public String getCategoryName() {
        return categoryName;
    }
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    public String getOrganizationName() {
        return organizationName;
    }
    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public String getEventType() {
        return eventType;
    }
    public void setEventType(String eventType) {
        this.eventType = eventType;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public Date getStartDate() {
        return startDate;
    }
    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }
    public Date getEndDate() {
        return endDate;
    }
    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    public Date getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    public String getImageIds() {
        return imageIds;
    }
    public void setImageIds(String imageIds) {
        this.imageIds = imageIds;
    }
    public String getImageUrls() {
        return imageUrls;
    }
    public void setImageUrls(String imageUrls) {
        this.imageUrls = imageUrls;
    }
    public String getImageTitles() {
        return imageTitles;
    }
    public void setImageTitles(String imageTitles) {
        this.imageTitles = imageTitles;
    }
}
