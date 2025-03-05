<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
    <jsp:include page="header.jsp">
        <jsp:param name="pageTitle" value="History Approved Event Management" />
    </jsp:include>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen">
            <jsp:include page="sidebar.jsp" />
            <!-- Main Content -->
            <div class="flex-1 p-6">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">History Approved Event Management</h2>

                    <!-- Tab Navigation -->
                    <div class="mb-6 tab-nav border-b pb-2">
                        <c:url var="viewAllEventsUrl" value="/admin/viewAllEvents" />
                        <c:url var="viewApprovedEventsUrl" value="/admin/viewApprovedEvents" />
                        <c:url var="viewHistoryApprovedEventsUrl" value="/admin/viewHistoryApprovedEvents" />
                        <a class="${pageContext.request.requestURI.contains('viewAllEvents') ? 'active' : ''}" href="${viewAllEventsUrl}">View All</a>
                        <a class="${pageContext.request.requestURI.contains('viewApprovedEvents') ? 'active' : ''}" href="${viewApprovedEventsUrl}">View Approved</a>
                        <a class="${pageContext.request.requestURI.contains('viewHistoryApprovedEvents') ? 'active' : ''}" href="${viewHistoryApprovedEventsUrl}">View History Approved</a>
                    </div>

                    <!-- Search Bar -->
                    <form action="${viewHistoryApprovedEventsUrl}" class="mb-6 flex items-center justify-end space-x-4" method="get">
                        <div class="relative w-64">
                            <input class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full"
                                   placeholder="Search events by name" type="text" name="search" value="${param.search}" />
                            <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                        </div>
                        <input class="bg-blue-600 text-white py-2 px-4 rounded" type="submit" value="Search"/>
                    </form>

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
                                    <th class="px-6 py-3 text-left">Approved Date</th>
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
                                            <span class="${event.status == 'Completed' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800'} py-1 px-3 rounded-full text-xs">
                                                ${event.status}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <fmt:formatDate value="${event.approvedAt}" pattern="dd/MM/yyyy HH:mm" />
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty events}">
                                    <tr>
                                        <td class="text-center py-4 text-gray-500" colspan="6">No events found.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <jsp:include page="pagination.jsp">
                        <jsp:param name="baseUrl" value="/admin/viewHistoryApprovedEvents" />
                        <jsp:param name="page" value="${page}" />
                        <jsp:param name="totalPages" value="${totalPages}" />
                    </jsp:include>


                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>
