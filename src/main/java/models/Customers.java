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
public class Customers {
    private int customerId;
    private String fullName;
    private String email;
    private String phone;
    private String profilePicture;
    private Date createdAt;
    private Date updatedAt;

    public Customers() {
    }

    public Customers(int customerId, String fullName, String email, String phone, String profilePicture, Date createdAt, Date updatedAt) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.profilePicture = profilePicture;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }
    
    
}
