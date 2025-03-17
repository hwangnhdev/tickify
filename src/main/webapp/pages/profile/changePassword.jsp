<%-- 
    Document   : changePassword
    Created on : 18 Feb 2025, 16:05:08
    Author     : Dinh Minh Tien CE190701
--%>
<%@page import="dals.CustomerDAO"%>
<%@ page import="models.Customer" %>
<%@ page import="models.CustomerAuth" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Change Password</title>
        <style>
            body {
                font-family: Inter, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f5f5f5;
            }
            .password-container {
                border-color: #fff;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
                width: 360px;
                padding: 20px;
                text-align: center;
                border-width: 0.8px;
                border-style: solid;
                position: relative;
            }
            input[type="password"] {
                font-family: Inter, sans-serif;
                width: 90%;
                padding: 12px;
                margin: 10px 0;
                border-radius: 4px;
                border-style: solid;
                border-width: 0.8px;
                border-radius: 5px;
                border-color: #FFFFFF;
                background-color: #f5f7fc;
                font-size: 14px;
                color: #2a2d34;
            }
            label {
                font-weight: 700;
                font-size: 14px;
                line-height: 16px;
            }
            form {
                margin-top: 20px;
                text-align: left;
            }
            .change-btn {
                background-color: #2dc275;
                color: white;
                padding: 10px;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                width: 100%;
                align-items: center;
                text-align: center;
                font-weight: 700;
                line-height: 18.4px;
                font-size: 16px;
            }
            .change-btn:hover {
                background-color: #45a049;
            }
            .close-btn {
                position: absolute;
                top: 17px; /* Adjust distance from the top */
                left: 17px; /* Move to the left side inside .profile-container */
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <div class="password-container">
            <div class="close-btn" onclick="window.location.href = 'event';" style="cursor: pointer;">
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M15 3L3 15M3 3l12 12" stroke="#2A2D34" stroke-width="2" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>
                </svg>
            </div>
            </br>
            <form action="change-password" method="post">
                <label>Current Password</label><br>
                <input type="password" name="currentPassword" required /><br><br>

                <label>New Password</label><br>
                <input type="password" name="newPassword" required /><br><br>

                <label>Confirm New Password</label><br>
                <input type="password" name="confirmPassword" required /><br><br>

                <button type="submit" class="change-btn" value="Change Password">Change Password</button>
            </form>
        </div>

        <p style="color:red;">
            <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : ""%>
        </p>

        <p style="color:green;">
            <%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : ""%>
        </p>
    </body>
</html>
