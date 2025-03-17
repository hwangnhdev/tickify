<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Voucher List</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    </head>
    <body class="bg-gray-900 text-white">
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
                    <a class="flex items-center text-white bg-green-700 p-2 rounded" href="${pageContext.request.contextPath}/vouchers"><i class="fas fa-tags mr-2"></i>Voucher</a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="/Tickify/organizerOrders"><i class="fas fa-list mr-2"></i>Order List</a>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="flex-1 flex flex-col">
                <!-- Header -->
                <header class="flex justify-between items-center bg-gray-800 p-4 shadow-md">
                    <h1 class="text-2xl font-bold text-white">Voucher List</h1>
                    <div class="flex items-center space-x-4">
                        <button class="flex items-center text-white">
                            <img alt="User avatar" class="mr-2 rounded-full" height="30" src="https://storage.googleapis.com/a1aa/image/_qCewoK0KXQhWyQzRe9zG7PpYaYijDdWdPLzWZ3kkg8.jpg" width="30"/>
                            My Account
                        </button>
                    </div>
                </header>

                <!-- Main Section -->
                <section class="flex-1 p-4 overflow-y-auto">
                    <!-- Search Section -->
                    <div class="mb-4 flex flex-col sm:flex-row sm:items-center sm:justify-between p-3 bg-gray-800 p-4 rounded-lg shadow-md">
                        <!-- Search Form -->
                        <form action="searchVoucher" method="get" class="flex items-center mt-2 sm:mt-0">
                            <input type="hidden" name="eventId" value="${eventId}"/>
                            <div class="relative">
                                <input type="text" name="searchVoucher" placeholder="Search by voucher code" 
                                       class="p-1 pl-2 pr-8 text-sm rounded-l bg-gray-700 text-white border border-r-0 border-gray-600 focus:ring-1 focus:ring-green-500" />
                                <button type="submit" 
                                        class="absolute right-0 top-0 h-full bg-green-500 hover:bg-green-600 text-white px-2 py-1 rounded-r transition-colors duration-200">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>

                        <!-- Filter Form -->
                        <form action="${pageContext.request.contextPath}/vouchers" method="get" class="flex items-center space-x-2">
                            <input type="hidden" name="eventId" value="${eventId}"/>
                            <label for="voucherStatus" class="text-white text-sm font-medium">Status:</label>
                            <select name="voucherStatus" id="voucherStatus" class="p-1 text-sm rounded bg-gray-700 text-white border border-gray-600 focus:ring-1 focus:ring-green-500">
                                <option value="all" ${voucherStatus == 'all' ? 'selected' : ''}>All</option>
                                <option value="active" ${voucherStatus == 'active' ? 'selected' : ''}>Active</option>
                                <option value="inactive" ${voucherStatus == 'inactive' ? 'selected' : ''}>Inactive</option>
                            </select>
                            <button type="submit" class="bg-green-500 hover:bg-green-600 text-white text-sm p-1 px-2 rounded transition-colors duration-200">
                                <i class="fas fa-filter"></i>
                            </button>
                        </form>

                        <a href="${pageContext.request.contextPath}/createVoucher?eventId=${eventId}"
                           class="flex items-center bg-green-500 hover:bg-green-600 text-white text-sm font-medium py-1 px-3 rounded transition-colors duration-200">
                            Create Voucher
                        </a>
                    </div>

                    <!-- Vouchers Table -->
                    <div class="bg-gray-800 rounded-lg shadow-lg overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-700">
                            <thead class="bg-gray-700">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-id-badge mr-2"></i>Voucher ID
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-ticket-alt mr-2"></i>Voucher Code
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-align-left mr-2"></i>Description
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-calendar-alt mr-2"></i>Expiration Time
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-check-circle mr-2"></i>Status
                                    </th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-white uppercase tracking-wider">
                                        <i class="fas fa-tools mr-2"></i>Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-gray-800 divide-y divide-gray-700">
                                <c:forEach var="voucher" items="${vouchers}">
                                    <tr class="hover:bg-gray-700 transition-colors duration-150">
                                        <td class="px-6 py-4 text-sm">${voucher.voucherId}</td>
                                        <td class="px-6 py-4 text-sm">${voucher.code}</td>
                                        <td class="px-6 py-4 text-sm">${voucher.description}</td>
                                        <td class="px-6 py-4 text-sm">
                                            <div class="flex flex-col">
                                                <span class="${voucher.statusLabel == 'Ongoing' ? 'text-green-500' : 'text-red-500'}">
                                                    ${voucher.statusLabel}
                                                </span>
                                                ${voucher.formattedExpirationTime}
                                            </div></td>
                                        <td class="px-6 py-4 text-sm">
                                            <div class="flex flex-col">
                                                <span class="${voucher.status ? 'text-green-500' : 'text-red-500'}">
                                                    ${voucher.status ? 'Active' : 'Inactive'}
                                                </span>

                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-sm">
                                            <div class="flex space-x-2">
                                                <a href="editVoucher?voucherId=${voucher.voucherId}" 
                                                   class="text-white bg-green-600 hover:bg-green-700 px-2 py-1 rounded" 
                                                   title="Edit Voucher">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button onclick="showDeleteConfirm(${voucher.voucherId}, ${eventId})"
                                                        class="text-white bg-red-600 hover:bg-red-700 px-2 py-1 rounded"
                                                        title="Delete Voucher">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty vouchers}">
                                    <tr>
                                        <td colspan="6" class="px-6 py-4 text-center text-gray-400">No vouchers found.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Delete Confirmation Modal -->
                    <div id="deleteModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 overflow-y-auto h-full w-full z-50">
                        <div class="relative top-20 mx-auto p-5 border w-96 shadow-lg rounded-md bg-gray-800">
                            <div class="mt-3 text-center">
                                <h3 class="text-lg leading-6 font-medium text-white">Confirm Deletion</h3>
                                <div class="mt-2 px-7 py-3">
                                    <p class="text-sm text-gray-300">Are you sure you want to delete this voucher? This action cannot be undone.</p>
                                </div>
                                <div class="items-center px-4 py-3">
                                    <form id="deleteForm" method="post" action="${pageContext.request.contextPath}/DeleteVoucherController">
                                        <input type="hidden" name="voucherId" id="deleteVoucherId">
                                        <input type="hidden" name="eventId" id="deleteEventId">
                                        <button type="submit"
                                                class="px-4 py-2 bg-red-600 text-white text-base font-medium rounded-md w-32 mr-2 hover:bg-red-700">
                                            Delete
                                        </button>
                                        <button type="button" onclick="hideDeleteConfirm()"
                                                class="px-4 py-2 bg-gray-600 text-white text-base font-medium rounded-md w-32 hover:bg-gray-700">
                                            Cancel
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
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
                                <a href="${pageContext.request.contextPath}/vouchers?eventId=${eventId}&page=1" 
                                   class="px-3 py-1 bg-green-500 text-white rounded-l hover:bg-green-600">First</a>
                                <a href="${pageContext.request.contextPath}/vouchers?eventId=${eventId}&page=${currentPage - 1}" 
                                   class="px-3 py-1 bg-green-500 text-white hover:bg-green-600">Prev</a>
                            </c:if>
                            <c:if test="${startPage gt 1}">
                                <span class="px-3 py-1">...</span>
                            </c:if>
                            <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                <c:choose>
                                    <c:when test="${i eq currentPage}">
                                        <span class="px-3 py-1 bg-green-700 text-white font-bold rounded">${i}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="${pageContext.request.contextPath}/vouchers?eventId=${eventId}&page=${i}" 
                                           class="px-3 py-1 bg-green-500 text-white hover:bg-green-600 rounded">${i}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                            <c:if test="${endPage lt totalPages}">
                                <span class="px-3 py-1">...</span>
                            </c:if>
                            <c:if test="${currentPage lt totalPages}">
                                <a href="${pageContext.request.contextPath}/vouchers?eventId=${eventId}&page=${currentPage + 1}" 
                                   class="px-3 py-1 bg-green-500 text-white hover:bg-green-600">Next</a>
                                <a href="${pageContext.request.contextPath}/vouchers?eventId=${eventId}&page=${totalPages}" 
                                   class="px-3 py-1 bg-green-500 text-white rounded-r hover:bg-green-600">Last</a>
                            </c:if>
                        </div>
                    </c:if>
                </section>
            </main>
        </div>
        <script>
            function showDeleteConfirm(voucherId, eventId) {
                // Set the voucherId and eventId in the hidden form fields
                document.getElementById('deleteVoucherId').value = voucherId;
                document.getElementById('deleteEventId').value = eventId;

                // Show the modal
                document.getElementById('deleteModal').classList.remove('hidden');
            }

            function hideDeleteConfirm() {
                // Hide the modal
                document.getElementById('deleteModal').classList.add('hidden');
            }

            // Optional: Close modal when clicking outside
            window.onclick = function (event) {
                const modal = document.getElementById('deleteModal');
                if (event.target === modal) {
                    hideDeleteConfirm();
                }
            };
        </script>
    </body>
</html>