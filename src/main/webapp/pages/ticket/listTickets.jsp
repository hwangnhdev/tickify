<%--
    Document   : listTickets
    Created on : Feb 23, 2025, 9:21:06 PM
    Author     : Duong Minh Kiet CE180166
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>My Tickets</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
</head>
<body class="bg-gray-900 text-white">
  <!-- Combined Header Start -->
  <header class="flex items-center justify-between p-4 bg-green-500">
    <div class="flex items-center space-x-2">
      <img alt="Ticketbox logo with flowers" class="h-10" height="40" src="https://storage.googleapis.com/a1aa/image/QFGmlqUxV3wOt_WWADoO4_0Qg_nIc4DWyGV_T-K5MoE.jpg" width="100"/>
    </div>
    <div class="flex items-center space-x-4">
      <div class="flex items-center bg-white rounded-full px-4 py-2">
        <i class="fas fa-search text-gray-500"></i>
        <input class="ml-2 outline-none" placeholder="What are you looking for today?" type="text"/>
        <button class="ml-2 text-gray-500">Search</button>
      </div>
      <button class="border border-white text-white rounded-full px-4 py-2">Create Event</button>
      <button class="text-white flex items-center">
        <i class="fas fa-ticket-alt"></i>
        <span class="ml-2">My Tickets</span>
      </button>
      <div class="flex items-center space-x-2">
        <img alt="User profile picture" class="h-10 w-10 rounded-full" height="40" src="https://storage.googleapis.com/a1aa/image/A801-ljJDOLUESUaN4cVCr88w4cHkhM6CF-iQwweB1w.jpg" width="40"/>
        <span class="text-white">My Account</span>
        <i class="fas fa-chevron-down text-white"></i>
      </div>
      <div class="flex items-center space-x-2">
        <img alt="UK flag" class="h-10 w-10 rounded-full" height="40" src="https://storage.googleapis.com/a1aa/image/Hv3dsj94PzPtHddKe0Q_EHj4yNS0kUqj6raCZYyfMrw.jpg" width="40"/>
        <i class="fas fa-chevron-down text-white"></i>
      </div>
    </div>
  </header>
  <!-- Combined Header End -->

  <div class="container mx-auto p-4">
    <!-- Breadcrumb -->
    <div class="flex items-center mb-4">
      <a class="text-gray-400" href="#">Home page</a>
      <span class="mx-2 text-gray-400">&gt;</span>
      <span class="text-white">My Tickets</span>
    </div>
    <div class="flex">
      <!-- Sidebar -->
      <div class="w-1/4">
        <div class="flex items-center mb-4">
          <img alt="User profile picture" class="rounded-full w-12 h-12 mr-2" height="50" width="50"
               src="https://storage.googleapis.com/a1aa/image/OuErQrDmJalc9zfXm5ROeIW1JoinlLwvWPvn5P3F50Q.jpg" />
          <div>
            <p class="text-gray-400">Account of</p>
            <p class="font-bold">Duong Minh Kiet</p>
          </div>
        </div>
        <div class="mb-4">
          <a class="flex items-center text-gray-400 mb-2" href="#">
            <i class="fas fa-user mr-2"></i>
            My account
          </a>
          <a class="flex items-center text-green-500 mb-2" href="#">
            <i class="fas fa-ticket-alt mr-2"></i>
            My Tickets
          </a>
          <a class="flex items-center text-gray-400" href="#">
            <i class="fas fa-calendar-alt mr-2"></i>
            My created events
          </a>
        </div>
      </div>
      <!-- Main Content -->
      <div class="w-3/4">
        <h1 class="text-2xl font-bold mb-4">My Tickets</h1>
        <!-- Grid filter for All, Finished, Processing, Cancelled -->
        <div class="grid grid-cols-4 gap-2 mb-4">
          <a href="${pageContext.request.contextPath}/viewalltickets?status=ALL" 
             class="py-2 px-4 rounded-full transition-colors hover:bg-green-600 ${currentStatus eq 'ALL' ? 'bg-green-500 text-white' : 'bg-gray-700 text-white'}">
            All
          </a>
          <a href="${pageContext.request.contextPath}/viewalltickets?status=Finished" 
             class="py-2 px-4 rounded-full transition-colors hover:bg-green-600 ${currentStatus eq 'Finished' ? 'bg-green-500 text-white' : 'bg-gray-700 text-white'}">
            Finished
          </a>
          <a href="${pageContext.request.contextPath}/viewalltickets?status=Processing" 
             class="py-2 px-4 rounded-full transition-colors hover:bg-green-600 ${currentStatus eq 'Processing' ? 'bg-green-500 text-white' : 'bg-gray-700 text-white'}">
            Processing
          </a>
          <a href="${pageContext.request.contextPath}/viewalltickets?status=Cancelled" 
             class="py-2 px-4 rounded-full transition-colors hover:bg-green-600 ${currentStatus eq 'Cancelled' ? 'bg-green-500 text-white' : 'bg-gray-700 text-white'}">
            Cancelled
          </a>
        </div>
        <!-- Upcoming & Past links -->
        <div class="flex justify-center mb-4">
          <a href="${pageContext.request.contextPath}/viewalltickets?status=Upcoming" 
             class="mr-4 transition-colors hover:underline ${currentStatus eq 'Upcoming' ? 'text-green-500' : 'text-white'}">
            Upcoming
          </a>
          <a href="${pageContext.request.contextPath}/viewalltickets?status=Past" 
             class="transition-colors hover:underline ${currentStatus eq 'Past' ? 'text-green-500' : 'text-white'}">
            Past
          </a>
        </div>
        <!-- Ticket list -->
        <div>
          <c:if test="${not empty message}">
            <p class="text-red-500">${message}</p>
          </c:if>
          <c:forEach var="ticket" items="${ticketList}">
            <a href="${pageContext.request.contextPath}/viewticketdetail?ticketId=${ticket.ticketId}" class="block mb-4">
              <div class="bg-gray-800 p-4 rounded-md flex space-x-4 hover:bg-gray-700 transition-colors">
                <div class="bg-gray-700 p-4 rounded-md text-center">
                  <p class="text-2xl font-bold"><fmt:formatDate value="${ticket.orderDate}" pattern="dd" /></p>
                  <p><fmt:formatDate value="${ticket.orderDate}" pattern="MMMM" /></p>
                  <p><fmt:formatDate value="${ticket.orderDate}" pattern="yyyy" /></p>
                </div>
                <div class="flex-1">
                  <h2 class="text-xl font-bold">${ticket.eventName}</h2>
                  <div class="flex items-center space-x-2 my-2">
                    <span class="bg-green-500 text-white px-2 py-1 rounded-md">${ticket.orderStatus}</span>
                    <span class="bg-gray-700 text-white px-2 py-1 rounded-md">${ticket.ticketType}</span>
                  </div>
                  <p>Order code: ${ticket.orderCode}</p>
                  <p>
                    <fmt:formatDate value="${ticket.startTime}" pattern="HH:mm" /> - 
                    <fmt:formatDate value="${ticket.endTime}" pattern="HH:mm" />, 
                    <fmt:formatDate value="${ticket.orderDate}" pattern="dd MMM, yyyy" />
                  </p>
                  <p>${ticket.location}</p>
                </div>
              </div>
            </a>
          </c:forEach>
        </div>
      </div>
    </div>
  </div>
</body>
</html>
