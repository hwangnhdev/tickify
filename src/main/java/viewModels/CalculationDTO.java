package viewModels;

import java.math.BigDecimal;

public class CalculationDTO {
    private BigDecimal totalSubtotal;
    private BigDecimal discountAmount;
    private BigDecimal finalTotal;

    public CalculationDTO() {}

    public CalculationDTO(BigDecimal totalSubtotal, BigDecimal discountAmount, BigDecimal finalTotal) {
        this.totalSubtotal = totalSubtotal;
        this.discountAmount = discountAmount;
        this.finalTotal = finalTotal;
    }

    public BigDecimal getTotalSubtotal() {
        return totalSubtotal;
    }

    public void setTotalSubtotal(BigDecimal totalSubtotal) {
        this.totalSubtotal = totalSubtotal;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getFinalTotal() {
        return finalTotal;
    }

    public void setFinalTotal(BigDecimal finalTotal) {
        this.finalTotal = finalTotal;
    }
}
