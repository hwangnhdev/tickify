<%-- 
    Document   : footer
    Created on : Feb 11, 2025, 3:22:19 PM
    Author     : thanh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }
            .footer {
                background-color: #2d2f3b;
                color: #fff;
                padding: 55.5px 20px;
            }
            .footer-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                gap: 20px;
                margin-left: 160px;
            }
            .footer-section {
                flex: 1;
                min-width: 200px;
            }
            .footer-section h4 {
                font-size: 16px;
                margin-bottom: 10px;
            }
            .footer-section p,
            .footer-section ul,
            .footer-section form {
                font-size: 14px;
                line-height: 1.6;
            }
            .footer-section ul {
                list-style: none;
                padding: 0;
            }
            .footer-section ul li a {
                color: #fff;
                text-decoration: none;
            }
            .footer-section ul li a:hover {
                text-decoration: underline;
            }
            .hotline-number {
                font-size: 18px;
                font-weight: bold;
                color: #00a651;
            }
            .subscribe-form {
                display: flex;
                gap: 10px;
            }
            .subscribe-form input {
                padding: 8px;
                flex: 1;
                border: none;
                border-radius: 4px;
            }
            .subscribe-form button {
                background-color: #00a651;
                border: none;
                color: #fff;
                padding: 8px 12px;
                border-radius: 4px;
                cursor: pointer;
            }
            .footer-bottom {
                margin-top: 40px;
                font-size: 12px;
                text-align: center;
                color: #ccc;
                margin-bottom: 0px;
            }
        </style>
    </head>
    <body>
        <footer class="footer">
            <div class="footer-container">
                <div class="footer-section">
                    <h4>Hotline</h4>
                    <p>Monday - Friday (8:30 AM - 6:30 PM)</p>
                    <p class="hotline-number">1900.6408</p>
                    <p>Email: support@tickìy.vn</p>
                    <p>Office: FPT Nguyen Van Cu, Thanh Pho Can Tho</p>
                </div>
                <div class="footer-section">
                    <h4>For Customer</h4>
                    <ul>
                        <li><a href="#">Customer terms of use</a></li>
                        <li><a href="#">Organizer terms of use</a></li>
                    </ul>
                    <h4>Subscribe to our hottest events</h4>
                    <form class="subscribe-form">
                        <input type="email" placeholder="Your Email" />
                        <button type="submit">→</button>
                    </form>
                </div>
                <div class="footer-section">
                    <h4>Our Company</h4>
                    <ul>
                        <li><a href="#">Operational regulations</a></li>
                        <li><a href="#">Information privacy policy</a></li>
                        <li><a href="#">Dispute settlement policy</a></li>
                        <li><a href="#">Payment privacy policy</a></li>
                        <li><a href="#">Return and inspection policy</a></li>
                        <li><a href="#">Shipping and delivery conditions</a></li>
                        <li><a href="#">Payment methods</a></li>
                    </ul>
                </div>
            </div>
            <div class="footer-bottom">
                <p>Tickìy Co., Ltd ©</p>
                <p>Legal representative: Group 3 FPT</p>
                <p>Address: FPT Nguyen Van Cu, Thanh Pho Can Tho</p>
            </div>
        </footer>
    </body>
</html>
