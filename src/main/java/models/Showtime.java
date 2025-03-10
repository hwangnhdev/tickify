/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

/***
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class Showtime {

    private int showtimeId;
    private int eventId;
    private Timestamp startDate;
    private Timestamp endDate;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    private List<TicketType> ticketTypes; // Vui add to store Json

    public Showtime() {
    }

    public Showtime(int showtimeId, int eventId, Timestamp startDate, Timestamp endDate, String status, Timestamp createdAt, Timestamp updatedAt) {
        this.showtimeId = showtimeId;
        this.eventId = eventId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Showtime(int showtimeId, int eventId, Timestamp startDate, Timestamp endDate, String status, Timestamp createdAt, Timestamp updatedAt, List<TicketType> ticketTypes) {
        this.showtimeId = showtimeId;
        this.eventId = eventId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.ticketTypes = ticketTypes;
    }

    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
    }

    public int getEventId() {
        return eventId;
    }

    public void setEventId(int eventId) {
        this.eventId = eventId;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public List<TicketType> getTicketTypes() {
        return ticketTypes;
    }

    public void setTicketTypes(List<TicketType> ticketTypes) {
        this.ticketTypes = ticketTypes;
    }
    
    @Override
    public String toString() {
        return "Showtime{"
                + "showtimeId=" + showtimeId
                + ", eventId=" + eventId
                + ", startDate=" + startDate
                + ", endDate=" + endDate
                + ", status='" + status + '\''
                + ", createdAt=" + createdAt
                + ", updatedAt=" + updatedAt
                + '}';
    }
}
