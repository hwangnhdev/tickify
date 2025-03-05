/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class CustomerAuth {

    private int customerAuthId;
    private int customerId;
    private String authProvider;
    private String password;
    private String providerId;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public CustomerAuth() {
    }

    public CustomerAuth(int customerAuthId, int customerId, String authProvider, String password, String providerId) {
        this.customerAuthId = customerAuthId;
        this.customerId = customerId;
        this.authProvider = authProvider;
        this.password = password;
        this.providerId = providerId;
    }

    public CustomerAuth(int customerAuthId, int customerId, String authProvider, String password, String providerId, Timestamp createdAt, Timestamp updatedAt) {
        this.customerAuthId = customerAuthId;
        this.customerId = customerId;
        this.authProvider = authProvider;
        this.password = password;
        this.providerId = providerId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getCustomerAuthId() {
        return customerAuthId;
    }

    public void setCustomerAuthId(int customerAuthId) {
        this.customerAuthId = customerAuthId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getAuthProvider() {
        return authProvider;
    }

    public void setAuthProvider(String authProvider) {
        this.authProvider = authProvider;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getProviderId() {
        return providerId;
    }

    public void setProviderId(String providerId) {
        this.providerId = providerId;
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

    @Override
    public String toString() {
        return "CustomerAuth{" + "customerAuthId=" + customerAuthId + ", customerId=" + customerId + ", authProvider=" + authProvider + ", password=" + password + ", providerId=" + providerId + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + '}';
    }

}
