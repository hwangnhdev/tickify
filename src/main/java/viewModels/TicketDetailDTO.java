package viewModels;

import java.util.Date;
import java.util.List;

/**
 * DTO hiển thị chi tiết vé (View Ticket Detail) cho khách hàng.
 */
public class TicketDetailDTO {
    // Thông tin chung của đơn hàng
    private String orderCode;
    private String ticketStatus;
    private String paymentStatus;
    
    // Thông tin sự kiện
    private Date startDate;
    private Date endDate;
    private String location;
    private String eventName;
    private double ticketPrice;
    private String eventImage;
    
    // Thông tin ghế (nếu áp dụng)
    private String seat;  // Đây là thông tin ghế tổng hợp (nếu cần)
    
    // Thông tin người mua
    private String buyerName;
    private String buyerEmail;
    private String buyerPhone;
    private String buyerAddress;
    
    // Thông tin vé & giao dịch
    private double originalTotalAmount;
    private String voucherApplied;     // Yes/No
    private String voucherPercentageCode;
    private double discountPercentage;
    private String voucherFixedCode;
    private double discountFixed;
    private double finalTotalAmount;
    
    // Danh sách chi tiết các loại vé trong đơn hàng (sẽ lấy thông tin chi tiết từng dòng vé)
    private List<TicketItemDTO> ticketItems;
    
    // Danh sách ghế được gom theo loại vé (VIP, Regular, ...)
    private List<TicketSeatDTO> ticketSeats;

    // Getters and Setters

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
    public double getTicketPrice() {
        return ticketPrice;
    }
    public void setTicketPrice(double ticketPrice) {
        this.ticketPrice = ticketPrice;
    }
    public String getEventImage() {
        return eventImage;
    }
    public void setEventImage(String eventImage) {
        this.eventImage = eventImage;
    }
    public String getSeat() {
        return seat;
    }
    public void setSeat(String seat) {
        this.seat = seat;
    }
    public String getBuyerName() {
        return buyerName;
    }
    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }
    public String getBuyerEmail() {
        return buyerEmail;
    }
    public void setBuyerEmail(String buyerEmail) {
        this.buyerEmail = buyerEmail;
    }
    public String getBuyerPhone() {
        return buyerPhone;
    }
    public void setBuyerPhone(String buyerPhone) {
        this.buyerPhone = buyerPhone;
    }
    public String getBuyerAddress() {
        return buyerAddress;
    }
    public void setBuyerAddress(String buyerAddress) {
        this.buyerAddress = buyerAddress;
    }
    public double getOriginalTotalAmount() {
        return originalTotalAmount;
    }
    public void setOriginalTotalAmount(double originalTotalAmount) {
        this.originalTotalAmount = originalTotalAmount;
    }
    public String getVoucherApplied() {
        return voucherApplied;
    }
    public void setVoucherApplied(String voucherApplied) {
        this.voucherApplied = voucherApplied;
    }
    public String getVoucherPercentageCode() {
        return voucherPercentageCode;
    }
    public void setVoucherPercentageCode(String voucherPercentageCode) {
        this.voucherPercentageCode = voucherPercentageCode;
    }
    public double getDiscountPercentage() {
        return discountPercentage;
    }
    public void setDiscountPercentage(double discountPercentage) {
        this.discountPercentage = discountPercentage;
    }
    public String getVoucherFixedCode() {
        return voucherFixedCode;
    }
    public void setVoucherFixedCode(String voucherFixedCode) {
        this.voucherFixedCode = voucherFixedCode;
    }
    public double getDiscountFixed() {
        return discountFixed;
    }
    public void setDiscountFixed(double discountFixed) {
        this.discountFixed = discountFixed;
    }
    public double getFinalTotalAmount() {
        return finalTotalAmount;
    }
    public void setFinalTotalAmount(double finalTotalAmount) {
        this.finalTotalAmount = finalTotalAmount;
    }
    public List<TicketItemDTO> getTicketItems() {
        return ticketItems;
    }
    public void setTicketItems(List<TicketItemDTO> ticketItems) {
        this.ticketItems = ticketItems;
    }
    public List<TicketSeatDTO> getTicketSeats() {
        return ticketSeats;
    }
    public void setTicketSeats(List<TicketSeatDTO> ticketSeats) {
        this.ticketSeats = ticketSeats;
    }
}
