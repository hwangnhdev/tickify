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
public class Customer {

    private int customerId;
    private String fullName;
    private String email;
    private String address;
    private String phone;
    private String profilePicture;
    private Boolean status;

    public Customer() {
    }

    public Customer(int customerId, String fullName, String email, String address, String phone, String profilePicture, Boolean status) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.profilePicture = profilePicture;
        this.status = status;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getProfilePicture() {
        return profilePicture;
    }

    public void setProfilePicture(String profilePicture) {
        this.profilePicture = profilePicture;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "Customer{"
                + "customerId=" + customerId
                + ", fullName='" + fullName + '\''
                + ", email='" + email + '\''
                + ", address='" + address + '\''
                + ", phone='" + phone + '\''
                + ", profilePicture='" + profilePicture + '\''
                + ", status=" + status
                + '}';
    }
}
