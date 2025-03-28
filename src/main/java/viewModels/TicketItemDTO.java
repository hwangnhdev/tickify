package viewModels;

import java.math.BigDecimal;

public class TicketItemDTO {

    private int ticketTypeId;
    private String ticketType;
    private String ticketCode;
    private int quantity;
    private BigDecimal unitPrice;
    private BigDecimal subtotalPerType;
    private String seats;
    private String paymentStatus;
    private String ticketStatus;
    private String ticketQRCode;

    public TicketItemDTO() {
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public String getTicketQRCode() {
        return ticketQRCode;
    }

    public void setTicketQRCode(String ticketQRCode) {
        this.ticketQRCode = ticketQRCode;
    }

    public String getTicketType() {
        return ticketType;
    }

    public void setTicketType(String ticketType) {
        this.ticketType = ticketType;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(BigDecimal unitPrice) {
        this.unitPrice = unitPrice;
    }

    public BigDecimal getSubtotalPerType() {
        return subtotalPerType;
    }

    public void setSubtotalPerType(BigDecimal subtotalPerType) {
        this.subtotalPerType = subtotalPerType;
    }

    public String getSeats() {
        return seats;
    }

    public void setSeats(String seats) {
        this.seats = seats;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(String ticketStatus) {
        this.ticketStatus = ticketStatus;
    }
}
