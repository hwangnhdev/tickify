/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class Seat extends TicketType {

    private int seatId;
    private int eventId;
    private String seatRow;
    private String seatCol;
    private String status;

    public Seat() {
    }

    public Seat(int seatId, int eventId, String seatRow, String seatCol, String status) {
        this.seatId = seatId;
        this.eventId = eventId;
        this.seatRow = seatRow;
        this.seatCol = seatCol;
        this.status = status;
    }

    public Seat(int seatId, int eventId, String seatRow, String seatCol, String status, int ticketTypeId, String name, String description, double price, int totalQuantity, int soldQuantity, Date createdAt, Date updatedAt) {
        super(ticketTypeId, eventId, name, description, price, totalQuantity, soldQuantity, createdAt, updatedAt);
        this.seatId = seatId;
        this.seatRow = seatRow;
        this.seatCol = seatCol;
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

    @Override
    public String toString() {
        return "Seat{"
                + "seatId=" + seatId
                + ", seatRow='" + seatRow + '\''
                + ", seatCol='" + seatCol + '\''
                + ", status='" + status + '\''
                + ", ticketTypeId=" + getTicketTypeId()
                + ", eventId=" + getEventId()
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
