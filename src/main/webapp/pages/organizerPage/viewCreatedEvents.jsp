<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>My Ticket - Organizer Center</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
      rel="stylesheet"
    />
  </head>
  <body class="bg-gray-900 text-white">
    <!-- Navigation Bar -->
    <nav class="flex items-center justify-between p-4 bg-gray-900">
      <div class="text-white text-xl font-bold">
        My event
      </div>
      <div class="flex items-center space-x-4">
        <button class="bg-green-500 text-white px-4 py-2 rounded-full flex items-center">
          <i class="fas fa-plus mr-2"></i>
          Create Event
        </button>
        <div class="flex items-center space-x-2">
          <img alt="User avatar" class="w-8 h-8 rounded-full" height="30" src="https://storage.googleapis.com/a1aa/image/5iVEPfopVewyc6JPVATLTnxtc7aAiGv8cEmQdRmfVUY.jpg" width="30"/>
          <span class="text-white">My Account</span>
          <i class="fas fa-caret-down text-white"></i>
        </div>
      </div>
    </nav>

    <!-- Container full height -->
    <div class="flex h-screen">
      <!-- Sidebar (Full height) -->
      <div class="w-1/4 bg-gray-800 p-4 h-full">
        <div class="text-green-500 text-2xl font-bold mb-6">
          Organizer Center
        </div>
        <ul>
          <!-- Menu My Ticket: đặt làm mặc định -->
          <li class="mb-4">
            <a class="flex items-center text-white hover:underline" href="${pageContext.request.contextPath}/myTicket">
              <i class="fas fa-ticket-alt mr-2"></i> My Ticket
            </a>
          </li>
          <li class="mb-4">
            <a class="flex items-center text-white hover:underline" href="${pageContext.request.contextPath}/reportManagement">
              <i class="fas fa-file-alt mr-2"></i> Report Management
            </a>
          </li>
          <li>
            <a class="flex items-center text-white hover:underline" href="${pageContext.request.contextPath}/termsForOrganizers">
              <i class="fas fa-file-contract mr-2"></i> Terms for Organizers
            </a>
          </li>
        </ul>
      </div>

      <!-- Main Content -->
      <div class="flex-1 p-4 h-full overflow-auto">
        <!-- Header -->
        <div class="flex justify-between items-center mb-4">
          <h1 class="text-2xl font-bold">Danh sách Sự kiện đã Tạo</h1>
          <div class="flex items-center">
            <i class="fas fa-user-circle text-2xl"></i>
          </div>
        </div>

        <!-- Search Bar -->
        <form method="get" action="${pageContext.request.contextPath}/viewCreatedEvents" class="flex items-center mb-4">
          <input
            name="query"
            class="bg-gray-700 text-white px-4 py-2 rounded-l w-full"
            placeholder="Search event"
            type="text"
          />
          <button
            type="submit"
            class="bg-gray-600 text-white px-4 py-2 rounded-r hover:bg-green-600 transition-colors"
          >
            Search
          </button>
        </form>

        <!-- Các nút lọc theo status -->
        <div class="flex space-x-2 mb-4">
          <a
            href="${pageContext.request.contextPath}/viewCreatedEvents?status=all"
            class="p-2 w-full rounded-md text-center ${currentStatus == 'all' ? 'bg-green-500' : 'bg-gray-700'} text-white"
          >
            All
          </a>
          <a
            href="${pageContext.request.contextPath}/viewCreatedEvents?status=pending"
            class="p-2 w-full rounded-md text-center ${currentStatus == 'pending' ? 'bg-green-500' : 'bg-gray-700'} text-white"
          >
            Pending
          </a>
          <a
            href="${pageContext.request.contextPath}/viewCreatedEvents?status=rejected"
            class="p-2 w-full rounded-md text-center ${currentStatus == 'rejected' ? 'bg-green-500' : 'bg-gray-700'} text-white"
          >
            Rejected
          </a>
        </div>

        <!-- Danh sách Sự kiện -->
        <div class="grid grid-cols-1 gap-4">
          <c:choose>
            <c:when test="${not empty events}">
              <c:forEach var="event" items="${events}">
                <!-- Wrap toàn bộ sự kiện trong một anchor để click chuyển đến organizer detail -->
                <a href="${pageContext.request.contextPath}/OrganizerEventDetailController?eventId=${event.eventId}" class="block">
                  <div class="bg-gray-800 p-4 rounded-md flex flex-col md:flex-row md:items-center hover:bg-gray-700 transition-colors">
                    <!-- Hiển thị ảnh nếu có -->
                    <c:if test="${not empty event.imageURL}">
                      <img
                        src="${event.imageURL}"
                        alt="${event.imageTitle}"
                        class="w-48 h-auto mr-4 rounded-md"
                      />
                    </c:if>
                    <div class="flex-1">
                      <h2 class="text-xl font-bold mb-2">
                        <c:out value="${event.eventName}" />
                      </h2>
                      <div class="flex items-center text-green-400 mb-2">
                        <i class="far fa-calendar-alt mr-2"></i>
                        <span><c:out value="${event.startDate}" /></span>
                      </div>
                      <div class="flex items-center text-green-400 mb-2">
                        <i class="fas fa-map-marker-alt mr-2"></i>
                        <span><c:out value="${event.location}" /></span>
                      </div>
                      <p class="mb-2">
                        Status:
                        <span class="px-2 py-1 rounded bg-green-500 text-white">
                          <c:out value="${event.status}" />
                        </span>
                      </p>
                    </div>
                  </div>
                </a>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <p class="text-center">Không có sự kiện nào.</p>
            </c:otherwise>
          </c:choose>
        </div>
      </div>
    </div>
  </body>
</html>
