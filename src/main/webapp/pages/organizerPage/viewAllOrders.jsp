<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Danh sách đơn hàng</title>
    <!-- Nhúng Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Nhúng Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="bg-gray-50 p-6">
    <div class="max-w-7xl mx-auto">
        <!-- Header với tiêu đề và form tìm kiếm -->
        <div class="flex flex-col md:flex-row md:justify-between items-center mb-6">
            <h1 class="text-2xl font-bold mb-4 md:mb-0">Danh sách đơn hàng</h1>
            <form action="${pageContext.request.contextPath}/searchOrders" method="get" class="flex space-x-2">
                <input type="text" name="keyword" placeholder="Tìm kiếm..." value="${keyword}" class="border border-gray-300 rounded-md p-2" />
                <button type="submit" class="bg-blue-500 text-white rounded-md p-2 hover:bg-blue-600 transition">
                    <i class="fas fa-search"></i> Tìm kiếm
                </button>
            </form>
        </div>

        <!-- Hiển thị thông báo lỗi nếu có -->
        <c:if test="${not empty errorMessage}">
            <div class="mb-4 p-4 bg-red-100 border border-red-400 text-red-700 rounded">
                ${errorMessage}
            </div>
        </c:if>

        <!-- Bảng danh sách đơn hàng -->
        <div class="bg-white shadow rounded-lg overflow-hidden">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mã đơn hàng</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tên khách hàng</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Ngày đặt</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Tổng tiền</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Số lượng vé</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Trạng thái</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Mã giao dịch</th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="7" class="text-center py-4">Không tìm thấy đơn hàng nào</td>
                        </tr>
                    </c:if>
                    <c:forEach var="order" items="${orders}">
                        <tr class="cursor-pointer hover:bg-blue-100 transition duration-300 ease-in-out"
                            onclick="window.location.href='OrganizerOrderDetailController?orderId=${order.orderId}'">
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                    ${order.orderId}
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">${order.customerName}</td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <fmt:formatDate value="${order.orderDate}" pattern="dd MMM, yyyy" />
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="$" />
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">${order.totalTickets}</td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full
                                    <c:choose>
                                        <c:when test="${order.paymentStatus == 'New Order'}">bg-green-100 text-green-800</c:when>
                                        <c:when test="${order.paymentStatus == 'Accepted by Restaurant'}">bg-yellow-100 text-yellow-800</c:when>
                                        <c:when test="${order.paymentStatus == 'Prepared'}">bg-red-100 text-red-800</c:when>
                                        <c:when test="${order.paymentStatus == 'Rejected by Store'}">bg-red-100 text-red-800</c:when>
                                        <c:when test="${order.paymentStatus == 'Completed'}">bg-green-100 text-green-800</c:when>
                                        <c:when test="${order.paymentStatus == 'Pending'}">bg-orange-100 text-orange-800</c:when>
                                        <c:otherwise>bg-gray-100 text-gray-800</c:otherwise>
                                    </c:choose>
                                ">
                                    ${order.paymentStatus}
                                </span>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">${order.transactionId}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Phân trang -->
        <c:if test="${totalPages gt 1}">
            <div class="flex justify-center items-center mt-6 space-x-1">
                <c:set var="displayPages" value="5" />
                <c:set var="startPage" value="${currentPage - (displayPages div 2)}" />
                <c:set var="endPage" value="${currentPage + (displayPages div 2)}" />
                <c:if test="${startPage lt 1}">
                    <c:set var="endPage" value="${endPage + (1 - startPage)}" />
                    <c:set var="startPage" value="1" />
                </c:if>
                <c:if test="${endPage gt totalPages}">
                    <c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
                    <c:set var="endPage" value="${totalPages}" />
                    <c:if test="${startPage lt 1}">
                        <c:set var="startPage" value="1" />
                    </c:if>
                </c:if>
                <c:if test="${currentPage gt 1}">
                    <a href="${pageContext.request.contextPath}/viewAllOrders?page=1" class="px-3 py-1 bg-blue-500 text-white rounded-l hover:bg-blue-600">First</a>
                    <a href="${pageContext.request.contextPath}/viewAllOrders?page=${currentPage - 1}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600">Prev</a>
                </c:if>
                <c:if test="${startPage gt 1}">
                    <span class="px-3 py-1">...</span>
                </c:if>
                <c:forEach begin="${startPage}" end="${endPage}" var="i">
                    <c:choose>
                        <c:when test="${i eq currentPage}">
                            <span class="px-3 py-1 bg-blue-700 text-white font-bold rounded">${i}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/viewAllOrders?page=${i}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600 rounded">${i}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <c:if test="${endPage lt totalPages}">
                    <span class="px-3 py-1">...</span>
                </c:if>
                <c:if test="${currentPage lt totalPages}">
                    <a href="${pageContext.request.contextPath}/viewAllOrders?page=${currentPage + 1}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600">Next</a>
                    <a href="${pageContext.request.contextPath}/viewAllOrders?page=${totalPages}" class="px-3 py-1 bg-blue-500 text-white rounded-r hover:bg-blue-600">Last</a>
                </c:if>
            </div>
        </c:if>
    </div>
</body>
</html>
