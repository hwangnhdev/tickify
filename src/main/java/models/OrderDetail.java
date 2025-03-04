package models;

import java.util.Date;

public class OrderDetail {
    private int orderId;
    private Date orderDate;
    private double totalPrice;
    private String paymentStatus;
    private String transactionId;
    private Date orderCreatedAt;
    private String customerName;
    private String customerEmail;
    private String eventName;
    private String location;
    private String organizationName;
    private String accountHolder;
    private String accountNumber;
    private String bankName;
    private Date organizerCreatedAt;
    private int quantity;
    private int totalQuantity;
    private String voucherCode;
    private String discountType;
    private double discountValue;
    private double totalPriceAfterDiscount;
    private double totalBillForOrganization;
    private String seatList; // Danh sách ghế, ví dụ: "A1, A2, B1"

    // Getters và Setters cho tất cả các thuộc tính
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getPaymentStatus() { return paymentStatus; }
    public void setPaymentStatus(String paymentStatus) { this.paymentStatus = paymentStatus; }

    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public Date getOrderCreatedAt() { return orderCreatedAt; }
    public void setOrderCreatedAt(Date orderCreatedAt) { this.orderCreatedAt = orderCreatedAt; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getEventName() { return eventName; }
    public void setEventName(String eventName) { this.eventName = eventName; }

    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }

    public String getOrganizationName() { return organizationName; }
    public void setOrganizationName(String organizationName) { this.organizationName = organizationName; }

    public String getAccountHolder() { return accountHolder; }
    public void setAccountHolder(String accountHolder) { this.accountHolder = accountHolder; }

    public String getAccountNumber() { return accountNumber; }
    public void setAccountNumber(String accountNumber) { this.accountNumber = accountNumber; }

    public String getBankName() { return bankName; }
    public void setBankName(String bankName) { this.bankName = bankName; }

    public Date getOrganizerCreatedAt() { return organizerCreatedAt; }
    public void setOrganizerCreatedAt(Date organizerCreatedAt) { this.organizerCreatedAt = organizerCreatedAt; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public int getTotalQuantity() { return totalQuantity; }
    public void setTotalQuantity(int totalQuantity) { this.totalQuantity = totalQuantity; }

    public String getVoucherCode() { return voucherCode; }
    public void setVoucherCode(String voucherCode) { this.voucherCode = voucherCode; }

    public String getDiscountType() { return discountType; }
    public void setDiscountType(String discountType) { this.discountType = discountType; }

    public double getDiscountValue() { return discountValue; }
    public void setDiscountValue(double discountValue) { this.discountValue = discountValue; }

    public double getTotalPriceAfterDiscount() { return totalPriceAfterDiscount; }
    public void setTotalPriceAfterDiscount(double totalPriceAfterDiscount) { this.totalPriceAfterDiscount = totalPriceAfterDiscount; }

    public double getTotalBillForOrganization() { return totalBillForOrganization; }
    public void setTotalBillForOrganization(double totalBillForOrganization) { this.totalBillForOrganization = totalBillForOrganization; }

    public String getSeatList() { return seatList; }
    public void setSeatList(String seatList) { this.seatList = seatList; }
}
