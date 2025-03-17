<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Order Details</title>
    <jsp:include page="../../components/header.jsp" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet" />
    <!-- Tippy.js & Popper.js -->
    <link rel="stylesheet" href="https://unpkg.com/tippy.js@6/dist/tippy.css" />
    <script src="https://unpkg.com/@popperjs/core@2"></script>
    <script src="https://unpkg.com/tippy.js@6"></script>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
        }
        .truncate-text {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .seat-text {
            white-space: normal;
            word-wrap: break-word;
        }
    </style>
</head>
<body class="bg-gray-100 text-gray-900">
<div class="max-w-4xl mx-auto p-6">
    <div class="bg-white shadow rounded-lg p-6 space-y-8">
        <!-- Title: Event Name -->
        <div class="space-y-2">
            <h1 class="text-3xl font-bold truncate-text" title="${orderDetail.eventName}">
                <c:out value="${orderDetail.eventName}" default="No Data Available" />
            </h1>
        </div>
        <!-- Event Image -->
        <c:if test="${not empty orderDetail.image_url}">
            <div>
                <img src="${orderDetail.image_url}"
                     alt="<c:out value='${orderDetail.eventName}' default='No Data Available' />"
                     loading="lazy"
                     onerror="this.onerror=null; this.style.display='none';"
                     class="w-full h-auto rounded" />
            </div>
        </c:if>
        <!-- Order ID -->
        <div>
            <p class="text-sm text-gray-600 flex items-center">
                <i class="fas fa-receipt mr-2"></i>
                <span class="truncate-text" title="${orderDetail.orderId}">
                    Order ID: <c:out value="${orderDetail.orderId}" default="No Data Available" />
                </span>
            </p>
        </div>
        <!-- Order Overview -->
        <div class="border-t border-gray-200 pt-4">
            <h2 class="text-2xl font-bold mb-4">
                <i class="fas fa-info-circle mr-2"></i>Order Overview
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <!-- Payment Status -->
                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                    <h3 class="text-sm font-semibold">Payment Status</h3>
                    <p class="text-base truncate-text" title="${orderDetail.paymentStatus}">
                        <c:out value="${orderDetail.paymentStatus}" default="No Data Available" />
                    </p>
                </div>
                <!-- Order Date -->
                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                    <h3 class="text-sm font-semibold">Order Date</h3>
                    <p class="text-base">
                        <c:choose>
                            <c:when test="${not empty orderDetail.orderDate}">
                                <fmt:formatDate value="${orderDetail.orderDate}" pattern="dd MMM, yyyy HH:mm" />
                            </c:when>
                            <c:otherwise>No Data Available</c:otherwise>
                        </c:choose>
                    </p>
                </div>
               
            </div>
        </div>
        <!-- Event Schedule (Showtime) -->
        <c:if test="${not empty orderDetail.startDate or not empty orderDetail.endDate}">
            <div class="border-t border-gray-200 pt-4">
                <h2 class="text-2xl font-bold mb-4">
                    <i class="fas fa-clock mr-2"></i>Event Schedule
                </h2>
                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <c:if test="${not empty orderDetail.startDate}">
                        <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                            <h4 class="text-sm font-semibold">Start Date</h4>
                            <p class="text-base">
                                <fmt:formatDate value="${orderDetail.startDate}" pattern="HH:mm, dd MMM yyyy" />
                            </p>
                        </div>
                    </c:if>
                    <c:if test="${not empty orderDetail.endDate}">
                        <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                            <h4 class="text-sm font-semibold">End Date</h4>
                            <p class="text-base">
                                <fmt:formatDate value="${orderDetail.endDate}" pattern="HH:mm, dd MMM yyyy" />
                            </p>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
        <!-- Customer Information -->
        <div class="border-t border-gray-200 pt-4">
            <h2 class="text-2xl font-bold mb-4">
                <i class="fas fa-user mr-2"></i>Customer Information
            </h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                    <h4 class="text-sm font-semibold">Name</h4>
                    <p class="text-base truncate-text" title="${orderDetail.customerName}">
                        <c:out value="${orderDetail.customerName}" default="No Data Available" />
                    </p>
                </div>
                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                    <h4 class="text-sm font-semibold">Email</h4>
                    <p class="text-base truncate-text" title="${orderDetail.customerEmail}">
                        <c:out value="${orderDetail.customerEmail}" default="No Data Available" />
                    </p>
                </div>
            </div>
        </div>
        <!-- Order Summary -->
        
        <!-- Order Items -->
        <c:if test="${not empty orderDetail.orderItems}">
            <div class="bg-white shadow rounded-lg p-4 border border-gray-200">
                <h2 class="text-lg font-semibold mb-4">
                    <i class="fas fa-ticket-alt mr-2"></i>Order Items
                </h2>
                <table class="w-full text-left border-collapse">
                    <thead>
                        <tr class="bg-gray-100">
                            <th class="p-2 border border-gray-200">Ticket Type</th>
                            <th class="p-2 border border-gray-200">Seat</th>
                            <th class="p-2 border border-gray-200">Quantity</th>
                            <th class="p-2 border border-gray-200">Price</th>
                            <th class="p-2 border border-gray-200">Total</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${orderDetail.orderItems}" var="item">
                            <tr class="bg-white hover:bg-gray-50">
                                <td class="p-2 border border-gray-200">
                                    <span class="truncate-text" title="${item.ticketType}">
                                        <c:out value="${item.ticketType}" default="No Data Available" />
                                    </span>
                                </td>
                                <td class="p-2 border border-gray-200 seat-text">
                                    <c:out value="${item.seat}" default="No Data Available" />
                                </td>
                                <td class="p-2 border border-gray-200">
                                    <c:out value="${item.quantity}" default="0" />
                                </td>
                                <td class="p-2 border border-gray-200">
                                    <fmt:formatNumber value="${item.ticketPrice}" pattern="#,##0.00'đ'" />
                                </td>
                                <td class="p-2 border border-gray-200">
                                    <fmt:formatNumber value="${item.ticketPrice * item.quantity}" pattern="#,##0.00'đ'" />
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot class="bg-gray-50">
                        <tr>
                            <td class="p-2 font-semibold" colspan="4">Subtotal</td>
                            <td class="p-2 text-right">
                                <fmt:formatNumber value="${orderDetail.grandTotal}" pattern="#,##0.00'đ'" />
                            </td>
                        </tr>
                        <c:if test="${not empty orderDetail.voucherCode}">
                            <tr>
                                <td class="p-2 font-semibold" colspan="4">Discount</td>
                                <td class="p-2 text-right">
                                    <fmt:formatNumber value="${orderDetail.grandTotal - orderDetail.totalAfterDiscount}" pattern="#,##0.00'đ'" />
                                </td>
                            </tr>
                        </c:if>
                        <tr>
                            <td class="p-2 font-semibold" colspan="4">Total</td>
                            <td class="p-2 text-right text-green-500">
                                <fmt:formatNumber value="${orderDetail.totalAfterDiscount}" pattern="#,##0.00'đ'" />
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </c:if>
    </div>
    <c:if test="${empty orderDetail}">
        <div class="mt-6 p-4 bg-red-100 text-red-700 rounded">
            <p>No order details found.</p>
        </div>
    </c:if>
</div>
<script>
    // Configure Tippy.js for tooltips
    tippy('[title]', {
        animation: 'shift-away',
        arrow: true,
        theme: 'light-border',
        duration: [200, 150],
        maxWidth: 300,
        delay: [100, 50]
    });
</script>
</body>
</html>
