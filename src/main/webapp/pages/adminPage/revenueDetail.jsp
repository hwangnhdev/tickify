<%-- 
    Document   : revenueDetail
    Created on : Mar 13, 2025, 1:32:32 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Revenue Detail</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
        </style>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen">
            <jsp:include page="sidebar.jsp" />
            <div class="flex-1 p-6">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Revenue Detail</h2>
                    
<!--                     Tab Navigation 
                    <div class="mb-6 border-b pb-2 flex space-x-4">
                        <c:url var="viewAllEventsUrl" value="/admin/viewAllEvents" />
                        <c:url var="viewApprovedEventsUrl" value="/admin/viewApprovedEvents" />
                        <c:url var="viewHistoryApprovedEventsUrl" value="/admin/viewHistoryApprovedEvents" />
                        <a class="py-2 px-4 font-medium hover:text-blue-500 ${pageContext.request.requestURI.contains('viewAllEvents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" href="${viewAllEventsUrl}">View All</a>
                        <a class="py-2 px-4 font-medium hover:text-blue-500 ${pageContext.request.requestURI.contains('viewApprovedEvents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" href="${viewApprovedEventsUrl}">View Approved</a>
                        <a class="py-2 px-4 font-medium hover:text-blue-500 ${pageContext.request.requestURI.contains('viewHistoryApprovedEvents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" href="${viewHistoryApprovedEventsUrl}">View History Approved</a>
                    </div> comment -->
                    
                    <div class="bg-gray-100 p-4 rounded-lg mb-6">
                        <p><strong>Event ID:</strong> ${eventId}</p>
                        <p><strong>Event Name:</strong> ${eventName}</p>
                        <p><strong>Total Revenue:</strong>
                           <fmt:formatNumber value="${totalRevenue}" currencyCode="VND" minFractionDigits="0" /> VND
                        </p>
                    </div>
                    <div class="overflow-x-auto max-h-96">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Ticket Type</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Total Quantity</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Price</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Quantity Sold</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Total Revenue</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-100">
                                <c:forEach items="${revenueDetails}" var="revenueDetail">
                                    <tr class="hover:bg-gray-50 transition duration-150">
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${revenueDetail.name}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${revenueDetail.totalQuantity}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                            <fmt:formatNumber value="${revenueDetail.price}" currencyCode="VND" minFractionDigits="0" /> VND
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${revenueDetail.soldQuantity}</td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                            <fmt:formatNumber value="${revenueDetail.totalRevenuePerTicketType}" currencyCode="VND" minFractionDigits="0" /> VND
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
