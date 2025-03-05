<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Order List</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    </head>
    <body class="bg-gray-900 text-white">
        <!-- Sidebar và giao diện chung không thay đổi -->
        <div class="flex h-screen">
            <!-- Sidebar -->
            <aside class="fixed inset-y-0 left-0 transform w-64 bg-gradient-to-b from-green-900 to-black p-4 text-white transition-transform duration-300 md:w-1/6 md:relative md:transform-none z-50">
                <button class="md:hidden text-white absolute top-4 right-4" onclick="document.querySelector('aside').classList.toggle('-translate-x-full')">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="flex items-center mb-8">
                    <img alt="Tickify logo" class="mr-2" height="40" src="https://storage.googleapis.com/a1aa/image/8k6Ikw_t95IdEBRzaSbfv_qa-9InZk34-JUibXbK7B4.jpg" width="40"/>
                    <span class="text-lg font-bold text-green-500">Organizer Center</span>
                </div>
                <nav class="space-y-4">
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="/Tickify/pages/eventOverview.jsp"><i class="fas fa-chart-pie mr-2"></i>Overview</a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="eventAnalyst.jsp"><i class="fas fa-chart-line mr-2"></i>Analyst</a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="updateEvent"><i class="fas fa-edit mr-2"></i>Edit Event</a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="seatingChart.jsp"><i class="fas fa-chair mr-2"></i>Seat Map</a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="vouchers.jsp"><i class="fas fa-tags mr-2"></i>Voucher</a>
                    <a class="flex items-center text-white bg-green-700 p-2 rounded" href="/Tickify/organizerOrders"><i class="fas fa-list mr-2"></i>Order List</a>
                </nav>
            </aside>
            <!-- Main Content -->
            <main class="flex-1 flex flex-col">
                <!-- Header -->
                <header class="flex justify-between items-center bg-gray-800 p-4 shadow-md">
                    <h1 class="text-2xl font-bold text-green-400">Order List</h1>
                    <div class="flex items-center space-x-4">
                        <button class="flex items-center text-white">
                            <img alt="User avatar" class="mr-2 rounded-full" height="30" src="https://storage.googleapis.com/a1aa/image/_qCewoK0KXQhWyQzRe9zG7PpYaYijDdWdPLzWZ3kkg8.jpg" width="30"/>
                            My Account
                        </button>
                    </div>
                </header>
                <!-- Main Section -->
                <section class="flex-1 p-4 overflow-y-auto">
                    <!-- Filter and Search Section (2 form tách biệt) -->
                    <div class="mb-6 flex flex-col sm:flex-row sm:items-center sm:justify-between bg-gray-800 p-4 rounded-lg shadow-md">
                        <!-- Filter Form -->
                        <form action="organizerOrders" method="get" class="flex items-center space-x-4">
                            <label for="paymentStatus" class="text-white font-medium">Payment Status:</label>
                            <select name="paymentStatus" id="paymentStatus" class="p-2 rounded bg-gray-700 text-white border border-gray-600 focus:ring-2 focus:ring-green-500">
                                <option value="all" ${paymentStatus == 'all' ? 'selected' : ''}>All</option>
                                <option value="paid" ${paymentStatus == 'paid' ? 'selected' : ''}>Paid</option>
                                <option value="pending" ${paymentStatus == 'pending' ? 'selected' : ''}>Pending</option>
                            </select>
                            <input type="submit" value="Filter" class="bg-green-500 hover:bg-green-600 text-white p-2 rounded transition-colors duration-200"/>
                        </form>
                        <!-- Search Form -->
                        <form action="SearchOrderController" method="get" class="flex items-center space-x-4 mt-4 sm:mt-0">
                            <input type="text" name="searchOrder" placeholder="Tìm theo tên khách hàng" 
                                   class="p-2 rounded bg-gray-700 text-white border border-gray-600 focus:ring-2 focus:ring-green-500" />
                            <button type="submit" class="bg-green-500 hover:bg-green-600 text-white p-2 rounded transition-colors duration-200">
                                Search
                            </button>
                        </form>
                    </div>
                    <!-- Orders Table -->
                    <div class="bg-gray-800 rounded-lg shadow-lg overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-700">
                            <thead class="bg-gray-700">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-id-badge mr-2"></i>Order ID
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-calendar-alt mr-2"></i>Order Date
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-dollar-sign mr-2"></i>Total Price
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-check-circle mr-2"></i>Payment Status
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-user mr-2"></i>Customer Name
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-ticket-alt mr-2"></i>Event Name
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-map-marker-alt mr-2"></i>Location
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-barcode mr-2"></i>Ticket Code
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-gray-800 divide-y divide-gray-700">
                                <c:forEach var="order" items="${orders}">
                                    <tr class="hover:bg-gray-700 transition-colors duration-150 cursor-pointer" 
                                        onclick="window.open('orderDetail?orderId=${order.orderId}', '_blank')">
                                        <td class="px-6 py-4 text-sm md:whitespace-nowrap">${order.orderId}</td>
                                        <td class="px-6 py-4 text-sm">
                                            <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                        </td>
                                        <td class="px-6 py-4 text-sm">
                                            <fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,##0 đ"/>
                                        </td>
                                        <td class="px-6 py-4 text-sm">${order.paymentStatus}</td>
                                        <td class="px-6 py-4 text-sm">${order.customerName}</td>
                                        <td class="px-6 py-4 text-sm">${order.eventName}</td>
                                        <td class="px-6 py-4 text-sm">${order.location}</td>
                                        <td class="px-6 py-4 text-sm">${order.ticketCode}</td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty orders}">
                                    <tr>
                                        <td colspan="8" class="px-6 py-4 text-center text-gray-400">No orders found.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    <!-- Pagination -->
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
                                <a href="${pageContext.request.contextPath}/organizerOrders?page=1&paymentStatus=${paymentStatus}" class="px-3 py-1 bg-blue-500 text-white rounded-l hover:bg-blue-600">First</a>
                                <a href="${pageContext.request.contextPath}/organizerOrders?page=${currentPage - 1}&paymentStatus=${paymentStatus}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600">Prev</a>
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
                                        <a href="${pageContext.request.contextPath}/organizerOrders?page=${i}&paymentStatus=${paymentStatus}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600 rounded">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${endPage lt totalPages}">
                                <span class="px-3 py-1">...</span>
                            </c:if>
                            <c:if test="${currentPage lt totalPages}">
                                <a href="${pageContext.request.contextPath}/organizerOrders?page=${currentPage + 1}&paymentStatus=${paymentStatus}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600">Next</a>
                                <a href="${pageContext.request.contextPath}/organizerOrders?page=${totalPages}&paymentStatus=${paymentStatus}" class="px-3 py-1 bg-blue-500 text-white rounded-r hover:bg-blue-600">Last</a>
                            </c:if>
                        </div>
                    </c:if>
                </section>
            </main>
        </div>
    </body>
</html>
