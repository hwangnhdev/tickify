package dals;

import models.User;
import utils.DBContext;
import java.sql.*;

public class UserAccountDAO {

    /**
     * Xác thực người dùng theo username và password.
     * Kết hợp dữ liệu từ bảng UserAccounts và Users.
     *
     * @param username Tên đăng nhập.
     * @param password Mật khẩu (plain text trong demo).
     * @return Đối tượng User nếu xác thực thành công, ngược lại trả về null.
     */
    public User getUserByUsernameAndPassword(String username, String password) {
        User user = null;
        String query = "SELECT ua.account_id, ua.username, ua.password, ua.status AS account_status, " +
                       "       u.user_id, u.first_name, u.last_name, u.email, u.phone, u.address " +
                       "FROM UserAccounts ua " +
                       "JOIN Users u ON ua.user_id = u.user_id " +
                       "WHERE ua.username = ? AND ua.password = ? AND ua.status = 'Active'";
        
        try (Connection conn = new DBContext().connection;
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setString(1, username);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
