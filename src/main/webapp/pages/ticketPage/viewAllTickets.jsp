<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>

        <meta charset="UTF-8">
        <title>My Tickets - Tickify</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <body class="bg-gray-900 text-white">
        <div class="flex">
            <!-- Include Sidebar -->
            <jsp:include page="sidebar.jsp" />
            <jsp:include page="../../components/header.jsp"></jsp:include>
                <!-- Main Content -->
                <main class="w-3/4 p-8">
                    <h1 class="text-3xl font-bold mb-6">My Tickets</h1>
                    <!-- Ticket Filters -->
                    <div class="grid grid-cols-3 gap-4 mb-6">
                        <button onclick="window.location.href = 'viewAllTickets?status=all'" 
                                class="text-white px-4 py-2 rounded-md w-full transition duration-300 ${statusFilter == 'all' ? 'bg-green-500' : 'bg-gray-700 hover:bg-gray-600'}">
                        All
                    </button>
                    <button onclick="window.location.href = 'viewAllTickets?status=paid'" 
                            class="text-white px-4 py-2 rounded-md w-full transition duration-300 ${statusFilter == 'paid' ? 'bg-green-500' : 'bg-gray-700 hover:bg-gray-600'}">
                        Paid
                    </button>
                    <button onclick="window.location.href = 'viewAllTickets?status=pending'" 
                            class="text-white px-4 py-2 rounded-md w-full transition duration-300 ${statusFilter == 'pending' ? 'bg-green-500' : 'bg-gray-700 hover:bg-gray-600'}">
                        Pending
                    </button>
                </div>
                <div class="flex justify-center space-x-4 mb-6">
                    <button onclick="window.location.href = 'viewAllTickets?status=upcoming'" class="transition duration-300">
                        <span class="${statusFilter == 'upcoming' ? 'text--500 border-b-2 border-green-500 inline-block' : 'text-gray-400 hover:text-gray-300 inline-block'}">
                            Upcoming
                        </span>
                    </button>
                    <button onclick="window.location.href = 'viewAllTickets?status=past'" class="transition duration-300">
                        <span class="${statusFilter == 'past' ? 'text-white-500 border-b-2 border-green-500 inline-block' : 'text-gray-400 hover:text-gray-300 inline-block'}">
                            Past
                        </span>
                    </button>
                </div>


                <!-- Ticket List -->
                <c:if test="${empty tickets}">
                    <p class="text-center text-gray-300">You have not purchased any tickets yet.</p>
                </c:if>
                <c:if test="${not empty tickets}">
                    <div class="grid grid-cols-1 gap-6">
                        <c:forEach var="ticket" items="${tickets}">
                            <a href="${pageContext.request.contextPath}/viewTicketDetail?ticketCode=${ticket.orderCode}"
                               class="block bg-gray-700 text-white rounded-lg flex overflow-hidden w-full hover:bg-gray-600 transition-colors duration-200">
                                <!-- Date Section -->
                                <div class="bg-gray-600 p-6 flex flex-col items-center justify-center w-1/4">
                                    <div class="text-6xl font-bold">
                                        <fmt:formatDate value="${ticket.startDate}" pattern="dd" />
                                    </div>
                                    <div class="text-lg">Month</div>
                                    <div class="text-4xl font-bold">
                                        <fmt:formatDate value="${ticket.startDate}" pattern="MM" />
                                    </div>
                                    <div class="text-lg">
                                        <fmt:formatDate value="${ticket.startDate}" pattern="yyyy" />
                                    </div>
                                </div>
                                <!-- Ticket Info Section -->
                                <div class="p-6 w-3/4">
                                    <h1 class="text-xl font-bold mb-4 text-green-400">
                                        ${ticket.eventName}
                                    </h1>
                                    <div class="flex items-center mb-2">
                                        <span class="bg-green-500 text-white px-3 py-1 rounded-full text-sm mr-2">
                                            <c:choose>
                                                <c:when test="${not empty ticket.paymentStatus}">
                                                    ${ticket.paymentStatus}
                                                </c:when>
                                                <c:otherwise>
                                                    Successful
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    <div class="mb-2">
                                        <i class="fas fa-ticket-alt mr-2"></i>
                                        <span>Order code: ${ticket.orderCode}</span>
                                    </div>
                                    <div class="mb-2">
                                        <i class="far fa-clock mr-2"></i>
                                        <span>
                                            <fmt:formatDate value="${ticket.startDate}" pattern="HH:mm, dd 'of' MMM, yyyy" />
                                            -
                                            <fmt:formatDate value="${ticket.endDate}" pattern="HH:mm, dd 'of' MMM, yyyy" />
                                        </span>
                                    </div>
                                    <div>
                                        <i class="fas fa-map-marker-alt mr-2"></i>
                                        <span>${ticket.location}</span>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </div>
                </c:if>

                <!-- Pagination -->
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
        </div>
    </body>
</html>
