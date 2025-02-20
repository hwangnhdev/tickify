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
    
    
}
