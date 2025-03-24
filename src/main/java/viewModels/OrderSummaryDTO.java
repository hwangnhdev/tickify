package viewModels;

import java.util.Date;
import java.math.BigDecimal;

public class OrderSummaryDTO {
    private int orderId;
    private Date orderDate;
    private String paymentStatus;
    private String customerName;
    private String customerEmail;
    private String voucherCode;
    private String discountType;
    private BigDecimal discountValue;
    
    // Các trường bổ sung để hiển thị thông tin đơn hàng đầy đủ
    private BigDecimal grandTotal;
    private String eventName;
    private String location;

    public OrderSummaryDTO() {}

    public OrderSummaryDTO(int orderId, Date orderDate, String paymentStatus, String customerName, String customerEmail,
                            String voucherCode, String discountType, BigDecimal discountValue,
                            BigDecimal grandTotal, String eventName, String location) {
        this.orderId = orderId;
        this.orderDate = orderDate;
        this.paymentStatus = paymentStatus;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.voucherCode = voucherCode;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.grandTotal = grandTotal;
        this.eventName = eventName;
        this.location = location;
    }

    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public Date getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    public String getPaymentStatus() {
        return paymentStatus;
    }
    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
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
    public String getVoucherCode() {
        return voucherCode;
    }
    public void setVoucherCode(String voucherCode) {
        this.voucherCode = voucherCode;
    }
    public String getDiscountType() {
        return discountType;
    }
    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }
    public BigDecimal getDiscountValue() {
        return discountValue;
    }
    public void setDiscountValue(BigDecimal discountValue) {
        this.discountValue = discountValue;
    }
    public BigDecimal getGrandTotal() {
        return grandTotal;
    }
    public void setGrandTotal(BigDecimal grandTotal) {
        this.grandTotal = grandTotal;
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
}
