<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Ticket Detail</title>

        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
        <!-- Swiper CSS -->
        <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
        <!-- Custom Styles -->
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            .truncate-text {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .swiper-container {
                position: relative; /* Đảm bảo container có vị trí relative */
                overflow: hidden;
            }
            .swiper-wrapper {
                width: 100%;
            }
            .swiper-slide {
                width: 100% !important;
                box-sizing: border-box;
            }
            /* Cập nhật CSS cho pagination */
            .swiper-pagination {
                position: absolute;
                bottom: 10px;
                left: 50% !important;
                transform: translateX(-50%) !important;
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 8px;
                z-index: 10;
            }
            .swiper-pagination-bullet {
                width: 12px;
                height: 12px;
                background: #CBD5E0; /* xám nhẹ */
                opacity: 1;
                border-radius: 50%;
                cursor: pointer;
            }
            .swiper-pagination-bullet-active {
                background: #48BB78; /* green-500: màu xanh lá */
            }
        </style>
    </head>
    <body class="bg-gray-100 text-gray-900">
        <jsp:include page="../../components/header.jsp"></jsp:include>
            <div class="pt-24 max-w-4xl mx-auto p-6">

                <!-- Ánh xạ orderDetail sang ticketDetail -->
            <c:set var="ticketDetail" value="${orderDetail}" />

            <!-- Carousel: chỉ hiển thị 1 vé mỗi slide -->
            <c:if test="${not empty ticketDetail.orderItems}">
                <div class="mb-8">

                    <div class="mb-4 text-center">
                        <p class="text-sm text-gray-600 flex items-center">
                            <i class="fas  mr-2"></i>
                            Ticket Detail
                        </p>
                    </div>

                    <!-- Swiper container -->
                    <div class="swiper-container">
                        <div class="swiper-wrapper">
                            <c:forEach var="item" items="${ticketDetail.orderItems}">
                                <div class="swiper-slide bg-white shadow rounded-lg p-6">
                                    <!-- Div 1: Ảnh sự kiện (full width) -->
                                    <c:if test="${not empty ticketDetail.eventSummary.imageUrl}">
                                        <img src="${ticketDetail.eventSummary.imageUrl}" 
                                             alt="${ticketDetail.eventSummary.eventName != null ? ticketDetail.eventSummary.eventName : 'No image'}"
                                             class="w-full h-auto rounded mb-4 object-cover" />
                                    </c:if>

                                    <!-- Div 2: Thông tin vé (bên trái) & QR Code (bên phải) -->
                                    <div class="flex items-start justify-between">
                                        <!-- Cột thông tin vé -->
                                        <div class="flex flex-col space-y-2 w-2/3">
                                            <h2 class="text-2xl font-bold truncate-text" 
                                                title="${ticketDetail.eventSummary.eventName != null ? ticketDetail.eventSummary.eventName : 'N/A'}">
                                                ${ticketDetail.eventSummary.eventName != null ? ticketDetail.eventSummary.eventName : 'N/A'}
                                            </h2>
                                            <p class="text-gray-600">
                                                <i class="fas fa-map-marker-alt mr-1"></i> 
                                                ${ticketDetail.eventSummary.location != null ? ticketDetail.eventSummary.location : 'N/A'}
                                            </p>
                                            <p class="text-gray-600">
                                                <i class="fas fa-clock mr-1"></i>
                                                <fmt:formatDate value="${ticketDetail.eventSummary.startDate}" pattern="HH:mm, dd MMM yyyy" />
                                                -
                                                <fmt:formatDate value="${ticketDetail.eventSummary.endDate}" pattern="HH:mm, dd MMM yyyy" />
                                            </p>
                                            <p class="text-gray-600">
                                                <i class="fas fa-ticket-alt mr-1"></i> Ticket Code: 
                                                ${ticketDetail.eventSummary.ticketCode != null ? ticketDetail.eventSummary.ticketCode : 'N/A'}
                                            </p>
                                            <p class="text-gray-600">
                                                <i class="fas fa-chair mr-1"></i> Seat: 
                                                ${item.seats != null ? item.seats : 'No seat'}
                                            </p>
                                            <p class="text-gray-600">
                                                <i class="fas fa-tag mr-1"></i> Ticket Type: 
                                                ${item.ticketType != null ? item.ticketType : 'N/A'}
                                            </p>
                                            <p class="text-gray-600">
                                                <i class="fas fa-check-circle mr-1"></i> Ticket Status: 
                                                ${item.ticketStatus != null ? item.ticketStatus : 'N/A'}
                                            </p>
                                        </div>

                                        <!-- Cột QR Code -->
                                        <div class="flex-shrink-0 w-1/3 flex justify-end">
                                            <c:if test="${item.ticketQRCode != null}">
                                                <img src="${item.ticketQRCode}" 
                                                     alt="QR Code for ticket ${item.ticketCode}" 
                                                     class="w-32 h-32 rounded" />
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <!-- Navigation arrows -->
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div> 
                        <!-- Pagination -->
                        <div class="swiper-pagination"></div>
                    </div>

                </div>
            </c:if>
            <!-- Order Code hiển thị riêng -->
            <c:if test="${not empty ticketDetail.orderSummary.orderId}">
                <div class="mb-4 text-center">
                    <p class="text-sm text-gray-600 flex items-center">
                        <i class="fas fa-ticket-alt mr-2"></i>
                        <span class="truncate-text" title="Order #${ticketDetail.orderSummary.orderId != null ? ticketDetail.orderSummary.orderId : 'N/A'}">
                            Order: ${ticketDetail.orderSummary.orderId != null ? ticketDetail.orderSummary.orderId : 'N/A'}
                        </span>
                    </p>
                </div>
            </c:if>

            <!-- Payment Information -->
            <c:if test="${not empty ticketDetail.orderSummary.paymentStatus}">
                <div class="bg-white shadow rounded-lg p-6 space-y-8 mb-8">
                    <h2 class="text-2xl font-bold mb-4">
                        <i class="fas fa-credit-card mr-2"></i>Payment Information
                    </h2>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">

                        <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                            <h4 class="text-sm font-semibold">Payment Status</h4>
                            <p class="text-base truncate-text" title="${ticketDetail.orderSummary.paymentStatus != null ? ticketDetail.orderSummary.paymentStatus : 'N/A'}">
                                ${ticketDetail.orderSummary.paymentStatus != null ? ticketDetail.orderSummary.paymentStatus : 'N/A'}
                            </p>
                        </div>
                        <!-- Nếu bạn có thêm thông tin như Payment Date hay Grand Total, thêm các khối tương ứng -->
                        <c:if test="${not empty ticketDetail.orderSummary.orderDate}">
                            <div class="border p-3 rounded">
                                <h3 class="text-sm font-semibold">Order Date</h3>
                                <p class="text-base">
                                    <fmt:formatDate value="${ticketDetail.orderSummary.orderDate}" pattern="HH:mm, dd MMM yyyy" />
                                </p>
                            </div>
                        </c:if>
                    </div>
                </div>

            </c:if>


            <!-- Buyer Information -->
            <c:if test="${not empty ticketDetail.orderSummary}">
                <div class="bg-white shadow rounded-lg p-6 space-y-8">
                    <div class="border-t border-gray-200 pt-4">
                        <h2 class="text-2xl font-bold mb-4">
                            <i class="fas fa-user mr-2"></i>Buyer Information
                        </h2>
                        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                            <c:if test="${not empty ticketDetail.orderSummary.customerName}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Name</h4>
                                    <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerName != null ? ticketDetail.orderSummary.customerName : 'N/A'}">
                                        ${ticketDetail.orderSummary.customerName != null ? ticketDetail.orderSummary.customerName : 'N/A'}
                                    </p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.orderSummary.customerEmail}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Email</h4>
                                    <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerEmail != null ? ticketDetail.orderSummary.customerEmail : 'N/A'}">
                                        ${ticketDetail.orderSummary.customerEmail != null ? ticketDetail.orderSummary.customerEmail : 'N/A'}
                                    </p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.orderSummary.customerPhone}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Phone</h4>
                                    <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerPhone != null ? ticketDetail.orderSummary.customerPhone : 'N/A'}">
                                        ${ticketDetail.orderSummary.customerPhone != null ? ticketDetail.orderSummary.customerPhone : 'N/A'}
                                    </p>
                                </div>
                            </c:if>
                            <c:if test="${not empty ticketDetail.orderSummary.customerAddress}">
                                <div class="border border-gray-200 p-4 rounded hover:bg-gray-50">
                                    <h4 class="text-sm font-semibold">Address</h4>
                                    <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerAddress != null ? ticketDetail.orderSummary.customerAddress : 'N/A'}">
                                        ${ticketDetail.orderSummary.customerAddress != null ? ticketDetail.orderSummary.customerAddress : 'N/A'}
                                    </p>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Divider để tách biệt -->
            <hr class="my-8 border-gray-300">

            <!-- Order Detail: Bảng tổng hợp theo ticket type (không có cột Seat) -->
            <c:if test="${not empty ticketDetail.groupedOrderItems}">
                <div class="bg-white shadow rounded-lg p-4 border border-gray-200 mb-8">
                    <h2 class="text-lg font-semibold mb-4">
                        <i class="fas fa-receipt mr-2"></i>Order Detail
                    </h2>
                    <table class="w-full text-left border-collapse">
                        <thead>
                            <tr class="bg-gray-100">
                                <th class="p-2 border border-gray-200">Ticket type</th>
                                <th class="p-2 border border-gray-200">Quantity</th>
                                <th class="p-2 border border-gray-200">Amount</th>
                            </tr>
                        </thead>
                        <tbody class="text-gray-700 text-sm">
                            <c:forEach items="${ticketDetail.groupedOrderItems}" var="item">
                                <tr class="bg-white hover:bg-gray-50">
                                    <td class="p-2 border border-gray-200">
                                        <span class="truncate-text" title="${item.ticketType != null ? item.ticketType : 'N/A'}">
                                            ${item.ticketType != null ? item.ticketType : 'N/A'}
                                        </span><br/>
                                        <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00'đ'" />
                                    </td>
                                    <td class="p-2 border border-gray-200">
                                        ${item.quantity}
                                    </td>
                                    <td class="p-2 border border-gray-200">
                                        <fmt:formatNumber value="${item.subtotalPerType}" pattern="#,##0.00'đ'" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot class="bg-gray-50">
                            <tr>
                                <td class="p-2 font-semibold" colspan="2">Subtotal</td>
                                <td class="p-2 text-right">
                                    <fmt:formatNumber value="${ticketDetail.calculation.totalSubtotal}" pattern="#,##0.00'đ'" />
                                </td>
                            </tr>
                            <c:if test="${not empty ticketDetail.orderSummary.voucherCode}">
                                <tr>
                                    <td class="p-2 font-semibold" colspan="2">
                                        Discount (Voucher: ${ticketDetail.orderSummary.voucherCode})
                                    </td>
                                    <td class="p-2 text-right">
                                        <span class="text-red-500">
                                            -<fmt:formatNumber value="${ticketDetail.calculation.discountAmount}" pattern="#,##0.00'đ'" />
                                            <c:if test="${ticketDetail.orderSummary.discountType eq 'percentage'}">
                                                (<fmt:formatNumber value="${ticketDetail.orderSummary.discountValue}" pattern="#,##0.##"/>%)
                                            </c:if>
                                        </span>
                                    </td>
                                </tr>
                            </c:if>
                            <tr>
                                <td class="p-2 font-semibold" colspan="2">Total</td>
                                <td class="p-2 text-right text-green-500">
                                    <fmt:formatNumber value="${ticketDetail.calculation.finalTotal}" pattern="#,##0.00'đ'" />
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </c:if>

            <!-- Swiper JS -->
            <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
            <script>
                var swiper = new Swiper('.swiper-container', {
                    slidesPerView: 1,
                    spaceBetween: 0,
                    initialSlide: 0,
                    observer: true,
                    observeParents: true,
                    navigation: {
                        nextEl: '.swiper-button-next',
                        prevEl: '.swiper-button-prev',
                    },
                    pagination: {
                        el: '.swiper-pagination',
                        clickable: true,
                        type: 'bullets'
                    },
                    watchOverflow: true
                });
                window.addEventListener('load', function () {
                    swiper.update();
                });
            </script>

            <!-- Tippy.js: Cấu hình cho các phần tử có thuộc tính title -->
            <script>
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
