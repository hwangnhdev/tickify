<%-- 
    Document   : eventDetail
    Created on : Feb 15, 2025, 8:22:57 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Event Detail</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <!-- Tailwind CSS -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
        <style>
            /* Existing styles remain unchanged */
            body {
                font-family: "Roboto", sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f7f7f7;
                color: #333;
            }

            .container-event_detail {
                display: flex;
                justify-content: center;
                align-items: center;
                padding: 20px;
                background-color: black;
                margin-top: 1%;
            }

            .event-card-event_detail {
                display: flex;
                flex-direction: row;
                background: linear-gradient(135deg, #706969, #514b4b);
                border-radius: 15px;
                box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                max-width: 1300px;
                width: 100%;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            .event-details {
                padding: 25px;
                flex: 1;
                color: #fff;
            }

            .event-details h1 {
                font-size: 2rem;
                font-weight: bold;
                transition: color 0.3s ease-in-out, transform 0.2s ease-in-out;
            }

            .event-details h1:hover {
                color: #ffcc00;
                transform: translateY(-2px);
            }

            .event-image-event_detail img {
                transition: transform 0.3s ease-in-out, filter 0.3s ease-in-out;
                max-width: 100%;
                height: auto;
                border-radius: 0 15px 15px 0;
            }

            .ticket {
                position: relative;
                border: 2px dashed #4a5568;
                border-radius: 10px;
                padding: 20px;
                background-color: #2d3748;
                color: white;
                margin-bottom: 10px;
            }

            .ticket::before, .ticket::after {
                content: '';
                position: absolute;
                width: 20px;
                height: 20px;
                background-color: #2d3748;
                border: 2px dashed #4a5568;
                border-radius: 50%;
            }
            .ticket::before {
                top: -11px;
                left: 50%;
                transform: translateX(-50%);
            }
            .ticket::after {
                bottom: -11px;
                left: 50%;
                transform: translateX(-50%);
            }

            /* Hiệu ứng chữ (text) */
            .event-details h1 {
                font-size: 2rem;
                font-weight: bold;
                transition: color 0.3s ease-in-out, transform 0.2s ease-in-out;
            }

            .event-details h1:hover {
                color: #ffcc00;
                transform: translateY(-2px);
            }

            .event-details p {
                font-size: 1rem;
                transition: color 0.3s ease-in-out, transform 0.2s;
            }

            .event-details p:hover {
                color: #ddd;
                transform: translateX(5px);
            }

            /* Hiệu ứng khi hover vào card */
            .event-card-event_detail:hover {
                transform: scale(1.02); /* Phóng to nhẹ */
                box-shadow: 0px 12px 25px rgba(0, 0, 0, 0.3); /* Bóng đổ mạnh hơn */
                transition: all 0.3s ease-in-out; /* Hiệu ứng mượt */
            }

            /* Hiệu ứng khi hover vào nút */
            .btn {
                transition: background-color 0.3s ease-in-out, transform 0.2s;
            }

            .btn:hover {
                background-color: #e63946; /* Màu đỏ sáng */
                transform: scale(1.05); /* Phóng to nhẹ */
            }

            .event-details h1 {
                font-size: 28px;
                margin: 0 0 15px;
                line-height: 1.4;
                font-weight: bold;
            }

            .event-details p {
                margin: 8px 0;
                font-size: 16px;
                line-height: 1.6;
            }

            .event-details .price {
                font-size: 20px;
                font-weight: bold;
                margin: 20px 0;
                color: #f3c623;
            }

            .event-details .btn {
                background-color: #1db954;
                color: #fff;
                padding: 12px 25px;
                border: none;
                border-radius: 25px;
                cursor: pointer;
                font-size: 16px;
                text-align: center;
                transition: all 0.3s ease;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            }

            .event-details .btn:hover {
                background-color: #17a045;
                transform: scale(1.05);
            }

            .event-image-event_detail {
                flex: 1;
            }

            .event-image-event_detail img {
                width: 100%;
                height: 100%;
                object-fit: fill;
                border-top-right-radius: 15px;
                border-bottom-right-radius: 15px;
            }

            .event-info-event_detail_relevant {
                background: linear-gradient(135deg, #ffffff, #f7f7f7);
                color: #333;
                padding: 25px;
                border-radius: 0 0 15px 15px;
                line-height: 1.8;
                box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
                font-family: "Roboto", sans-serif;
                margin: 10px 60px;
            }

            .event-info-event_detail {
                background: linear-gradient(135deg, #ffffff, #f7f7f7);
                color: #333;
                padding: 25px;
                border-radius: 0 0 15px 15px;
                line-height: 1.8;
                box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
                font-family: "Roboto", sans-serif;
                margin: 10px 60px;
            }

            .event-info-event_detail h2 {
                font-size: 28px;
                color: #1db954;
                font-weight: bold;
                margin-bottom: 15px;
                position: relative;
                text-transform: uppercase;
                text-align: center;
            }

            .event-info-event_detail h2::after {
                content: "";
                display: block;
                width: 50px;
                height: 3px;
                background: #1db954;
                margin-top: 5px;
                border-radius: 2px;
            }

            .event-info-event_detail ul {
                list-style: none;
                padding: 0;
            }

            .event-info-event_detail li {
                margin-bottom: 15px;
                font-size: 16px;
                display: flex;
                align-items: center;
            }

            .event-info-event_detail li::before {
                content: "✔";
                color: #1db954;
                margin-right: 10px;
                font-weight: bold;
            }

            .event-info-event_detail li span {
                font-size: 15px;
                color: #555;
                font-weight: 500;
            }

            .event-info-event_detail li:hover {
                background: rgba(29, 185, 84, 0.1);
                border-radius: 5px;
                padding: 5px 10px;
                transition: all 0.3s ease;
            }

            /* Hiệu ứng cho từng mục Showtime */
            .event-info-event_detail .text-gray-400 {
                font-size: 1rem;
                transition: color 0.3s ease-in-out, transform 0.2s;
                cursor: pointer;
            }

            .event-info-event_detail .text-gray-400:hover {
                color: #ffffff;
                transform: translateX(5px);
            }

            /* Hiệu ứng cho từng loại vé */
            .event-info-event_detail .bg-gray-700 {
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
                cursor: pointer;
            }

            .event-info-event_detail .bg-gray-700:hover {
                transform: scale(1.02);
                box-shadow: 0px 4px 10px rgba(255, 255, 255, 0.2);
            }

            /* Hiệu ứng cho giá vé */
            .text-green-400 {
                font-weight: bold;
                font-size: 1.1rem;
            }

            /* Hiệu ứng cho trạng thái vé */
            .bg-green-500, .bg-gray-500 {
                font-weight: bold;
                transition: background-color 0.3s ease-in-out;
            }

            .bg-green-500:hover {
                background-color: #32a852;
            }

            .bg-gray-500:hover {
                background-color: #6b7280;
            }

            /* Hiệu ứng nút đặt vé */
            .bg-red-500 {
                transition: background-color 0.3s ease-in-out, transform 0.2s;
            }

            .bg-red-500:hover {
                background-color: #e63946;
                transform: scale(1.05);
            }

            /* Textarea Styling */
            .event-info-textarea {
                width: 100%;
                padding: 0.5rem;
                border-radius: 0.375rem;
                background-color: #4B5563;
                border: 1px solid #6B7280;
                color: #FFFFFF;
                outline: none;
                resize: vertical;
                min-height: 100px;
                max-height: 400px;
                overflow-y: auto;
                box-shadow: 0 0 0 2px transparent;
                transition: border-color 0.3s ease, box-shadow 0.3s ease, height 0.3s ease;
                height: 300px;
                line-height: 1;
            }
            .event-info-textarea:focus {
                border-color: #15803D;
                box-shadow: 0 0 0 2px #15803D;
                background-color: #374151;
                color: #FFFFFF;
            }


            /*toggle*/
            .show-time-details {
                height: auto;
                transition: height 0.3s ease-out, opacity 0.3s ease-out, padding 0.3s ease-out;
                overflow: hidden;
            }
            .show-time-details.collapsed {
                height: 0;
                opacity: 0;
                padding: 0;
            }

            /*responsive*/
            @media (max-width: 768px) {
                .event-card-event_detail {
                    flex-direction: column;
                }

                .event-image-event_detail img {
                    border-radius: 0;
                    border-bottom-left-radius: 15px;
                    border-bottom-right-radius: 15px;
                }
            }
            /*All Events*/
            .title-all_events {
                text-align: center;
                font-size: 24px;
                font-weight: bold;
            }
            .event-card-all_events {
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                text-align: center;
                transition: transform 0.3s, box-shadow 0.3s;
                margin-top: 1%;
            }

            .event-card-all_events:hover {
                transform: translateY(-10px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .event-card-all_events img {
                width: 100%;
                height: 180px;
                object-fit: fill;
                background-color: #f0f0f0;
                display: block;
                transition: filter 0.3s;
                object-fit: fill;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            .event-card-all_events:hover img {
                filter: brightness(1.1);
                transform: scale(1.1);
                box-shadow: 0px 0px 15px rgba(255, 255, 255, 0.5);
            }
            .event-card-all_events h4 {
                font-size: 16px;
                margin: 10px 0 5px;
                color: #000000;
            }
            .event-card-all_events p {
                font-size: 14px;
                margin: 0 0;
                color: #000000;
            }
            .g-4, .gy-4 {
                --bs-gutter-y: 1.5rem;
                margin: 0 7%;
            }
            .py-4 {
                padding-top: 0.5rem !important;
                padding-bottom: 1.5rem !important;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="../../components/header.jsp"></jsp:include>
        <c:set var="event" value="${eventDetail}" />
        <c:set var="category" value="${eventCategories}" />
        <c:set var="organizer" value="${organizer}" />
        <c:set var="listShowtimes" value="${listShowtimes}" />
        <input value="${eventId}" name="eventID" hidden/>
        <input value="${event.organizerId}" name="organizerId" hidden/>

        <div class="container-event_detail">
            <div class="event-card-event_detail">
                <div class="event-details">
                    <div class="ticket">
                        <h1>${event.eventName}</h1>
                        <p><strong>Category:</strong> ${category.categoryName}</p>
                        <p><strong>Type Of Event:</strong> ${event.eventType}</p>
                        <p><strong>Organizer:</strong> ${organizer.organizationName}</p>
                        <p><strong>Venue:</strong> ${event.location}</p>
                        <p><strong>Status:</strong> <c:if test="${event.status == 'Approved'}">Available</c:if></p>
                        </div>
                        <div class="w-full mt-2 inline-flex items-center justify-center bg-gray-800 border border-red-900 px-4 py-2 rounded-full cursor-pointer" 
                             onclick="window.location.href = '#ShowtimesInformation'">
                            <i class="fas fa-check-circle mr-2 text-white"></i>
                            <span class="text-white-400 text-sm">Order Ticket Now</span>
                        </div>
                    </div>
                    <div class="event-image-event_detail">
                        <img src="${logoBannerImage}" alt="${titleEventImage}"/>
                </div>
            </div>
        </div>

        <!-- Event Showtimes Section with Integrated Template -->
        <div class="event-info-event_detail" id="ShowtimesInformation">
            <div class="max-w-2xl mx-auto">
                <div class="bg-gray-800 rounded-lg shadow-lg p-4">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-lg font-semibold">Showtimes Information</h2>
                    </div>
                    <!-- Loop through listShowtimes -->
                    <c:forEach var="showtime" items="${listShowtimes}" varStatus="loop">
                        <div class="show-time mb-4">
                            <div class="text-gray-400 show-time-header text-light" onclick="toggleShowTime(this)">
                                <i class="fas fa-chevron-down"></i>
                                <span class="show-time-label">Showtime ${loop.count}: </span>
                                <span>Start Date: ${showtime.startDate} - End Date: ${showtime.endDate}</span>
                            </div>
                            <div class="show-time-details space-y-2">
                                <!-- Loop through ticketTypes for this showtime -->
                                <c:forEach var="ticket" items="${showtime.ticketTypes}">
                                    <div class="flex justify-between items-center bg-gray-700 p-3 rounded-lg saved-ticket">
                                        <span class="text-light">${ticket.name}</span>
                                        <div class="flex items-center space-x-2">
                                            <span class="text-green-400">${ticket.price} đ</span>
                                            <span class="bg-green-500 text-white px-2 py-1 rounded-lg">
                                                <c:choose>
                                                    <c:when test="${ticket.totalQuantity - ticket.soldQuantity > 0}">Available</c:when>
                                                    <c:otherwise>Sold Out</c:otherwise>
                                                </c:choose>
                                            </span>
                                            <c:choose>
                                                <c:when test="${not empty sessionScope.customerId}">
                                                    <a href="viewSeat?showtimeId=${showtime.showtimeId}&ticketTypeId=${ticket.ticketTypeId}" 
                                                       class="bg-red-500 text-white px-2 py-1 rounded-lg hover:bg-red-600">
                                                        Order Now
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/pages/signUpPage/signUp.jsp" 
                                                       class="bg-gray-500 text-white px-2 py-1 rounded-lg hover:bg-gray-600">
                                                        Order Now
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>

        <div class="event-info-event_detail">
            <h2>Event Information Details</h2>
            <label class="block text-dark mb-2"><i class="fas fa-star text-yellow-500 mr-2"></i><strong>Event Information:</strong></label>
            <textarea class="event-info-textarea" placeholder="Description" readonly>${event.description}</textarea>
            <ul>
                <li><p><strong>Category: </strong> ${category.categoryName}</p></li>
                <li><p><strong>Category Description: </strong> ${category.description}</p></li>
                <li><p><strong>Type Of Event:</strong> ${event.eventType}</p></li>
                <li><p><strong>Venue Address:</strong> ${event.location}</p></li>
                <li><p><strong>Organizer Name:</strong> ${organizer.organizationName}</p></li>
                <img style="margin-left: 38%; max-width: 300px; max-height: 300px;" src="${logoOrganizerImage}" alt="${titleOrganizerImage}" />
                <li><strong>All Images Of Event</strong></li>
                <div class="flex">
                    <img style="margin-left: 13%; max-width: 300px; max-height: 600px;" src="${logoEventImage}" alt="${titleEventImage}" />
                    <img style="margin-left: 1%; width: 700px; max-height: 600px;" src="${logoBannerImage}" alt="${titleEventImage}" />
                </div>
            </ul>
        </div>

        <div class="event-info-event_detail">
            <!-- Google Maps Section -->
            <section class="mapAddress" style="padding: 32px 0">
                <div class="containers">
                    <div class="infoAddress"></div>
                    <div class="map">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3919.489511011803!2d106.69907477479463!3d10.776889059126504!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31752f3b8f6333d5%3A0xa8f36b0ebda0d20d!2sSaigon%20Opera%20House%20(Ho%20Chi%20Minh%20Municipal%20Theater)!5e0!3m2!1sen!2s!4v1708131234567" 
                                width="100%" height="450" style="border:0; display: inline-block;" 
                                allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade">
                        </iframe>
                    </div>
                </div>
            </section>
        </div>

        <div class="event-info-event_detail_relevant">
            <c:choose>
                <c:when test="${empty filteredEvents}">
                    <!--All Event--> 
                    <h2 class="text-xl font-bold  text-center" style="margin-left: 4%;">
                        <i class="fas fa-calendar-week text-green-500 mr-2"></i> All Events For You
                    </h2>
                    <div class="container py-4">
                        <div class="row gy-4" id="event-container">
                            <!-- Loop through paginated events -->
                            <c:forEach var="event" items="${paginatedEventsAll}">
                                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                                    <div class="event-card-all_events">
                                        <a style="text-decoration: none;" href="eventDetail?id=${event.event.eventId}">
                                            <img src="${event.eventImage.imageUrl}" alt="${event.eventImage.imageTitle}" />
                                            <h2 class="text-white text-sm font-semibold mb-2 h-[56px] line-clamp-2 overflow-hidden" style="margin-bottom: -0.5rem !important; padding: 0.5rem !important; background-color: #121212;">
                                                ${event.event.eventName}
                                            </h2>
                                            <p class="text-sm font-semibold" style="color: #00a651; background-color: #121212;">From  <fmt:formatNumber value="${event.minPrice}" currencyCode="VND" minFractionDigits="0" /> VND</p>
                                            <p class="text-sm font-semibold" style="color: white; background-color: #121212;">
                                                <i class="far fa-calendar-alt mr-2"></i>
                                                <span class=""><fmt:formatDate value="${event.firstStartDate}" pattern="hh:mm:ss a, dd MMM yyyy"/></span>
                                            </p>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- Bootstrap JS for All Events-->
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
                </c:when>
                <c:otherwise>
                    <!-- Relevant Events -->
                    <h2 class="text-xl font-bold text-center">
                        <i class="fas fa-star text-yellow-500 mr-2"></i> Relevant Events
                    </h2>
                    <div class="container py-4">
                        <div class="row gy-4" id="event-container">
                            <c:forEach var="event" items="${filteredEvents}">
                                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                                    <div class="event-card-all_events">
                                        <a style="text-decoration: none;" href="eventDetail?id=${event.event.eventId}">
                                            <img src="${event.eventImage.imageUrl}" alt="${event.eventImage.imageTitle}" />
                                            <h2 class="text-white text-sm font-semibold mb-2 h-[56px] line-clamp-2 overflow-hidden" style="margin-bottom: -0.5rem !important; padding: 0.5rem !important; background-color: #121212;">
                                                ${event.event.eventName}
                                            </h2>
                                            <p class="text-sm font-semibold" style="color: #00a651; background-color: #121212;">From  <fmt:formatNumber value="${event.minPrice}" currencyCode="VND" minFractionDigits="0" /> VND</p>
                                            <p class="text-sm font-semibold" style="color: white; background-color: #121212;">
                                                <i class="far fa-calendar-alt mr-2"></i>
                                                <span class=""><fmt:formatDate value="${event.firstStartDate}" pattern="hh:mm:ss a, dd MMM yyyy"/></span>
                                            </p>
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                    <!-- Pagination -->
                    <jsp:include page="pagination.jsp">
                        <jsp:param name="baseUrl" value="/eventDetail" />
                        <jsp:param name="page" value="${currentPage}" />
                        <jsp:param name="totalPages" value="${totalPages}" />
                        <jsp:param name="selectedStatus" value="${selectedStatus}" />
                    </jsp:include>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Footer -->
        <jsp:include page="../../components/footer.jsp"></jsp:include>
            <script>
                                function toggleShowTime(button) {
                                    const showTime = button.closest('.show-time');
                                    const details = showTime.querySelector('.show-time-details');
                                    const labelSpan = showTime.querySelector('.show-time-label');
                                    const icon = button.querySelector('i');

                                    // Toggle the collapsed state
                                    details.classList.toggle('collapsed');
                                    icon.classList.toggle('fa-chevron-down');
                                    icon.classList.toggle('fa-chevron-up');

                                    // Get showtime index from label
                                    let showTimeIndex = '1';
                                    if (labelSpan && labelSpan.textContent) {
                                        const match = labelSpan.textContent.match(/\d+/);
                                        showTimeIndex = match ? match[0] : '1';
                                    }

                                    // Get start and end dates from the header
                                    const dateSpan = button.querySelector('span:last-child');
                                    const dateText = dateSpan ? dateSpan.textContent : '';

                                    if (details.classList.contains('collapsed')) {
                                        // Collapsed state: show dates in label
                                        labelSpan.textContent = `Showtime ${showTimeIndex}: ${dateText}`;
                                        details.style.height = '0';
                                    } else {
                                        // Expanded state: reset label and expand details
                                        labelSpan.textContent = `Showtime ${showTimeIndex}: `;
                                        details.style.height = `${details.scrollHeight}px`;

                                        // Reset height to auto after transition for dynamic content
                                        setTimeout(() => {
                                            details.style.height = 'auto';
                                        }, 0); // Match transition duration
                                    }
                                }
        </script>
    </body>
</html>