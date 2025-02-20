<%-- 
    Document   : submitOTP
    Created on : Jan 26, 2025, 11:49:37 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Font Awesome CDN  -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css"
          integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog=="
          crossorigin="anonymous" />
    <!-- CSS -->
    <!--<link rel="stylesheet" href="otp.css">-->
    <title>OTP Field Form - Coding Torque</title>

    <style>
        body {
            margin: 0;
            font-family: "Poppins", sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
            background: #282a36;
            height: 100vh;
            color: #fff;
        }

        .otp-field {
            display: flex;
        }

        .otp-field input {
            width: 24px;
            font-size: 32px;
            padding: 10px;
            text-align: center;
            border-radius: 5px;
            margin: 2px;
            border: 2px solid #55525c;
            background: #21232d;
            font-weight: bold;
            color: #fff;
            outline: none;
            transition: all 0.1s;
        }

        .otp-field input:focus {
            border: 2px solid #a527ff;
            box-shadow: 0 0 2px 2px #a527ff6a;
        }

        .disabled {
            opacity: 0.5;
        }

        .space {
            margin-right: 1rem !important;
        }
    </style>
</head>
<body>
    <!-- Further code here -->
    <form id="otpForm" action="<%= request.getContextPath()%>/verifyOtp" method="POST">
        <input type="hidden" name="otp" id="otpInput">
        <p>OTP sent on ${sessionScope.userForgetPassword.getEmail()}</p>
        <h1>Enter OTP</h1>
        <div class="otp-field">
            <input type="text" maxlength="1" />
            <input type="text" maxlength="1" />
            <input type="text" maxlength="1" />
            <input type="text" maxlength="1" />
            <input type="text" maxlength="1" />
            <input type="text" maxlength="1" />
        </div>
        <button type="submit" style="display: none;">Submit OTP</button>
    </form>

    <script>
        const inputs = document.querySelectorAll(".otp-field input");
        const otpInput = document.getElementById("otpInput");
        const otpForm = document.getElementById("otpForm");

        inputs.forEach((input, index) => {
            input.dataset.index = index;
            input.addEventListener("keyup", handleOtp);
            input.addEventListener("paste", handleOnPasteOtp);
        });

        function handleOtp(e) {
            const input = e.target;
            let value = input.value;
            let isValidInput = value.match(/[0-9]/); // Chỉ cho phép số từ 0-9
            input.value = isValidInput ? value[0] : ""; // Lấy ký tự đầu tiên nếu đúng

            let fieldIndex = input.dataset.index;
            if (fieldIndex < inputs.length - 1 && isValidInput) {
                input.nextElementSibling.focus(); // Chuyển sang ô tiếp theo nếu nhập đúng
            }

            if (fieldIndex == inputs.length - 1 && isValidInput) {
                submitOtp(); // Gửi OTP khi nhập xong
            }

            if (e.key === "Backspace" && fieldIndex > 0) {
                input.previousElementSibling.focus(); // Chuyển về ô trước nếu xoá
            }
        }

        function handleOnPasteOtp(e) {
            const data = e.clipboardData.getData("text");
            const value = data.split("");
            if (value.length === inputs.length) {
                inputs.forEach((input, index) => (input.value = value[index]));
                submitOtp();
            }
        }

        function submitOtp() {
            let otp = "";
            inputs.forEach(input => {
                otp += input.value;
            });
            otpInput.value = otp; // Gán OTP vào input ẩn trong form
            otpForm.submit(); // Gửi form
        }
    </script>
</body>
</html>
