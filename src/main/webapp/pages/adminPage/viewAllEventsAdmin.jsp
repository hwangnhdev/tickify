<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">
    <jsp:include page="header.jsp">
        <jsp:param name="pageTitle" value="Event Management" />
    </jsp:include>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen">
            <jsp:include page="sidebar.jsp" />
            <!-- Main Content -->
            <div class="flex-1 p-6">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Event Management</h2>
                    <!-- Tab Navigation -->
                    <div class="mb-6 tab-nav border-b pb-2">
                        <c:url var="viewAllEventsUrl" value="/admin/viewAllEvents" />
                        <c:url var="viewApprovedEventsUrl" value="/admin/viewApprovedEvents" />
                        <c:url var="viewHistoryApprovedEventsUrl" value="/admin/viewHistoryApprovedEvents" />
                        <a class="${pageContext.request.requestURI.contains('viewAllEvents') ? 'active' : ''}" href="${viewAllEventsUrl}">View All</a>
                        <a class="${pageContext.request.requestURI.contains('viewApprovedEvents') ? 'active' : ''}" href="${viewApprovedEventsUrl}">View Approved</a>
                        <a class="${pageContext.request.requestURI.contains('viewHistoryApprovedEvents') ? 'active' : ''}" href="${viewHistoryApprovedEventsUrl}">View History Approved</a>
                    </div>
                    <!-- Filter and Search Bar -->
                    <form action="${viewAllEventsUrl}" class="mb-6 flex items-center justify-end space-x-4" method="get">
                        <div class="flex items-center space-x-2">
                            <label class="mr-2" for="statusFilter">Status:</label>
                            <select class="bg-gray-200 text-black p-2 rounded" id="statusFilter" name="status">
                                <option <c:if test="${empty selectedStatus}">selected</c:if> value="">All</option>
                                <option <c:if test="${selectedStatus == 'Active'}">selected</c:if> value="Active">Active</option>
                                <option <c:if test="${selectedStatus == 'Cancelled'}">selected</c:if> value="Cancelled">Cancelled</option>
                                <option <c:if test="${selectedStatus == 'Completed'}">selected</c:if> value="Completed">Completed</option>
                                <option <c:if test="${selectedStatus == 'Pending'}">selected</c:if> value="Pending">Pending</option>
                                </select>
                            </div>
                            <input class="bg-blue-600 text-white py-2 px-4 rounded" type="submit" value="Filter"/>
                            <div class="relative w-64">
                                <input class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" placeholder="Search events by name" type="text" name="search"/>
                                <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                            </div>
                            <input class="bg-blue-600 text-white py-2 px-4 rounded" type="submit" value="Search"/>
                        </form>

                        <!-- Thêm code để kiểm tra có sự kiện nào Pending -->
                    <c:set var="showActionColumn" value="false" />
                    <c:forEach items="${events}" var="event">
                        <c:if test="${event.status == 'Pending'}">
                            <c:set var="showActionColumn" value="true" />
                        </c:if>
                    </c:forEach>

                    <!-- Event List Table -->
                    <div class="overflow-x-auto">
                        <table class="min-w-full bg-white border border-gray-300 rounded-lg shadow-md">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th class="px-6 py-3 text-left">ID</th>
                                    <th class="px-6 py-3 text-left">Event Name</th>
                                    <th class="px-6 py-3 text-left">Location</th>
                                    <th class="px-6 py-3 text-left">Event Type</th>
                                    <th class="px-6 py-3 text-left">Status</th>
                                    <!-- Chỉ hiển thị cột Actions nếu có sự kiện nào Pending -->
                                    <c:if test="${showActionColumn}">
                                        <th class="px-6 py-3 text-left">Actions</th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${events}" var="event">
                                    <tr class="hover:bg-gray-100 transition duration-200">
                                        <td class="px-6 py-4">${event.eventId}</td>
                                        <td class="px-6 py-4">
                                            <c:url var="eventDetailUrl" value="/admin/viewEventDetail">
                                                <c:param name="eventId" value="${event.eventId}" />
                                                <c:param name="page" value="${page}" />
                                            </c:url>
                                            <a class="event-name text-blue-500" href="${eventDetailUrl}">
                                                ${event.eventName}
                                            </a>
                                        </td>
                                        <td class="px-6 py-4">${event.location}</td>
                                        <td class="px-6 py-4">${event.eventType}</td>
                                        <td class="px-6 py-4">
                                            <span class="${event.status == 'Active' ? 'bg-green-100 text-green-800' : event.status == 'Cancelled' ? 'bg-red-100 text-red-800' : event.status == 'Completed' ? 'bg-gray-100 text-gray-800' : 'bg-yellow-100 text-yellow-800'} py-1 px-3 rounded-full text-xs">
                                                ${event.status}
                                            </span>
                                        </td>
                                        <!-- Chỉ hiển thị cột Actions nếu showActionColumn true -->
                                        <c:if test="${showActionColumn}">
                                            <td class="px-6 py-4">
                                                <c:if test="${event.status == 'Pending'}">
                                                    <button class="bg-green-600 text-white py-2 px-4 rounded mr-2" onclick="updateEvent(${event.eventId}, 'Active')">
                                                        Accept
                                                    </button>
                                                    <button class="bg-red-600 text-white py-2 px-4 rounded" onclick="updateEvent(${event.eventId}, 'Rejected')">
                                                        Reject
                                                    </button>
                                                </c:if>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty events}">
                                    <tr>
                                        <td class="text-center py-4 text-gray-500" colspan="${showActionColumn ? 6 : 5}">No events found.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Update: Sử dụng file phân trang tái sử dụng (không xóa code khác của bạn) -->
                    <jsp:include page="pagination.jsp">
                        <jsp:param name="baseUrl" value="/admin/viewAllEvents" />
                        <jsp:param name="page" value="${page}" />
                        <jsp:param name="totalPages" value="${totalPages}" />
                        <jsp:param name="selectedStatus" value="${selectedStatus}" />
                    </jsp:include>

                    <!-- End phân trang -->

                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
        <script>
            function updateEvent(eventId, newStatus) {
                var actionText = newStatus === 'Active' ? 'accept' : 'reject';
                swal({
                    title: "Are you sure?",
                    text: "Do you want to " + actionText + " event #" + eventId + "?",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
                        .then((willUpdate) => {
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
