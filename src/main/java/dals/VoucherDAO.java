/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import models.Voucher;
import utils.DBContext;

/**
 *
 * @author Dinh Minh Tien - CE190701
 */
public class VoucherDAO extends DBContext {

    private static final String SELECT_ALL_VOUCHERS = "SELECT * FROM Vouchers";
    private static final String SELECT_VOUCHER_BY_ID = "SELECT * FROM Vouchers WHERE voucher_id = ?";
    private static final String SELECT_VOUCHER_BY_EVENT = "SELECT * FROM Vouchers WHERE event_id = ?";
    private static final String INSERT_VOUCHER = "insert into Vouchers (event_id, code, description, discount_type, discount_value, "
            + "start_date, end_date, usage_limit, status, created_at, updated_at)"
            + "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_VOUCHER = "update Vouchers set code = ?, description = ?, discount_type = ?, discount_value = ?, start_date = ?, end_date = ?, usage_limit = ?, status = ?, updated_at = ? where voucher_id = ?";

    private Voucher mapResultSetToVoucher(ResultSet rs) throws SQLException {
        Voucher voucher = new Voucher();
        voucher.setVoucherId(rs.getInt("voucher_id"));
        voucher.setEventId(rs.getInt("event_id"));
        voucher.setCode(rs.getString("code"));
        voucher.setDescription(rs.getString("description"));
        voucher.setDiscountType(rs.getString("discount_type"));
        voucher.setDiscountValue(rs.getDouble("discount_value"));
        voucher.setStartDate(rs.getTimestamp("start_date"));
        voucher.setEndDate(rs.getTimestamp("end_date"));
        voucher.setUsageLimit(rs.getInt("usage_limit"));
        voucher.setStatus(rs.getBoolean("status"));
        voucher.setCreatedAt(rs.getTimestamp("created_at"));
        voucher.setUpdatedAt(rs.getTimestamp("updated_at"));
        return voucher;
    }

    public List<Voucher> getAllVouchers() {
        List<Voucher> vouchers = new ArrayList<>();
        try {
            PreparedStatement stmt = connection.prepareStatement(SELECT_ALL_VOUCHERS);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                vouchers.add(mapResultSetToVoucher(rs));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return vouchers;
    }

    public Voucher getVoucherById(int id) {
        try ( PreparedStatement stmt = connection.prepareStatement(SELECT_VOUCHER_BY_ID)) {
            stmt.setInt(1, id);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToVoucher(rs);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public List<Voucher> getVouchersByEvent(int eventId) {
        List<Voucher> vouchers = new ArrayList<>();
        try ( PreparedStatement stmt = connection.prepareStatement(SELECT_VOUCHER_BY_EVENT)) {
            stmt.setInt(1, eventId);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    vouchers.add(mapResultSetToVoucher(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return vouchers;
    }

    public boolean insertVoucher(Voucher voucher) {
        try ( PreparedStatement stmt = connection.prepareStatement(INSERT_VOUCHER)) {
            stmt.setInt(1, voucher.getEventId());
            stmt.setString(2, voucher.getCode());
            stmt.setString(3, voucher.getDescription());
            stmt.setString(4, voucher.getDiscountType());
            stmt.setDouble(5, voucher.getDiscountValue());
            stmt.setTimestamp(6, voucher.getStartDate());
            stmt.setTimestamp(7, voucher.getEndDate());
            stmt.setInt(8, voucher.getUsageLimit());
            stmt.setBoolean(9, voucher.isStatus());
            stmt.setTimestamp(10, new Timestamp(System.currentTimeMillis())); // created_at
            stmt.setTimestamp(11, new Timestamp(System.currentTimeMillis())); // updated_at
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

    public boolean updateVoucher(Voucher voucher) {
        try ( PreparedStatement stmt = connection.prepareStatement(UPDATE_VOUCHER)) {
            stmt.setString(1, voucher.getCode());
            stmt.setString(2, voucher.getDescription());
            stmt.setString(3, voucher.getDiscountType());
            stmt.setDouble(4, voucher.getDiscountValue());
            stmt.setTimestamp(5, voucher.getStartDate());
            stmt.setTimestamp(6, voucher.getEndDate());
            stmt.setInt(7, voucher.getUsageLimit());
            stmt.setBoolean(8, voucher.isStatus());
            stmt.setTimestamp(9, new Timestamp(System.currentTimeMillis())); // updated_at
            stmt.setInt(10, voucher.getVoucherId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return false;
    }

//    public static void main(String[] args) {
//        VoucherDAO voucherDAO = new VoucherDAO();
//            Voucher v = new Voucher(
//                0, 100, "TEST2025", "Test Voucher", "percentage", 15.0,
//                Timestamp.valueOf("2025-03-10 00:00:00"),
//                Timestamp.valueOf("2025-03-20 23:59:59"),
//                10, true, new Timestamp(System.currentTimeMillis()),
//                new Timestamp(System.currentTimeMillis())
//            );
//
//            System.out.println("Attempting to insert voucher...");
//            boolean generatedId = voucherDAO.insertVoucher(v);
//            System.out.println("Result: " + (generatedId ? "Success, ID: " + generatedId : "Failed"));
//    }
}
