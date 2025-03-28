<%-- 
    Document   : revenueDetail
    Created on : Mar 13, 2025, 1:32:32 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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

                    <div class="bg-gray-100 p-4 rounded-lg mb-6">
                        <p><strong>Event ID:</strong> ${eventId}</p>
                        <p><strong>Event Name:</strong> ${eventName}</p>
                        <p><strong>Total Revenue:</strong>
                            <fmt:formatNumber value="${totalRevenue}" currencyCode="VND" minFractionDigits="0" /> VND
                        </p>
                    </div>
                    <div class="mb-6">
                        <h3 class="text-xl font-semibold mb-4">Showtimes</h3>

                        <div class="space-y-4">
                            <c:forEach var="showtime" items="${showtimeList}">
                                <div class="bg-blue-100 p-4 rounded-lg" onclick="toggleDropdown('dropdown${showtime.getShowtimeId()}')">
                                    <div class="flex justify-between items-center">
                                        <p class="font-medium">Showtime ${showtime.getShowtimeId()}</p>
                                        <button class="text-blue-500">
                                            <i class="fas fa-chevron-down"></i>
                                        </button>
                                    </div>
                                    <div id="dropdown${showtime.getShowtimeId()}" class="hidden mt-4 bg-white p-4 rounded-lg">
                                        <table class="min-w-full divide-y divide-gray-200">
                                            <thead class="bg-gray-100">
                                                <tr>
                                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Ticket Type</th>
                                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Price</th>
                                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Quantity Sold</th>
                                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Total Revenue</th>
                                                </tr>
                                            </thead>
                                            <tbody class="bg-white divide-y divide-gray-100">
                                                <c:forEach var="ticketType" items="${showtime.ticketTypes}">
                                                    <tr class="hover:bg-gray-50 transition duration-150">
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${ticketType.name}</td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                                            <fmt:formatNumber value="${ticketType.price}" currencyCode="VND" minFractionDigits="0" /> VND
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                                            <c:choose>
                                                                <c:when test="${not empty ticketType.tickets}">
                                                                    ${fn:length(ticketType.tickets)}
                                                                </c:when>
                                                                <c:otherwise>0</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                                                            <c:choose>
                                                                <c:when test="${not empty ticketType.tickets}">
                                                                    <fmt:formatNumber value="${ticketType.price*fn:length(ticketType.tickets)}" currencyCode="VND" minFractionDigits="0" /> VND
                                                                </c:when>
                                                                <c:otherwise>0</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
                        
        <script>
            function toggleDropdown(id) {
                const dropdown = document.getElementById(id);
                if (dropdown.classList.contains('hidden')) {
                    dropdown.classList.remove('hidden');
                } else {
                    dropdown.classList.add('hidden');
                }
            }
        </script>
    </body>
</html>
