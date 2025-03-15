<%-- 
    Document   : login
    Created on : Mar 12, 2025, 3:45:53 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Login</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            .error {
                color: red;
                font-size: 0.875rem;
                margin-top: 4px;
                display: none;
            }
            
            input {
                background-color: #eee;
                border: none;
                padding: 12px 15px;
                margin: 8px 0;
                width: 100%;
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
                color: black;
            }
        </style>
    </head>
    <body class="bg-black flex items-center justify-center min-h-screen">
        <div class="w-full max-w-sm p-6 bg-gray-800 rounded-lg shadow-md">
            <h2 class="text-2xl font-bold text-center text-green-500 mb-6">
                Admin Login
            </h2>
            <form id="adminLoginForm" action="<%= request.getContextPath()%>/adminLogin" method="post">
                <div class="mb-4">
                    <label class="block text-green-500 text-sm font-bold mb-2" for="email">
                        Email
                    </label>
                    <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" 
                           id="email" name="email" placeholder="Email" type="email"/>
                    <p id="emailError" class="error">Email không hợp lệ!</p>
                </div>
                <div class="mb-6">
                    <label class="block text-green-500 text-sm font-bold mb-2" for="password">
                        Password
                    </label>
                    <div class="password-container">
                        <input class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 mb-3 leading-tight focus:outline-none focus:shadow-outline" 
                               id="password" name="password" placeholder="Password" type="password"/>
                        <span class="toggle-password">
                            <i class="fa-regular fa-eye"></i>
                        </span>
                    </div>
                    <p id="passwordError" class="error">Mật khẩu phải có ít nhất 8 ký tự, gồm chữ hoa, chữ thường, số và ký tự đặc biệt.</p>
                </div>
                <div class="flex items-center justify-between">
                    <button class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline" type="submit">
                        Log In
                    </button>
                    <a class="inline-block align-baseline font-bold text-sm text-green-500 hover:text-green-700" href="#">
                        Forgot Password?
                    </a>
                </div>
            </form>
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

            document.addEventListener("DOMContentLoaded", function () {
                const form = document.getElementById("adminLoginForm");
                const emailInput = document.getElementById("email");
                const passwordInput = document.getElementById("password");
                const emailError = document.getElementById("emailError");
                const passwordError = document.getElementById("passwordError");

                function validateEmail(email) {
                    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                    return emailRegex.test(email);
                }

                function validatePassword(password) {
                    const passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
                    return passwordRegex.test(password);
                }

                form.addEventListener("submit", function (event) {
                    let isValid = true;

                    // Kiểm tra email
                    if (!validateEmail(emailInput.value.trim())) {
                        emailError.style.display = "block";
                        isValid = false;
                    } else {
                        emailError.style.display = "none";
                    }

                    // Kiểm tra mật khẩu
                    if (!validatePassword(passwordInput.value.trim())) {
                        passwordError.style.display = "block";
                        isValid = false;
                    } else {
                        passwordError.style.display = "none";
                    }

                    if (!isValid) {
                        event.preventDefault();
                    }
                });

                // Ẩn lỗi khi người dùng nhập đúng
                emailInput.addEventListener("input", () => {
                    if (validateEmail(emailInput.value.trim())) {
                        emailError.style.display = "none";
                    }
                });

                passwordInput.addEventListener("input", () => {
                    if (validatePassword(passwordInput.value.trim())) {
                        passwordError.style.display = "none";
                    }
                });
            });

        </script>
    </body>
</html>

