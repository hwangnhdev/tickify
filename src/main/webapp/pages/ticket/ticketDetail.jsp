<%-- 
    Document   : ticketDetail
    Created on : Feb 23, 2025, 9:25:07 PM
    Author     : Duong Minh Kiet CE180166
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Detail</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="bg-gray-800 text-white">
    <div class="max-w-4xl mx-auto p-4">
        <!-- Khung order -->
        <div class="bg-gray-700 p-4 rounded-lg shadow-lg">
            <!-- Tiêu đề sự kiện, lấy từ ticket -->
            <div class="text-white text-lg font-semibold mb-4">
                ${ticket.eventName} - Vé tham gia sự kiện
            </div>

            <!-- Order Header -->
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-lg font-semibold">Order: ${ticket.orderCode}</h2>
            </div>
            <!-- Order Info -->
            <div class="grid grid-cols-3 gap-4 mb-4">
                <div class="bg-gray-600 p-2 rounded-lg">
                    <h3 class="text-sm font-semibold">Order date</h3>
                    <p class="text-sm">
                        <fmt:formatDate value="${ticket.orderDate}" pattern="dd MMM, yyyy" />
                    </p>
                    <p class="text-sm">
                        <fmt:formatDate value="${ticket.startTime}" pattern="HH:mm" />
                    </p>
                </div>
                <div class="bg-gray-600 p-2 rounded-lg">
                    <h3 class="text-sm font-semibold">Payment method</h3>
                    <p class="text-sm">Free</p>
                </div>
                <div class="bg-gray-600 p-2 rounded-lg">
                    <h3 class="text-sm font-semibold">Order status</h3>
                    <p class="text-sm">${ticket.orderStatus}</p>
                </div>
            </div>
            <!-- Buyer Information -->
            <div class="bg-gray-600 p-4 rounded-lg mb-4">
                <div class="flex items-center mb-2">
                    <i class="fas fa-user mr-2"></i>
                    <h3 class="text-sm font-semibold">Buyer information</h3>
                </div>
                <div class="grid grid-cols-2 gap-4">
                    <div class="bg-gray-700 p-2 rounded-lg">
                        <h4 class="text-sm font-semibold">Name</h4>
                        <p class="text-sm">Dương Minh Kiệt</p>
                    </div>
                    <div class="bg-gray-700 p-2 rounded-lg">
                        <h4 class="text-sm font-semibold">Email</h4>
                        <p class="text-sm">kietduong043@gmail.com</p>
                    </div>
                    <div class="bg-gray-700 p-2 rounded-lg">
                        <h4 class="text-sm font-semibold">Phone number</h4>
                        <p class="text-sm">+84376835255</p>
                    </div>
                    <div class="bg-gray-700 p-2 rounded-lg">
                        <h4 class="text-sm font-semibold">Address</h4>
                        <p class="text-sm">Địa chỉ của bạn</p>
                    </div>
                </div>
            </div>
            <!-- Order Detail -->
            <div class="bg-gray-600 p-4 rounded-lg">
                <div class="flex items-center mb-2">
                    <i class="fas fa-receipt mr-2"></i>
                    <h3 class="text-sm font-semibold">Order detail</h3>
                </div>
                <div class="grid grid-cols-3 gap-4 mb-4">
                    <div class="bg-gray-700 p-2 rounded-lg">
                        <h4 class="text-sm font-semibold">Ticket type</h4>
                        <p class="text-sm">${ticket.ticketType}</p>
                        <p class="text-sm">0 đ</p>
                    </div>
                    <div class="bg-gray-700 p-2 rounded-lg">
                        <h4 class="text-sm font-semibold">Quantity</h4>
                        <p class="text-sm">1</p>
                    </div>
                    <div class="bg-gray-700 p-2 rounded-lg">
                        <h4 class="text-sm font-semibold">Amount</h4>
                        <p class="text-sm">$0 đ</p>
                    </div>
                </div>
                <div class="flex justify-between items-center mb-2">
                    <h4 class="text-sm font-semibold">Subtotal</h4>
                    <p class="text-sm">$0 đ</p>
                </div>
                <div class="flex justify-between items-center">
                    <h4 class="text-sm font-semibold">0</h4>
                    <p class="text-sm text-green-500">$0 đ</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>