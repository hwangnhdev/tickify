package viewModels;

import java.sql.Timestamp;
import java.util.List;
import models.Event;

public class EventDetailDTO extends Event {

    // Các thông tin chi tiết bổ sung cho view chi tiết sự kiện
    private String categoryName;
    private String organizationName;
    private String accountHolder;
    private String accountNumber;
    private String bankName;
    private Timestamp startDate; // Lấy từ Showtimes
    private Timestamp endDate;   // Lấy từ Showtimes
    private List<String> imageUrls; // Danh sách các URL hình ảnh của sự kiện

    // Các trường bổ sung cần thiết cho trang chi tiết
    private String imageUrl;      // Hình ảnh đại diện
    private String eventStatus;   // Trạng thái của sự kiện (Processing, Approved, Rejected, ...)
    private String description;   // Mô tả sự kiện

    // Getters và Setters cho các trường bổ sung
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
    public String getAccountHolder() {
        return accountHolder;
    }
    public void setAccountHolder(String accountHolder) {
        this.accountHolder = accountHolder;
    }
    public String getAccountNumber() {
        return accountNumber;
    }
    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }
    public String getBankName() {
        return bankName;
    }
    public void setBankName(String bankName) {
        this.bankName = bankName;
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
    public List<String> getImageUrls() {
        return imageUrls;
    }
    public void setImageUrls(List<String> imageUrls) {
        this.imageUrls = imageUrls;
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
    @Override
    public String getDescription() {
        return description;
    }
    @Override
    public void setDescription(String description) {
        this.description = description;
    }
}
