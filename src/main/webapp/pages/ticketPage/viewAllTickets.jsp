<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>My Tickets</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    </head>
    <body class="bg-gray-900 text-white">
        <!-- HEADER: Giao diện đẹp từ HTML -->
        <header class="bg-green-500 p-4 flex justify-between items-center">
            <div class="flex items-center">
                <span class="text-3xl font-bold text-white">
                    ticketbox
                </span>
            </div>
            <div class="flex items-center space-x-4">
                <div class="relative">
                    <input class="pl-10 pr-4 py-2 rounded-full text-black" placeholder="What are you looking for today?" type="text"/>
                    <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                </div>
                <a href="${pageContext.request.contextPath}/createEvent" 
                   class="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition-colors duration-200">
                    Create Event
                </a>
                <!-- URL cho My Tickets ở thanh menu -->
                <a href="${pageContext.request.contextPath}/myTickets" 
                   class="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition-colors duration-200">
                    My Tickets
                </a>
                <div class="relative">
                    <button class="flex items-center space-x-2 px-4 py-2 rounded-full hover:bg-green-600 transition-colors duration-200">
                        <img alt="User avatar" class="h-10 w-10 rounded-full" height="40" 
                             src="https://storage.googleapis.com/a1aa/image/h71lG1q8DXBqilEUcrvIYvR8bqmHnaCRfnARuEGr6Mg.jpg" width="40"/>
                        <span>My Account</span>
                        <i class="fas fa-chevron-down"></i>
                    </button>
                </div>
                <img alt="Flag" class="h-10 w-10 rounded-full hover:opacity-80 transition-opacity duration-200" 
                     height="40" src="https://storage.googleapis.com/a1aa/image/iOTz5_MlFPFZm2ax8JGx-RdCHntuioNHvXZLPH_F4mw.jpg" width="40"/>
            </div>
        </header>

        <!-- MAIN CONTENT -->
        <main class="p-8">
            <div class="flex space-x-8">
                <!-- SIDEBAR: Giao diện đẹp từ HTML -->
                <aside class="w-1/4">
                    <nav class="space-y-4">
                        <div class="flex items-center space-x-4">
                            <img alt="User avatar" class="h-12 w-12 rounded-full" height="50" 
                                 src="https://storage.googleapis.com/a1aa/image/h71lG1q8DXBqilEUcrvIYvR8bqmHnaCRfnARuEGr6Mg.jpg" width="50"/>
                            <div>
                                <p class="text-gray-400">Account of</p>
                                <p class="font-bold">Dương Minh Kiệt</p>
                            </div>
                        </div>
                        <ul class="space-y-2">
                            <li class="flex items-center space-x-2">
                                <i class="fas fa-user"></i>
                                <a class="text-gray-400 hover:text-white transition-colors duration-200" href="#">
                                    My account
                                </a>
                            </li>
                            <li class="flex items-center space-x-2">
                                <i class="fas fa-ticket-alt text-green-500"></i>
                                <a class="text-green-500 hover:text-green-400 transition-colors duration-200" href="#">
                                    My Tickets
                                </a>
                            </li>
                            <li class="flex items-center space-x-2">
                                <i class="fas fa-calendar-alt"></i>
                                <a class="text-gray-400 hover:text-white transition-colors duration-200" href="#">
                                    My created events
                                </a>
                            </li>
                        </ul>
                    </nav>
                </aside>

                <!-- TICKET LIST -->
                <section class="w-3/4">
                    <h1 class="text-2xl font-bold mb-4">My Tickets</h1>
                    <!-- FILTER BUTTONS -->
                    <div class="flex flex-col items-center mb-4">
                        <div class="flex space-x-4 mb-2 w-full">
                            <a class="bg-gray-700 text-white px-4 py-2 rounded-full flex-1 flex justify-center items-center text-center
                               hover:bg-green-600 transition-colors duration-200
                               " 
                               href="${pageContext.request.contextPath}/viewAllTickets?customerId=3">
                                All
                            </a>
                            <a class="bg-gray-700 text-white px-4 py-2 rounded-full flex-1 flex justify-center items-center text-center
                               hover:bg-green-600 transition-colors duration-200
                               " 
                               href="${pageContext.request.contextPath}/viewAllTickets?customerId=3&status=pending">
                                Pending
                            </a>
                            <a class="bg-gray-700 text-white px-4 py-2 rounded-full flex-1 flex justify-center items-center text-center
                               hover:bg-green-600 transition-colors duration-200
                               " 
                               href="${pageContext.request.contextPath}/viewAllTickets?customerId=3&status=completed">
                                Completed
                            </a>
                        </div>

                    </div>

                    <!-- DANH SÁCH VÉ -->
                    <div class="space-y-4">
                        <c:if test="${not empty tickets}">
                            <c:forEach var="ticket" items="${tickets}">
                                <a href="${pageContext.request.contextPath}/viewTicketDetail?orderId=${ticket.orderId}"
                                   class="block bg-gray-800 p-4 rounded-lg flex space-x-4 hover:bg-gray-700 focus:bg-gray-700 active:bg-gray-600 transition-colors duration-150">
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
                                    <div>
                                        <h2 class="text-xl font-bold">${ticket.eventName}</h2>
                                        <div class="flex items-center space-x-2 my-2">
                                            <span class="bg-green-500 text-white px-2 py-1 rounded-full">
                                                ${ticket.paymentStatus}
                                            </span>
                                            <span class="bg-gray-700 text-green-500 px-2 py-1 rounded-full">
                                                ${ticket.ticketType}
                                            </span>
                                        </div>
                                        <p>
                                            <i class="fas fa-barcode"></i>
                                            Order code: ${ticket.orderId}
                                        </p>
                                        <p>
                                            <i class="fas fa-clock"></i>
                                            <fmt:formatDate value="${ticket.startDate}" pattern="HH:mm, dd MMM, yyyy" /> -
                                            <fmt:formatDate value="${ticket.endDate}" pattern="HH:mm, dd MMM, yyyy" />
                                        </p>
                                        <p>
                                            <i class="fas fa-map-marker-alt"></i>
                                            ${ticket.location}
                                        </p>
                                        <p>
                                            <i class="fas fa-ticket-alt"></i>
                                            Ticket ID: ${ticket.ticketId} | Price: ${ticket.unitPrice}
                                        </p>
                                    </div>
                                </a>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty tickets}">
                            <p class="text-center">Không có vé nào được mua.</p>
                        </c:if>
                    </div>
                </section>
            </div>
        </main>
    </body>
</html>
