package models;

import java.util.List;

public class OrganizerOrderDetailDTO {
    private OrganizerOrderHeader orderHeader;
    private List<OrganizerOrderDetail> orderDetails;

    // Getters & Setters
    public OrganizerOrderHeader getOrderHeader() {
        return orderHeader;
    }
    public void setOrderHeader(OrganizerOrderHeader orderHeader) {
        this.orderHeader = orderHeader;
    }
    public List<OrganizerOrderDetail> getOrderDetails() {
        return orderDetails;
    }
    public void setOrderDetails(List<OrganizerOrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
}
