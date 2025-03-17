<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Order Detail</title>
        <jsp:include page="../../components/header.jsp"></jsp:include>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet" />
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            .truncate-text {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
        </style>
    </head>
    <body class="bg-gray-100 text-gray-900">
        <div class="max-w-4xl mx-auto p-6">
            <div class="bg-white shadow rounded-lg p-6 space-y-8">
                
                <!-- 🔹 Header: Event Name -->
                <c:if test="${not empty orderDetail.eventName}">
                    <div class="space-y-2">
                        <h1 class="text-3xl font-bold truncate-text">
                            ${orderDetail.eventName}
                        </h1>
                    </div>
                </c:if>

                <!-- 🔹 Event Image -->
                <c:if test="${not empty orderDetail.image_url}">
                    <div>
                        <img src="${orderDetail.image_url}"
                             alt="${orderDetail.eventName}"
                             loading="lazy"
                             onerror="this.onerror=null; this.style.display='none';"
                             class="w-full h-auto rounded" />
                    </div>
                </c:if>

                <!-- 🔹 Order Code -->
                <c:if test="${not empty orderDetail.orderId}">
                    <div>
                        <p class="text-sm text-gray-600 flex items-center">
                            <i class="fas fa-receipt mr-2"></i>
                            <span class="truncate-text">Order Code: ${orderDetail.orderId}</span>
                        </p>
                    </div>
                </c:if>

                <!-- 🔹 Order Overview -->
                <div class="border-t border-gray-200 pt-4">
                    <h2 class="text-2xl font-bold mb-4">
                        <i class="fas fa-info-circle mr-2"></i>Order Overview
                    </h2>
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                        <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                            <h3 class="text-sm font-semibold">Payment Status</h3>
                            <p class="text-base truncate-text">${orderDetail.paymentStatus}</p>
                        </div>
                        <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                            <h3 class="text-sm font-semibold">Order Date</h3>
                            <p class="text-base">
                                <fmt:formatDate value="${orderDetail.orderDate}" pattern="dd MMM, yyyy" />
                            </p>
                        </div>
                        <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                            <h3 class="text-sm font-semibold">Seat</h3>
                            <p class="text-base truncate-text">${orderDetail.seat}</p>
                        </div>
                    </div>
                </div>

                <!-- 🔹 Buyer Information -->
                <c:if test="${not empty orderDetail.customerName or not empty orderDetail.customerEmail}">
                    <div class="border-t border-gray-200 pt-4">
                        <h2 class="text-2xl font-bold mb-4">
                            <i class="fas fa-user mr-2"></i>Buyer Information
                        </h2>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <c:if test="${not empty orderDetail.customerName}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Name</h4>
                                    <p class="text-base truncate-text">${orderDetail.customerName}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty orderDetail.customerEmail}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Email</h4>
                                    <p class="text-base truncate-text">${orderDetail.customerEmail}</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>

                <!-- 🔹 Order Summary -->
                <div class="bg-white shadow rounded-lg p-4 border border-gray-200">
                    <h2 class="text-lg font-semibold mb-4">
                        <i class="fas fa-receipt mr-2"></i>Order Summary
                    </h2>
                    <table class="w-full text-left border-collapse">
                        <tbody>
                            <tr class="border-b border-gray-200">
                                <td class="p-2 font-semibold">Subtotal</td>
                                <td class="p-2">
                                    <fmt:formatNumber value="${orderDetail.grandTotal}" pattern="#,##0.00'đ'" />
                                </td>
                            </tr>

                            <!-- 🔹 Voucher Discount -->
                            <c:if test="${not empty orderDetail.voucherCode}">
                                <tr class="border-b border-gray-200">
                                    <td class="p-2 font-semibold">Voucher</td>
                                    <td class="p-2">${orderDetail.voucherCode}</td>
                                </tr>
                                <tr class="border-b border-gray-200">
                                    <td class="p-2 font-semibold">Discount</td>
                                    <td class="p-2">
                                        <c:choose>
                                            <c:when test="${orderDetail.discountType eq 'percentage'}">
                                                ${orderDetail.discountPercentValue}% 
                                                (<fmt:formatNumber value="${orderDetail.discountPercentage}" pattern="#,##0.00'đ'" />)
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${orderDetail.discountFixed}" pattern="#,##0.00'đ'" />
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:if>

                            <tr class="border-b border-gray-200">
                                <td class="p-2 font-semibold">Total After Discount</td>
                                <td class="p-2">
                                    <fmt:formatNumber value="${orderDetail.totalAfterDiscount}" pattern="#,##0.00'đ'" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- 🔹 Thông báo nếu orderDetail rỗng -->
            <c:if test="${empty orderDetail}">
                <div class="mt-6 p-4 bg-red-100 text-red-700 rounded">
                    <p>Order details not found.</p>
                </div>
            </c:if>
        </div>
    </body>
</html>
