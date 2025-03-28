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
                min-height: 100vh;
                background-color: #fff;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .profile-container {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
                width: 90%;
                max-width: 420px;
                padding: 30px;
                position: relative;
                border: 1px solid #e0e0e0;
                margin-top: 60px;
            }

            .close-btn {
                position: absolute;
                top: 15px;
                left: 15px;
                cursor: pointer;
                transition: transform 0.2s ease;
            }

            .close-btn:hover {
                transform: scale(1.1);
            }

            .profile-picture {
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
                padding-bottom: 25px;
            }

            .profile-picture img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 0px;
                background-color: #fff;
            }

            .profile-picture label {
                position: absolute;
                bottom: 5px;
                right: 35%;
                background-color: #2dc275;
                border-radius: 50%;
                width: 32px;
                height: 32px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: white;
                cursor: pointer;
                transition: background-color 0.3s ease;
                font-size: 18px;
            }

            .profile-picture label:hover {
                background-color: #45a049;
            }

            .profile-picture input[type="file"] {
                display: none;
            }

            .form-wrapper {
                text-align: left;
                padding-top: 10px;
            }

            label {
                font-weight: 600;
                font-size: 14px;
                line-height: 20px;
                color: #2a2d34;
                display: block;
            }

            .profile-container input[type="text"],
            .profile-container input[type="email"],
            .profile-container input[type="date"]{
                font-family: 'Inter', sans-serif;
                width: 100%;
                padding: 10px;
                margin-bottom: 10px;
                border-radius: 6px;
                border: 1px solid #d1d5db;
                background-color: #f9fafb;
                font-size: 14px;
                color: #2a2d34;
                box-sizing: border-box;
                transition: border-color 0.2s ease;
            }

            .profile-container input[type="text"]:focus,
            .profile-container input[type="email"]:focus,
            .profile-container input[type="date"]:focus {
                outline: none;
                border-color: #2dc275;
            }

            .profile-container input[disabled] {
                background-color: #e5e7eb;
                color: #6b7280;
                cursor: not-allowed;
            }
            
            .profile-container gender-group {
                text-align: left;
                margin: 10px 0;
            }
            .profile-container gender-group label {
                margin-right: 10px;
            }

            .submit-btn {
                background-color: #2dc275;
                color: white;
                padding: 12px;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                width: 100%;
                font-weight: 600;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .submit-btn:hover {
                background-color: #45a049;
            }

            .change-password-link {
                display: block;
                text-align: center;
                margin-top: 15px;
                color: #2dc275;
                font-size: 14px;
                font-weight: 600;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .change-password-link:hover {
                color: #45a049;
            }

            /* Popup Styles */
            .popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.2);
                z-index: 2000;
                text-align: center;
                width: 300px;
            }

            .popup.success {
                border: 2px solid #2dc275;
            }

            .popup h3 {
                margin: 0 0 10px;
                color: #2a2d34;
                font-size: 18px;
                font-weight: 600;
            }

            .popup p {
                margin: 0 0 15px;
                color: #666;
                font-size: 14px;
            }

            .popup button {
                background-color: #2dc275;
                color: white;
                padding: 8px 20px;
                border: none;
                border-radius: 20px;
                cursor: pointer;
                font-weight: 600;
                transition: background-color 0.3s ease;
            }

            .popup button:hover {
                background-color: #45a049;
            }

            .popup-backdrop {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1900;
            }

            @media (max-width: 480px) {
                .profile-container {
                    width: 95%;
                    padding: 20px;
                    margin-top: 100px;
                }
                .profile-picture img {
                    width: 90px;
                    height: 90px;
                }
                .profile-picture label {
                    right: 30%;
                    width: 28px;
                    height: 28px;
                    font-size: 16px;
                }
                .popup {
                    width: 90%;
                    max-width: 280px;
                }
            }
        </style>
    </head>
    <%
        Customer profile = (Customer) request.getAttribute("profile");
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>
    <body>
        <jsp:include page="../../components/header.jsp"></jsp:include>

            <div class="profile-container">
                <div class="close-btn" onclick="window.location.href = 'event';" aria-label="Close profile">
                    <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M15 3L3 15M3 3l12 12" stroke="#2A2D34" stroke-width="2" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>
                    </svg>
                </div>

                <form action="profile" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                    <div class="profile-picture">
                        <img name="profile_picture" id="profile_picture" src="<%= profile.getProfilePicture() != null && !profile.getProfilePicture().isEmpty() ? profile.getProfilePicture() : "default-avatar.jpg"%>" alt="Profile Picture" />
                    <label for="imageUpload">📷</label>
                    <input type="file" id="imageUpload" name="profile_picture" accept="image/*" onchange="previewImage(event)" />
                </div>

                <div class="form-wrapper">
                    <input type="hidden" name="customerId" value="<%= profile.getCustomerId()%>" />

                    <label for="fullname">Full Name</label>
                    <input type="text" id="fullname" name="fullname" maxlength="50" value="<%= profile.getFullName()%>" required />

                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" maxlength="40" value="<%= profile.getEmail()%>" disabled />

                    <label for="address">Address</label>
                    <input type="text" id="address" name="address" maxlength="80" value="<%= profile.getAddress() != null ? profile.getAddress() : ""%>" />

                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone" pattern="[0-9]{10}" maxlength="10" value="<%= profile.getPhone() != null ? profile.getPhone() : ""%>" placeholder="10 digits only" required />

                    <label for="dob">Date of Birth</label>
                    <input type="date" id="dob" name="dob" value="<%= profile.getDob() != null ? profile.getDob() : ""%>" />

                    <div class="gender-group">
                        <label>Gender</label>
                        <span><input type="radio" name="gender" value="male" <%= "male".equals(profile.getGender()) ? "checked" : ""%> /> Male</span> &nbsp;
                        <span><input type="radio" name="gender" value="female" <%= "female".equals(profile.getGender()) ? "checked" : ""%> /> Female</span> &nbsp;
                        <span><input type="radio" name="gender" value="others" <%= "others".equals(profile.getGender()) ? "checked" : ""%> /> Others</span>
                    </div>
                    </br>
                    <button type="submit" class="submit-btn">Complete</button>
                </div>
            </form>

            <a href="<%= request.getContextPath()%>/changePassword" class="change-password-link">Change Password</a>
        </div>

        <!-- Popup Notification -->
        <div class="popup-backdrop" id="popupBackdrop"></div>
        <div class="popup success" id="successPopup">
            <h3>Success!</h3>
            <p>Your profile has been updated successfully.</p>
            <button onclick="closePopup()">OK</button>
        </div>
        <div class="popup" id="errorPopup" style="border: 2px solid red;">
            <h3>Error!</h3>
            <p><%= errorMessage != null ? errorMessage : "Something went wrong."%></p>
            <button onclick="closeErrorPopup()">OK</button>
        </div>

        <script>
            // Preview uploaded image
            function previewImage(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('profile_picture').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            }

            // Form validation
            function validateForm() {
                const phone = document.getElementById('phone').value;
                const fullName = document.getElementById('fullname').value;
                const dob = document.getElementById('dob').value;
                const phonePattern = /^[0-9]{10}$/;

                if (!phonePattern.test(phone)) {
                    alert('Please enter a valid 10-digit phone number.');
                    return false;
                }
                if (fullName.trim() === '') {
                    alert('Full Name cannot be empty.');
                    return false;
                }
                if (dob) { 
                    const dobDate = new Date(dob);
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);

                    if (dobDate >= today) {
                        alert('Date of Birth must be earlier than today.');
                        return false;
                    }
                }
                return true;
            }

            // Popup functions
            function showPopup() {
                document.getElementById('successPopup').style.display = 'block';
                document.getElementById('popupBackdrop').style.display = 'block';
            }

            function closePopup() {
                document.getElementById('successPopup').style.display = 'none';
                document.getElementById('popupBackdrop').style.display = 'none';
                window.location.href = 'event';
            }
            
            // Check for success message or error message and show popup
            <% if (successMessage != null && !successMessage.isEmpty()) { %>
            showPopup();
            <% } %>
            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            showErrorPopup();
            <% }%>
        </script>
    </body>
</html>