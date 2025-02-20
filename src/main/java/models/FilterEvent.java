/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;
import java.util.List;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class FilterEvent {

    private List<Integer> categoryID;
    private String location;
    private Date startDate;
    private Date endDate;
    private String price;
    private boolean vouchers;
    private String searchQuery;

    public FilterEvent() {
    }

    public FilterEvent(List<Integer> categoryID, String location, Date startDate, Date endDate, String price, boolean vouchers, String searchQuery) {
        this.categoryID = categoryID;
        this.location = location;
        this.startDate = startDate;
        this.endDate = endDate;
        this.price = price;
        this.vouchers = vouchers;
        this.searchQuery = searchQuery;
    }

    public List<Integer> getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(List<Integer> categoryID) {
        this.categoryID = categoryID;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public boolean isVouchers() {
        return vouchers;
    }

    public void setVouchers(boolean vouchers) {
        this.vouchers = vouchers;
    }

    public String getSearchQuery() {
        return searchQuery;
    }

    public void setSearchQuery(String searchQuery) {
        this.searchQuery = searchQuery;
    }

}
