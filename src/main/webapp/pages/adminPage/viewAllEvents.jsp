<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>View All Events - Admin</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <body class="bg-gray-50">
        <!-- Header -->
        <header class="bg-green-500 p-4 flex justify-between items-center">
            <div class="text-white text-3xl font-bold">ticketbox Admin</div>
            <nav class="space-x-4">
                <a href="${pageContext.request.contextPath}/viewEvents" class="text-white hover:underline">View All Events</a>
                <!-- Các liên kết quản lý khác nếu cần -->
            </nav>
        </header>

        <!-- Main Content -->
        <main class="max-w-7xl mx-auto p-6">
            <h1 class="text-2xl font-bold mb-6">Danh sách sự kiện</h1>

            <!-- Danh sách sự kiện theo dạng card -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <c:forEach var="event" items="${events}">
                    <div class="bg-white shadow rounded-lg overflow-hidden">
                        <c:if test="${not empty event.imageUrl}">
                            <img src="${event.imageUrl}" alt="${event.eventName}" class="w-full h-48 object-cover">
                        </c:if>
                        <div class="p-4">
                            <h2 class="text-xl font-bold mb-2">${event.eventName}</h2>
                            <p class="text-gray-600 mb-1"><strong>Location:</strong> ${event.location}</p>
                            <p class="text-gray-600 mb-1"><strong>Type:</strong> ${event.eventType}</p>
                            <p class="text-gray-500 text-sm mb-1">
                                <strong>Start:</strong> <fmt:formatDate value="${event.startDate}" pattern="dd MMM, yyyy" />
                            </p>
                            <p class="text-gray-500 text-sm mb-1">
                                <strong>End:</strong> <fmt:formatDate value="${event.endDate}" pattern="dd MMM, yyyy" />
                            </p>
                            <p class="text-gray-600 mb-2"><strong>Status:</strong> ${event.eventStatus}</p>
                            <p class="text-gray-500 text-sm mb-2">${event.description}</p>
                            <a href="${pageContext.request.contextPath}/OrganizerEventDetailController?eventId=${event.eventId}"
                               class="inline-block bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600">
                                Manage
                            </a>
                        </div>
                    </div>
                </c:forEach>
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
                        <a href="${pageContext.request.contextPath}/admin/viewEvents?page=1" class="px-3 py-1 bg-blue-500 text-white rounded-l hover:bg-blue-600">First</a>
                        <a href="${pageContext.request.contextPath}/admin/viewEvents?page=${currentPage - 1}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600">Prev</a>
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
                                <a href="${pageContext.request.contextPath}/admin/viewEvents?page=${i}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600 rounded">${i}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${endPage lt totalPages}">
                        <span class="px-3 py-1">...</span>
                    </c:if>
                    <c:if test="${currentPage lt totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/viewEvents?page=${currentPage + 1}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600">Next</a>
                        <a href="${pageContext.request.contextPath}/admin/viewEvents?page=${totalPages}" class="px-3 py-1 bg-blue-500 text-white rounded-r hover:bg-blue-600">Last</a>
                    </c:if>
                </div>
            </c:if>
        </main>
    </body>
</html>
