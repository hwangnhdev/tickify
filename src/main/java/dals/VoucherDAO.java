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

    private static final String SELECT_ALL_VOUCHERS = "SELECT * WHERE is_deleted = 0 FROM Vouchers";
    private static final String SELECT_VOUCHER_BY_ID = "SELECT * FROM Vouchers WHERE voucher_id = ?";
    private static final String SELECT_VOUCHER_BY_EVENT = "SELECT * FROM Vouchers WHERE event_id = ? AND is_deleted = 0 "
            + "ORDER BY voucher_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    private static final String INSERT_VOUCHER = "insert into Vouchers (event_id, code, description, discount_type, discount_value, "
            + "start_date, end_date, usage_limit, status, created_at, updated_at, is_deleted)"
            + "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_VOUCHER = "update Vouchers set code = ?, description = ?, discount_type = ?, discount_value = ?, start_date = ?, end_date = ?, usage_limit = ?, status = ?, updated_at = ? where voucher_id = ?";
    private static final String DELETE_VOUCHER = "update Vouchers set is_deleted = ? where voucher_id = ?";
    private static final String SEARCH_VOUCHER = "SELECT * FROM Vouchers "
            + "WHERE event_id = ? AND LOWER(code) LIKE ? AND is_deleted = 0 "
            + "ORDER BY voucher_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    private Voucher mapResultSetToVoucher(ResultSet rs) throws SQLException {
        Voucher voucher = new Voucher();
        voucher.setVoucherId(rs.getInt("voucher_id"));
        voucher.setEventId(rs.getInt("event_id"));
        voucher.setCode(rs.getString("code"));
        voucher.setDescription(rs.getString("description"));
        voucher.setDiscountType(rs.getString("discount_type"));
        voucher.setDiscountValue(rs.getInt("discount_value"));
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

    public List<Voucher> getVouchersByEvent(int eventId, int page, int pageSize) {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = SELECT_VOUCHER_BY_EVENT;
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.setInt(2, (page - 1) * pageSize);
            stmt.setInt(3, pageSize);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    vouchers.add(mapResultSetToVoucher(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching vouchers: " + e.getMessage());
        }
        return vouchers;
    }

    public int getTotalVouchersByEvent(int eventId) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM vouchers WHERE event_id = ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error counting vouchers: " + e.getMessage());
        }
        return total;
    }

    public List<Voucher> searchVoucher(int eventId, String keyword, int page, int pageSize) {
        List<Voucher> vouchers = new ArrayList<>();
        try ( PreparedStatement stmt = connection.prepareStatement(SEARCH_VOUCHER)) {
            stmt.setInt(1, eventId);
            stmt.setString(2, "%" + keyword.toLowerCase() + "%"); // Case-insensitive search
            stmt.setInt(3, (page - 1) * pageSize);
            stmt.setInt(4, pageSize);
            try ( ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    vouchers.add(mapResultSetToVoucher(rs));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error counting vouchers: " + e.getMessage());
        }
        return vouchers;
    }

    public int getTotalSearchVouchers(int eventId, String keyword) {
        int total = 0;
        String sql = "SELECT COUNT(*) "
                + "FROM Vouchers "
                + "WHERE event_id = ? "
                + "  AND LOWER(code) LIKE ?";
        try ( PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.setString(2, "%" + keyword.toLowerCase() + "%");
            try ( ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error counting vouchers: " + e.getMessage());
        }
        return total;
    }
    
    // Get vouchers by event ID and status with pagination
    public List<Voucher> getVouchersByEventAndStatus(int eventId, int page, int pageSize, boolean status, boolean isDeleted) {
        List<Voucher> vouchers = new ArrayList<>();
        String sql = "SELECT * FROM vouchers WHERE event_id = ? AND status = ? AND is_deleted = ? ORDER BY event_id ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        int offset = (page - 1) * pageSize;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.setBoolean(2, status);
            stmt.setBoolean(3, isDeleted);
            stmt.setInt(4, offset);
            stmt.setInt(5, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    vouchers.add(mapResultSetToVoucher(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return vouchers;
    }
    public static void main(String[] args) {
        VoucherDAO dao = new VoucherDAO();
        int page = 1;
        int PAGE_SIZE = 1;
        List<Voucher> vouchers = dao.getVouchersByEventAndStatus(1, page, PAGE_SIZE, true, false);
        System.out.println(vouchers);
    }
    
    // Get total number of vouchers by event ID
    public int getTotalVouchersByEventAndStatus(int eventId, boolean status) {
        String sql = "SELECT COUNT(*) FROM vouchers WHERE event_id = ? AND status = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, eventId);
            stmt.setBoolean(2, status);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public boolean insertVoucher(Voucher voucher) {
        try ( PreparedStatement stmt = connection.prepareStatement(INSERT_VOUCHER)) {
            stmt.setInt(1, voucher.getEventId());
            stmt.setString(2, voucher.getCode());
            stmt.setString(3, voucher.getDescription());
            stmt.setString(4, voucher.getDiscountType());
            stmt.setInt(5, voucher.getDiscountValue());
            stmt.setTimestamp(6, voucher.getStartDate());
            stmt.setTimestamp(7, voucher.getEndDate());
            stmt.setInt(8, voucher.getUsageLimit());
            stmt.setBoolean(9, voucher.isStatus());
            stmt.setTimestamp(10, new Timestamp(System.currentTimeMillis())); // created_at
            stmt.setTimestamp(11, new Timestamp(System.currentTimeMillis())); // updated_at
            stmt.setBoolean(12, voucher.isDeleted());
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
            stmt.setInt(4, voucher.getDiscountValue());
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

    public boolean deleteVoucher(int voucherId) {
        try ( PreparedStatement stmt = connection.prepareStatement(DELETE_VOUCHER)) {
            stmt.setBoolean(1, true);
            stmt.setInt(2, voucherId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

}
