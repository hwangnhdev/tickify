<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng của Organizer</title>
    <!-- Nhúng Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Nhúng Font Awesome cho các biểu tượng (nếu cần) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="bg-gray-50 p-6">
    <div class="max-w-4xl mx-auto bg-white p-6 shadow rounded-lg">
        <h1 class="text-3xl font-bold mb-6 text-center text-gray-800">
            <i class="fas fa-receipt mr-2"></i>Chi tiết đơn hàng
        </h1>
        
        <!-- Thông tin đơn hàng -->
        <div class="mb-8 border p-6 rounded-lg bg-gray-50 transition transform hover:scale-105 hover:shadow-lg">
            <h2 class="text-2xl font-semibold mb-4 text-gray-700">
                <i class="fas fa-info-circle mr-2"></i>Thông tin đơn hàng
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-gray-600">
                <c:if test="${not empty organizerOrderDetailDTO.orderHeader.orderId}">
                    <p><strong>Mã đơn hàng:</strong> ${organizerOrderDetailDTO.orderHeader.orderId}</p>
                </c:if>
                <c:if test="${not empty organizerOrderDetailDTO.orderHeader.orderDate}">
                    <p><strong>Ngày đặt:</strong> ${organizerOrderDetailDTO.orderHeader.orderDate}</p>
                </c:if>
                <c:if test="${not empty organizerOrderDetailDTO.orderHeader.totalPrice}">
                    <p><strong>Tổng tiền:</strong> ${organizerOrderDetailDTO.orderHeader.totalPrice}</p>
                </c:if>
                <c:if test="${not empty organizerOrderDetailDTO.orderHeader.paymentStatus}">
                    <p><strong>Trạng thái:</strong> ${organizerOrderDetailDTO.orderHeader.paymentStatus}</p>
                </c:if>
                <c:if test="${not empty organizerOrderDetailDTO.orderHeader.transactionId}">
                    <p><strong>Mã giao dịch:</strong> ${organizerOrderDetailDTO.orderHeader.transactionId}</p>
                </c:if>
                <c:if test="${not empty organizerOrderDetailDTO.orderHeader.voucherCode}">
                    <p><strong>Voucher:</strong> ${organizerOrderDetailDTO.orderHeader.voucherCode}</p>
                </c:if>
            </div>
        </div>
        
        <!-- Thông tin khách hàng -->
        <div class="mb-8 border p-6 rounded-lg bg-gray-50 transition transform hover:scale-105 hover:shadow-lg">
            <h2 class="text-2xl font-semibold mb-4 text-gray-700">
                <i class="fas fa-user mr-2"></i>Thông tin khách hàng
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-gray-600">
                <c:if test="${not empty organizerOrderDetailDTO.orderHeader.customerName}">
                    <p><strong>Họ tên:</strong> ${organizerOrderDetailDTO.orderHeader.customerName}</p>
                </c:if>
                <c:if test="${not empty organizerOrderDetailDTO.orderHeader.customerEmail}">
                    <p><strong>Email:</strong> ${organizerOrderDetailDTO.orderHeader.customerEmail}</p>
                </c:if>
                <c:if test="${not empty organizerOrderDetailDTO.orderHeader.customerPhone}">
                    <p><strong>Số điện thoại:</strong> ${organizerOrderDetailDTO.orderHeader.customerPhone}</p>
                </c:if>
            </div>
        </div>
        
        <!-- Danh sách vé -->
        <div class="mb-8">
            <h2 class="text-2xl font-semibold mb-4 text-gray-700">
                <i class="fas fa-ticket-alt mr-2"></i>Danh sách vé
            </h2>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white border border-gray-200">
                    <thead class="bg-gray-200 text-gray-700">
                        <tr>
                            <th class="py-3 px-4 border-b">STT</th>
                            <th class="py-3 px-4 border-b">Loại vé</th>
                            <th class="py-3 px-4 border-b">Số lượng</th>
                            <th class="py-3 px-4 border-b">Đơn giá</th>
                            <th class="py-3 px-4 border-b">Thành tiền</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="detail" items="${organizerOrderDetailDTO.orderDetails}" varStatus="status">
                            <tr class="hover:bg-blue-100 transition duration-300">
                                <td class="py-3 px-4 border-b">${status.index + 1}</td>
                                <td class="py-3 px-4 border-b">
                                    <c:if test="${not empty detail.ticketType}">
                                        ${detail.ticketType}
                                    </c:if>
                                </td>
                                <td class="py-3 px-4 border-b">
                                    <c:if test="${not empty detail.quantity}">
                                        ${detail.quantity}
                                    </c:if>
                                </td>
                                <td class="py-3 px-4 border-b">
                                    <c:if test="${not empty detail.unitPrice}">
                                        ${detail.unitPrice}
                                    </c:if>
                                </td>
                                <td class="py-3 px-4 border-b">
                                    <c:if test="${not empty detail.detailTotalPrice}">
                                        ${detail.detailTotalPrice}
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Nút quay lại -->
        <div class="text-center">
            <a href="viewAllOrders" class="inline-block bg-blue-500 text-white px-6 py-3 rounded-lg hover:bg-blue-600 transition duration-200">
                <i class="fas fa-arrow-left mr-2"></i>Quay lại danh sách đơn hàng
            </a>
        </div>
    </div>
</body>
</html>
