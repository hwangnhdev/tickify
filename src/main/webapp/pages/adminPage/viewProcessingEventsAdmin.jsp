<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
    <jsp:include page="header.jsp">
        <jsp:param name="pageTitle" value="Approve Events" />
    </jsp:include>
    <body class="bg-gray-100 font-sans antialiased">
        <!-- Sử dụng flex-col cho mobile và flex-row cho desktop -->
        <div class="flex flex-col md:flex-row h-screen">
            <jsp:include page="sidebar.jsp" />
            <!-- Main Content -->
            <div class="flex-1 p-6 overflow-auto">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Approve Events</h2>
                    <!-- Tab Navigation (Include chung) -->
                    <jsp:include page="tabNav.jsp" />

                    <!-- Search Bar (Responsive, full width trên mobile,  w-64 trên desktop) -->
                    <form id="filterForm" action="${pageContext.request.contextPath}/admin/viewProcessingEvents" method="get" class="mb-6 flex flex-wrap items-center justify-end gap-4">
                        <div class="relative w-full sm:w-64">
                            <input type="text" name="search" placeholder="Search events by name" 
                                   class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" 
                                   value="${param.search}">
                            <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                        </div>
                        <input type="submit" value="Search" class="bg-blue-600 text-white py-2 px-4 rounded">
                    </form>

                    <!-- Xác định hiển thị cột hành động nếu có sự kiện có trạng thái processing -->
                    <c:set var="showActionColumn" value="false" />
                    <c:forEach items="${events}" var="event">
                        <c:if test="${fn:toLowerCase(event.status) == 'processing'}">
                            <c:set var="showActionColumn" value="true" />
                        </c:if>
                    </c:forEach>

                    <!-- Bảng danh sách sự kiện -->
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">ID</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Event Name</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Location</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Event Type</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Status</th>
                                        <c:if test="${showActionColumn}">
                                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Actions</th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-100">
                                <c:forEach items="${events}" var="event">
                                    <tr class="hover:bg-gray-50 transition duration-150">
                                        <!-- ID -->
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${event.eventId}</td>
                                        <!-- Event Name: truncate nếu quá dài, hiển thị title để xem full -->
                                        <td class="px-6 py-4 whitespace-nowrap text-sm truncate" title="${event.eventName}">
                                            <c:url var="eventDetailUrl" value="/admin/viewEventDetail">
                                                <c:param name="eventId" value="${event.eventId}" />
                                                <c:param name="page" value="${page}" />
                                            </c:url>
                                            <a href="${eventDetailUrl}" class="text-blue-500 hover:underline">
                                                ${event.eventName}
                                            </a>
                                        </td>
                                        <!-- Location -->
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600 truncate" title="${event.location}">
                                            ${event.location}
                                        </td>
                                        <!-- Event Type -->
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600 truncate" title="${event.eventType}">
                                            ${event.eventType}
                                        </td>
                                        <!-- Status -->
                                        <td class="px-6 py-4 whitespace-nowrap text-sm">
                                            <span class="${event.status == 'Approved' ? 'bg-green-100 text-green-800' 
                                                           : event.status == 'Rejected' ? 'bg-red-100 text-red-800' 
                                                           : event.status == 'Completed' ? 'bg-gray-100 text-gray-800' 
                                                           : 'bg-yellow-100 text-yellow-800'} py-1 px-3 rounded-full">
                                                      ${event.status}
                                                  </span>
                                            </td>
                                            <c:if test="${fn:toLowerCase(event.status) == 'processing'}">
                                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                                    <div class="flex flex-col sm:flex-row gap-4">
                                                        <button type="button" onclick="updateEvent(${event.eventId}, 'Approved')"
                                                                class="w-full sm:w-1/2 bg-green-600 text-white py-2 px-6 rounded-full flex items-center justify-center hover:scale-105 transition transform focus:outline-none focus:ring-2 focus:ring-green-500">
                                                            <i class="fas fa-check-circle text-xl mr-2"></i>
                                                            <span class="truncate">Approve</span>
                                                        </button>
                                                        <button type="button" onclick="updateEvent(${event.eventId}, 'Rejected')"
                                                                class="w-full sm:w-1/2 bg-red-600 text-white py-2 px-6 rounded-full flex items-center justify-center hover:scale-105 transition transform focus:outline-none focus:ring-2 focus:ring-red-500">
                                                            <i class="fas fa-times-circle text-xl mr-2"></i>
                                                            <span class="truncate">Reject</span>
                                                        </button>
                                                    </div>
                                                </td>
                                            </c:if>

                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty events}">
                                        <tr>
                                            <td class="px-6 py-4 text-center text-gray-500" colspan="${showActionColumn ? 6 : 5}">
                                                No events found.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Phân trang -->
                        <jsp:include page="pagination.jsp">
                            <jsp:param name="baseUrl" value="${pageContext.request.contextPath}/admin/viewProcessingEvents" />
                            <jsp:param name="page" value="${page}" />
                            <jsp:param name="totalPages" value="${totalPages}" />
                            <jsp:param name="selectedStatus" value="processing" />
                        </jsp:include>
                    </div>
                </div>
            </div>

            <jsp:include page="footer.jsp" />

            <!-- JavaScript: SweetAlert for update confirmation -->
            <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
            <script>
                                                            function updateEvent(eventId, newStatus) {
                                                                var popupTitle, popupMessage, popupIcon;
                                                                if (newStatus === 'Approved') {
                                                                    popupTitle = "Approve Event";
                                                                    popupMessage = "Are you sure you want to approve event #" + eventId + "?";
                                                                    popupIcon = "info";
                                                                } else if (newStatus === 'Rejected') {
                                                                    popupTitle = "Reject Event";
                                                                    popupMessage = "Are you sure you want to reject event #" + eventId + "?";
                                                                    popupIcon = "error";
                                                                } else {
                                                                    popupTitle = "Confirm";
                                                                    popupMessage = "Do you want to update event #" + eventId + "?";
                                                                    popupIcon = "warning";
                                                                }
                                                                swal({
                                                                    title: popupTitle,
                                                                    text: popupMessage,
                                                                    icon: popupIcon,
                                                                    buttons: true,
                                                                    dangerMode: true,
                                                                }).then((willUpdate) => {
                                                                    if (willUpdate) {
                                                                        fetch('${pageContext.request.contextPath}/admin/approveEvent', {
                                                                            method: 'POST',
                                                                            headers: {
                                                                                'Content-Type': 'application/x-www-form-urlencoded'
                                                                            },
                                                                            body: 'eventId=' + eventId + '&newStatus=' + newStatus
                                                                        })
                                                                                .then(response => response.text())
                                                                                .then(result => {
                                                                                    if (result.trim() === 'success') {
                                                                                        swal("Success", "Event updated successfully!", "success")
                                                                                                .then(() => window.location.reload());
                                                                                    } else {
                                                                                        swal("Failed", "Failed to update event.", "error");
                                                                                    }
                                                                                })
                                                                                .catch(error => {
                                                                                    swal("Error", "Error: " + error, "error");
                                                                                });
                                                                    }
                                                                });
                                                            }
            </script>
        </body>
    </html>
