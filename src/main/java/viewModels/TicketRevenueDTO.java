/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package viewModels;

import java.sql.Timestamp;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class TicketRevenueDTO {

    private int showtimeId;
    private Timestamp startDate;
    private Timestamp endDate;
    private String ticketType;
    private int totalTicket;
    private double priceOfTicket;
    private int sold;
    private int remaining;
    private double totalRevenue;
    private double fillRate;

    public TicketRevenueDTO() {
    }

    public TicketRevenueDTO(int showtimeId, Timestamp startDate, Timestamp endDate, String ticketType, int totalTicket, double priceOfTicket, int sold, int remaining, double totalRevenue, double fillRate) {
        this.showtimeId = showtimeId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.ticketType = ticketType;
        this.totalTicket = totalTicket;
        this.priceOfTicket = priceOfTicket;
        this.sold = sold;
        this.remaining = remaining;
        this.totalRevenue = totalRevenue;
        this.fillRate = fillRate;
    }

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public Timestamp getEndDate() {
        return endDate;
    }

    public void setEndDate(Timestamp endDate) {
        this.endDate = endDate;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public int getTotalTicket() {
        return totalTicket;
    }

    public void setTotalTicket(int totalTicket) {
        this.totalTicket = totalTicket;
    }

    public double getPriceOfTicket() {
        return priceOfTicket;
    }

    public void setPriceOfTicket(double priceOfTicket) {
        this.priceOfTicket = priceOfTicket;
    }

    public int getSold() {
        return sold;
    }

    public void setSold(int sold) {
        this.sold = sold;
    }

    public int getRemaining() {
        return remaining;
    }

    public void setRemaining(int remaining) {
        this.remaining = remaining;
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(double totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public double getFillRate() {
        return fillRate;
    }

    public void setFillRate(double fillRate) {
        this.fillRate = fillRate;
    }

}
