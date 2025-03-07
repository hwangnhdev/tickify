/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import models.Showtime;
import utils.DBContext;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class ShowtimeDAO extends DBContext {

    // SQL Queries
    private static final String SELECT_ALL_SHOWTIMES = "SELECT * FROM Showtimes";
    private static final String SELECT_SHOWTIME_BY_ID = "SELECT * FROM Showtimes WHERE showtime_id = ?";
    private static final String SELECT_SHOWTIME_BY_EVENT_ID = "SELECT * FROM Showtimes WHERE event_id = ?";
    private static final String INSERT_SHOWTIME = "INSERT INTO Showtimes (event_id, start_date, end_date, status, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_SHOWTIME = "UPDATE Showtimes SET event_id = ?, start_date = ?, end_date = ?, status = ?, updated_at = ? WHERE showtime_id = ?";
    private static final String DELETE_SHOWTIME = "DELETE FROM Showtimes WHERE showtime_id = ?";

    // 📌 Chuyển `ResultSet` thành đối tượng `Showtime`
    private Showtime mapResultSetToShowtime(ResultSet rs) throws SQLException {
        return new Showtime(
                rs.getInt("showtime_id"),
                rs.getInt("event_id"),
                rs.getTimestamp("start_date"),
                rs.getTimestamp("end_date"),
                rs.getString("status"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
        );
    }

    // 📌 CREATE: Thêm một suất chiếu mới
    public boolean insertShowtime(Showtime showtime) {
        try ( PreparedStatement st = connection.prepareStatement(INSERT_SHOWTIME)) {
            st.setInt(1, showtime.getEventId());
            st.setTimestamp(2, showtime.getStartDate());
            st.setTimestamp(3, showtime.getEndDate());
            st.setString(4, showtime.getStatus());
            st.setTimestamp(5, showtime.getCreatedAt());
            st.setTimestamp(6, showtime.getUpdatedAt());

            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 📌 READ: Lấy danh sách tất cả suất chiếu
    public List<Showtime> selectAllShowtimes() {
        List<Showtime> showtimes = new ArrayList<>();
        try ( PreparedStatement st = connection.prepareStatement(SELECT_ALL_SHOWTIMES);  ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                showtimes.add(mapResultSetToShowtime(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return showtimes;
    }
    
    // 📌 READ: Lấy suất chiếu theo ID
    public Showtime selectShowtimeById(int id) {
        try (PreparedStatement st = connection.prepareStatement(SELECT_SHOWTIME_BY_ID)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToShowtime(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 📌 READ: Lấy suất chiếu theo Event ID
    public List<Showtime> selectShowtimeByEventId(int eventId) {
        List<Showtime> showtimes = new ArrayList<>();
        try ( PreparedStatement st = connection.prepareStatement(SELECT_SHOWTIME_BY_EVENT_ID)) {
            st.setInt(1, eventId);
            try ( ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    showtimes.add(mapResultSetToShowtime(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return showtimes;
    }

    // 📌 UPDATE: Cập nhật thông tin suất chiếu
    public boolean updateShowtime(Showtime showtime) {
        try ( PreparedStatement st = connection.prepareStatement(UPDATE_SHOWTIME)) {
            st.setInt(1, showtime.getEventId());
            st.setTimestamp(2, showtime.getStartDate());
            st.setTimestamp(3, showtime.getEndDate());
            st.setString(4, showtime.getStatus());
            st.setTimestamp(5, showtime.getUpdatedAt());
            st.setInt(6, showtime.getShowtimeId());

            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 📌 DELETE: Xóa suất chiếu theo ID
    public boolean deleteShowtime(int id) {
        try ( PreparedStatement st = connection.prepareStatement(DELETE_SHOWTIME)) {
            st.setInt(1, id);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
