package viewModels;

import java.sql.Timestamp;

public class EventSummaryDTO {
    private int eventId;
    private String eventName;
    private String location;
    private Timestamp startDate;
    private Timestamp endDate;
    private String imageUrl;
    private String eventStatus; // ví dụ: "upcoming", "past", v.v.
    
    // Thêm các trường để hiển thị thông tin Ticket Detail (nếu cần)
    private String ticketCode;
    private String ticketInfo;

    public EventSummaryDTO() {}

    public EventSummaryDTO(int eventId, String eventName, String location, Timestamp startDate, Timestamp endDate,
                           String imageUrl, String eventStatus, String ticketCode, String ticketInfo) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.imageUrl = imageUrl;
        this.eventStatus = eventStatus;
        this.ticketCode = ticketCode;
        this.ticketInfo = ticketInfo;
    }

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

    public String getEventStatus() {
        return eventStatus;
    }

    public void setEventStatus(String eventStatus) {
        this.eventStatus = eventStatus;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public String getTicketInfo() {
        return ticketInfo;
    }

    public void setTicketInfo(String ticketInfo) {
        this.ticketInfo = ticketInfo;
    }
}
