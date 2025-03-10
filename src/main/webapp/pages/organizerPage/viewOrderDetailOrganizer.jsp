<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Order Detail</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <jsp:include page="../../components/header.jsp"></jsp:include>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    </head>
    <body class="bg-white text-gray-800">
        <div class="max-w-4xl mx-auto p-6 space-y-8">
            <!-- Header -->
            <h1 class="text-3xl font-bold text-center mb-6">
                <i class="fas fa-receipt mr-2"></i>Order Detail
            </h1>
            
            <!-- Order Information Section -->
            <div class="bg-white border rounded-lg shadow p-6">
                <h2 class="text-2xl font-semibold mb-4 flex items-center">
                    <i class="fas fa-info-circle mr-2"></i>Order Information
                </h2>
                <table class="w-full">
                    <tbody class="divide-y divide-gray-200">
                        <tr>
                            <th class="py-2 text-left w-1/3">Order ID</th>
                            <td class="py-2">${orderDetail.orderId}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Order Date</th>
                            <td class="py-2">
                                <fmt:formatDate value="${orderDetail.orderDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Grand Total</th>
                            <td class="py-2">
                                <fmt:formatNumber value="${orderDetail.grandTotal}" type="currency" currencySymbol="đ" />
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Voucher Code</th>
                            <td class="py-2">${orderDetail.voucherCode}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Discount Type</th>
                            <td class="py-2">${orderDetail.discount_type}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Discount Value</th>
                            <td class="py-2">
                                <c:choose>
                                    <c:when test="${orderDetail.discount_type == 'Percentage'}">
                                        ${orderDetail.discount_value}%
                                    </c:when>
                                    <c:otherwise>
                                        <fmt:formatNumber value="${orderDetail.discount_value}" type="currency" currencySymbol="đ" />
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Discount Amount</th>
                            <td class="py-2">
                                <fmt:formatNumber value="${orderDetail.discountAmount}" type="currency" currencySymbol="đ" />
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Total After Discount</th>
                            <td class="py-2">
                                <fmt:formatNumber value="${orderDetail.totalAfterDiscount}" type="currency" currencySymbol="đ" />
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Payment Status</th>
                            <td class="py-2">${orderDetail.paymentStatus}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Customer Information Section -->
            <div class="bg-white border rounded-lg shadow p-6">
                <h2 class="text-2xl font-semibold mb-4 flex items-center">
                    <i class="fas fa-user mr-2"></i>Customer Information
                </h2>
                <table class="w-full">
                    <tbody class="divide-y divide-gray-200">
                        <tr>
                            <th class="py-2 text-left w-1/3">Customer Name</th>
                            <td class="py-2">${orderDetail.customerName}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Customer Email</th>
                            <td class="py-2">${orderDetail.customerEmail}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Event Information Section -->
            <div class="bg-white border rounded-lg shadow p-6">
                <h2 class="text-2xl font-semibold mb-4 flex items-center">
                    <i class="fas fa-calendar-alt mr-2"></i>Event Information
                </h2>
                <table class="w-full">
                    <tbody class="divide-y divide-gray-200">
                        <tr>
                            <th class="py-2 text-left w-1/3">Event Name</th>
                            <td class="py-2">${orderDetail.eventName}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Location</th>
                            <td class="py-2">${orderDetail.location}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Event Image Section -->
            <div class="bg-white border rounded-lg shadow p-6 text-center" style="height:300px;">
                <h2 class="text-2xl font-semibold mb-4">Event Image</h2>
                <c:if test="${not empty orderDetail.image_url}">
                    <img src="${orderDetail.image_url}" alt="Event Image" class="mx-auto w-full h-full object-cover">
                </c:if>
                <c:if test="${empty orderDetail.image_url}">
                    <p>No image available.</p>
                </c:if>
            </div>
            
            <!-- Ticket Information Section -->
            <div class="bg-white border rounded-lg shadow p-6">
                <h2 class="text-2xl font-semibold mb-4">Ticket Information</h2>
                <table class="w-full">
                    <tbody class="divide-y divide-gray-200">
                        <tr>
                            <th class="py-2 text-left w-1/3">Seat List</th>
                            <td class="py-2">${orderDetail.seatList}</td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <!-- Action Buttons Section -->
            <div class="flex justify-between mt-8">
                <a href="ordersList.jsp" class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded">
                    <i class="fas fa-arrow-left mr-2"></i>Back to Orders
                </a>
            </div>
        </div>
    </body>
</html>
