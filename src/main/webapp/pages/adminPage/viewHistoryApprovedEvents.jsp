<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="header.jsp" %>

<div class="flex h-screen">
  <%-- Include Sidebar từ file sidebar.jsp --%>
  <%@ include file="sidebar.jsp" %>
  
  <!-- Main Content -->
  <div class="flex-1 p-6">
    <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
      <h2 class="text-3xl font-bold mb-6">Approved Events History</h2>
      
      <!-- Bảng danh sách sự kiện -->
      <div class="overflow-x-auto">
        <table class="min-w-full bg-white border border-gray-300 rounded-lg shadow-md">
          <thead class="bg-gray-200">
            <tr>
              <th class="px-6 py-3 text-left">ID</th>
              <th class="px-6 py-3 text-left">Event Name</th>
              <th class="px-6 py-3 text-left">Location</th>
              <th class="px-6 py-3 text-left">Event Type</th>
              <th class="px-6 py-3 text-left">Approved Time</th>
              <th class="px-6 py-3 text-left">Status</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach items="${events}" var="event">
              <tr class="hover:bg-gray-100 transition duration-200">
                <td class="px-6 py-4">${event.eventId}</td>
                <td class="px-6 py-4">
                  <a class="event-name text-blue-500" href="${pageContext.request.contextPath}/admin/viewEventDetail?eventId=${event.eventId}&amp;page=${page}">
                    ${event.eventName}
                  </a>
                </td>
                <td class="px-6 py-4">${event.location}</td>
                <td class="px-6 py-4">${event.eventType}</td>
                <td class="px-6 py-4">
                  <c:if test="${not empty event.updatedAt}">
                    <fmt:formatDate value="${event.updatedAt}" pattern="yyyy-MM-dd HH:mm:ss" />
                  </c:if>
                </td>
                <td class="px-6 py-4">
                  <span class="${event.status eq 'HistoryApproved' ? 'bg-blue-100 text-blue-800' : 'bg-yellow-100 text-yellow-800'} py-1 px-3 rounded-full text-xs">
                    ${event.status}
                  </span>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty events}">
              <tr>
                <td colspan="6" class="text-center py-4 text-gray-500">No approved events history found.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
      
      <!-- Phân trang -->
      <c:if test="${totalPages > 1}">
        <div class="mt-6 flex justify-center items-center space-x-4">
          <c:if test="${page > 1}">
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${pageContext.request.contextPath}/admin/viewHistoryApprovedEvents?page=1">First</a>
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${pageContext.request.contextPath}/admin/viewHistoryApprovedEvents?page=${page - 1}">Prev</a>
          </c:if>
          <c:forEach begin="1" end="${totalPages}" var="i">
            <c:choose>
              <c:when test="${i eq page}">
                <span class="bg-blue-500 text-white py-2 px-4 rounded">${i}</span>
              </c:when>
              <c:otherwise>
                <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${pageContext.request.contextPath}/admin/viewHistoryApprovedEvents?page=${i}">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:forEach>
          <c:if test="${page < totalPages}">
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${pageContext.request.contextPath}/admin/viewHistoryApprovedEvents?page=${page + 1}">Next</a>
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${pageContext.request.contextPath}/admin/viewHistoryApprovedEvents?page=${totalPages}">Last</a>
          </c:if>
        </div>
      </c:if>
      
    </div>
  </div>
</div>

<%@ include file="footer.jsp" %>
