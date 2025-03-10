<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
  <jsp:include page="header.jsp">
    <jsp:param name="pageTitle" value="Approved Event Management" />
  </jsp:include>
  <body class="bg-gray-100 font-sans antialiased">
    <div class="flex h-screen">
      <jsp:include page="sidebar.jsp" />
      <!-- Main Content -->
      <div class="flex-1 p-6">
        <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
          <h2 class="text-3xl font-bold mb-6">Approved Event Management</h2>
          
          <!-- Tab Navigation -->
          <div class="mb-6 border-b pb-2 flex space-x-4">
            <c:url var="viewAllEventsUrl" value="/admin/viewAllEvents" />
            <c:url var="viewApprovedEventsUrl" value="/admin/viewApprovedEvents" />
            <c:url var="viewHistoryApprovedEventsUrl" value="/admin/viewHistoryApprovedEvents" />
            <a class="py-2 px-4 font-medium hover:text-blue-500 ${pageContext.request.requestURI.contains('viewAllEvents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" href="${viewAllEventsUrl}">View All</a>
            <a class="py-2 px-4 font-medium hover:text-blue-500 ${pageContext.request.requestURI.contains('viewApprovedEvents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" href="${viewApprovedEventsUrl}">View Approved</a>
            <a class="py-2 px-4 font-medium hover:text-blue-500 ${pageContext.request.requestURI.contains('viewHistoryApprovedEvents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" href="${viewHistoryApprovedEventsUrl}">View History Approved</a>
          </div>

          <!-- Independent Search Bar for Approved Events -->
          <form action="viewApprovedEvents" method="get" class="flex justify-end items-center mb-6">
            <div class="relative w-64">
              <input 
                type="text" 
                name="search" 
                placeholder="Search events by name" 
                value="${searchKeyword}" 
                class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full"
              >
              <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
            </div>
            <button type="submit" class="ml-2 bg-blue-600 text-white py-2 px-4 rounded">Search</button>
          </form>

          <!-- Event List Table -->
          <div class="overflow-x-auto">
            <table class="min-w-full divide-y divide-gray-200">
              <thead class="bg-gray-200">
                <tr>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">ID</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Event Name</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Location</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Event Type</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Status</th>
                  <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Approved Date</th>
                </tr>
              </thead>
              <tbody class="bg-white divide-y divide-gray-100">
                <c:forEach items="${events}" var="event">
                  <tr class="hover:bg-gray-50 transition duration-150">
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">${event.eventId}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm">
                      <c:url var="eventDetailUrl" value="/admin/viewApprovedDetail">
                        <c:param name="eventId" value="${event.eventId}" />
                        <c:param name="page" value="${page}" />
                      </c:url>
                      <a href="${eventDetailUrl}" class="text-blue-500 hover:underline" title="${event.eventName}">
                        ${event.eventName}
                      </a>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600" title="${event.location}">${event.location}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600" title="${event.eventType}">${event.eventType}</td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm">
                      <span class="${event.status == 'Active' ? 'bg-green-100 text-green-800' : event.status == 'Cancelled' ? 'bg-red-100 text-red-800' : event.status == 'Completed' ? 'bg-gray-100 text-gray-800' : 'bg-yellow-100 text-yellow-800'} py-1 px-3 rounded-full">
                        ${event.status}
                      </span>
                    </td>
                    <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-600">
                      <fmt:formatDate value="${event.approvedAt}" pattern="dd/MM/yyyy HH:mm" />
                    </td>
                  </tr>
                </c:forEach>
                <c:if test="${empty events}">
                  <tr>
                    <td class="px-6 py-4 text-center text-gray-500" colspan="6">No events found.</td>
                  </tr>
                </c:if>
              </tbody>
            </table>
          </div>

          <!-- Pagination -->
          <jsp:include page="pagination.jsp">
            <jsp:param name="baseUrl" value="/admin/viewApprovedEvents" />
            <jsp:param name="page" value="${page}" />
            <jsp:param name="totalPages" value="${totalPages}" />
            <jsp:param name="selectedStatus" value="${selectedStatus}" />
          </jsp:include>
        </div>
      </div>
    </div>
    <jsp:include page="footer.jsp" />
  </body>
</html>
