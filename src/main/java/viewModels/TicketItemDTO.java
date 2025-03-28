package viewModels;

import java.math.BigDecimal;

public class TicketItemDTO {

    private int ticketTypeId;
    private String ticketType;
    private BigDecimal unitPrice;
    private String seats; // Danh sách ghế dạng chuỗi (ví dụ: "A-15, A-16, A-14, A-13")
    private int quantity;
    private BigDecimal subtotalPerType;

    public TicketItemDTO() {
    }

    public TicketItemDTO(int ticketTypeId, String ticketType, BigDecimal unitPrice, String seats, int quantity, BigDecimal subtotalPerType) {
        this.ticketTypeId = ticketTypeId;
        this.ticketType = ticketType;
        this.unitPrice = unitPrice;
        this.seats = seats;
        this.quantity = quantity;
        this.subtotalPerType = subtotalPerType;
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public String getSeats() {
        return seats;
    }

    public void setSeats(String seats) {
        this.seats = seats;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getSubtotalPerType() {
        return subtotalPerType;
    }

    public void setSubtotalPerType(BigDecimal subtotalPerType) {
        this.subtotalPerType = subtotalPerType;
    }
}
