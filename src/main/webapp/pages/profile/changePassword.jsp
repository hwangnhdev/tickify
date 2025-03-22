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
                font-family: 'Inter', sans-serif;
                min-height: 100vh;
                background-color: #fff;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            .password-container {
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

            .password-container form {
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

            .password-container input[type="password"] {
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

            .password-container input[type="password"]:focus {
                outline: none;
                border-color: #2dc275;
            }

            .change-btn {
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

            .change-btn:hover {
                background-color: #45a049;
            }

            .error-text {
                color: red;
                font-size: 12px;
                margin-top: -8px;
                margin-bottom: 8px;
                display: none;
                text-align: left;
            }

            .input-error {
                border-color: #ff0000;
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
                .password-container {
                    width: 95%;
                    padding: 20px;
                    margin-top: 100px;
                }
                .popup {
                    width: 90%;
                    max-width: 280px;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="../../components/header.jsp"></jsp:include>

        <div class="password-container">
            <div class="close-btn" onclick="window.location.href = 'profile';" style="cursor: pointer;">
                <svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M15 3L3 15M3 3l12 12" stroke="#2A2D34" stroke-width="2" stroke-miterlimit="10" stroke-linecap="round" stroke-linejoin="round"></path>
                </svg>
            </div>

            <form action="changePassword" method="post" onsubmit="return validateForm()">
                <label>Current Password</label>
                <input type="password" name="currentPassword" id="currentPassword" required />
                <div id="currentPasswordError" class="error-text"></div>

                <label>New Password</label>
                <input type="password" name="newPassword" id="newPassword" required />
                <div id="newPasswordError" class="error-text">Password must be at least 8 characters, include uppercase, lowercase, number, and special character</div>

                <label>Confirm New Password</label>
                <input type="password" name="confirmPassword" id="confirmPassword" required />
                <div id="confirmPasswordError" class="error-text">Passwords do not match</div>

                <button type="submit" class="change-btn">Change Password</button>
            </form>
        </div>

        <!-- Popup Notification -->
        <div class="popup-backdrop" id="popupBackdrop"></div>
        <div class="popup success" id="successPopup">
            <h3>Success!</h3>
            <p>Your password has been changed successfully.</p>
            <button onclick="closePopup()">OK</button>
        </div>

        <script>
            // Retrieve server-side messages
            const successMessage = "<%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : "" %>";
            const errorMessage = "<%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>";

            function validateForm() {
                let isValid = true;
                const currentPassword = document.getElementById('currentPassword');
                const newPassword = document.getElementById('newPassword');
                const confirmPassword = document.getElementById('confirmPassword');

                // Reset error states
                resetErrors();

                // Password strength regex: at least 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character
                const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;

                // Validate current password
                if (!currentPassword.value) {
                    showError('currentPassword', 'currentPasswordError', 'Please enter your current password');
                    isValid = false;
                }

                // Validate new password strength
                if (!passwordRegex.test(newPassword.value)) {
                    showError('newPassword', 'newPasswordError');
                    isValid = false;
                }

                // Validate password confirmation
                if (newPassword.value !== confirmPassword.value) {
                    showError('confirmPassword', 'confirmPasswordError');
                    isValid = false;
                }

                return isValid;
            }

            function showError(inputId, errorId, customMessage = null) {
                const input = document.getElementById(inputId);
                const error = document.getElementById(errorId);
                input.classList.add('input-error');
                error.style.display = 'block';
                if (customMessage) {
                    error.textContent = customMessage;
                }
            }

            function resetErrors() {
                const inputs = document.querySelectorAll('input[type="password"]');
                const errors = document.querySelectorAll('.error-text');

                inputs.forEach(input => input.classList.remove('input-error'));
                errors.forEach(error => {
                    error.style.display = 'none';
                });
            }

            // Popup functions
            function showPopup() {
                document.getElementById('successPopup').style.display = 'block';
                document.getElementById('popupBackdrop').style.display = 'block';
            }

            function closePopup() {
                document.getElementById('successPopup').style.display = 'none';
                document.getElementById('popupBackdrop').style.display = 'none';
                window.location.href = 'profile'; // Redirect to profile page
            }

            // Real-time validation
            document.querySelectorAll('input[type="password"]').forEach(input => {
                input.addEventListener('input', validateForm);
            });

            // Show popup if success message exists
            if (successMessage) {
                showPopup();
            }

            // Show alert if error message exists (optional, can be replaced with popup if desired)
            if (errorMessage) {
                alert(errorMessage);
            }
        </script>
    </body>
</html>