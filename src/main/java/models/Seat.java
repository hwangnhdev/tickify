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
public class Seat extends TicketType {

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
        this.seatCol = seatCol;
        this.status = status;
    }

    public Seat(int seatId, int ticketTypeId, String seatRow, String seatCol, String status, int showtimeId, String name, String description, double price, String color, int totalQuantity, int soldQuantity, Timestamp createdAt, Timestamp updatedAt) {
        super(ticketTypeId, showtimeId, name, description, price, color, totalQuantity, soldQuantity, createdAt, updatedAt);
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

    @Override
    public int getTicketTypeId() {
        return ticketTypeId;
    }

    @Override
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

    @Override
    public String toString() {
        return "Seat{"
                + "seatId=" + seatId
                + ", seatRow='" + seatRow + '\''
                + ", seatCol='" + seatCol + '\''
                + ", status='" + status + '\''
                + ", ticketTypeId=" + getTicketTypeId()
                + ", getTicketTypeId=" + getTicketTypeId()
                + ", name='" + getName() + '\''
                + ", description='" + getDescription() + '\''
                + ", price=" + getPrice()
                + ", color=" + getColor()
                + ", totalQuantity=" + getTotalQuantity()
                + ", soldQuantity=" + getSoldQuantity()
                + ", createdAt=" + getCreatedAt()
                + ", updatedAt=" + getUpdatedAt()
                + '}';
    }

}
