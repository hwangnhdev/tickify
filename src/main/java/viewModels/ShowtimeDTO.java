package viewModels;

import java.sql.Timestamp;

    public class ShowtimeDTO {
        private int showtimeId;
        private Timestamp startDate;
        private Timestamp endDate;
        private String showtimeStatus;
        private int totalSeats; // Tổng số ghế tính từ số lượng ghế của các loại vé

    // Getters and Setters
    public int getShowtimeId() {
        return showtimeId;
    }

    public void setShowtimeId(int showtimeId) {
        this.showtimeId = showtimeId;
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

    public String getShowtimeStatus() {
        return showtimeStatus;
    }

    public void setShowtimeStatus(String showtimeStatus) {
        this.showtimeStatus = showtimeStatus;
    }

    public int getTotalSeats() {
        return totalSeats;
    }

    public void setTotalSeats(int totalSeats) {
        this.totalSeats = totalSeats;
    }
}
