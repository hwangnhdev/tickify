/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class DBContext {

    public Connection connection;

    public DBContext() {
        try {
            String url = "jdbc:sqlserver://localhost:1433;databaseName=Tickify_version_2;trustServerCertificate=true";
            String username = "sa";
            String password = "admin";

            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (SQLException | ClassNotFoundException e) {
            System.out.println(e);
        }
    }

    public boolean isConnected() { // Check connect of sql with netbeans
        try {
            return connection != null && !connection.isClosed();
        } catch (SQLException e) {
            System.out.println(e);
            return false;
        }
    }

    public static void main(String[] args) { // Check connect of sql with netbeans
        DBContext dbContext = new DBContext();
        if (dbContext.isConnected()) {
            System.out.println("Connected Successfully!");
        } else {
            System.out.println("Connected Not Successfully!");
        }
    }
}
