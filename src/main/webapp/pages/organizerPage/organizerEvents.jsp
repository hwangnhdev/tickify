<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Organizer Events - Tickify Organizer</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
            /* Xử lý text tràn */
            .truncate-text {
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            /* Container ảnh sử dụng aspect ratio để duy trì tỉ lệ cố định */
            .card-image-container {
                width: 100%;
                /* Dùng aspect-ratio để container tự động tính chiều cao theo tỉ lệ mong muốn */
                aspect-ratio: 16 / 9;  /* Hoặc điều chỉnh theo tỉ lệ ảnh gốc: ví dụ 4/3, 1/1, ... */
                overflow: hidden;
                background-color: #000; /* Màu nền để tạo điểm nhấn nếu ảnh không lấp đầy container */
                display: flex;
                align-items: center;
                justify-content: center;
            }

            /* Ảnh sẽ hiển thị đầy đủ, không bị cắt xén */
            .card-image-container img {
                width: 100%;
                height: 100%;
                object-fit: contain; /* Hiển thị toàn bộ ảnh */
                display: block;
            }

            /* CSS cho suggestions của search */
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
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    </head>
    <body class="bg-gray-900 text-white">
        <div class="flex h-screen">
            <!-- Sidebar -->
            <aside class="w-1/6 bg-gradient-to-b from-green-900 to-black p-4 text-white">
                <div class="flex items-center mb-8">
                    <img src="https://storage.googleapis.com/a1aa/image/8k6Ikw_t95IdEBRzaSbfv_qa-9InZk34-JUibXbK7B4.jpg" 
                         alt="Tickify logo" class="mr-2" height="40" width="40">
                    <span class="text-lg font-bold text-green-500">Organizer Center</span>
                </div>
                <nav class="space-y-4">
                    <a href="${pageContext.request.contextPath}/OrganizerEventController" 
                       class="flex items-center text-white w-full p-2 rounded-lg hover:bg-green-700 transition duration-200">
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
                        <button type="button" onclick="window.open('${pageContext.request.contextPath}/createNewEvent?customerId=${sessionScope.customerId}', '_blank')" 
                                class="bg-green-500 text-white px-6 py-3 rounded-full shadow-lg hover:bg-green-600 transition duration-200">
                            + Create Event
                        </button>
                        <button class="flex items-center text-white">
                            <img src="https://storage.googleapis.com/a1aa/image/_qCewoK0KXQhWyQzRe9zG7PpYaYijDdWdPLzWZ3kkg8.jpg" 
                                 alt="User avatar" class="mr-2 rounded-full" height="30" width="30">
                            My Account
                        </button>
                    </div>
                </header>
                <!-- Search and Filters -->
                <section class="p-4">
                    <div class="flex items-center">
                        <!-- Search Bar -->
                        <div class="flex items-center relative">
                            <form action="OrganizerEventController" method="GET">
                                <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                                    <i class="fas fa-search text-gray-500"></i>
                                </span>
                                <input type="text" name="eventName" placeholder="Search event" class="w-64 pl-10 pr-4 py-2 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-green-500 text-black">
                                <button type="submit" class="ml-3 bg-gray-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200">
                                    Search
                                </button>
                            </form>
                        </div>
                        <!-- Filter Buttons -->
                        <div class="flex flex-1 ml-4 space-x-2">
                            <button class="flex-1 px-4 py-2 rounded-full transition duration-200 ${currentFilter == 'all' ? 'bg-green-500' : 'bg-gray-600'}" 
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=all'">
                                All
                            </button>
                            <button class="flex-1 px-4 py-2 rounded-full transition duration-200 ${currentFilter == 'processing' ? 'bg-green-500' : 'bg-gray-600'}" 
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=processing'">
                                Processing
                            </button>
                            <button class="flex-1 px-4 py-2 rounded-full transition duration-200 ${currentFilter == 'approved' ? 'bg-green-500' : 'bg-gray-600'}" 
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=approved'">
                                Approved
                            </button>
                            <button class="flex-1 px-4 py-2 rounded-full transition duration-200 ${currentFilter == 'rejected' ? 'bg-green-500' : 'bg-gray-600'}" 
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=rejected'">
                                Rejected
                            </button>
                            <button class="flex-1 px-4 py-2 rounded-full transition duration-200 ${currentFilter == 'upcoming' ? 'bg-green-500' : 'bg-gray-600'}" 
                                    onclick="location.href = '${pageContext.request.contextPath}/OrganizerEventController?filter=upcoming'">
                                Upcoming
                            </button>
                            <button class="flex-1 px-4 py-2 rounded-full transition duration-200 ${currentFilter == 'past' ? 'bg-green-500' : 'bg-gray-600'}" 
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
                            <!-- Card sự kiện -->
                            <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden mb-4">
                                <!-- Phần trên: 2 cột (ảnh và thông tin) -->
                                <div class="flex">
                                    <c:if test="${not empty event.imageUrl}">
                                        <div class="w-1/3 flex items-center justify-center bg-gray-800 card-image-container">
                                            <!-- Sử dụng class "cover" để ảnh luôn bao phủ container.
                                                 Nếu muốn hiển thị toàn bộ ảnh mà không cắt, thay đổi "cover" thành "contain" -->
                                            <img src="${event.imageUrl}" alt="Event image" class="cover" />
                                        </div>
                                    </c:if>
                                    <div class="w-2/3 p-4 bg-gray-800 flex flex-col justify-center">
                                        <h2 class="text-xl font-bold text-white cursor-pointer hover:text-gray-400 mb-4" 
                                            onclick="window.open('${pageContext.request.contextPath}/OrganizerEventDetailController?eventId=${event.eventId}', '_blank')">
                                            ${event.eventName}
                                        </h2>
                                        <div class="flex flex-col gap-2">
                                            <c:if test="${not empty event.startDate}">
                                                <div class="flex items-center text-green-400">
                                                    <i class="far fa-calendar-alt mr-2 text-white"></i>
                                                    <span>
                                                        <fmt:formatDate value="${event.startDate}" pattern="HH:mm, EEEE, MMM dd yyyy" />
                                                    </span>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty event.location}">
                                                <div class="flex items-center text-green-400">
                                                    <i class="fas fa-map-marker-alt mr-2 text-white"></i>
                                                    <span>${event.location}</span>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty event.eventStatus}">
                                                <div class="flex items-center text-green-400">
                                                    <i class="fas fa-check-circle mr-2 text-white"></i>
                                                    <span>Status: ${event.eventStatus}</span>
                                                </div>
                                            </c:if>
                                            <c:if test="${not empty event.startDate and not empty event.endDate}">
                                                <div class="flex items-center text-green-400">
                                                    <i class="fas fa-hourglass-half mr-2 text-white"></i>
                                                    <span>Duration: 
                                                        <fmt:formatDate value="${event.startDate}" pattern="MMM dd, yyyy" /> - 
                                                        <fmt:formatDate value="${event.endDate}" pattern="MMM dd, yyyy" />
                                                    </span>
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                <!-- Phần dưới: Các nút hành động, căn giữa -->
                                <div class="p-4 border-t border-gray-700 flex justify-center">
                                    <button type="button" 
                                            onclick="window.open('${pageContext.request.contextPath}/eventOverview?eventId=${event.eventId}', '_blank')" 
                                            class="group flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700 mx-2">
                                        <i class="fas fa-chart-pie text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Overview</span>
                                    </button>
                                    <button type="button" 
                                            onclick="window.open('${pageContext.request.contextPath}/organizerOrders?eventId=${event.eventId}', '_blank')"
                                            class="group flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700 mx-2">
                                        <i class="fas fa-list text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Orders</span>
                                    </button>
                                    <button type="button" 
                                            onclick="window.open('${pageContext.request.contextPath}/viewdetail.jsp', '_blank')" 
                                            class="group flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700 mx-2">
                                        <i class="fas fa-chair text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Seating Chart</span>
                                    </button>
                                    <c:if test="${event.eventStatus eq 'Processing'}">
                                        <button type="button" 
                                                onclick="window.open('${pageContext.request.contextPath}/updateEvent?eventId=${event.eventId}', '_blank')" 
                                                class="group flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700 mx-2">
                                            <i class="fas fa-edit text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                            <span class="text-gray-400 group-hover:text-white">Edit</span>
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </section>
            </main>
        </div>

        <!-- JavaScript xử lý AJAX cho tìm kiếm & gợi ý -->
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
                    if (suggestions.length === 0)
                        return;

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
                            <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden mb-4">
                                <div class="flex">
                                    <div class="w-1/3 flex items-center justify-center bg-gray-800 card-image-container">
                                        <img src="${event.imageUrl}" alt="Event image" class="cover" />
                                    </div>
                                    <div class="w-2/3 p-4 bg-gray-800 flex flex-col justify-center">
                                        <h2 class="text-xl font-bold text-white cursor-pointer hover:text-gray-400 mb-4" 
                                            onclick="location.href = '${pageContext.request.contextPath}/organizerEventDetail?eventId=` + event.eventId + `'">
                                            ` + event.eventName + `
                                        </h2>
                                        <div class="flex flex-col gap-2">
                                            <div class="flex items-center text-green-400">
                                                <i class="fas fa-map-marker-alt mr-2 text-white"></i>
                                                <span>` + event.location + `</span>
                                            </div>
                                            <div class="flex items-center text-green-400">
                                                <i class="fas fa-check-circle mr-2 text-white"></i>
                                                <span>Status: ` + event.status + `</span>
                                            </div>
                                            <div class="flex items-center text-green-400">
                                                <i class="fas fa-hourglass-half mr-2 text-white"></i>
                                                <span>Duration: ` + formatDate(event.createdAt) + ` - ` + formatDate(event.updatedAt) + `</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="p-4 border-t border-gray-700 flex justify-center">
                                    <button type="button" onclick="location.href = '${pageContext.request.contextPath}/eventOverview?eventId=` + event.eventId + `'" 
                                            class="group flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700 mx-2">
                                        <i class="fas fa-chart-pie text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Overview</span>
                                    </button>
                                    <button type="button" onclick="location.href = '${pageContext.request.contextPath}/organizerOrders?eventId=` + event.eventId + `'" 
                                            class="group flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700 mx-2">
                                        <i class="fas fa-list text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Orders</span>
                                    </button>
                                    <button type="button" onclick="location.href = '${pageContext.request.contextPath}/viewdetail.jsp'" 
                                            class="group flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700 mx-2">
                                        <i class="fas fa-chair text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Seating Chart</span>
                                    </button>
                                    <button type="button" onclick="location.href = '${pageContext.request.contextPath}/updateEvent?eventId=` + event.eventId + `'" 
                                            class="group flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700 mx-2">
                                        <i class="fas fa-edit text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Edit</span>
                                    </button>
                                </div>
                            </div>`;
                        container.append(eventHtml);
                    });
                }
            });
        </script>
    </body>
</html>
