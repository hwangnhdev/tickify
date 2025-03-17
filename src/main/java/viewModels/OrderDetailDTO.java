package viewModels;

import java.sql.Timestamp;
import java.util.List;

public class OrderDetailDTO {

    private int orderDetailId;
    private int orderId;
    private Timestamp orderDate;
    private String customerName;
    private String customerEmail;
    private String eventName;
    private String location;
    private double grandTotal;
    private String voucherCode;
    private String voucherPercentageCode;
    private double discountPercentValue;
    private double discountPercentage;
    private String voucherFixedCode;
    private double discountFixed;
    private double totalAfterDiscount;
    private String image_url;
    private String paymentStatus;
    private String seat;
    private String discountType;
    // Thuộc tính mới cho Ticket Type
    private String ticketType;
    // Danh sách order items (vé)
    private List<TicketItemDTO> orderItems;
    // Thêm 2 trường cho lịch trình sự kiện (showtime)
    private Timestamp startDate;
    private Timestamp endDate;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(int orderDetailId, int orderId, Timestamp orderDate, String customerName, String customerEmail,
            String eventName, String location, double grandTotal, String voucherCode,
            String voucherPercentageCode, double discountPercentValue, double discountPercentage,
            String voucherFixedCode, double discountFixed,
            double totalAfterDiscount, String image_url, String paymentStatus, String seat, String discountType,
            String ticketType, List<TicketItemDTO> orderItems, Timestamp startDate, Timestamp endDate) {
        this.orderDetailId = orderDetailId;
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.eventName = eventName;
        this.location = location;
        this.grandTotal = grandTotal;
        this.voucherCode = voucherCode;
        this.voucherPercentageCode = voucherPercentageCode;
        this.discountPercentValue = discountPercentValue;
        this.discountPercentage = discountPercentage;
        this.voucherFixedCode = voucherFixedCode;
        this.discountFixed = discountFixed;
        this.totalAfterDiscount = totalAfterDiscount;
        this.image_url = image_url;
        this.paymentStatus = paymentStatus;
        this.seat = seat;
        this.discountType = discountType;
        this.ticketType = ticketType;
        this.orderItems = orderItems;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    // Getters and Setters
    // ... (các getter/setter cũ)

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

    public List<TicketItemDTO> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<TicketItemDTO> orderItems) {
        this.orderItems = orderItems;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
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

    public double getGrandTotal() {
        return grandTotal;
    }

    public void setGrandTotal(double grandTotal) {
        this.grandTotal = grandTotal;
    }

    public String getVoucherCode() {
        return voucherCode;
    }

    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }

    public String getVoucherPercentageCode() {
        return voucherPercentageCode;
    }

    public void setVoucherPercentageCode(String voucherPercentageCode) {
        this.voucherPercentageCode = voucherPercentageCode;
    }

    public double getDiscountPercentValue() {
        return discountPercentValue;
    }

    public void setDiscountPercentValue(double discountPercentValue) {
        this.discountPercentValue = discountPercentValue;
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

    public double getTotalAfterDiscount() {
        return totalAfterDiscount;
    }

    public void setTotalAfterDiscount(double totalAfterDiscount) {
        this.totalAfterDiscount = totalAfterDiscount;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getSeat() {
        return seat;
    }

    public void setSeat(String seat) {
        this.seat = seat;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }
    
}
