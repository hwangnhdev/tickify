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

    public String getImageTitle() { // Sửa từ getImage_title() thành getImageTitle()
        return imageTitle;
    }

    public void setImageTitle(String imageTitle) { // Sửa từ setImage_title() thành setImageTitle()
        this.imageTitle = imageTitle;
    }
}