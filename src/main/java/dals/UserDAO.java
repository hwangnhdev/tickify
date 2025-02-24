package dals;

import models.User;
import utils.DBContext;
import java.sql.*;

public class UserDAO {

    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        // Sử dụng cột "password" thay vì "user_password"
        String query = "SELECT * FROM Users WHERE email = ? AND password = ?";

        try (Connection conn = new DBContext().connection;
             PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, email);
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
