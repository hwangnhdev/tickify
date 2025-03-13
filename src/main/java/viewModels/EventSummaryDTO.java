package viewModels;

import java.sql.Timestamp;

public class EventSummaryDTO {

    private int eventId;
    private String eventName;
    private String location;
    private Timestamp startDate;
    private Timestamp endDate;
    private String imageUrl;
    private String paymentStatus;  // Thông tin thanh toán nếu cần hiển thị
    private String eventStatus;    // Ví dụ: "Upcoming", "Past", "Ongoing"

    public EventSummaryDTO() {
    }

    public EventSummaryDTO(int eventId, String eventName, String location, Timestamp startDate, Timestamp endDate, String imageUrl, String paymentStatus, String eventStatus) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.imageUrl = imageUrl;
        this.paymentStatus = paymentStatus;
        this.eventStatus = eventStatus;
    }

    // Getters and Setters
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
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public Timestamp getStartDate() {
        return startDate;
    }
    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }
    public Timestamp getEndDate() {
        return endDate;
    }
    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }
    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    public String getPaymentStatus() {
        return paymentStatus;
    }
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
    public String getEventStatus() {
        return eventStatus;
    }
    public void setEventStatus(String eventStatus) {
        this.eventStatus = eventStatus;
    }
}
