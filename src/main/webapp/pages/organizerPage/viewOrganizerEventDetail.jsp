<%@ page contentType="text/html;charset=UTF-8" language="java" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Organizer Event Detail</title>
        <!-- Tailwind CSS & Aspect Ratio Plugin -->
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            tailwind.config = {
                theme: {extend: {}},
                plugins: [require('@tailwindcss/aspect-ratio')],
            }
        </script>
        <!-- Font Awesome & Google Fonts -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;600&display=swap" rel="stylesheet" />
        <!-- jQuery (cần cho AJAX và xử lý DOM) -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            /* Animation & Typography */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .animate-fadeIn {
                animation: fadeIn 0.8s ease-out forwards;
            }
            .fancy-text {
                font-family: 'Playfair Display', serif;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.2);
            }
            .font-inter {
                font-family: 'Inter', sans-serif;
            }
            .card-title {
                margin-bottom: 1.5rem;
            }
            .card-content {
                margin-bottom: 1rem;
            }
            .glow-border {
                border: 2px dashed rgba(74,85,104,0.5);
                box-shadow: 0 0 10px rgba(74,85,104,0.5);
            }
            /* Grid container cho header */
            .equal-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
                grid-auto-rows: 1fr;
            }
            /* Modal Lightbox */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.75);
                z-index: 50;
                align-items: center;
                justify-content: center;
            }
            .modal.active {
                display: flex;
            }
            /* Căn chỉnh text */
            .text-justify {
                text-align: justify;
            }
            .text-left {
                text-align: left;
            }
            /* Style cho suggestions dropdown */
            #suggestions div.selected {
                background-color: rgba(255,255,255,0.1);
            }
        </style>
    </head>
    <!-- Sử dụng nền tối với bg-gray-900 và chữ trắng -->
    <body class="bg-gray-900 text-white">
        <!-- Include Header -->
        <jsp:include page="../../components/header.jsp" />

        <!-- Set các attribute từ Controller -->
        <c:set var="event" value="${organizerEventDetail}" />
        <c:set var="listEventImages" value="${listEventImages}" />
        <c:set var="listShowtimes" value="${listShowtimes}" />
        <c:set var="ticketTypes" value="${listTicketTypes}" />

        <main class="max-w-6xl mx-auto p-6 mt-20 animate-fadeIn">
            <!-- Header: Card thông tin sự kiện & Banner -->
            <div class="flex flex-col md:flex-row gap-4 min-h-[350px]">
                <!-- Phần Thông Tin Sự Kiện -->
                <section class="flex-1 bg-gray-800 text-white p-6 rounded-2xl shadow-2xl glow-border flex flex-col justify-between">
                    <c:if test="${not empty event}">
                        <div>
                            <h2 class="fancy-text text-3xl font-bold card-title" title="${event.eventName}">
                                ${event.eventName}
                            </h2>
                            <p class="text-sm card-content flex items-center font-inter text-gray-300">
                                <i class="fas fa-calendar-alt mr-2 text-gray-400"></i>
                                <span>
                                    <fmt:formatDate value="${event.startDate}" pattern="dd MMMM, yyyy" /> -
                                    <fmt:formatDate value="${event.endDate}" pattern="dd MMMM, yyyy" />
                                </span>
                            </p>
                            <p class="text-sm card-content flex items-center font-inter text-gray-300">
                                <i class="fas fa-map-marker-alt mr-2 text-gray-400"></i>
                                <span title="${event.location}">${event.location}</span>
                            </p>
                            <p class="text-sm card-content font-inter text-gray-300">
                                <i class="fas fa-tag mr-1 text-gray-400"></i>
                                <strong>Category:</strong> ${event.categoryName}
                            </p>
                            <p class="text-sm card-content font-inter text-gray-300">
                                <i class="fas fa-layer-group mr-1 text-gray-400"></i>
                                <strong>Event Type:</strong> ${event.eventType}
                            </p>
                        </div>
                        <div class="mt-4 border-t border-gray-600 pt-4">
                            <c:choose>
                                <c:when test="${fn:toLowerCase(event.eventStatus) == 'processing'}">
                                    <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-gray-600 px-4 py-2 rounded-full">
                                        <i class="fas fa-hourglass-half mr-2"></i>
                                        <span class="text-sm">Status: ${event.eventStatus}</span>
                                    </div>
                                </c:when>
                                <c:when test="${fn:toLowerCase(event.eventStatus) == 'approved'}">
                                    <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-green-600 px-4 py-2 rounded-full">
                                        <i class="fas fa-check-circle mr-2"></i>
                                        <span class="text-green-400 text-sm">Status: ${event.eventStatus}</span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-red-900 px-4 py-2 rounded-full">
                                        <i class="fas fa-times-circle mr-2"></i>
                                        <span class="text-sm">Status: ${event.eventStatus}</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                    <c:if test="${empty event}">
                        <p class="text-sm text-center">No event details available.</p>
                    </c:if>
                </section>
                <!-- Phần Banner Ảnh -->
                <section class="flex-1 relative">
                    <c:if test="${not empty event.imageUrl}">
                        <img alt="${event.eventName} Banner" 
                             class="w-full h-full object-contain rounded-2xl shadow-2xl transition duration-500 ease-in-out hover:scale-105" 
                             src="${event.imageUrl}" style="object-fit: fill;"/>
                    </c:if>
                </section>
            </div>

            <!-- About Section -->
   <section class="bg-gradient-to-r from-gray-800 to-gray-700 p-6 rounded-xl shadow-lg mt-6 text-left">
    <c:choose>
        <c:when test="${not empty event.description}">
            <h3 class="text-2xl font-bold text-white card-title">About</h3>
            <hr class="border-gray-500 mb-4" />
            <textarea class="w-full p-4 border border-gray-600 rounded-lg font-inter text-gray-200 text-justify resize-y bg-gray-800" rows="6" readonly><c:out value="${fn:trim(event.description)}"/></textarea>
        </c:when>
        <c:otherwise>
            <p class="text-gray-200 font-inter">No event description found.</p>
        </c:otherwise>
    </c:choose>
