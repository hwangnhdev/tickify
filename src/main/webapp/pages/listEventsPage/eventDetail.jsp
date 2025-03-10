<%-- 
    Document   : eventDetail
    Created on : Feb 15, 2025, 8:22:57 PM
    Author     : Tang Thanh Vui - CE180901
--%>

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
            }

            .event-card-event_detail {
                display: flex;
                flex-direction: row;
                background: linear-gradient(135deg, #706969, #514b4b);
                border-radius: 15px;
                box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                max-width: 1300px;
                max-height: 700px;
                height: 100%;
                width: 100%;
            }

            .event-details {
                padding: 25px;
                flex: 1;
                color: #fff;
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
                    <h1>${event.eventName}</h1>
                    <p><strong>Category:</strong> ${category.categoryName}</p>
                    <p><strong>Type Of Event:</strong> ${event.eventType}</p>
                    <p><strong>Organizer:</strong> ${organizer.organizationName}</p>
                    <p><strong>Venue:</strong> ${event.location}</p>
                    <p><strong>Status:</strong> <c:if test="${event.status == 'Active'}">Available</c:if></p>
                        <a class="btn" href="#ShowtimesInformation">Order Ticket Now</a>
                    </div>
                    <div class="event-image-event_detail">
                        <img src="${logoBannerImage}" alt="${titleEventImage}" />
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
                        <div class="text-gray-400 mb-4 text-light">
                            <i class="fas fa-chevron-down"></i>
                            <span>Showtime ${loop.count}: </span>
                            <span>Start Date: ${showtime.startDate} - End Date: ${showtime.endDate}</span>
                        </div>
                        <div class="space-y-2">
                            <!-- Loop through ticketTypes for this showtime -->
                            <c:forEach var="ticket" items="${showtime.ticketTypes}">
                                <div class="flex justify-between items-center bg-gray-700 p-3 rounded-lg">
                                    <span class="text-light">${ticket.name}</span>
                                    <div class="flex items-center space-x-2">
                                        <span class="text-green-400">${ticket.price} đ</span>
                                        <span class="bg-green-500 text-white px-2 py-1 rounded-lg">
                                            <c:choose>
                                                <c:when test="${ticket.totalQuantity - ticket.soldQuantity > 0}">Available</c:when>
                                                <c:otherwise>Sold Out</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <a href="bookTicket?showtimeId=${showtime.showtimeId}&ticketTypeId=${ticket.ticketTypeId}" 
                                           class="bg-red-500 text-white px-2 py-1 rounded-lg hover:bg-red-600">
                                            Order Now
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
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

        <!-- Relevant Events -->
        <h2 class="text-xl font-bold text-center">
            <i class="fas fa-star text-yellow-500 mr-2"></i> Relevant Events
        </h2>
        <c:choose>
            <c:when test="${empty filteredEvents}">
                <p class="text-center">Not Event Found From Your Filter And Search</p>
            </c:when>
            <c:otherwise>
                <div class="container py-4">
                    <div class="row gy-4" id="event-container">
                        <c:forEach var="event" items="${filteredEvents}">
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3" id="${event.eventId}">
                                <div class="event-card-all_events">
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}&categoryId=${event.categoryId}">
                                        <img src="${event.imageUrl}" alt="${event.eventName}" />
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

        <!-- Footer -->
        <jsp:include page="../../components/footer.jsp"></jsp:include>
    </body>
</html>