/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package viewModels;

/**
 *
 * @author Duong Minh Kiet CE180166
 */
public class TicketSeatDTO {

    private String ticketType; // Ví dụ: "VIP", "Regular"
    private String seatList;   // Ví dụ: "A1, A2, A3" hoặc "B1, B2"

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public String getSeatList() {
        return seatList;
    }

    public void setSeatList(String seatList) {
        this.seatList = seatList;
    }
}
