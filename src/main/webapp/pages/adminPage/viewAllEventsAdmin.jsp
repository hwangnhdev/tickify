<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
    <jsp:include page="header.jsp">
        <jsp:param name="pageTitle" value="Event Management" />
    </jsp:include>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen">
            <jsp:include page="sidebar.jsp" />
            <!-- Main Content -->
            <div class="flex-1 p-6 overflow-y-auto">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Event Management</h2>
                    <jsp:include page="tabNav.jsp" />

                    <!-- Filter and Search Bar -->
                    <form id="filterForm" action="${viewAllEventsUrl}" method="get" class="mb-6 flex flex-wrap items-center justify-end gap-4">
                        <div class="flex items-center space-x-2">
                            <label for="statusFilter" class="mr-2">Status:</label>
                            <select id="statusFilter" name="status" class="bg-gray-200 text-black p-2 rounded" onchange="this.form.submit()">
                                <option <c:if test="${empty selectedStatus}">selected</c:if> value="">All</option>
                                <option <c:if test="${selectedStatus == 'Approved'}">selected</c:if> value="Approved">Approved</option>
                                <option <c:if test="${selectedStatus == 'Rejected'}">selected</c:if> value="Rejected">Rejected</option>
                                <option <c:if test="${selectedStatus == 'processing'}">selected</c:if> value="processing">Processing</option>
                                </select>
                            </div>
                            <div class="relative w-64">
                                <input type="text" name="search" placeholder="Search events by name" 
                                       class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" 
                                       value="${param.search}">
                            <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                        </div>
                        <input type="submit" value="Search" class="bg-blue-600 text-white py-2 px-4 rounded">
                    </form>

                    <!-- Event List Table (View-only) -->
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">ID</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Event Name</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Location</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Event Type</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Status</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-100">
                                <c:forEach items="${events}" var="event">
                                    <tr class="hover:bg-gray-50 transition duration-150">
                                        <td class="px-6 py-4 text-sm text-gray-600">${event.eventId}</td>
                                        <td class="px-6 py-4 text-sm">
                                            <c:url var="eventDetailUrl" value="/admin/viewEventDetail">
                                                <c:param name="eventId" value="${event.eventId}" />
                                                <c:param name="page" value="${page}" />
                                            </c:url>
                                            <a href="${eventDetailUrl}" class="text-blue-500 hover:underline truncate" title="${event.eventName}">
                                                ${event.eventName}
                                            </a>
                                        </td>
                                        <td class="px-6 py-4 text-sm text-gray-600 truncate" title="${event.location}">
                                            ${event.location}
                                        </td>
                                        <td class="px-6 py-4 text-sm text-gray-600 truncate" title="${event.eventType}">
                                            ${event.eventType}
                                        </td>
                                        <td class="px-6 py-4 text-sm">
                                            <span class="${event.status == 'Approved' ? 'bg-green-100 text-green-800' 
                                                           : event.status == 'Rejected' ? 'bg-red-100 text-red-800' 
                                                           : event.status == 'Completed' ? 'bg-gray-100 text-gray-800' 
                                                           : 'bg-yellow-100 text-yellow-800'} py-1 px-3 rounded-full">
                                                      ${event.status}
                                                  </span>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty events}">
                                        <tr>
                                            <td class="px-6 py-4 text-center text-gray-500" colspan="5">
                                                No events found.
                                            </td>
                                        </tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>

                        <!-- Pagination -->
                        <jsp:include page="pagination.jsp">
                            <jsp:param name="baseUrl" value="/admin/viewAllEvents" />
                            <jsp:param name="page" value="${page}" />
                            <jsp:param name="totalPages" value="${totalPages}" />
                            <jsp:param name="selectedStatus" value="${selectedStatus}" />
                        </jsp:include>
                    </div>
                </div>
            </div>

        </body>
    </html>
