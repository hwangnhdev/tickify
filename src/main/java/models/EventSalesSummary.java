/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventSalesSummary {

    private int eventId;
    private String eventName;
    private int totalTicketsSold;
    private double grossSales;
    private double revenue;
    private Timestamp period;
    private Date periodDate;
    private String date; // Add this field for chart labels

    public EventSalesSummary() {
    }

    public EventSalesSummary(int eventId, String eventName, int totalTicketsSold, double grossSales) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.totalTicketsSold = totalTicketsSold;
        this.grossSales = grossSales;
    }

    public EventSalesSummary(int eventId, String eventName, double revenue, int totalTicketsSold, Timestamp period) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.revenue = revenue;
        this.totalTicketsSold = totalTicketsSold;
        this.period = period;
    }

    public EventSalesSummary(int eventId, String eventName, double revenue, int totalTicketsSold, Date periodDate) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.revenue = revenue;
        this.totalTicketsSold = totalTicketsSold;
        this.periodDate = periodDate;
    }

    // Constructor for chart data
    public EventSalesSummary(String date, double revenue, int totalTicketsSold) {
        this.date = date;
        this.revenue = revenue;
        this.totalTicketsSold = totalTicketsSold;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getEventName() {
        return eventName;
    }

    public void setEventName(String eventName) {
        this.eventName = eventName;
    }

    public int getTotalTicketsSold() {
        return totalTicketsSold;
    }

    public void setTotalTicketsSold(int totalTicketsSold) {
        this.totalTicketsSold = totalTicketsSold;
    }

    public double getGrossSales() {
        return grossSales;
    }

    public void setGrossSales(double grossSales) {
        this.grossSales = grossSales;
    }

    public double getRevenue() {
        return revenue;
    }

    public void setRevenue(double revenue) {
        this.revenue = revenue;
    }

    public Timestamp getPeriod() {
        return period;
    }

    public void setPeriod(Timestamp period) {
        this.period = period;
    }

    public Date getPeriodDate() {
        return periodDate;
    }

    public void setPeriodDate(Date periodDate) {
        this.periodDate = periodDate;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

}
