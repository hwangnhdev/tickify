 <!-- Tab Navigation -->
        <div class="mb-6 tab-nav border-b pb-2">
          <c:url var="viewAllEventsUrl" value="/admin/viewAllEvents" />
          <c:url var="viewApprovedEventsUrl" value="/admin/viewApprovedEvents" />
          <c:url var="viewHistoryApprovedEventsUrl" value="/admin/viewHistoryApprovedEvents" />
          <a class="${pageContext.request.requestURI.contains('viewAllEvents') ? 'active' : ''} mr-4" href="${viewAllEventsUrl}">View All</a>
          <a class="${pageContext.request.requestURI.contains('viewApprovedEvents') ? 'active' : ''} mr-4" href="${viewApprovedEventsUrl}">View Approved</a>
          <a class="${pageContext.request.requestURI.contains('viewHistoryApprovedEvents') ? 'active' : ''}" href="${viewHistoryApprovedEventsUrl}">View History Approved</a>
        </div>

        <!-- Filter and Search Bar -->
        <form action="${viewAllEventsUrl}" class="mb-6 flex flex-wrap items-center justify-end gap-4" method="get">
          <div class="flex items-center space-x-2">
            <label for="statusFilter" class="mr-2">Status:</label>
            <select id="statusFilter" name="status" class="bg-gray-200 text-black p-2 rounded">
              <option <c:if test="${empty selectedStatus}">selected</c:if> value="">All</option>
              <option <c:if test="${selectedStatus == 'Active'}">selected</c:if> value="Active">Active</option>
              <option <c:if test="${selectedStatus == 'Rejected'}">selected</c:if> value="Rejected">Rejected</option>
              <option <c:if test="${selectedStatus == 'Pending'}">selected</c:if> value="Pending">Pending</option>
            </select>
          </div>
          <input type="submit" value="Filter" class="bg-blue-600 text-white py-2 px-4 rounded">
          <div class="relative w-64">
            <input type="text" name="search" placeholder="Search events by name" class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full">
            <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
          </div>
          <input type="submit" value="Search" class="bg-blue-600 text-white py-2 px-4 rounded">
        </form>