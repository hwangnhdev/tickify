<%-- 
    Document   : header
    Created on : Jan 12, 2025, 2:52:16 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hoang</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
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
                background-color: rgb(45, 194, 117);
                padding: 14px 20px;
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
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            /* Khi hover vào logo */
            .logo-header img:hover {
                transform: scale(1.1);
                box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
            }

            .search-bar-header {
                display: flex;
                align-items: center;
                background: white;
                padding: 5px 10px;
                border-radius: 20px;
                transition: box-shadow 0.3s ease-in-out;
                position: relative;
            }

            .search-bar-header input {
                border: none;
                outline: none;
                padding: 5px;
                width: 220px;
                font-size: 14px;
            }

            /* Hiệu ứng hover cho nút search */
            .search-bar-header button {
                cursor: pointer;
                color: black;
                background-color: white;
                border: none;
                font-size: 14px;
                transition: color 0.3s ease-in-out;
            }

            .search-bar-header button:hover {
                color: #e63946;
                font-weight: bold;
            }

            /* Khi hover vào thanh tìm kiếm */
            .search-bar-header:hover::before {
                opacity: 1;
                animation: glowing 2s linear infinite;
            }

            /* Tạo hiệu ứng viền nhiều màu */
            .search-bar-header::before {
                content: "";
                position: absolute;
                top: -3px;
                left: -3px;
                right: -3px;
                bottom: -3px;
                border-radius: 23px; /* Lớn hơn 20px của search-bar-header */
                background: linear-gradient(45deg, #ff0000, #ff7300, #ffeb00, #47ff00, #00ffee, #002bff, #7a00ff, #ff00a6, #ff0000);
                background-size: 400%;
                z-index: -1;
                filter: blur(6px);
                opacity: 0;
                transition: opacity 0.3s ease-in-out;
            }

            /* Animation đổi màu */
            @keyframes glowing {
                0% {
                    background-position: 0% 50%;
                }
                50% {
                    background-position: 100% 50%;
                }
                100% {
                    background-position: 0% 50%;
                }
            }

            .user-actions-header {
                display: flex;
                align-items: center;
            }

            .user-actions-header a, .user-actions-header button {
                text-decoration: none;
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
                top: 69px; /* Nằm ngay dưới header (chiều cao header ~60px) */
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

            .categories-header {
                display: flex;
                justify-content: center;
                gap: 15px; /* Khoảng cách giữa các link */
                background-color: #222; /* Màu nền */
                padding: 10px 0;
                border-radius: 0;
            }

            .categories-header a {
                text-decoration: none;
                color: white;
                font-weight: bold;
                padding: 8px 15px;
                border-radius: 5px;
                transition: background-color 0.3s ease-in-out, transform 0.2s ease-in-out;
            }

            /* Hiệu ứng hover */
            .categories-header a:hover {
                background-color: #17a045;
                transform: scale(1.1);
            }

            /* Hiệu ứng khi active (click) */
            .categories-header a:active {
                background-color: #17a045;
                transform: scale(0.95);
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <header class="flex justify-between items-center text-white">
            <div class="logo-header">
                <a style="text-decoration: none; color: white;" href="event">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMOKXV6ymSP4avAusI4_RPe4Q6Tv4K2raW168in8s6w5dn70V42qa9l2y5wxU05gpikA&usqp=CAU"
                         alt="Ticketbox Logo">
                </a>
            </div>

            <!-- Search Bar -->
            <div class="search-bar-header">
                <form action="allEvents" method="GET">
                    <input style="color: black;" type="text" value="${searchQuery != null ? searchQuery : ''}" name="query"
                           placeholder="What are you looking for today?" required>
                    <button type="submit">Search</button>
                </form>
            </div>

            <!-- User Actions -->
            <div class="user-actions-header flex items-center space-x-4">
                <c:choose>
                    <c:when test="${not empty sessionScope.customerId}">
                        <a class="border border-white text-white rounded-full px-4 py-2" href="createNewEvent">Create Event</a>
                        <button class="text-white flex items-center"
                                onclick="window.location.href = '<%= request.getContextPath()%>/viewAllTickets'">
                            <i class="fas fa-ticket-alt"></i>
                            <span class="ml-2">My Tickets</span>
                        </button>

                        <!-- Dropdown -->
                        <div class="relative">
                            <!-- Avatar + Account -->
                            <div class="flex items-center space-x-2 px-4 cursor-pointer rounded-md"
                                 onclick="toggleDropdown()">
                                <c:choose>
                                    <c:when test="${not empty sessionScope.customerImage}">
                                        <img alt="User profile picture" class="h-10 w-10 rounded-full"
                                             src="${sessionScope.customerImage}" width="40" height="40"/>
                                    </c:when>
                                    <c:otherwise>
                                        <img alt="User profile picture" class="h-10 w-10 rounded-full"
                                             src="https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_1280.png" width="40" height="40"/>
                                    </c:otherwise>
                                </c:choose>
                                <span>My Account</span>
                                <i class="fas fa-chevron-down"></i>
                            </div>

                            <!-- Dropdown Menu -->
                            <div id="dropdown-menu"
                                 class="absolute right-0 mt-2 w-48 bg-white shadow-lg rounded-md hidden" style="color: black; overflow: hidden;">
                                <a href="<%= request.getContextPath()%>/profile" class="block px-4 py-2 hover:bg-gray-100 text-black">My Profile</a>
                                <a href="<%= request.getContextPath()%>/viewAllTickets" class="block px-4 py-2 hover:bg-gray-100 text-black">My Tickets</a>
                                <a href="OrganizerEventController" class="block px-4 py-2 hover:bg-gray-100 text-black">My Events</a>
                                <a href="<%= request.getContextPath()%>/logout" class="block px-4 py-2 hover:bg-gray-100 text-black">Log Out</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="<%= request.getContextPath()%>/pages/signUpPage/signUp.jsp" class="text-white">Sign In | Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </header>

        <nav class="categories-header">
            <c:forEach begin="0" end="5" var="category" items="${listCategories}">
                <a style="text-decoration: none; color: white;" href="allEvents?category=${category.categoryId}">
                    ${category.categoryName}
                </a>
            </c:forEach>
        </nav>

        <!-- JavaScript -->
        <script>
            function toggleDropdown() {
                var dropdown = document.getElementById("dropdown-menu");
                dropdown.classList.toggle("hidden");
            }

            // Đóng dropdown nếu click bên ngoài
            document.addEventListener("click", function (event) {
                var dropdown = document.getElementById("dropdown-menu");
                var profileMenu = dropdown.previousElementSibling; // Phần tử bấm mở dropdown
                if (!profileMenu.contains(event.target) && !dropdown.contains(event.target)) {
                    dropdown.classList.add("hidden");
                }
            });
        </script>
    </body>
</html>