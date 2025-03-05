/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Seat;
import utils.DBContext;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class SeatDAO extends DBContext {

    private static final String SELECT_ALL_SEATS = "SELECT * FROM Seats";
    private static final String SELECT_SEATS_BY_EVENT_ID = "SELECT * FROM Seats WHERE event_id = ?";
    private static final String SELECT_SEAT_BY_ID = "SELECT * FROM Seats WHERE seat_id = ?";
    private static final String SELECT_SEATS_BY_SHOWTIME_ID
            = "SELECT \n"
            + "    s.seat_id, \n"
            + "    s.seat_row, \n"
            + "    s.seat_col, \n"
            + "    s.status AS seat_status,\n"
            + "    tt.ticket_type_id,\n"
            + "    tt.name AS ticket_type_name,\n"
            + "    tt.price,\n"
            + "    tt.color\n"
            + "FROM Seats s\n"
            + "JOIN TicketTypes tt ON s.ticket_type_id = tt.ticket_type_id\n"
            + "WHERE tt.showtime_id = ?;";
    private static final String INSERT_SEAT = "INSERT INTO Seats (event_id, seat_row, seat_number, status) VALUES (?, ?, ?, ?)";
    private static final String UPDATE_SEAT_STATUS = "UPDATE Seats SET status = ? WHERE seat_id = ?";
    private static final String DELETE_SEAT = "DELETE FROM Seats WHERE seat_id = ?";

    private Seat mapResultSetToSeat(ResultSet rs) throws SQLException {
        Seat seat = new Seat();
        seat.setSeatId(rs.getInt("seat_id"));
        seat.setEventId(rs.getInt("event_id"));
        seat.setSeatRow(rs.getString("seat_row"));
        seat.setSeatCol(rs.getString("seat_col"));
        seat.setStatus(rs.getString("status"));
        return seat;
    }

    /**
     * Lấy danh sách tất cả các ghế
     */
    public List<Seat> selectAllSeats() {
        List<Seat> seats = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_ALL_SEATS);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                seats.add(mapResultSetToSeat(rs));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return seats;
    }

    /**
     * Lấy danh sách ghế theo showtime_id
     */
    public List<Seat> selectSeatsByShowtimeId(int showtimeId) {
        List<Seat> seats = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_SEATS_BY_SHOWTIME_ID);
            st.setInt(1, showtimeId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Seat seat = new Seat();
                seat.setSeatId(rs.getInt("seat_id"));
                seat.setSeatRow(rs.getString("seat_row"));
                seat.setSeatCol(rs.getString("seat_col"));
                seat.setStatus(rs.getString("seat_status"));
                seat.setTicketTypeId(rs.getInt("ticket_type_id"));
                seat.setName(rs.getString("ticket_type_name"));
                seat.setPrice(rs.getDouble("price"));
                seat.setColor(rs.getString("color"));
                seats.add(seat);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return seats;
    }

    /**
     * Lấy danh sách ghế theo event_id
     */
    public List<Seat> selectSeatsByEventId(int eventId) {
        List<Seat> seats = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_SEATS_BY_EVENT_ID);
            st.setInt(1, eventId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                seats.add(mapResultSetToSeat(rs));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return seats;
    }

    /**
     * Lấy thông tin ghế theo seat_id
     */
    public Seat selectSeatById(int seatId) {
        Seat seat = null;
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_SEAT_BY_ID);
            st.setInt(1, seatId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                seat = mapResultSetToSeat(rs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return seat;
    }

    /**
     * Thêm mới một ghế vào database
     */
    public boolean insertSeat(Seat seat) {
        try {
            PreparedStatement st = connection.prepareStatement(INSERT_SEAT);
            st.setInt(1, seat.getEventId());
            st.setString(2, seat.getSeatRow());
            st.setString(3, seat.getSeatCol());
            st.setString(4, seat.getStatus());

            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    /**
     * Cập nhật trạng thái ghế (ví dụ: available, not available)
     */
    public boolean updateSeatStatus(int seatId, String newStatus) {
        try {
            PreparedStatement st = connection.prepareStatement(UPDATE_SEAT_STATUS);
            st.setString(1, newStatus);
            st.setInt(2, seatId);

            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    /**
     * Xóa một ghế theo seat_id
     */
    public boolean deleteSeat(int seatId) {
        try {
            PreparedStatement st = connection.prepareStatement(DELETE_SEAT);
            st.setInt(1, seatId);

            int rowsDeleted = st.executeUpdate();
            return rowsDeleted > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public static void main(String[] args) {
        SeatDAO seatDao = new SeatDAO();
        List<Seat> seatsForEvent = seatDao.selectSeatsByEventId(2);
        for (Seat seat : seatsForEvent) {
            System.out.println(seat.getSeatRow() + seat.getSeatCol());
        }
    }
}
