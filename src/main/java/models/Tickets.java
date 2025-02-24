package models;

import java.util.Date;
import java.sql.Time;

/**
 * Lớp model đại diện cho đối tượng Tickets.
 * Bao gồm thông tin từ bảng Tickets và thông tin liên quan từ bảng Orders.
 */
public class Tickets {
    // Thuộc tính của bảng Tickets
    private int ticketId;
    private int orderDetailId;
    private int seatId;
    private String ticketCode;
    private double price;
    private String status; // Trạng thái vé
    private Date checkInDatetime;
    private Date createdAt;
    private Date updatedAt;
    
    // Thuộc tính từ bảng Orders
    private String eventName;
    private String orderCode;
    private Date orderDate;
    private Time startTime;
    private Time endTime;
    private String location;
    private String orderStatus;
    private String ticketType;
    
    // Getters và Setters
    public int getTicketId() {
        return ticketId;
    }
    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }
    public int getOrderDetailId() {
        return orderDetailId;
    }
    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }
    public int getSeatId() {
        return seatId;
    }
    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }
    public String getTicketCode() {
        return ticketCode;
    }
    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public Date getCheckInDatetime() {
        return checkInDatetime;
    }
    public void setCheckInDatetime(Date checkInDatetime) {
        this.checkInDatetime = checkInDatetime;
    }
    public Date getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
    public Date getUpdatedAt() {
        return updatedAt;
    }
    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    public String getEventName() {
        return eventName;
    }
    public void setEventName(String eventName) {
        this.eventName = eventName;
    }
    public String getOrderCode() {
        return orderCode;
    }
    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }
    public Date getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    public Time getStartTime() {
        return startTime;
    }
    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }
    public Time getEndTime() {
        return endTime;
    }
    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }
    public String getLocation() {
        return location;
    }
    public void setLocation(String location) {
        this.location = location;
    }
    public String getOrderStatus() {
        return orderStatus;
    }
    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }
    public String getTicketType() {
        return ticketType;
    }
    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }
}