</section>

            <!-- Organizer Information Section -->
            <section class="bg-gray-800 p-6 rounded-xl shadow-lg mt-6 text-left">
                <c:choose>
                    <c:when test="${not empty event.organizationName}">
                        <h3 class="text-2xl font-bold text-white card-title">Organizer Information</h3>
                        <hr class="border-gray-600 mb-4" />
                        <p class="text-gray-300 flex items-center font-inter">
                            <i class="fas fa-user mr-2 text-blue-500"></i>
                            <span>Organizer: ${event.organizationName}</span>
                        </p>
                        <p class="text-gray-300 flex items-center font-inter">
                            <i class="fas fa-id-badge mr-2 text-blue-500"></i>
                            <span>Account Holder: ${event.accountHolder}</span>
                        </p>
                        <p class="text-gray-300 flex items-center font-inter">
                            <i class="fas fa-credit-card mr-2 text-blue-500"></i>
                            <span>Account Number: ${event.accountNumber}</span>
                        </p>
                        <p class="text-gray-300 flex items-center font-inter">
                            <i class="fas fa-landmark mr-2 text-blue-500"></i>
                            <span>Bank: ${event.bankName}</span>
                        </p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-gray-300 font-inter">No organizer detail found.</p>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Showtimes Section -->
            <section class="bg-gray-800 p-6 rounded-xl shadow-lg mt-6 text-left">
                <h3 class="text-2xl font-bold text-white mb-4">Showtimes</h3>
                <hr class="border-gray-600 mb-4" />
                <c:if test="${not empty listShowtimes}">
                    <div class="space-y-4">
                        <c:forEach var="st" items="${listShowtimes}">
                            <div class="p-4 border rounded-lg flex flex-col gap-1 font-inter bg-gray-700">
                                <p class="flex items-center text-gray-300">
                                    <i class="fas fa-play mr-2 text-blue-500"></i>
                                    <span><strong>Start:</strong> <fmt:formatDate value="${st.startDate}" pattern="dd MMMM, yyyy HH:mm" /></span>
                                </p>
                                <p class="flex items-center text-gray-300">
                                    <i class="fas fa-stop mr-2 text-blue-500"></i>
                                    <span><strong>End:</strong> <fmt:formatDate value="${st.endDate}" pattern="dd MMMM, yyyy HH:mm" /></span>
                                </p>
                                <p class="flex items-center text-gray-300">
                                    <i class="fas fa-signal mr-2 text-blue-500"></i>
                                    <span><strong>Status:</strong> ${st.showtimeStatus}</span>
                                </p>
                                <p class="flex items-center text-gray-300">
                                    <i class="fas fa-users mr-2 text-blue-500"></i>
                                    <span><strong>Total Seats:</strong> ${st.totalSeats}</span>
                                </p>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty listShowtimes}">
                    <p class="text-center text-gray-300 font-inter">No showtime information available.</p>
                </c:if>
            </section>

            <!-- Ticket Types Section -->
            <section class="bg-gray-800 p-6 rounded-xl shadow-lg mt-6 text-left">
                <h3 class="text-2xl font-bold text-white mb-4">Ticket Types</h3>
                <hr class="border-gray-600 mb-4" />
                <c:if test="${not empty ticketTypes}">
                    <div class="space-y-4">
                        <c:forEach var="tt" items="${ticketTypes}">
                            <div class="p-4 border rounded-lg font-inter bg-gray-700">
                                <p class="flex items-center text-gray-300">
                                    <i class="fas fa-ticket-alt mr-2 text-blue-500"></i>
                                    <span><strong>Name:</strong> ${tt.name}</span>
                                </p>
                                <p class="flex items-center text-gray-300">
                                    <i class="fas fa-align-left mr-2 text-blue-500"></i>
                                    <span><strong>Description:</strong> ${tt.description}</span>
                                </p>
                                <p class="flex items-center text-gray-300">
                                    <i class="fas fa-dollar-sign mr-2 text-blue-500"></i>
                                    <span><strong>Price:</strong> $${tt.price}</span>
                                </p>
                                <p class="flex items-center text-gray-300">
                                    <i class="fas fa-layer-group mr-2 text-blue-500"></i>
                                    <span><strong>Total Quantity:</strong> ${tt.totalQuantity}</span>
                                </p>
                                <p class="flex items-center text-gray-300">
                                    <i class="fas fa-shopping-cart mr-2 text-blue-500"></i>
                                    <span><strong>Sold Quantity:</strong> ${tt.soldQuantity}</span>
                                </p>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty ticketTypes}">
                    <p class="text-center text-gray-300 font-inter">No ticket type information available.</p>
                </c:if>
            </section>

            <!-- Event Images Section -->
            <section class="bg-gray-800 p-6 rounded-xl shadow-lg mt-6 text-center">
                <h3 class="text-2xl font-bold text-white mb-4">Event Images</h3>
                <hr class="border-gray-600 mb-4" />
                <c:choose>
                    <c:when test="${not empty listEventImages}">
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                            <c:forEach var="img" items="${listEventImages}">
                                <div class="relative group h-48 overflow-hidden">
                                    <img class="w-full h-full object-contain rounded-lg shadow-md transition duration-500 hover:scale-105 cursor-pointer"
                                         src="${img.imageUrl}"
                                         alt="${event.eventName} - ${img.imageTitle}"
                                         loading="lazy"
                                         onclick="openModal('${img.imageUrl}', '${img.imageTitle}')"/>
                                    <div class="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-25 transition duration-300 rounded-lg"></div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-gray-300">No additional images available.</p>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Modal Lightbox -->
            <div id="imageModal" class="modal" role="dialog" aria-modal="true" aria-labelledby="modalTitle">
                <div class="relative">
                    <img id="modalImage" class="max-w-full max-h-full rounded-lg" src="" alt="Enlarged Image" />
                    <button onclick="closeModal()" class="absolute top-2 right-2 text-white text-3xl" aria-label="Close">&times;</button>
                </div>
            </div>
        </main>

        <!-- Modal & SweetAlert Script -->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
                        function openModal(imageUrl, imageTitle) {
                            const modal = document.getElementById('imageModal');
                            const modalImage = document.getElementById('modalImage');
                            modalImage.src = imageUrl;
                            modalImage.alt = imageTitle;
                            modal.classList.add('active');
                        }
                        function closeModal() {
                            const modal = document.getElementById('imageModal');
                            modal.classList.remove('active');
                        }
                        document.getElementById('imageModal').addEventListener('click', function (e) {
                            if (e.target === this) {
                                closeModal();
                            }
                        });
        </script>
        <!-- JavaScript xử lý AJAX cho tìm kiếm & gợi ý -->
        <script>
            $(document).ready(function () {
                let selectedIndex = -1;
                function fetchSuggestions(eventName) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/OrganizerEventController',
                        type: 'POST',
                        data: {eventName: eventName, organizerId: 98},
                        dataType: 'json',
                        success: function (data) {
                            displaySuggestions(data);
                        },
                        error: function (xhr, status, error) {
                            console.error("Error fetching suggestions: " + error);
                        }
                    });
                }
                function searchEvents(eventName) {
                    $.ajax({
                        url: '${pageContext.request.contextPath}/OrganizerEventController',
                        type: 'POST',
                        data: {eventName: eventName, organizerId: 98},
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
                $('#searchInput').on('input', function () {
                    var eventName = $(this).val().trim();
                    selectedIndex = -1;
                    if (eventName === "") {
                        $('#suggestions').addClass('hidden').empty();
                    } else {
                        fetchSuggestions(eventName);
                    }
                });
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
                $('#suggestions').on('click', 'div', function () {
                    $('#searchInput').val($(this).text());
                    $('#suggestions').addClass('hidden');
                });
                $('#searchButton').click(function () {
                    var eventName = $('#searchInput').val().trim();
                    if (eventName === "") {
                        alert("Please enter an event name to search.");
                        return;
                    }
                    searchEvents(eventName);
                    $('#suggestions').addClass('hidden');
                });
                function displaySuggestions(events) {
                    var suggestions = $('#suggestions');
                    suggestions.empty().removeClass('hidden');
                    selectedIndex = -1;
                    if (events.length === 0) {
                        suggestions.append('<div>No suggestions found</div>');
                        return;
                    }
                    $.each(events, function (index, event) {
                        suggestions.append('<div>' + event.eventName + '</div>');
                    });
                }
                function updateSelectedSuggestion(suggestions) {
                    suggestions.removeClass('selected');
                    if (selectedIndex >= 0) {
                        suggestions.eq(selectedIndex).addClass('selected');
                        $('#searchInput').val(suggestions.eq(selectedIndex).text());
                    }
                }
                function updateEventsList(events) {
                    var container = $('#eventsContainer');
                    container.empty();
                    if (events.length === 0) {
                        container.append('<p class="text-center text-gray-300">No events found.</p>');
                        return;
                    }
                    // Hàm formatDate với định dạng "dd MMMM, yyyy"
                    function formatDate(dateString) {
                        const date = new Date(dateString);
                        const day = String(date.getDate()).padStart(2, '0');
                        const month = date.toLocaleString('en-US', {month: 'long'});
                        const year = date.getFullYear();
                        return `${day} ${month}, ${year}`;
                                    }
                                    $.each(events, function (index, event) {
                                        var eventHtml = `
                            <div class="bg-gray-800 rounded-lg shadow-xl overflow-hidden mb-6 transform hover:-translate-y-1 hover:shadow-2xl transition-all duration-300">
                                <div class="flex">
                                    <div class="w-1/3 flex items-center justify-center bg-gray-800 card-image-container">
                                        <img src="${event.imageUrl}" alt="Event image" class="object-contain" />
                                    </div>
                                    <div class="w-2/3 p-6 flex flex-col justify-center">
                                        <h2 class="text-3xl font-bold text-white cursor-pointer hover:text-gray-400 mb-4" 
                                            onclick="window.open('${pageContext.request.contextPath}/OrganizerEventDetailController?eventId=` + event.eventId + `', '_blank')">
                                            ` + event.eventName + `
                                        </h2>
                                        <div class="flex flex-col gap-2">
                                            <div class="flex items-center text-green-400">
                                                <i class="far fa-calendar-alt mr-2 text-white"></i>
                                                <span>` + formatDate(event.startDate) + `</span>
                                            </div>
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
                                                <span>Duration: ` + formatDate(event.startDate) + ` - ` + formatDate(event.endDate) + `</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="p-4 border-t border-gray-700 flex justify-center space-x-4">
                                    <button type="button" onclick="window.open('${pageContext.request.contextPath}/eventOverview?eventId=` + event.eventId + `', '_blank')"
                                            class="flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700">
                                        <i class="fas fa-chart-pie text-2xl text-green-400 mr-2"></i>
                                        <span class="text-gray-400">Overview</span>
                                    </button>
                                    <button type="button" onclick="window.open('${pageContext.request.contextPath}/organizerOrders?eventId=` + event.eventId + `', '_blank')"
                                            class="flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700">
                                        <i class="fas fa-list text-2xl text-green-400 mr-2"></i>
                                        <span class="text-gray-400">Orders</span>
                                    </button>
                                    <button type="button" onclick="window.open('${pageContext.request.contextPath}/viewdetail.jsp', '_blank')"
                                            class="flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700">
                                        <i class="fas fa-chair text-2xl text-green-400 mr-2"></i>
                                        <span class="text-gray-400">Seating Chart</span>
                                    </button>
                                    <button type="button" onclick="window.open('${pageContext.request.contextPath}/updateEvent?eventId=` + event.eventId + `', '_blank')"
                                            class="flex items-center justify-center bg-gray-800 px-4 py-2 rounded-lg transition duration-200 hover:bg-gray-700">
                                        <i class="fas fa-edit text-2xl text-green-400 mr-2"></i>
                                        <span class="text-gray-400">Edit</span>
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
