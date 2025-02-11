/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class Vouchers {
    private int voucherId;
    private String code;
    private String description;
    private String discountType;
    private double discountValue;
    private Date expirationDate;
    private int usageLimit;
    private int status;
    private Date createdAt;
    private Date updatedAt;

    public Vouchers() {
    }

    public Vouchers(int voucherId, String code, String description, String discountType, double discountValue, Date expirationDate, int usageLimit, int status, Date createdAt, Date updatedAt) {
        this.voucherId = voucherId;
        this.code = code;
        this.description = description;
        this.discountType = discountType;
        this.discountValue = discountValue;
        this.expirationDate = expirationDate;
        this.usageLimit = usageLimit;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    
}
