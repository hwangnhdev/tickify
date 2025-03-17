/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dals;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.mindrot.jbcrypt.BCrypt;

import models.CustomerAuth;
import models.Customer;
import utils.DBContext;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class CustomerDAO extends DBContext {

    public static void main(String[] args) {
//        Customer customer = new Customer();
//        CustomerAuth customerAuth = new CustomerAuth();
//        CustomerDAO cusDao = new CustomerDAO();
//        CustomerAuthDAO cusAuthDao = new CustomerAuthDAO();
//
//        customer = cusDao.selectCustomerById(3);
//        customerAuth = cusAuthDao.selectCustomerAuthById(customer.getCustomerId());
//
//        System.out.println(customer);
//        System.out.println(customerAuth)

        CustomerDAO dao = new CustomerDAO();
        System.out.println(dao.getPassword(1));

    }

    private static final String SELECT_ALL_CUSTOMERS = "SELECT * FROM Customers";
    private static final String SELECT_CUSTOMER_BY_ID = "SELECT * FROM Customers WHERE customer_id = ?";
    private static final String SELECT_CUSTOMER_BY_EMAIL = "SELECT * FROM Customers WHERE email = ?";
    private static final String INSERT_CUSTOMER = "INSERT INTO Customers (full_name, email, address, phone, profile_picture, status) VALUES (?, ?, ?, ?, ?, ?)";
    private static final String UPDATE_CUSTOMER = "UPDATE Customers SET full_name = ?, email = ?, address = ?, phone = ?, profile_picture = ?, status = ? WHERE customer_id = ?";

    private Customer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomerId(rs.getInt("customer_id"));
        customer.setFullName(rs.getString("full_name"));
        customer.setEmail(rs.getString("email"));
        customer.setAddress(rs.getString("address"));
        customer.setPhone(rs.getString("phone"));
        customer.setProfilePicture(rs.getString("profile_picture"));
        customer.setStatus(rs.getBoolean("status"));
        return customer;
    }

    public List<Customer> selectAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_ALL_CUSTOMERS);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return customers;
    }

    public Customer selectCustomerById(int id) {
        Customer customer = null;
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_CUSTOMER_BY_ID);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                customer = mapResultSetToCustomer(rs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return customer;
    }

    public Customer selectCustomerByEmail(String email) {
        Customer customer = null;
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_CUSTOMER_BY_EMAIL);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                customer = mapResultSetToCustomer(rs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return customer;
    }

    public boolean insertCustomer(Customer customer) {
        try {
            PreparedStatement st = connection.prepareStatement(INSERT_CUSTOMER);
            st.setString(1, customer.getFullName());
            st.setString(2, customer.getEmail());
            st.setString(3, customer.getAddress());
            st.setString(4, customer.getPhone());
            st.setString(5, customer.getProfilePicture());
            st.setBoolean(6, customer.getStatus());

            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public boolean updateCustomer(Customer customer) {
        String query = "UPDATE Customers SET full_name = ?, address = ?, phone = ?, profile_picture = ? WHERE customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, customer.getFullName());
            ps.setString(2, customer.getAddress());
            ps.setString(3, customer.getPhone());
            ps.setString(4, customer.getProfilePicture());
            ps.setInt(5, customer.getCustomerId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating profile: " + e.getMessage());
        }
        return false;
    }
    
    public boolean updateCustomerImageProfile(Customer customer) {
        String query = "UPDATE Customers SET profile_picture = ? WHERE customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, customer.getProfilePicture());
            ps.setInt(2, customer.getCustomerId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating profile: " + e.getMessage());
        }
        return false;
    }

    /**
     * Method to get customer's information
     *
     * @param customerId
     * @return Customer object
     */
    public Customer getCustomerById(int customerId) {
        String query = "select customer_id, full_name, address, phone, email, profile_picture, status\n"
                + "	from Customers\n"
                + "where customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setFullName(rs.getString("full_name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setEmail(rs.getString("email"));
                    customer.setProfilePicture(rs.getString("profile_picture"));
                    customer.setStatus(rs.getBoolean("status"));
                    return customer;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching profile: " + e.getMessage());
        }
        return null;
    }

    /**
     * Method for customer to change their password
     *
     * @param customerId
     * @param newPassword
     * @return true if updated successfully, false if failed
     */
    public boolean updatePassword(int customerId, String newPassword) {
        String sql = "UPDATE Customer_auths SET password=? WHERE customer_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt()); // Hash newPasword
            ps.setString(1, hashedPassword);
            ps.setInt(2, customerId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error updating password: " + e.getMessage());
        }
        return false;
    }

    public CustomerAuth getPassword(int customerId) {
        CustomerAuth pass = null;
        String sql = "SELECT password FROM Customer_auths WHERE customer_id=?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    pass = new CustomerAuth();
                    pass.setPassword(rs.getString("password"));
                }
            }
        } catch (SQLException e) {
            System.out.println("Error fetching password: " + e.getMessage());
        }
        return pass; // Return the retrieved object (or null if not found)
    }

    // Phương thức lấy danh sách khách hàng với tìm kiếm, lọc và phân trang
    // Lấy danh sách khách hàng với tìm kiếm, lọc theo trạng thái và phân trang
    public List<Customer> getAllCustomers(String searchTerm, String selectedStatus, String sortColumn, String sortOrder, int pageNumber, int pageSize) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT customer_id, full_name, email, status "
                + "FROM Customers "
                + "WHERE (? IS NULL OR full_name LIKE ?) "
                + "AND (? IS NULL OR status = ?) "
                + "ORDER BY " + sortColumn + " " + sortOrder + " "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            // Thiết lập tham số cho searchTerm
            if (searchTerm == null) {
                stmt.setNull(1, Types.NVARCHAR);
                stmt.setNull(2, Types.NVARCHAR);
            } else {
                stmt.setNString(1, searchTerm);
                stmt.setNString(2, "%" + searchTerm + "%");
            }
            // Thiết lập tham số cho selectedStatus
            if (selectedStatus == null || selectedStatus.trim().isEmpty()) {
                stmt.setNull(3, Types.INTEGER);
                stmt.setNull(4, Types.INTEGER);
            } else {
                int status = Integer.parseInt(selectedStatus);
                stmt.setInt(3, status);
                stmt.setInt(4, status);
            }
            // Thiết lập tham số phân trang
            int offset = (pageNumber - 1) * pageSize;
            stmt.setInt(5, offset);
            stmt.setInt(6, pageSize);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setFullName(rs.getString("full_name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setStatus(rs.getBoolean("status"));
                    customers.add(customer);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Tính tổng số bản ghi khách hàng theo điều kiện tìm kiếm và trạng thái
    public int getTotalCustomerCount(String searchTerm, String selectedStatus) {
        int count = 0;
        String sql = "SELECT COUNT(*) AS total "
                + "FROM Customers "
                + "WHERE (? IS NULL OR full_name LIKE ?) "
                + "AND (? IS NULL OR status = ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            if (searchTerm == null) {
                stmt.setNull(1, Types.NVARCHAR);
                stmt.setNull(2, Types.NVARCHAR);
            } else {
                stmt.setNString(1, searchTerm);
                stmt.setNString(2, "%" + searchTerm + "%");
            }
            if (selectedStatus == null || selectedStatus.trim().isEmpty()) {
                stmt.setNull(3, Types.INTEGER);
                stmt.setNull(4, Types.INTEGER);
            } else {
                int status = Integer.parseInt(selectedStatus);
                stmt.setInt(3, status);
                stmt.setInt(4, status);
            }
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    count = rs.getInt("total");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public Customer getCustomerProfile(int customerId) {
        Customer customer = null;
        String sql = "SELECT customer_id AS UserID, "
                + "full_name AS UserName, "
                + "email, "
                + "address, "
                + "phone, "
                + "profile_picture AS ProfilePicture, "
                + "status AS AccountStatus "
                + "FROM Customers "
                + "WHERE customer_id = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    customer = new Customer();
                    customer.setCustomerId(rs.getInt("UserID"));
                    customer.setFullName(rs.getString("UserName"));
                    customer.setEmail(rs.getString("email"));
                    customer.setAddress(rs.getString("address"));
                    customer.setPhone(rs.getString("phone"));
                    // Vì trong database đã lưu URL đầy đủ, nên gán trực tiếp
                    customer.setProfilePicture(rs.getString("ProfilePicture"));
                    customer.setStatus(rs.getBoolean("AccountStatus"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    /**
     * Cập nhật trạng thái tài khoản của khách hàng dựa theo customerId. Nếu
     * active = true → status = 1 (Active), ngược lại → status = 0 (Inactive)
     */
    public boolean updateAccountStatus(int customerId, boolean active) {
        String sql = "UPDATE Customers SET status = ? WHERE customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Dùng setInt để cập nhật giá trị 1 (active) hoặc 0 (inactive)
            ps.setInt(1, active ? 1 : 0);
            ps.setInt(2, customerId);
            int updatedRows = ps.executeUpdate();
            System.out.println("updateAccountStatus: customerId = " + customerId + ", active = " + active + ", updatedRows = " + updatedRows);
            return updatedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật thông tin cá nhân của khách hàng (không thay đổi các trường khác như status)
    public void updateCustomerInfo(Customer customer) {
        String sql = "UPDATE Customers SET full_name = ?, email = ?, address = ?, phone = ? WHERE customer_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, customer.getFullName());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getPhone());
            ps.setInt(5, customer.getCustomerId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
