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
import models.Category;
import utils.DBContext;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class CategoryDAO extends DBContext {

    private static final String GET_ALL_CATEGORY = "SELECT * FROM Categories";
    private static final String GET_ALL_CATEGORY_SEARCH = "SELECT * FROM Categories WHERE category_name LIKE ?";
    private static final String GET_CATEGORY_BY_NAME = "SELECT * FROM Categories WHERE category_name = ?";
    private static final String GET_CATEGORY_BY_ID = "SELECT * FROM Categories WHERE category_id = ?";
    private static final String CREATE_CATEGORY = "INSERT INTO Categories (category_name, description, created_at) VALUES (?, ?, GETDATE())";
    private static final String UPDATE_CATEGORY = "UPDATE Categories SET category_name = ?, description = ?, updated_at = GETDATE() WHERE category_id = ?";
    private static final String DELETE_CATEGORY = "DELETE Categories WHERE category_id = ?";

    private Category mapResultSetToCategory(ResultSet rs) throws SQLException {
        Category category = new Category(
                rs.getInt("category_id"),
                rs.getString("category_name"),
                rs.getString("description"),
                rs.getTimestamp("created_at"),
                rs.getTimestamp("updated_at")
        );
        return category;
    }

    /*getCategoryByName*/
    public Category getCategoryByName(String categoryName) {
        Category category = null;
        try {
            PreparedStatement st = connection.prepareStatement(GET_CATEGORY_BY_NAME);
            st.setString(1, categoryName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                category = mapResultSetToCategory(rs);
                return category;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }
        return null;
    }

    /*getCategoryByName*/
    public Category getCategoryByID(int categoryID) {
        Category category = null;
        try {
            PreparedStatement st = connection.prepareStatement(GET_CATEGORY_BY_ID);
            st.setInt(1, categoryID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                category = mapResultSetToCategory(rs);
                return category;
            }
        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }
        return null;
    }

    /*getAllCategories*/
    public List<Category> getAllCategories() {
        List<Category> listCategories = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(GET_ALL_CATEGORY);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                listCategories.add(mapResultSetToCategory(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }
        return listCategories;
    }

    /*createCategory*/
    public void createCategory(Category category) {
        try {
            PreparedStatement st = connection.prepareStatement(CREATE_CATEGORY);
            st.setString(1, category.getCategoryName());
            st.setString(2, category.getDescription());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }
    }

    /*updateCategory*/
    public void updateCategory(Category category) {
        try {
            PreparedStatement st = connection.prepareStatement(UPDATE_CATEGORY);
            st.setString(1, category.getCategoryName());
            st.setString(2, category.getDescription());
            st.setInt(3, category.getCategoryId());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }
    }

    /*deleteCategory*/
    public void deleteCategory(int categoryID) {
        try {
            PreparedStatement st = connection.prepareStatement(DELETE_CATEGORY);
            st.setInt(1, categoryID);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }
    }

    /*getCategoryByNameSearch*/
    public List<Category> getAllCategories(String query) {
        List<Category> listCategories = new ArrayList<>();
        try {
            PreparedStatement st = connection.prepareStatement(GET_ALL_CATEGORY_SEARCH);
            st.setString(1, "%" + query + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                listCategories.add(mapResultSetToCategory(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }
        return listCategories;
    }

    public static void main(String[] args) {
        CategoryDAO dao = new CategoryDAO();
        List<Category> cate = dao.getAllCategories("c");
        for (Category category : cate) {
            System.out.println(category.getCategoryName());
        }
    }
}
