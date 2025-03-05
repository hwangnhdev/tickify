<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- Navigation Tabs -->
<div class="mb-6 tab-nav border-b pb-2">
  <a class="${pageContext.request.requestURI.contains('viewAllEvents') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/viewAllEvents">View All</a>
  <a class="${pageContext.request.requestURI.contains('viewApprovedEvents') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/viewApprovedEvents">View Approved</a>
  <a class="${pageContext.request.requestURI.contains('viewHistoryApprovedEvents') ? 'active' : ''}" href="${pageContext.request.contextPath}/admin/viewHistoryApprovedEvents">View History Approved</a>
</div>

<!-- Search & Filter Form -->
<form action="${pageContext.request.contextPath}/admin/${param.searchAction}" class="mb-6 flex items-center justify-end space-x-4" method="get">
  <!-- N?u trang là View All thì hi?n th? filter tr?ng thái -->
  <c:if test="${param.searchAction eq 'viewAllEvents'}">
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
  </c:if>
  
  <!-- Thanh tìm ki?m chung -->
  <div class="relative w-64">
    <input class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" placeholder="Search events" type="text" name="search"/>
    <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
  </div>
  <input class="bg-blue-600 text-white py-2 px-4 rounded" type="submit" value="Search"/>
</form>
