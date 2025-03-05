<%-- 
    Document   : my-profile
    Created on : 18 Feb 2025, 07:23:45
    Author     : Dinh Minh Tien CE190701
--%>

<%@page import="dals.CustomerDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Customer" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Profile</title>
        <style>
            body {
                font-family: Inter, sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f5f5f5;
            }
            .profile-container {
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
            .profile-picture {
                position: relative;
            }
            .profile-picture img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
            }
            .profile-picture .camera-icon {
                position: absolute;
                bottom: 0;
                right: 20px;
                background-color: #4CAF50;
                border-radius: 50%;
                padding: 5px;
                color: white;
                cursor: pointer;
            }
            form {
                margin-top: 20px;
                text-align: left;
            }

            label {
                font-weight: 700;
                font-size: 14px;
                line-height: 16px;
            }

            input[type="text"], input[type="email"], input[type="date"] {
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
            input[disabled] {
                background-color: #f5f7fc;
                color: #afb8c9;
            }
            .gender-group {
                text-align: left;
                margin: 10px 0;
            }
            .gender-group label {
                margin-right: 10px;
            }
            .submit-btn {
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
            .submit-btn:hover {
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
    <%
        Customer profile = (Customer) request.getAttribute("profile");
    %>

    <body>
        <div class="profile-container">
            <div class="close-btn" onclick="window.location.href = 'event';" style="cursor: pointer;">
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M15 3L3 15M3 3l12 12" stroke="#2A2D34" stroke-width="2" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>
                </svg>
            </div>
            </br>

            <form action="profile" method="post">
                <input type="hidden" name="customerId" value="<%= profile.getCustomerId()%>" />

                <div class="profile-picture">
                    <label class="camera-icon">
                        <input type="file" style="display: none;" />
                        📷
                    </label>
                </div>
                
                <label>Full Name</label>
                <input type="text" name="fullname" maxlength="50" value="<%= profile.getFullName()%>" />

                <label>Email</label>
                <input type="text" name="email" maxlength="40" value="<%= profile.getEmail()%>" disabled />

                <label>Address</label>
                <input type="text" name="address" maxlenght="80" value="<%= profile.getAddress()%>"/>

                <label>Phone Number</label>
                <input type="text" name="phone" pattern="[0-9]*" maxlength="10" value="<%= profile.getPhone()%>" />

                <button type="submit" class="submit-btn" value="Complete">Complete</button>

            </form>
        </div>
    </body>
</html>
