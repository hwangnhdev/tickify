<%-- 
    Document   : revenue
    Created on : Mar 12, 2025, 6:24:36 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <jsp:include page="header.jsp">
        <jsp:param name="pageTitle" value="Revenue Management" />
    </jsp:include>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen">
            <jsp:include page="sidebar.jsp" />
            <div class="flex-1 p-6">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Revenue Management</h2>

                    <!-- Filter and Search Bar -->
                    <form id="filterForm" action="${viewAllEventsUrl}" method="get" class="mb-6 flex flex-wrap items-center justify-end gap-4">
                        <div class="flex items-center space-x-2">
                            <label for="statusFilter" class="mr-2">Status:</label>
                            <select id="statusFilter" name="status" class="bg-gray-200 text-black p-2 rounded" onchange="this.form.submit()">
                                <option <c:if test="${empty selectedStatus}">selected</c:if> value="">All</option>
                                <option <c:if test="${selectedStatus == 'Active'}">selected</c:if> value="Active">Active</option>
                                <option <c:if test="${selectedStatus == 'Rejected'}">selected</c:if> value="Rejected">Rejected</option>
                                <option <c:if test="${selectedStatus == 'Pending'}">selected</c:if> value="Pending">Pending</option>
                                </select>
                            </div>
                            <div class="relative w-64">
                                <input type="text" name="search" placeholder="Search events by name" class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" value="${param.search}">
                            <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                        </div>
                        <input type="submit" value="Search" class="bg-blue-600 text-white py-2 px-4 rounded">
                    </form>
                            
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">ID</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Event Name</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Total Tickets Sold</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Total Revenue</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Start Date</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">End Date</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-100">
                                <c:forEach items="${revenues}" var="revenue">
                                    <tr class="hover:bg-gray-50 transition duration-150">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${revenue.eventId}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                            <c:url var="eventDetailUrl" value="/admin/revenueDetail">
                                                <c:param name="eventId" value="${revenue.eventId}" />
                                                <c:param name="eventName" value="${revenue.eventName}" />
                                                <c:param name="totalRevenue" value="${revenue.totalRevenue}" />
                                            </c:url>
                                            <a href="${eventDetailUrl}" class="text-blue-500 hover:underline">
                                                ${revenue.eventName}
                                            </a>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${revenue.totalTicketsSold}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                            <fmt:formatNumber value="${revenue.totalRevenue}" currencyCode="VND" minFractionDigits="0" /> VND
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                            <fmt:formatDate value="${revenue.startDate}" pattern="HH:mm" var="formattedTime"/>
                                            <fmt:formatDate value="${revenue.startDate}" pattern="dd MMM, yyyy" var="formattedDate"/>
                                            ${formattedTime} - ${formattedDate}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                            <fmt:formatDate value="${revenue.endDate}" pattern="HH:mm" var="formattedTime"/>
                                            <fmt:formatDate value="${revenue.endDate}" pattern="dd MMM, yyyy" var="formattedDate"/>
                                            ${formattedTime} - ${formattedDate}
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty revenues}">
                                    <tr>
                                        <td class="px-6 py-4 text-center text-gray-500" colspan="6">
                                            No revenue data available.
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>

