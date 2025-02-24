/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class SalesHistory {

    private java.sql.Date saleDate;
    private int ticketsSold;
    private double dailySales;

    public SalesHistory() {
    }

    public SalesHistory(Date saleDate, int ticketsSold, double dailySales) {
        this.saleDate = saleDate;
        this.ticketsSold = ticketsSold;
        this.dailySales = dailySales;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }

    public int getTicketsSold() {
        return ticketsSold;
    }

    public void setTicketsSold(int ticketsSold) {
        this.ticketsSold = ticketsSold;
    }

    public double getDailySales() {
        return dailySales;
    }

    public void setDailySales(double dailySales) {
        this.dailySales = dailySales;
    }

}
