<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>My Tickets - Ticketbox</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  </head>
  <body class="bg-gray-900 text-white">
    <!-- Header -->
    <header class="bg-green-500 p-4 flex justify-between items-center">
      <div class="flex items-center">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Ticketbox Logo" class="h-10">
        <span class="text-3xl font-bold ml-2">Ticketbox</span>
      </div>
      <nav class="flex space-x-4">
        <a href="${pageContext.request.contextPath}/viewAllTickets" class="hover:text-green-300">My Tickets</a>
        <a href="${pageContext.request.contextPath}/myProfile" class="hover:text-green-300">My Account</a>
      </nav>
    </header>
    
    <!-- Main Content -->
    <main class="p-8">
      <h1 class="text-2xl font-bold mb-6">My Tickets</h1>
      <c:if test="${empty tickets}">
        <p class="text-center text-gray-300">You have not purchased any tickets yet.</p>
      </c:if>
      <c:if test="${not empty tickets}">
        <div class="grid grid-cols-1 gap-6">
          <c:forEach var="ticket" items="${tickets}">
            <!-- Mỗi vé hiển thị dưới dạng card, click chuyển sang trang chi tiết vé -->
            <a href="${pageContext.request.contextPath}/viewTicketDetail?ticketCode=${ticket.orderCode}" 
               class="block bg-gray-800 p-4 rounded-lg flex space-x-4 hover:bg-gray-700 transition-colors duration-200">
              <!-- Phần ngày sự kiện -->
              <div class="bg-gray-700 p-4 rounded-lg text-center">
                <p class="text-2xl font-bold">
                  <fmt:formatDate value="${ticket.startDate}" pattern="dd" />
                </p>
                <p>
                  <fmt:formatDate value="${ticket.startDate}" pattern="MMM" />
                </p>
                <p>
                  <fmt:formatDate value="${ticket.startDate}" pattern="yyyy" />
                </p>
              </div>
              <!-- Thông tin vé -->
              <div>
                <h2 class="text-xl font-bold">${ticket.eventName}</h2>
                <!-- Thêm Order Code hiển thị cho khách hàng -->
                <p class="text-gray-300"><strong>Order Code:</strong> ${ticket.orderCode}</p>
                <p class="text-gray-300"><strong>Location:</strong> ${ticket.location}</p>
                <p class="text-gray-300">
                  <strong>Unit Price:</strong> <fmt:formatNumber value="${ticket.unitPrice}" type="currency" currencySymbol="$" />
                </p>
                <p class="text-gray-300"><strong>Payment Status:</strong> ${ticket.paymentStatus}</p>
                <p class="text-sm text-gray-400">
                  <strong>Event Duration:</strong> 
                  <fmt:formatDate value="${ticket.startDate}" pattern="dd MMM, yyyy" /> - 
                  <fmt:formatDate value="${ticket.endDate}" pattern="dd MMM, yyyy" />
                </p>
              </div>
            </a>
          </c:forEach>
        </div>
      </c:if>
      
      <!-- Phân trang -->
      <c:if test="${totalPages gt 1}">
        <div class="flex justify-center items-center mt-6 space-x-1">
          <c:set var="displayPages" value="5" />
          <c:set var="startPage" value="${currentPage - (displayPages div 2)}" />
          <c:set var="endPage" value="${currentPage + (displayPages div 2)}" />
          <c:if test="${startPage lt 1}">
            <c:set var="endPage" value="${endPage + (1 - startPage)}" />
            <c:set var="startPage" value="1" />
          </c:if>
          <c:if test="${endPage gt totalPages}">
            <c:set var="startPage" value="${startPage - (endPage - totalPages)}" />
            <c:set var="endPage" value="${totalPages}" />
            <c:if test="${startPage lt 1}">
              <c:set var="startPage" value="1" />
            </c:if>
          </c:if>
          <c:if test="${currentPage gt 1}">
            <a href="${pageContext.request.contextPath}/viewAllTickets?page=1" class="px-3 py-1 bg-blue-500 text-white rounded-l hover:bg-blue-600">First</a>
            <a href="${pageContext.request.contextPath}/viewAllTickets?page=${currentPage - 1}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600">Prev</a>
          </c:if>
          <c:if test="${startPage gt 1}">
            <span class="px-3 py-1">...</span>
          </c:if>
          <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:choose>
              <c:when test="${i eq currentPage}">
                <span class="px-3 py-1 bg-blue-700 text-white font-bold rounded">${i}</span>
              </c:when>
              <c:otherwise>
                <a href="${pageContext.request.contextPath}/viewAllTickets?page=${i}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600 rounded">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:forEach>
          <c:if test="${endPage lt totalPages}">
            <span class="px-3 py-1">...</span>
          </c:if>
          <c:if test="${currentPage lt totalPages}">
            <a href="${pageContext.request.contextPath}/viewAllTickets?page=${currentPage + 1}" class="px-3 py-1 bg-blue-500 text-white hover:bg-blue-600">Next</a>
            <a href="${pageContext.request.contextPath}/viewAllTickets?page=${totalPages}" class="px-3 py-1 bg-blue-500 text-white rounded-r hover:bg-blue-600">Last</a>
          </c:if>
        </div>
      </c:if>
    </main>
  </body>
</html>
