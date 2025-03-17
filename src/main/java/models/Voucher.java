/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

/**
 *
 * @author Dinh Minh Tien - CE190701
 */
public class Voucher {

    private int voucherId;
    private int eventId;
    private String code;
    private String description;
    private String discountType;
    private int discountValue;
    private Timestamp startDate;
    private Timestamp endDate;
    private int usageLimit;
    private boolean status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean deleted;

    public Voucher() {
    }

    public Voucher(int voucherId, int eventId, String code, String description, String discountType, int discountValue, Timestamp startDate, Timestamp endDate, int usageLimit, boolean status, Timestamp createdAt, Timestamp updatedAt, boolean deleted) {
        this.voucherId = voucherId;
        this.eventId = eventId;
        this.code = code;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.startDate = startDate;
        this.endDate = endDate;
        this.usageLimit = usageLimit;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.deleted = deleted;
    }

    public int getVoucherId() {
        return voucherId;
    }

    public void setVoucherId(int voucherId) {
        this.voucherId = voucherId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDiscountType() {
        return discountType;
    }

    public void setDiscountType(String discountType) {
        this.discountType = discountType;
    }

    public int getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(int discountValue) {
        this.discountValue = discountValue;
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

    public int getUsageLimit() {
        return usageLimit;
    }

    public void setUsageLimit(int usageLimit) {
        this.usageLimit = usageLimit;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isDeleted() {
        return deleted;
    }

    public void setDeleted(boolean deleted) {
        this.deleted = deleted;
    }

    // Helper method to format expiration time
    public String setFormattedExpirationTime(String string) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        return dateFormat.format(startDate) + " - " + dateFormat.format(endDate);
    }

    // Helper method to determine status label
    public String setStatusLabel(String string) {
        return (endDate.getTime() >= System.currentTimeMillis()) ? "Ongoing" : "Expired";
    }

    // Helper method to format discount
    public String setFormattedDiscount(String string) {
        return discountType.equalsIgnoreCase("percentage")
                ? discountValue + "%" : String.format("%d VND", discountValue);
    }

    public String getFormattedExpirationTime() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm");
        return dateFormat.format(startDate) + " - " + dateFormat.format(endDate);
    }

    /**
     * Determine status label
     *
     * @return
     */
    public String getStatusLabel() {
        return (endDate.getTime() >= System.currentTimeMillis()) ? "Ongoing" : "Expired";
    }

    /**
     * Format discount value
     *
     * @return
     */
    public String getFormattedDiscount() {
        return discountType.equalsIgnoreCase("percentage")
                ? discountValue + "%"
                : String.format("%d VND", discountValue);
    }
}
