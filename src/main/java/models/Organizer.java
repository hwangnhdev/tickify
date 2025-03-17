/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class Organizer {

    private int organizerId;
    private int customerId;
    private String organizationName;
    private String accountHolder;
    private String accountNumber;
    private String bankName;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public Organizer() {
    }

    public Organizer(int organizerId, int customerId, String organizationName, String accountHolder, String accountNumber, String bankName, Timestamp createdAt, Timestamp updatedAt) {
        this.organizerId = organizerId;
        this.customerId = customerId;
        this.organizationName = organizationName;
        this.accountHolder = accountHolder;
        this.accountNumber = accountNumber;
        this.bankName = bankName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getOrganizerId() {
        return organizerId;
    }

    public void setOrganizerId(int organizerId) {
        this.organizerId = organizerId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getOrganizationName() {
        return organizationName;
    }

    public void setOrganizationName(String organizationName) {
        this.organizationName = organizationName;
    }

    public String getAccountHolder() {
        return accountHolder;
    }

    public void setAccountHolder(String accountHolder) {
        this.accountHolder = accountHolder;
    }

    public String getAccountNumber() {
        return accountNumber;
    }

    public void setAccountNumber(String accountNumber) {
        this.accountNumber = accountNumber;
    }

    public String getBankName() {
        return bankName;
    }

    public void setBankName(String bankName) {
        this.bankName = bankName;
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

}
