package models;

import java.sql.Date;
import java.sql.Timestamp;

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

    public Customer() {
    }

    public Customer(int customerId, String fullName, String email, String address, String phone,
            String profilePicture, Boolean status, Date dob, String gender) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.email = email;
        this.address = address;
        this.phone = phone;
        this.profilePicture = profilePicture;
        this.status = status;
        this.dob = dob;
        this.gender = gender;
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

    // Getters & Setters cũ...
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

    // Các getter và setter mới cho dob và gender:
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

    // Phương thức hiển thị trạng thái (có thể giữ nguyên)
    public String getStatusText() {
        return (status != null && status) ? "Active" : "Inactive";
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
                + ", dob=" + dob
                + ", gender=" + gender
                + '}';
    }
}
