<%-- 
    Document   : changePassword
    Created on : 18 Feb 2025, 16:05:08
    Author     : Dinh Minh Tien CE190701
--%>
<%@page import="dals.CustomerDAO"%>
<%@ page import="models.Customers" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Change Password</title>
    </head>
    <body>
        <h2>Change Password</h2>

        <form action="change-password" method="post">
            <label>Current Password:</label><br>
            <input type="password" name="currentPassword" required /><br><br>

            <label>New Password:</label><br>
            <input type="password" name="newPassword" required /><br><br>

            <label>Confirm New Password:</label><br>
            <input type="password" name="confirmPassword" required /><br><br>

            <button type="submit">Change Password</button>
        </form>

        <p style="color:red;">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : ""%>
        </p>

        <p style="color:green;">
            <%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : ""%>
        </p>
    </body>
</html>
