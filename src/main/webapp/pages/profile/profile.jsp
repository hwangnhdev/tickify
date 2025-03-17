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
                font-family: 'Inter', sans-serif;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh; /* Ensure full height */
                background-color: #f5f5f5;
                margin: 0;
                padding-top: 120px; /* Space for fixed header */
            }
            .profile-container {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                width: 90%; /* Responsive width */
                max-width: 400px; /* Max width for larger screens */
                padding: 25px;
                text-align: center;
                border: 1px solid #e0e0e0;
                position: relative;
            }
            .profile-picture {
                position: relative;
                margin-bottom: 20px;
                display: flex; /* Add this */
                justify-content: center; /* Center horizontally */
                align-items: center; /* Center vertically */
            }
            .profile-picture img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover; /* Ensure image fits nicely */
                border: 2px solid #2dc275;
            }
            .profile-picture input[type="file"] {
                display: none;
            }
            .profile-picture label {
                position: absolute;
                bottom: 0;
                right: 20px;
                background-color: #2dc275;
                border-radius: 50%;
                padding: 8px;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }
            .profile-picture label:hover {
                background-color: #45a049;
            }
            form {
                text-align: left;
            }
            label {
                font-weight: 700;
                font-size: 14px;
                line-height: 16px;
                color: #2a2d34;
                display: block;
                margin-bottom: 5px;
            }
            input[type="text"], input[type="email"], input[type="date"] {
                font-family: 'Inter', sans-serif;
                width: 100%;
                padding: 12px;
                margin-bottom: 15px;
                border-radius: 5px;
                border: 1px solid #d1d5db;
                background-color: #f5f7fc;
                font-size: 14px;
                color: #2a2d34;
                box-sizing: border-box;
            }
            input[disabled] {
                background-color: #e5e7eb;
                color: #6b7280;
                cursor: not-allowed;
            }
            .submit-btn {
                background-color: #2dc275;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                width: 100%;
                font-weight: 700;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }
            .submit-btn:hover {
                background-color: #45a049;
            }
            .close-btn {
                position: absolute;
                top: 15px;
                left: 15px;
                cursor: pointer;
                transition: transform 0.2s ease;
            }
            .close-btn:hover {
                transform: scale(1.2);
            }
            @media (max-width: 480px) {
                .profile-container {
                    width: 95%;
                    padding: 15px;
                }
                .profile-picture img {
                    width: 80px;
                    height: 80px;
                    align-items: center;
                }
            }
        </style>
    </head>
    <%
        Customer profile = (Customer) request.getAttribute("profile");
    %>
    <body>
        <jsp:include page="../../components/header.jsp"></jsp:include>

            <div class="profile-container">
                <div class="close-btn" onclick="window.location.href = 'event';" aria-label="Close profile">
                    <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M15 3L3 15M3 3l12 12" stroke="#2A2D34" stroke-width="2" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>
                    </svg>
                </div>

                <form action="profile" method="post" onsubmit="return validateForm();">
                    <input type="hidden" name="customerId" value="<%= profile.getCustomerId()%>" />

                <div class="profile-picture">
                    <img name="profile_picture" id="profile_picture" src="<%= profile.getProfilePicture() != null && !profile.getProfilePicture().isEmpty() ? profile.getProfilePicture() : "default-avatar.jpg"%>" alt="Profile Picture" />
                    <label for="imageUpload">📷</label>
                    <input type="file" id="imageUpload" name="image" accept="image/*" onchange="previewImage(event)" />
                </div>

                <label for="fullname">Full Name</label>
                <input type="text" id="fullname" name="fullname" maxlength="50" value="<%= profile.getFullName()%>" required />

                <label for="email">Email</label>
                <input type="email" id="email" name="email" maxlength="40" value="<%= profile.getEmail()%>" disabled />

                <label for="address">Address</label>
                <input type="text" id="address" name="address" maxlength="80" value="<%= profile.getAddress() != null ? profile.getAddress() : ""%>" />

                <label for="phone">Phone Number</label>
                <input type="text" id="phone" name="phone" pattern="[0-9]{10}" maxlength="10" value="<%= profile.getPhone() != null ? profile.getPhone() : ""%>" placeholder="10 digits only" required />

                <button type="submit" class="submit-btn">Complete</button>
            </form>
        </div>

        <script>
            // Preview uploaded image
            function previewImage(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('profileImage').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            }

            // Form validation
            function validateForm() {
                const phone = document.getElementById('phone').value;
                const fullName = document.getElementById('fullname').value;
                const phonePattern = /^[0-9]{10}$/;

                if (!phonePattern.test(phone)) {
                    alert('Please enter a valid 10-digit phone number.');
                    return false;
                }
                if (fullName.trim() === '') {
                    alert('Full Name cannot be empty.');
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>