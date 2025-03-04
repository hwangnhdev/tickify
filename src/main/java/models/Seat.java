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
    private int ticketTypeId;
    private String seatRow;
    private String seatCol;
    private String status;
    private String ticketTypeName; // Vui add to store json

    public Seat() {
    }

    public Seat(int seatId, int ticketTypeId, String seatRow, String seatCol, String status) {
        this.seatId = seatId;
        this.ticketTypeId = ticketTypeId;
        this.seatRow = seatRow;
        this.seatCol = seatCol;
        this.status = status;
    }

    // Vui add to store json
    public Seat(int seatId, int ticketTypeId, String seatRow, String seatCol, String status, String ticketTypeName) {
        this.seatId = seatId;
        this.ticketTypeId = ticketTypeId;
        this.seatRow = seatRow;
        this.seatCol = seatCol;
        this.status = status;
        this.ticketTypeName = ticketTypeName;
    }
    
    public int getSeatId() {
        return seatId;
    }

    public void setSeatId(int seatId) {
        this.seatId = seatId;
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public String getSeatRow() {
        return seatRow;
    }

    public void setSeatRow(String seatRow) {
        this.seatRow = seatRow;
    }

    public String getSeatCol() {
        return seatCol;
    }

    public void setSeatCol(String seatCol) {
        this.seatCol = seatCol;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getTicketTypeName() {
        return ticketTypeName;
    }

    // Vui add to return json for controller
    public void setTicketTypeName(String ticketTypeName) {
        this.ticketTypeName = ticketTypeName;
    }

}
