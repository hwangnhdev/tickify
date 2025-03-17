<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Ticket Detail</title>
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
                    <!-- Header: Event Name -->
                <c:if test="${not empty ticketDetail.eventName}">
                    <div class="space-y-2">
                        <h1 class="text-3xl font-bold truncate-text">
                            ${ticketDetail.eventName}
                        </h1>
                    </div>
                </c:if>
                <!-- Event Image -->
                <c:if test="${not empty ticketDetail.eventImage}">
                    <div>
                        <img src="${ticketDetail.eventImage}"
                             alt="${ticketDetail.eventName}"
                             loading="lazy"
                             onerror="this.onerror=null; this.style.display='none';"
                             class="w-full h-auto rounded" />
                    </div>
                </c:if>
                <!-- Order Code -->
                <c:if test="${not empty ticketDetail.orderCode}">
                    <div>
                        <p class="text-sm text-gray-600 flex items-center">
                            <i class="fas fa-ticket-alt mr-2"></i>
                            <span class="truncate-text">Order Code: ${ticketDetail.orderCode}</span>
                        </p>
                    </div>
                </c:if>
                <!-- Ticket Overview -->
                <c:if test="${not empty ticketDetail.ticketStatus or not empty ticketDetail.paymentStatus or not empty ticketDetail.location}">
                    <div class="border-t border-gray-200 pt-4">
                        <h2 class="text-2xl font-bold mb-4">
                            <i class="fas fa-info-circle mr-2"></i>Ticket overview
                        </h2>
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <c:if test="${not empty ticketDetail.ticketStatus}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h3 class="text-sm font-semibold">Ticket status</h3>
                                    <p class="text-base truncate-text">${ticketDetail.ticketStatus}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.paymentStatus}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h3 class="text-sm font-semibold">Payment status</h3>
                                    <p class="text-base truncate-text">${ticketDetail.paymentStatus}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.location}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h3 class="text-sm font-semibold">Location</h3>
                                    <p class="text-base truncate-text">${ticketDetail.location}</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
                <!-- Ticket Detail -->
                <c:if test="${not empty ticketDetail.ticketType or not empty ticketDetail.seat or not empty ticketDetail.startDate or not empty ticketDetail.endDate}">
                    <div class="border-t border-gray-200 pt-4">
                        <h2 class="text-2xl font-bold mb-4">
                            <i class="fas fa-ticket-alt mr-2"></i>Ticket detail
                        </h2>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <c:if test="${not empty ticketDetail.ticketType}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Ticket type</h4>
                                    <p class="text-base truncate-text">${ticketDetail.ticketType}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.seat}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Seat</h4>
                                    <p class="text-base truncate-text">${ticketDetail.seat}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.startDate}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Start date</h4>
                                    <p class="text-base">
                                        <fmt:formatDate value="${ticketDetail.startDate}" pattern="dd MMM, yyyy" />
                                    </p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.endDate}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">End date</h4>
                                    <p class="text-base">
                                        <fmt:formatDate value="${ticketDetail.endDate}" pattern="dd MMM, yyyy" />
                                    </p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
                <!-- Buyer Information -->
                <c:if test="${not empty ticketDetail.buyerName or not empty ticketDetail.buyerEmail or not empty ticketDetail.buyerPhone or not empty ticketDetail.buyerAddress}">
                    <div class="border-t border-gray-200 pt-4">
                        <h2 class="text-2xl font-bold mb-4">
                            <i class="fas fa-user mr-2"></i>Buyer information
                        </h2>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <c:if test="${not empty ticketDetail.buyerName}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Name</h4>
                                    <p class="text-base truncate-text">${ticketDetail.buyerName}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.buyerEmail}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Email</h4>
                                    <p class="text-base truncate-text">${ticketDetail.buyerEmail}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.buyerPhone}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Phone</h4>
                                    <p class="text-base truncate-text">${ticketDetail.buyerPhone}</p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.buyerAddress}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Address</h4>
                                    <p class="text-base truncate-text">${ticketDetail.buyerAddress}</p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </c:if>
                <!-- Order Summary -->
                <c:if test="${not empty ticketDetail.ticketType or not empty ticketDetail.quantity or not empty ticketDetail.amount or (ticketDetail.voucherApplied eq 'Yes') or not empty ticketDetail.originalTotalAmount or not empty ticketDetail.finalTotalAmount}">
                    <div class="bg-white shadow rounded-lg p-4 border border-gray-200">
                        <h2 class="text-lg font-semibold mb-4">
                            <i class="fas fa-receipt mr-2"></i>Order detail
                        </h2>
                        <table class="w-full text-left border-collapse">
                            <thead>
                                <tr class="bg-gray-100">
                                    <c:if test="${not empty ticketDetail.ticketType}">
                                        <th class="p-2 border border-gray-200">Ticket type</th>
                                        </c:if>
                                        <c:if test="${not empty ticketDetail.quantity}">
                                        <th class="p-2 border border-gray-200">Quantity</th>
                                        </c:if>
                                        <c:if test="${not empty ticketDetail.amount}">
                                        <th class="p-2 border border-gray-200">Amount</th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <tr class="bg-white hover:bg-gray-50">
                                    <c:if test="${not empty ticketDetail.ticketType}">
                                        <td class="p-2 border border-gray-200">
                                            ${ticketDetail.ticketType}<br />
                                            <fmt:formatNumber value="${ticketDetail.ticketPrice}" pattern="#,##0.00'đ'" />
                                        </td>
                                    </c:if>
                                    <c:if test="${not empty ticketDetail.quantity}">
                                        <td class="p-2 border border-gray-200">
                                            ${ticketDetail.quantity}
                                        </td>
                                    </c:if>
                                    <c:if test="${not empty ticketDetail.amount}">
                                        <td class="p-2 border border-gray-200">
                                            <fmt:formatNumber value="${ticketDetail.amount}" pattern="#,##0.00'đ'" />
                                        </td>
                                    </c:if>
                                </tr>
                                <!-- Subtotal Row -->
                                <c:if test="${not empty ticketDetail.originalTotalAmount}">
                                    <tr class="bg-gray-50">
                                        <td class="p-2 border border-gray-200 font-semibold" colspan="2">
                                            Subtotal
                                        </td>
                                        <td class="p-2 border border-gray-200">
                                            <fmt:formatNumber value="${ticketDetail.originalTotalAmount}" pattern="#,##0.00'đ'" />
                                        </td>
                                    </tr>
                                </c:if>
                                <!-- Voucher Discount Row: Kiểu phần trăm -->
                                <c:if test="${ticketDetail.voucherApplied eq 'Yes' and not empty ticketDetail.voucherPercentageCode}">
                                    <tr class="bg-white hover:bg-gray-50">
                                        <td class="p-2 border border-gray-200 font-semibold" colspan="2">
                                            Voucher (%): <span class="font-normal">${ticketDetail.voucherPercentageCode}</span>
                                        </td>
                                        <td class="p-2 border border-gray-200 text-left font-semibold">
                                            Savings: <fmt:formatNumber value="${ticketDetail.discountPercentage}" pattern="#,##0.00'đ'" />
                                        </td>
                                    </tr>
                                </c:if>

                                <!-- Voucher Discount Row: Kiểu tiền cố định -->
                                <c:if test="${ticketDetail.voucherApplied eq 'Yes' and not empty ticketDetail.voucherFixedCode}">
                                    <tr class="bg-white hover:bg-gray-50">
                                        <td class="p-2 border border-gray-200 font-semibold" colspan="2">
                                            Voucher (Fixed): <span class="font-normal">${ticketDetail.voucherFixedCode}</span>
                                        </td>
                                        <td class="p-2 border border-gray-200 text-left font-semibold">
                                            Savings: <fmt:formatNumber value="${ticketDetail.discountFixed}" pattern="#,##0.00'đ'" />
                                        </td>
                                    </tr>
                                </c:if>
                                <!-- Total Amount Row -->
                                <c:if test="${not empty ticketDetail.finalTotalAmount}">
                                    <tr class="bg-gray-50">
                                        <td class="p-2 border border-gray-200 font-semibold" colspan="2">
                                            Total Amount
                                        </td>
                                        <td class="p-2 border border-gray-200 text-green-500">
                                            <fmt:formatNumber value="${ticketDetail.finalTotalAmount}" pattern="#,##0.00'đ'" />
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
            <!-- Thông báo nếu ticketDetail rỗng -->
            <c:if test="${empty ticketDetail}">
                <div class="mt-6 p-4 bg-red-100 text-red-700 rounded">
                    <p>Không tìm thấy chi tiết vé.</p>
                </div>
            </c:if>
        </div>
    </body>
</html>
