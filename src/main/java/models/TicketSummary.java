/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class TicketSummary {

    private int eventId;
    private String eventName;
    private String ticketTypeName;
    private int totalTickets;
    private int ticketsSold;
    private int ticketsRemaining;
    private double soldPercentage;

    public TicketSummary() {
    }

    public TicketSummary(int eventId, String eventName, String ticketTypeName, int totalTickets, int ticketsSold, int ticketsRemaining, double soldPercentage) {
        this.eventId = eventId;
        this.eventName = eventName;
        this.ticketTypeName = ticketTypeName;
        this.totalTickets = totalTickets;
        this.ticketsSold = ticketsSold;
        this.ticketsRemaining = ticketsRemaining;
        this.soldPercentage = soldPercentage;
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

    public String getTicketTypeName() {
        return ticketTypeName;
    }

    public void setTicketTypeName(String ticketTypeName) {
        this.ticketTypeName = ticketTypeName;
    }

    public int getTotalTickets() {
        return totalTickets;
    }

    public void setTotalTickets(int totalTickets) {
        this.totalTickets = totalTickets;
    }

    public int getTicketsSold() {
        return ticketsSold;
    }

    public void setTicketsSold(int ticketsSold) {
        this.ticketsSold = ticketsSold;
    }

    public int getTicketsRemaining() {
        return ticketsRemaining;
    }

    public void setTicketsRemaining(int ticketsRemaining) {
        this.ticketsRemaining = ticketsRemaining;
    }

    public double getSoldPercentage() {
        return soldPercentage;
    }

    public void setSoldPercentage(double soldPercentage) {
        this.soldPercentage = soldPercentage;
    }

}
