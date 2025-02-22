/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventSalesSummary {

    private int eventId;
    private String eventName;
    private int totalTicketsSold;
    private double grossSales;

    public EventSalesSummary() {
    }

    public EventSalesSummary(int eventId, String eventName, int totalTicketsSold, double grossSales) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.totalTicketsSold = totalTicketsSold;
        this.grossSales = grossSales;
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

}
