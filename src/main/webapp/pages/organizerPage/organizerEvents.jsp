<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Organizer Events - Tickify Organizer</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            #suggestions {
                position: absolute;
                top: 45px;
                background-color: white;
                border: 1px solid #ddd;
                border-radius: 15px;
                max-height: 200px;
                overflow-y: auto;
                width: 256px;
                z-index: 10;
                color: black;
            }
            #suggestions div {
                padding: 8px;
                cursor: pointer;
            }
            #suggestions div:hover, #suggestions .selected {
                background-color: #f0f0f0;
            }
        </style>
    </head>
    <body class="bg-gray-900 text-white">
        <div class="flex h-screen">
            <!-- Sidebar -->
            <aside class="w-1/6 bg-gradient-to-b from-green-900 to-black p-4 text-white">
                <div class="flex items-center mb-8">
                    <img src="https://storage.googleapis.com/a1aa/image/8k6Ikw_t95IdEBRzaSbfv_qa-9InZk34-JUibXbK7B4.jpg" alt="Tickify logo" class="mr-2" height="40" width="40">
                    <span class="text-lg font-bold text-green-500">Organizer Center</span>
                </div>
                <nav class="space-y-4">
                    <a class="flex items-center text-white w-full p-2 rounded-lg hover:bg-green-700 hover:text-white transition duration-200" 
                       href="${pageContext.request.contextPath}/OrganizerEventController">
                        <i class="fas fa-ticket-alt mr-2"></i>My Events
                    </a>
                </nav>
            </aside>
            <!-- Main Content -->
            <main class="flex-1 flex flex-col">
                <!-- Header -->
                <header class="flex justify-between items-center bg-gray-800 p-4">
                    <h1 class="text-xl font-bold">My Events</h1>
                    <div class="flex items-center space-x-4">
                        <button type="button" onclick="location.href = '${pageContext.request.contextPath}/createEvent.jsp'" 
                                class="bg-green-500 text-white px-6 py-3 rounded-full shadow-lg hover:bg-green-600 transition duration-200">
                            + Create Event
                        </button>
                        <button class="flex items-center text-white">
                            <img src="https://storage.googleapis.com/a1aa/image/_qCewoK0KXQhWyQzRe9zG7PpYaYijDdWdPLzWZ3kkg8.jpg" alt="User avatar" class="mr-2 rounded-full" height="30" width="30">
                            My Account
                        </button>
                    </div>
                </header>
                <!-- Search and Filters -->
                <section class="p-4">
                    <div class="flex items-center">
                        <!-- Search Bar -->
                        <div class="flex items-center relative">
                            <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                                <i class="fas fa-search text-gray-500"></i>
                            </span>
                            <input type="text" id="searchInput" placeholder="Search event" class="w-64 pl-10 pr-4 py-2 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-green-500 text-black">
                            <div id="suggestions" class="hidden"></div>
                            <button id="searchButton" class="ml-3 bg-gray-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200">
                                Search
                            </button>
                        </div>
                        <!-- Filter Buttons -->
                        <div class="flex flex-1 ml-4 space-x-2">
                            <button class="flex-1 bg-gray-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200"
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=all'">
                                All
                            </button>
                            <button class="flex-1 bg-gray-600 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200"
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=pending'">
                                Pending
                            </button>
                            <button class="flex-1 bg-gray-600 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200"
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=paid'">
                                Paid
                            </button>
                            <button class="flex-1 bg-gray-600 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200"
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=upcoming'">
                                Upcoming
                            </button>
                            <button class="flex-1 bg-gray-600 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200"
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=past'">
                                Past
                            </button>
                        </div>
                    </div>
                </section>
                <!-- Events List -->
                <section class="flex-1 p-4 overflow-y-auto">
                    <div id="eventsContainer" class="w-full p-4 space-y-6">
                        <c:if test="${empty events}">
                            <p class="text-center text-gray-300">No events found.</p>
                        </c:if>
                        <c:forEach var="event" items="${events}">
                            <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden flex w-full mb-4">
                                <c:if test="${not empty event.image}">
                                    <img src="${event.image}" alt="Event image" class="w-1/4 object-cover">
                                </c:if>
                                <div class="p-4 flex-1">
                                    <h2 class="text-xl font-bold text-white cursor-pointer hover:text-gray-400" 
                                        onclick="location.href = '${pageContext.request.contextPath}/organizerEventDetail?eventId=${event.eventId}'">
                                        ${event.eventName}
                                    </h2>
                                    <div class="flex items-center text-green-400 mt-2">
                                        <i class="far fa-calendar-alt mr-2"></i>
                                        <span><fmt:formatDate value="${event.startDate}" pattern="HH:mm, EEEE, MMM dd yyyy" /></span>
                                    </div>
                                    <div class="flex items-center text-green-400 mt-2">
                                        <i class="fas fa-map-marker-alt mr-2"></i>
                                        <span>${event.location}</span>
                                    </div>
                                    <p class="text-gray-400 mt-2">
                                        Payment Status: ${event.paymentStatus}
                                    </p>
                                    <p class="text-gray-400 mt-2">
                                        Duration: <fmt:formatDate value="${event.startDate}" pattern="MMM dd, yyyy" /> - <fmt:formatDate value="${event.endDate}" pattern="MMM dd, yyyy" />
                                    </p>
                                    <div class="p-4 mt-4 grid grid-cols-2 sm:grid-cols-4 gap-4 text-center">
                                        <button type="button" onclick="location.href = '${pageContext.request.contextPath}/pages/eventOverview.jsp'" 
                                                class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                            <i class="fas fa-chart-pie text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                            <span class="text-gray-400 group-hover:text-white">Overview</span>
                                        </button>
                                        <button type="button" onclick="location.href = '${pageContext.request.contextPath}/viewdetail.jsp'" 
                                                class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                            <i class="fas fa-list text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                            <span class="text-gray-400 group-hover:text-white">Orders</span>
                                        </button>
                                        <button type="button" onclick="location.href = '${pageContext.request.contextPath}/viewdetail.jsp'" 
                                                class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                            <i class="fas fa-chair text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                            <span class="text-gray-400 group-hover:text-white">Seating Chart</span>
                                        </button>
                                        <button type="button" onclick="location.href = '${pageContext.request.contextPath}/viewdetail.jsp'" 
                                                class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                            <i class="fas fa-edit text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                            <span class="text-gray-400 group-hover:text-white">Edit</span>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </main>
        </div>

        <!-- JavaScript xử lý AJAX -->
        <script>
            $(document).ready(function () {
                let selectedIndex = -1; // Chỉ số của gợi ý được chọn

                // Hàm lấy gợi ý tìm kiếm
                function fetchSuggestions(eventName) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/OrganizerEventController',
                        type: 'POST',
                        data: {
                            eventName: eventName,
                            organizerId: 98 // Giả định organizerId = 98
                        },
                        dataType: 'json',
                        success: function (data) {
                            displaySuggestions(data);
                        },
                        error: function (xhr, status, error) {
                            console.error("Error fetching suggestions: " + error);
                        }
                    });
                }

                // Hàm tìm kiếm sự kiện
                function searchEvents(eventName) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/OrganizerEventController',
                        type: 'POST',
                        data: {
                            eventName: eventName,
                            organizerId: 98
                        },
                        dataType: 'json',
                        success: function (data) {
                            updateEventsList(data);
                        },
                        error: function (xhr, status, error) {
                            console.error("Error: " + error);
                            $('#eventsContainer').html('<p class="text-center text-gray-300">Error occurred while searching events.</p>');
                        }
                    });
                }

                // Sự kiện khi gõ vào ô input
                $('#searchInput').on('input', function () {
                    var eventName = $(this).val().trim();
                    selectedIndex = -1; // Đặt lại chỉ số khi gõ
                    if (eventName === "") {
                        $('#suggestions').addClass('hidden').empty();
                    } else {
                        fetchSuggestions(eventName);
                    }
                });

                // Xử lý phím mũi tên và Enter
                $('#searchInput').on('keydown', function (e) {
                    var suggestions = $('#suggestions div');
                    if (suggestions.length === 0) return;

                    if (e.key === 'ArrowDown') {
                        e.preventDefault();
                        if (selectedIndex < suggestions.length - 1) {
                            selectedIndex++;
                            updateSelectedSuggestion(suggestions);
                        }
                    } else if (e.key === 'ArrowUp') {
                        e.preventDefault();
                        if (selectedIndex > 0) {
                            selectedIndex--;
                            updateSelectedSuggestion(suggestions);
                        }
                    } else if (e.key === 'Enter') {
                        e.preventDefault();
                        if (selectedIndex >= 0 && selectedIndex < suggestions.length) {
                            $('#searchInput').val(suggestions.eq(selectedIndex).text());
                            $('#suggestions').addClass('hidden');
                            searchEvents($('#searchInput').val().trim());
                        } else if ($('#searchInput').val().trim() !== "") {
                            searchEvents($('#searchInput').val().trim());
                            $('#suggestions').addClass('hidden');
                        }
                    }
                });

                // Sự kiện click vào gợi ý
                $('#suggestions').on('click', 'div', function () {
                    $('#searchInput').val($(this).text());
                    $('#suggestions').addClass('hidden');
                });

                // Sự kiện khi nhấn nút Search
                $('#searchButton').click(function () {
                    var eventName = $('#searchInput').val().trim();
                    if (eventName === "") {
                        alert("Please enter an event name to search.");
                        return;
                    }
                    searchEvents(eventName);
                    $('#suggestions').addClass('hidden');
                });

                // Hiển thị gợi ý
                function displaySuggestions(events) {
                    var suggestions = $('#suggestions');
                    suggestions.empty().removeClass('hidden');
                    selectedIndex = -1; // Đặt lại chỉ số khi hiển thị gợi ý mới

                    if (events.length === 0) {
                        suggestions.append('<div>No suggestions found</div>');
                        return;
                    }

                    $.each(events, function (index, event) {
                        suggestions.append('<div>' + event.eventName + '</div>');
                    });
                }

                // Cập nhật gợi ý được chọn
                function updateSelectedSuggestion(suggestions) {
                    suggestions.removeClass('selected');
                    if (selectedIndex >= 0) {
                        suggestions.eq(selectedIndex).addClass('selected');
                        $('#searchInput').val(suggestions.eq(selectedIndex).text());
                    }
                }

                // Hàm cập nhật danh sách sự kiện
                function updateEventsList(events) {
                    var container = $('#eventsContainer');
                    container.empty();

                    if (events.length === 0) {
                        container.append('<p class="text-center text-gray-300">No events found.</p>');
                        return;
                    }

                    function formatDate(dateString) {
                        const date = new Date(dateString);
                        return date.toLocaleString('en-US', {
                            month: 'short',
                            day: '2-digit',
                            year: 'numeric',
                            hour: '2-digit',
                            minute: '2-digit',
                            hour12: false
                        }).replace(',', '');
                    }

                    $.each(events, function (index, event) {
                        var eventHtml = `
                            <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden flex w-full mb-4">
                                <img src="${event.image}" alt="Event image" class="w-1/4 object-cover">
                                <div class="p-4 flex-1">
                                    <h2 class="text-xl font-bold text-white cursor-pointer hover:text-gray-400" 
                                        onclick="location.href = '${pageContext.request.contextPath}/organizerEventDetail?eventId=` + event.eventId + `'">
                                        ` + event.eventName + `
                                    </h2>
                                    <div class="flex items-center text-green-400 mt-2">
                                        <i class="fas fa-map-marker-alt mr-2"></i>
                                        <span>` + event.location + `</span>
                                    </div>
                                    <p class="text-gray-400 mt-2">Status: ` + event.status + `</p>
                                    <p class="text-gray-400 mt-2">
                                        Duration: ` + formatDate(event.createdAt) + ` - ` + formatDate(event.updatedAt) + `
                                    </p>
                                    <div class="p-4 mt-4 grid grid-cols-2 sm:grid-cols-4 gap-4 text-center">
                                        <button type="button" onclick="location.href = '${pageContext.request.contextPath}/pages/eventOverview.jsp'" 
                                                class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                            <i class="fas fa-chart-pie text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                            <span class="text-gray-400 group-hover:text-white">Overview</span>
                                        </button>
                                        <button type="button" onclick="location.href = '${pageContext.request.contextPath}/viewdetail.jsp'" 
                                                class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                            <i class="fas fa-list text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                            <span class="text-gray-400 group-hover:text-white">Orders</span>
                                        </button>
                                        <button type="button" onclick="location.href = '${pageContext.request.contextPath}/viewdetail.jsp'" 
                                                class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                            <i class="fas fa-chair text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                            <span class="text-gray-400 group-hover:text-white">Seating Chart</span>
                                        </button>
                                        <button type="button" onclick="location.href = '${pageContext.request.contextPath}/viewdetail.jsp'" 
                                                class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                            <i class="fas fa-edit text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                            <span class="text-gray-400 group-hover:text-white">Edit</span>
                                        </button>
                                    </div>
                                </div>
                            </div>`;
                        container.append(eventHtml);
                    });
                }
            });
        </script>
    </body>
</html>