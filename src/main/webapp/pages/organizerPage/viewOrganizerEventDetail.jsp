<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Organizer Event Detail</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <style>
        .ticket {
            position: relative;
            border: 2px dashed #4a5568;
            border-radius: 10px;
            padding: 20px;
            background-color: #2d3748;
            color: white;
        }
        .ticket::before, .ticket::after {
            content: '';
            position: absolute;
            width: 20px;
            height: 20px;
            background-color: #2d3748;
            border: 2px dashed #4a5568;
            border-radius: 50%;
        }
        .ticket::before {
            top: -11px;
            left: 50%;
            transform: translateX(-50%);
        }
        .ticket::after {
            bottom: -11px;
            left: 50%;
            transform: translateX(-50%);
        }
    </style>
</head>
<body class="bg-gray-100">
    <header class="bg-green-500 p-4 flex justify-between items-center">
        <div class="text-white text-2xl font-bold">
            ticketbox
        </div>
        <div class="flex items-center space-x-4">
            <input class="p-2 rounded" placeholder="What are you looking for today" type="text"/>
            <button class="bg-white text-green-500 px-4 py-2 rounded">
                Search
            </button>
            <button class="bg-white text-green-500 px-4 py-2 rounded">
                Create Event
            </button>
            <button class="text-white">
                My Tickets
            </button>
            <button class="text-white">
                My Account
            </button>
            <button class="text-white">
                <i class="fas fa-globe"></i>
            </button>
        </div>
    </header>
    <nav class="bg-black text-white p-2 flex justify-center space-x-4">
        <a class="hover:underline" href="#">Music</a>
        <a class="hover:underline" href="#">Theaters &amp; Art</a>
        <a class="hover:underline" href="#">Sport</a>
        <a class="hover:underline" href="#">Others</a>
    </nav>
    <main class="max-w-6xl mx-auto p-4">
        <div class="flex flex-col lg:flex-row items-stretch">
            <!-- Khung hiển thị thông tin vé sự kiện -->
            <div class="ticket lg:w-1/3 relative flex flex-col justify-between bg-gray-700 text-white p-6 rounded-lg shadow-lg w-full max-w-md">
                <c:if test="${not empty organizerEventDetail}">
                    <div>
                        <h2 class="text-2xl font-bold mb-2">${organizerEventDetail.eventName}</h2>
                        <p class="text-sm mb-2">
                            <i class="fas fa-calendar-alt mr-2"></i>
                            <span class="text-green-500">${organizerEventDetail.startDate} - ${organizerEventDetail.endDate}</span>
                        </p>
                        <p class="text-sm mb-2">
                            <i class="fas fa-map-marker-alt mr-2"></i>
                            <span class="text-green-500">${organizerEventDetail.location}</span>
                        </p>
                    </div>
                    <!-- Giảm khoảng cách trên và dưới của hr -->
                    <hr class="border-gray-600 mt-0 mb-2">
                    <!-- Nút hiển thị trạng thái sự kiện -->
                    <div class="mt-2">
                        <button class="w-full bg-gray-600 text-gray-300 py-2 rounded-lg">
                            Status: ${organizerEventDetail.status}
                        </button>
                    </div>
                </c:if>
            </div>

            <!-- Khung hiển thị ảnh sự kiện chiếm 2/3, tự động điều chỉnh chiều cao theo container -->
            <div class="lg:w-2/3 mt-4 lg:mt-0 lg:ml-4">
                <c:if test="${not empty organizerEventDetail.imageURL}">
                    <img alt="${organizerEventDetail.imageTitle}" 
                         class="rounded-lg w-full h-full object-cover" 
                         src="${organizerEventDetail.imageURL}"/>
                </c:if>
            </div>
        </div>

        <section class="mt-8">
            <div class="bg-white p-6 rounded-lg shadow-md">
                <c:if test="${not empty organizerEventDetail}">
                    <h3 class="text-2xl font-bold mb-4">About</h3>
                    <div class="border-t border-gray-300 mt-2 mb-4"></div>
                    <h4 class="text-lg font-bold mt-4">Giới thiệu sự kiện:</h4>
                    <p class="mt-2 text-gray-700">${organizerEventDetail.description}</p>
                </c:if>
                <c:if test="${empty organizerEventDetail}">
                    <p class="text-gray-700">No event detail found.</p>
                </c:if>
            </div>
        </section>

        <section class="mt-8">
            <div class="bg-white p-6 rounded-lg shadow-md">
                <c:if test="${not empty organizerEventDetail}">
                    <h3 class="text-2xl font-bold mb-4">Organizer</h3>
                    <div class="border-t border-gray-300 mt-2 mb-4"></div>
                    <div class="flex items-center">
                        <div class="ml-4">
                            <p class="font-bold">${organizerEventDetail.organizationName}</p>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty organizerEventDetail}">
                    <p class="text-gray-700">No organizer detail found.</p>
                </c:if>
            </div>
        </section>
    </main>
</body>
</html>
