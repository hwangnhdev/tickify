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
    private Date dob;
    private String gender;
    private String password;

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

    /*Create for change password and change profile*/
    public Customer(int customerId, String fullName, String email, String address, String phone, String profilePicture, Boolean status, Date dob, String gender, String password) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.profilePicture = profilePicture;
        this.status = status;
        this.dob = dob;
        this.gender = gender;
        this.password = password;
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

    public Date getDob() {
        return dob;
    }

    public void setDob(Date dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

}
