package models;

import java.sql.Timestamp;
import java.util.List;

public class EventDetailDTO extends Event {

    // Các thông tin chi tiết bổ sung cho view chi tiết sự kiện
    private String categoryName;
    private String organizationName;
    private Timestamp startDate; // Lấy từ Showtimes
    private Timestamp endDate;   // Lấy từ Showtimes
    private List<String> imageUrls; // Danh sách các URL hình ảnh của sự kiện

    // Các trường bổ sung cần thiết cho trang chi tiết
    private String imageUrl;      // Hình ảnh đại diện
    private String paymentStatus; // Trạng thái thanh toán
    private String status;        // Trạng thái của sự kiện (ví dụ: Upcoming, Past, ...)
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

    public String getPaymentStatus() {
        return paymentStatus;
    }

    // Sửa lại setPaymentStatus để gán giá trị thay vì ném ra ngoại lệ
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
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

}
