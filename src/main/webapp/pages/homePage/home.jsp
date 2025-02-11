<%-- 
    Document   : homePage
    Created on : Jan 12, 2025, 2:49:46 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /* Reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Body Styles */
            body {
                font-family: 'Arial', sans-serif;
                line-height: 1.6;
                color: #333;
                background-color: #f9f9f9;
            }

            /* Container */
            .container {
                width: 90%;
                max-width: 1200px;
                margin: 0 auto;
            }

            /* Banner Section */
            .banner {
                position: relative;
                margin: 20px 0;
                width: 100%;
                overflow: hidden;
            }

            .banner-slider {
                display: flex;
                transition: transform 0.5s ease-in-out;
            }

            .banner-item {
                flex: 0 0 100%;
                position: relative;
                display: none; /* Ẩn tất cả các banner ban đầu */
            }

            .banner-item.active {
                display: block; /* Chỉ hiển thị banner đang active */
            }

            .banner-image {
                width: 100%;
                height: 400px; /* Đặt chiều cao cố định */
                object-fit: cover; /* Giữ tỷ lệ ảnh */
                border-radius: 10px;
            }

            .banner-content {
                position: absolute;
                bottom: 20px;
                left: 20px;
                color: white;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
                background-color: rgba(0, 0, 0, 0.4);
                padding: 10px;
                border-radius: 5px;
            }

            .banner-content h2 {
                font-size: 28px;
            }

            .banner-content span {
                color: #f9d342;
            }

            .banner-controls {
                position: absolute;
                top: 50%;
                left: 0;
                width: 100%;
                display: flex;
                justify-content: space-between;
                transform: translateY(-50%);
            }

            .banner-controls button {
                background-color: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                padding: 10px;
                cursor: pointer;
                border-radius: 50%;
                font-size: 18px;
            }

            .banner-controls button:hover {
                background-color: rgba(0, 0, 0, 0.8);
            }

            /* Events Section */
            .events {
                background-color: #fff;
                padding: 40px 0;
            }

            .section-title {
                text-align: center;
                margin-bottom: 20px;
                font-size: 24px;
                color: #333;
            }

            .event-grid {
                display: flex;
                gap: 20px;
                justify-content: center;
                flex-wrap: wrap;
            }

            .event-card {
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                width: 300px;
            }

            .event-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
            }

            .event-info {
                padding: 15px;
                text-align: center;
            }

            .event-info h3 {
                margin-bottom: 10px;
                font-size: 18px;
            }

            .event-info p {
                color: #1dbf73;
                font-weight: bold;
            }

            /* Footer */
            .footer {
                background-color: #333;
                color: white;
                text-align: center;
                padding: 20px 0;
            }

        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="../../components/header.jsp"></jsp:include>

        <section class="banner">
            <div class="banner-slider">
                <div class="banner-item active">
                    <img src="https://ticketbox.vn/kich-idecaf-thuoc-dang-da-tat-86287?utm_medium=mkt-rcm-events&utm_source=tkb-homepage" alt="2NE1 Asia Tour" class="banner-image">
                    <div class="banner-content">
                        <h2>WELCOME BACK <span>2NE1</span></h2>
                        <p>2024-25 Asia Tour</p>
                        <button class="btn btn-details">View Details</button>
                    </div>
                </div>
                <div class="banner-item">
                    <img src="https://ticketbox.vn/kich-idecaf-thuoc-dang-da-tat-86287?utm_medium=mkt-rcm-events&utm_source=tkb-homepage" alt="Simple Love" class="banner-image">
                    <div class="banner-content">
                        <h2>SIMPLE LOVE</h2>
                        <p>Babykun Concert</p>
                        <button class="btn btn-details">View Details</button>
                    </div>
                </div>
            </div>
            <div class="banner-controls">
                <button class="prev-btn">❮</button>
                <button class="next-btn">❯</button>
            </div>
        </section>

        <!-- Special Events Section -->
        <section class="events">
            <div class="container">
                <h2 class="section-title">Special Events</h2>
                <div class="event-grid">
                    <div class="event-card">
                        <img src="event1.jpg" alt="Event 1">
                        <div class="event-info">
                            <h3>Dưới bóng cây hạnh phúc</h3>
                            <p>From 500,000 VND</p>
                        </div>
                    </div>
                    <div class="event-card">
                        <img src="event2.jpg" alt="Event 2">
                        <div class="event-info">
                            <h3>Hòa nhạc cuối năm</h3>
                            <p>From 600,000 VND</p>
                        </div>
                    </div>
                    <div class="event-card">
                        <img src="event3.jpg" alt="Event 3">
                        <div class="event-info">
                            <h3>Giấc mơ đỏ</h3>
                            <p>From 400,000 VND</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="container footer-container">
                <p>© 2025 Ticketbox Co., Ltd. All Rights Reserved.</p>
            </div>
        </footer>

        <script>
            const banners = document.querySelectorAll('.banner-item');
            const prevBtn = document.querySelector('.prev-btn');
            const nextBtn = document.querySelector('.next-btn');
            let currentIndex = 0;

            function showBanner(index) {
                banners.forEach((banner, i) => {
                    banner.classList.toggle('active', i === index);
                });
            }

            function nextBanner() {
                currentIndex = (currentIndex + 1) % banners.length;
                showBanner(currentIndex);
            }

            function prevBanner() {
                currentIndex = (currentIndex - 1 + banners.length) % banners.length;
                showBanner(currentIndex);
            }

            prevBtn.addEventListener('click', prevBanner);
            nextBtn.addEventListener('click', nextBanner);

            // Auto-rotate banner every 5 seconds
            setInterval(nextBanner, 5000);

            // Hiển thị banner đầu tiên
            showBanner(currentIndex);

        </script>
    </body>
</html>
