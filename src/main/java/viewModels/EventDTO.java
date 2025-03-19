/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package viewModels;

import java.sql.Timestamp;
import models.Event;
import models.EventImage;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventDTO {

    private models.Event event;
    private models.EventImage eventImage;
    private double minPrice;
    private Timestamp firstStartDate;

    public EventDTO() {
    }

    public EventDTO(Event event, EventImage eventImage, double minPrice, Timestamp firstStartDate) {
        this.event = event;
        this.eventImage = eventImage;
        this.minPrice = minPrice;
        this.firstStartDate = firstStartDate;
    }

    public Event getEvent() {
        return event;
    }

    public void setEvent(Event event) {
        this.event = event;
    }

    public EventImage getEventImage() {
        return eventImage;
    }

    public void setEventImage(EventImage eventImage) {
        this.eventImage = eventImage;
    }

    public double getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(double minPrice) {
        this.minPrice = minPrice;
    }

    public Timestamp getFirstStartDate() {
        return firstStartDate;
    }

    public void setFirstStartDate(Timestamp firstStartDate) {
        this.firstStartDate = firstStartDate;
    }

}
