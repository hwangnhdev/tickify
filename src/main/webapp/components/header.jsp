<%-- 
    Document   : header
    Created on : Jan 12, 2025, 2:52:16 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
                padding-top: 100px; /* Khoảng cách từ đầu trang để tránh bị che bởi header (khoảng 90px từ header + 30px từ nav) */
            }

            /* Header (Fixed tại đầu trang) */
            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: #28a745;
                padding: 10px 20px;
                color: white;
                position: fixed; /* Cố định vị trí */
                top: 0; /* Nằm ở đầu trang */
                left: 0; /* Nằm ở bên trái */
                right: 0; /* Chiếm toàn bộ chiều rộng */
                z-index: 1100; /* Đảm bảo header hiển thị trên các phần tử khác, cao hơn filter (z-index: 1000) */
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1); /* Thêm shadow để phân biệt với nội dung */
            }

            .logo-header img {
                height: 30px;
                cursor: pointer;
                border-radius: 10px;
            }

            .search-bar-header {
                display: flex;
                align-items: center;
                background: white;
                padding: 5px 10px;
                border-radius: 20px;
            }

            .search-bar-header input {
                border: none;
                outline: none;
                padding: 5px;
                width: 220px;
                font-size: 14px;
            }

            .search-bar-header button {
                cursor: pointer;
                color: black;
                background-color: white;
                border: none;
                font-size: 14px;
            }

            .user-actions-header {
                display: flex;
                align-items: center;
            }

            .user-actions-header a, .user-actions-header button {
                margin-left: 15px;
                text-decoration: none;
                color: white;
                background: none;
                border: none;
                cursor: pointer;
                font-size: 16px;
            }

            /* Navigation Categories (Fixed ngay dưới header) */
            .categories-header {
                background: black;
                padding: 10px 0;
                text-align: center;
                position: fixed; /* Cố định vị trí */
                top: 60px; /* Nằm ngay dưới header (chiều cao header ~60px) */
                left: 0;
                right: 0;
                z-index: 1050; /* Hiển thị dưới header nhưng trên nội dung khác */
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            }

            .categories-header a {
                color: white;
                text-decoration: none;
                margin: 0 15px;
                font-size: 16px;
                transition: color 0.3s ease;
            }

            .categories-header a:hover {
                color: #3498db;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="logo-header">
                <a style="text-decoration: none; color: white;" href="event">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMOKXV6ymSP4avAusI4_RPe4Q6Tv4K2raW168in8s6w5dn70V42qa9l2y5wxU05gpikA&usqp=CAU" alt="Ticketbox Logo">
                </a>
            </div>
            <div class="search-bar-header">
                <!--Search Event-->
                <form action="allEvents" method="GET">
                    <input type="text" value="${searchQuery != null ? searchQuery : ''}" name="query" placeholder="What are you looking for today?" required>
                    <button type="submit">Search</button>
                </form>
                <!--<button>Search</button>-->
            </div>
            <div class="user-actions-header">
                <button>Create Event</button>
                <button>Purchased Tickets</button>
                <a href="<%= request.getContextPath()%>/profile">My Profile</a>
                <a href="<%= request.getContextPath()%>/change-password">Change Password</a>
                <a href="<%= request.getContextPath()%>/viewalltickets">My Tickets</a>
                <a href="<%= request.getContextPath()%>/pages/signUpPage/signUp.jsp">Sign In | Register</a>
            </div>
        </header>
        <nav class="categories-header">
            <a style="text-decoration: none; color: white;" href="allEvents?category=1">
                Concert
            </a>
            <a style="text-decoration: none; color: white;" href="allEvents?category=2">
                Technology
            </a>
            <a style="text-decoration: none; color: white;" href="allEvents?category=3">
                Sports
            </a>
            <a style="text-decoration: none; color: white;" href="allEvents?category=4">
                Festival
            </a>
            <a style="text-decoration: none; color: white;" href="allEvents?category=5">
                Exhibition
            </a>
        </nav>
    </body>
</html>
