<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Đưa thời gian hiện tại vào request để so sánh trong JSTL
    java.util.Date now = new java.util.Date();
    request.setAttribute("now", now);
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>My Tickets - Tickify</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- TailwindCSS và Font Awesome -->
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <!-- CSS tùy chỉnh -->
        <style>
            #ticketContainer {
                transition: opacity 0.2s ease-in-out;
            }
            .fade-in {
                animation: fadeIn 0.2s ease-in-out;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
        </style>
    </head>
    <body class="bg-gray-900 text-white">
        <jsp:include page="../../components/header.jsp" />

        <div class="pt-16 flex">
            <jsp:include page="sidebar.jsp" />

            <main class="w-3/4 p-8">
                <h1 class="text-3xl font-bold mb-6">My Tickets</h1>
                <!-- Nút Filter -->
                <div class="grid grid-cols-5 gap-4 mb-6">
                    <button id="btnAll" onclick="fetchTickets('all'); return false;"
                            class="filter-btn bg-gray-800 hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded-full shadow-lg transform hover:scale-105 transition duration-300">
                        All
                    </button>
                    <button id="btnPaid" onclick="fetchTickets('paid'); return false;"
                            class="filter-btn bg-gray-800 hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded-full shadow-lg transform hover:scale-105 transition duration-300">
                        Paid
                    </button>
                    <button id="btnPending" onclick="fetchTickets('pending'); return false;"
                            class="filter-btn bg-gray-800 hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded-full shadow-lg transform hover:scale-105 transition duration-300">
                        Pending
                    </button>
                    <button id="btnUpcoming" onclick="fetchTickets('upcoming'); return false;"
                            class="filter-btn bg-gray-800 hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded-full shadow-lg transform hover:scale-105 transition duration-300">
                        Upcoming
                    </button>
                    <button id="btnPast" onclick="fetchTickets('past'); return false;"
                            class="filter-btn bg-gray-800 hover:bg-gray-700 text-white font-semibold py-2 px-4 rounded-full shadow-lg transform hover:scale-105 transition duration-300">
                        Past
                    </button>
                </div>

                <!-- Thông báo Loading -->
                <div id="notification" class="mb-4 flex items-center justify-center"></div>

                <!-- Container Vé -->
                <div id="ticketContainer">
                    <c:if test="${empty tickets}">
                        <p class="text-center text-gray-300">You have not purchased any tickets yet.</p>
                    </c:if>
                    <c:if test="${not empty tickets}">
                        <div class="grid grid-cols-1 gap-6 fade-in">
                            <c:forEach var="ticket" items="${tickets}">
                                <a href="${pageContext.request.contextPath}/viewTicketDetail?orderI=${ticket.orderCode}"
                                   class="block bg-gray-700 text-white rounded-lg flex overflow-hidden w-full hover:bg-gray-600 transition-colors duration-200 mb-4">
                                    <div class="bg-gray-600 p-6 flex flex-col items-center justify-center w-1/4">
                                        <div class="text-6xl font-bold">
                                            <fmt:formatDate value="${ticket.startDate}" pattern="dd" />
                                        </div>
                                        <div class="text-lg">
                                            <fmt:formatDate value="${ticket.startDate}" pattern="MMM" />
                                        </div>
                                        <div class="text-4xl font-bold">
                                            <fmt:formatDate value="${ticket.startDate}" pattern="MM" />
                                        </div>
                                        <div class="text-lg">
                                            <fmt:formatDate value="${ticket.startDate}" pattern="yyyy" />
                                        </div>
                                    </div>
                                    <div class="p-6 w-3/4">
                                        <h1 class="text-xl font-bold mb-4 text-white-400">${ticket.eventName}</h1>
                                        <!-- Hiển thị Payment Status và Past/Upcoming nằm ngang -->
                                        <div class="flex items-center mb-2 space-x-2">
                                            <span class="bg-green-500 text-white px-3 py-1 rounded-full text-sm">
                                                <c:choose>
                                                    <c:when test="${not empty ticket.paymentStatus}">
                                                        ${ticket.paymentStatus}
                                                    </c:when>
                                                    <c:otherwise>
                                                        Successful
                                                    </c:otherwise>
                                                </c:choose>
                                            </span>
                                            <c:choose>
                                                <c:when test="${ticket.startDate.time lt now.time}">
                                                    <span class="bg-red-500 text-white px-3 py-1 rounded-full text-sm">Past</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="bg-green-500 text-white px-3 py-1 rounded-full text-sm">Upcoming</span>
                                                </c:otherwise>
                                            </c:choose>
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
                </div>

                <!-- Phân Trang (nếu cần) -->
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

        <!-- JavaScript: AJAX và xử lý active state của filter -->
        <script>
            var contextPath = "${pageContext.request.contextPath}";
            var currentFilter = ""; // Theo dõi filter hiện tại

            function capitalize(str) {
                return str.charAt(0).toUpperCase() + str.slice(1);
            }

            // Cập nhật trạng thái active cho các nút filter
            function setActive(status) {
                currentFilter = status;
                var buttons = document.querySelectorAll('.filter-btn');
                buttons.forEach(function (btn) {
                    btn.classList.remove('bg-green-500');
                });
                var btn = document.getElementById('btn' + capitalize(status));
                if (btn) {
                    btn.classList.add('bg-green-500');
                }
            }

            // Hàm fetchTickets: chỉ fetch khi filter thay đổi
            function fetchTickets(status) {
                if (currentFilter === status)
                    return;
                setActive(status);
                var notification = document.getElementById("notification");
                var ticketContainer = document.getElementById("ticketContainer");
                notification.innerHTML = '<div class="flex items-center"><div class="w-6 h-6 border-4 border-t-transparent border-green-500 rounded-full animate-spin"></div><span class="ml-2">Đang tải dữ liệu...</span></div>';

                fetch(contextPath + "/viewAllTickets?ajax=true&status=" + status)
                        .then(function (response) {
                            if (!response.ok) {
                                throw new Error("Network response was not ok");
                            }
                            return response.json();
                        })
                        .then(function (data) {
                            notification.innerText = "";
                            updateTicketContainer(data);
                        })
                        .catch(function (error) {
                            console.error("Error fetching tickets:", error);
                            notification.innerText = "Có lỗi xảy ra. Vui lòng thử lại sau.";
                        });
            }

            // Cập nhật nội dung danh sách vé với hiệu ứng chuyển mờ
            function updateTicketContainer(data) {
                var ticketContainer = document.getElementById("ticketContainer");
                ticketContainer.style.opacity = 0;
                if (!data.tickets || data.tickets.length === 0) {
                    ticketContainer.innerHTML = "<p class='text-center text-gray-300'>You have not purchased any tickets yet.</p>";
                    setTimeout(function () {
                        ticketContainer.style.opacity = 1;
                    }, 200);
                    return;
                }
                var html = "<div class='grid grid-cols-1 gap-6'>";
                data.tickets.forEach(function (ticket) {
                    html += '<a href="' + contextPath + '/viewTicketDetail?orderId=' + ticket.orderCode + '" class="block bg-gray-700 text-white rounded-lg flex overflow-hidden w-full hover:bg-gray-600 transition-colors duration-200 mb-4">';
                    html += '    <div class="bg-gray-600 p-6 flex flex-col items-center justify-center w-1/4">';
                    html += '        <div class="text-6xl font-bold">' + new Date(ticket.startDate).getDate() + '</div>';
                    html += '        <div class="text-lg">' + new Date(ticket.startDate).toLocaleString("en-US", {month: "short"}) + '</div>';
                    html += '        <div class="text-4xl font-bold">' + ("0" + (new Date(ticket.startDate).getMonth() + 1)).slice(-2) + '</div>';
                    html += '        <div class="text-lg">' + new Date(ticket.startDate).getFullYear() + '</div>';
                    html += '    </div>';
                    html += '    <div class="p-6 w-3/4">';
                    html += '        <h1 class="text-xl font-bold mb-4 text-green-400">' + ticket.eventName + '</h1>';
                    html += '        <div class="flex items-center mb-2 space-x-2">';
                    html += '            <span class="bg-green-500 text-white px-3 py-1 rounded-full text-sm">' + (ticket.paymentStatus || 'Successful') + '</span>';
                    html += '            <span class="' + (new Date(ticket.startDate) < new Date() ? 'bg-red-500' : 'bg-green-500') + ' text-white px-3 py-1 rounded-full text-sm">' + (new Date(ticket.startDate) < new Date() ? 'Past' : 'Upcoming') + '</span>';
                    html += '        </div>';
                    html += '        <div class="mb-2"><i class="fas fa-ticket-alt mr-2"></i><span>Order code: ' + ticket.orderCode + '</span></div>';
                    html += '        <div class="mb-2"><i class="far fa-clock mr-2"></i><span>' + new Date(ticket.startDate).toLocaleString() + ' - ' + new Date(ticket.endDate).toLocaleString() + '</span></div>';
                    html += '        <div><i class="fas fa-map-marker-alt mr-2"></i><span>' + ticket.location + '</span></div>';
                    html += '    </div>';
                    html += '</a>';
                });
                html += "</div>";
                setTimeout(function () {
                    ticketContainer.innerHTML = html;
                    ticketContainer.style.opacity = 1;
                }, 200);
            }

            // Khi trang load, mặc định active filter "All" và load dữ liệu
            window.onload = function () {
                fetchTickets('all');
            };
        </script>
    </body>
</html>