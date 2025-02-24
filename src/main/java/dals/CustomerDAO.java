/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import org.mindrot.jbcrypt.BCrypt;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import models.Customers;
import utils.DBContext;

/**
 *
 * @author Dinh Minh Tien CE190701
 */
public class CustomerDAO extends DBContext {

    /**
     * Method to get customer's information
     * @param customerId
     * @return Customers object
     */
    public Customers getCustomerById(int customerId) {
        String query = "select c.*,\n"
                + "	ca.password \n"
                + "	from Customers c\n"
                + "	inner join Customer_auths ca\n"
                + "	on c.customer_id = ca.customer_id\n"
                + "where c.customer_id = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customers customer = new Customers();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setFullName(rs.getString("full_name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setEmail(rs.getString("email"));
                    customer.setDob(rs.getDate("dob"));
                    customer.setGender(rs.getString("gender"));
                    customer.setProfilePicture(rs.getString("profile_picture"));
                    customer.setStatus(rs.getBoolean("status"));
                    customer.setPassword(rs.getString("password"));
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching profile: " + e.getMessage());
        }
        return null;
    }

    /**
     * Method for customer to update their own information
     * @param customer
     * @return true if updated successfully, false if failed
     */
    public boolean updateCustomer(Customers customer) {
        String query = "UPDATE Customers SET full_name = ?, address = ?, phone = ?, dob = ?, gender =?, profile_picture = ? WHERE customer_id = ?";
        try ( PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, customer.getFullName());
            ps.setString(2, customer.getAddress());
            ps.setString(3, customer.getPhone());
            ps.setDate(4, customer.getDob());
            ps.setString(5, customer.getGender());
            ps.setString(6, customer.getProfilePicture());
            ps.setInt(7, customer.getCustomerId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating profile: " + e.getMessage());
        }
        return false;
    }

    /**
     * Method for customer to change their password
     * @param customerId
     * @param newPassword
     * @return true if updated successfully, false if failed
     */
    public boolean updatePassword(int customerId, String newPassword) {
        String sql = "UPDATE Customer_auths SET password=? WHERE customer_id=?";
        try ( PreparedStatement ps = connection.prepareStatement(sql)) {
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt()); // Hash newPasword
            ps.setString(1, hashedPassword);
            ps.setInt(2, customerId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating password: " + e.getMessage());
        }
        return false;
    }
}
