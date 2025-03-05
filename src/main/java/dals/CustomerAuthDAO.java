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
import models.CustomerAuth;
import utils.DBContext;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class CustomerAuthDAO extends DBContext {

    private static final String SELECT_ALL_CUSTOMERS_AUTH = "SELECT * FROM Customer_auths";
    private static final String SELECT_CUSTOMER_AUTH_BY_CUSTOMER_ID = "SELECT * FROM Customer_auths WHERE customer_id = ?";
    private static final String SELECT_CUSTOMER_AUTH_BY_CUSTOMER_ID_PROVIDER = "SELECT * FROM Customer_auths WHERE customer_id = ? AND auth_provider = ?";
    private static final String INSERT_CUSTOMER_AUTH = "INSERT INTO Customer_auths (customer_id, auth_provider, provider_id, password, created_at, updated_at) VALUES (?, ?, ?, ?, GETDATE(), GETDATE())";
    private static final String UPDATE_CUSTOMER_AUTH = "UPDATE Customer_auths SET auth_provider = ?, provider_id = ?, password = ?, updated_at = ? WHERE customer_auth_id = ?";
    private static final String UPDATE_CUSTOMER_AUTH_PASSWORD_BY_CUSTOMER_ID = "UPDATE Customer_auths SET password = ?, updated_at = GETDATE() WHERE customer_id = ? AND auth_provider = ?";

    private CustomerAuth mapResultSetToCustomer(ResultSet rs) throws SQLException {
        CustomerAuth customerAuth = new CustomerAuth();
        customerAuth.setCustomerAuthId(rs.getInt("customer_auth_id"));
        customerAuth.setCustomerId(rs.getInt("customer_id"));
        customerAuth.setAuthProvider(rs.getString("auth_provider"));
        customerAuth.setProviderId(rs.getString("provider_id"));
        customerAuth.setPassword(rs.getString("password"));
        customerAuth.setCreatedAt(rs.getTimestamp("created_at"));
        customerAuth.setUpdatedAt(rs.getTimestamp("updated_at"));
        return customerAuth;
    }

    public List<CustomerAuth> selectAllCustomers() {
        List<CustomerAuth> customers = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_ALL_CUSTOMERS_AUTH);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return customers;
    }

    public CustomerAuth selectCustomerAuthById(int id) {
        CustomerAuth customerAuth = null;
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_CUSTOMER_AUTH_BY_CUSTOMER_ID);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                customerAuth = mapResultSetToCustomer(rs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return customerAuth;
    }

    public CustomerAuth selectCustomerAuthByIdProvider(int id, String provider) {
        CustomerAuth customerAuth = null;
        try {
            PreparedStatement st = connection.prepareStatement(SELECT_CUSTOMER_AUTH_BY_CUSTOMER_ID_PROVIDER);
            st.setInt(1, id);
            st.setString(2, provider);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                customerAuth = mapResultSetToCustomer(rs);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return customerAuth;
    }

    public boolean insertCustomerAuth(CustomerAuth customerAuth) {
        try {
            PreparedStatement st = connection.prepareStatement(INSERT_CUSTOMER_AUTH);
            st.setInt(1, customerAuth.getCustomerId());
            st.setString(2, customerAuth.getAuthProvider());
            st.setString(3, customerAuth.getProviderId());
            st.setString(4, customerAuth.getPassword());

            int rowsInserted = st.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public boolean updateCustomerAuth(CustomerAuth customerAuth) {
        try {
            PreparedStatement st = connection.prepareStatement(UPDATE_CUSTOMER_AUTH);
            st.setString(1, customerAuth.getAuthProvider());
            st.setString(2, customerAuth.getProviderId());
            st.setString(3, customerAuth.getPassword());
            st.setTimestamp(4, new Timestamp(customerAuth.getUpdatedAt().getTime()));
            st.setInt(5, customerAuth.getCustomerAuthId());

            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public boolean updateCustomerAuthPasswordByCustomerId(String password, int customerId, String provider) {
        try {
            PreparedStatement st = connection.prepareStatement(UPDATE_CUSTOMER_AUTH_PASSWORD_BY_CUSTOMER_ID);
            st.setString(1, password);
            st.setInt(2, customerId);
            st.setString(3, provider);

            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }
}
