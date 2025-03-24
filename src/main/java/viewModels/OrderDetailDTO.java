package viewModels;

import java.util.List;

public class OrderDetailDTO {
    private OrderSummaryDTO orderSummary;
    private CalculationDTO calculation;
    private EventSummaryDTO eventSummary;
    private List<TicketItemDTO> orderItems;

    public OrderDetailDTO() {}

    public OrderDetailDTO(OrderSummaryDTO orderSummary, CalculationDTO calculation, EventSummaryDTO eventSummary, List<TicketItemDTO> orderItems) {
        this.orderSummary = orderSummary;
        this.calculation = calculation;
        this.eventSummary = eventSummary;
        this.orderItems = orderItems;
    }

    public OrderSummaryDTO getOrderSummary() {
        return orderSummary;
    }

    public void setOrderSummary(OrderSummaryDTO orderSummary) {
        this.orderSummary = orderSummary;
    }

    public CalculationDTO getCalculation() {
        return calculation;
    }

    public void setCalculation(CalculationDTO calculation) {
        this.calculation = calculation;
    }

    public EventSummaryDTO getEventSummary() {
        return eventSummary;
    }

    public void setEventSummary(EventSummaryDTO eventSummary) {
        this.eventSummary = eventSummary;
    }

    public List<TicketItemDTO> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<TicketItemDTO> orderItems) {
        this.orderItems = orderItems;
    }
}
