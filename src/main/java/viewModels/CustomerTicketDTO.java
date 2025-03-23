package viewModels;

import java.util.Date;

/**
 * @author Duong Minh Kiet - CE180166
 *
 * DTO hiển thị chi tiết vé (View Ticket Detail) cho khách hàng.
 */
public class CustomerTicketDTO {

    private String orderCode;       // Mã đơn hàng 
    private String ticketStatus;    // Trạng thái vé (status từ bảng Tickets)
    private String paymentStatus;   // Trạng thái thanh toán (payment_status từ bảng Orders)
    private Date startDate;         // Ngày bắt đầu (start_date từ bảng Showtimes)
    private Date endDate;           // Ngày kết thúc (end_date từ bảng Showtimes)
    private String location;        // Địa điểm (location từ bảng Events)
    private String eventName;       // Tên sự kiện (event_name từ bảng Events)
    private double unitPrice;       // Giá vé đơn vị (price từ bảng Tickets)

    // Getters và Setters
    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(String ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
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

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }
}
