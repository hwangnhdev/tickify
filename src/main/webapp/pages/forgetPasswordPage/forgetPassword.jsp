<%-- 
    Document   : forgetPassword
    Created on : Jan 26, 2025, 11:50:24 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ taglib prefix="noti" uri="http://example.com/notification" %>--%>
<%--<%@ taglib prefix="noti" uri="/WEB-INF/tags/notificationTag.tld" %>--%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Input Email Page</title>
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
            <div class="form-container log-in-container">
                <form action="<%= request.getContextPath()%>/verifyEmail" method="post">
                    <h1>Input your Email</h1>

                    <!--Input-->
                    <input type="hidden" name="action" value="forgetPassword"/>
                    <input type="email" placeholder="Email" name="email" required/>
                    <button style="margin-top: 34px" >Send OTP</button>
                </form>
            </div>
        </div>
    </body>
</html>
