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

    /*getCategoryByName*/
    public Category getCategoryByName(String categoryName) {
        String sql = "SELECT * FROM Categories\n"
                + "WHERE category_name = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, categoryName);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Category category = new Category(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("description"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                return category;
            }

        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }

        return null;
    }

    /*getCategoryByName*/
    public Category getCategoryByID(int categoryID) {
        String sql = "SELECT * FROM Categories\n"
                + "WHERE category_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, categoryID);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                Category category = new Category(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("description"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
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
        String sql = "SELECT * FROM Categories";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Category category = new Category(
                        rs.getInt("category_id"),
                        rs.getString("category_name"),
                        rs.getString("description"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
                listCategories.add(category);
            }

        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }

        return listCategories;
    }

    /*createCategory*/
    public void createCategory(Category category) {
        String sql = "INSERT INTO Categories (category_name, description, created_at)\n"
                + "VALUES (?, ?, GETDATE())";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, category.getCategoryName());
            st.setString(2, category.getDescription());
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }
    }

    /*updateCategory*/
    public void updateCategory(Category category) {
        String sql = "UPDATE Categories\n"
                + "SET category_name = ?,\n"
                + "    description = ?,\n"
                + "    updated_at = GETDATE()\n"
                + "WHERE category_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
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
        String sql = "DELETE Categories\n"
                + "WHERE category_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, categoryID);
            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error fetching: " + e.getMessage());
        }
    }

    public static void main(String[] args) {
        /*getCategoryByName*/
//        CategoryDAO categoryDAO = new CategoryDAO();
//        Category category = categoryDAO.getCategoryByName("Music");
//        System.out.println(category.getCategoryName());

        /*getAllCategories*/
//        CategoryDAO categoryDAO = new CategoryDAO();
//        List<Category> listCategories = categoryDAO.getAllCategories();
//        for (Category category : listCategories) {
//            System.out.println(category.getCategoryName());
//        }

        /*createCategory*/
//        CategoryDAO categoryDAO = new CategoryDAO();
//        Category category = new Category("Hiphop", "Hiphop never die");
//        categoryDAO.createCategory(category);

        /*updateCategory*/
//        CategoryDAO categoryDAO = new CategoryDAO();
//        Category category = new Category(11, "Hiphop", "Hiphop never die Love you never wrong");
//        categoryDAO.updateCategory(category);

        /*deleteCategory*/
//        CategoryDAO categoryDAO = new CategoryDAO();
//        categoryDAO.deleteCategory(11);
    }
}
