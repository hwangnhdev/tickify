<%-- 
    Document   : changePassword
    Created on : Jan 26, 2025, 11:49:12 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Forget Password Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

        <style>
            @import url('https://fonts.googleapis.com/css?family=Montserrat:400,800');

            * {
                box-sizing: border-box;
            }

            body {
                background: rgb(0, 0, 0);
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                font-family: 'Montserrat', sans-serif;
                height: 100vh;
                margin: 0;
            }

            h1 {
                color: #fff;
                font-weight: bold;
                margin: 0;
                margin-bottom: 46px;
            }

            h2 {
                text-align: center;
            }

            p {
                font-size: 14px;
                font-weight: 100;
                line-height: 20px;
                letter-spacing: 0.5px;
                margin: 20px 0 30px;
            }

            span {
                font-size: 12px;
            }

            a {
                color: #333;
                font-size: 14px;
                text-decoration: none;
                margin: 15px 0;
            }

            button {
                border-radius: 20px;
                border: 1px solid rgb(45, 194, 117);
                background-color: rgb(45, 194, 117);
                color: #FFFFFF;
                font-size: 12px;
                font-weight: bold;
                padding: 12px 45px;
                letter-spacing: 1px;
                text-transform: uppercase;
                transition: transform 80ms ease-in;
            }

            button:active {
                transform: scale(0.95);
            }

            button:focus {
                outline: none;
            }

            button:hover {
                transition: all 0.2s ease-in;
                border: 1px solid rgb(45, 194, 117);
                background-color: rgb(45, 194, 117);
                cursor: pointer;
            }

            button.ghost {
                background-color: transparent;
                border-color: #FFFFFF;
            }

            form {
                background-color: rgb(39, 39, 42);
                display: flex;
                align-items: center;
                justify-content: center;
                flex-direction: column;
                padding: 0 50px;
                height: 100%;
                text-align: center;
            }

            input {
                background-color: #eee;
                border: none;
                padding: 12px 15px;
                margin: 8px 0;
                width: 100%;
            }

            input:last-child {
                background: #000;
            }

            input[readonly] {
                background-color: #e9ecef;
                cursor: not-allowed;
            }

            input:focus-visible {
                outline: none;
                border: none;
            }

            .password-container {
                position: relative;
                background-color: #eee;
                border: none;
                margin: 8px 0;
                width: 100%;
            }

            .password-container input {
                margin: 0;
            }

            .toggle-password {
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                cursor: pointer;
                font-size: 18px;
            }

            .container {
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 14px 28px rgba(0, 0, 0, 0.25),
                    0 10px 10px rgba(0, 0, 0, 0.22);
                position: relative;
                overflow: hidden;
                width: 550px;
                max-width: 100%;
                min-height: 480px;
            }

            .form-container {
                position: absolute;
                top: 0;
                height: 100%;
                transition: all 0.6s ease-in-out;
            }

            .log-in-container {
                left: 0;
                width: 100%;
                z-index: 2;
            }

            .container.right-panel-active .log-in-container {
                transform: translateX(100%);
            }

            @keyframes show {

                0%,
                49.99% {
                    opacity: 0;
                    z-index: 1;
                }

                50%,
                100% {
                    opacity: 1;
                    z-index: 5;
                }
            }
        </style>
    </head>

    <body>
        <div class="container" id="container">
            <!-- Reset Password Form -->
            <div class="form-container log-in-container">
                <form action="<%= request.getContextPath()%>/resetPassword" method="post">
                    <h1>Reset Password</h1>

                    <!-- Hidden Input -->
                    <input type="hidden" name="action" value="resetPassword"/>
                    <input type="email" name="email" value="${email}" readonly/>

                    <!-- New Password -->
                    <div class="password-container">
                        <input type="password" placeholder="New Password" name="newPassword" required>
                        <span class="toggle-password">
                            <i class="fa-regular fa-eye"></i>
                        </span>
                    </div>

                    <!-- Confirm Password -->
                    <div class="password-container">
                        <input type="password" placeholder="Confirm Password" name="confirmPassword" required>
                        <span class="toggle-password">
                            <i class="fa-regular fa-eye"></i>
                        </span>
                    </div>

                    <!-- Submit Button -->
                    <button style="margin-top: 34px">Save Password</button>
                </form>
            </div>
        </div>

        <script>
            const togglePasswordIcons = document.querySelectorAll('.toggle-password');

            togglePasswordIcons.forEach(toggle => {
                toggle.addEventListener('click', function () {
                    const passwordField = this.previousElementSibling;
                    const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordField.setAttribute('type', type);

                    // Toggle the icon
                    if (type === 'password') {
                        this.innerHTML = '<i class="fa-regular fa-eye"></i>';
                    } else {
                        this.innerHTML = '<i class="fa-regular fa-eye-slash"></i>';
                    }
                });
            });


            const signUpButton = document.getElementById('signUp');
            const signInButton = document.getElementById('signIn');
            const container = document.getElementById('container');

            signUpButton.addEventListener('click', () => {
                container.classList.add("right-panel-active");
            });

            signInButton.addEventListener('click', () => {
                container.classList.remove("right-panel-active");
            });
        </script>
    </body>
</html>
