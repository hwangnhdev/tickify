/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class Seat {
    private int seatId;
    private int eventId;
    private String seatRow;
    private String seatNumber;
    private String status;

    public Seat() {
    }

    public Seat(int seatId, int eventId, String seatRow, String seatNumber, String status) {
        this.seatId = seatId;
        this.eventId = eventId;
        this.seatRow = seatRow;
        this.seatNumber = seatNumber;
        this.status = status;
    }

    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
    }

    public String getSeatRow() {
        return seatRow;
    }

    public void setSeatRow(String seatRow) {
        this.seatRow = seatRow;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
