<%-- 
    Document   : homeevents
    Created on : Feb 11, 2025, 2:57:33 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <style>
            body {
                background-color: #121212;
                color: white;
            }

            /* Large Event */
            .content-grid-large_events {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                grid-gap: 5px;
                padding: 30px;
                margin: 0 0;
                margin-left: 7%;
            }

            .carousel-large_events {
                position: relative;
                overflow: hidden;
                width: 85%;
                height: 300px;
                width: 85%;
                height: 300px;
                display: flex;
                justify-content: center;
                border-radius: 8px;
            }

            .slides-large_events {
                display: flex;
                transition: transform 0.5s ease-in-out;
            }

            .event-card-large_events {
                flex: 0 0 100%;
                box-sizing: border-box;
                padding: 0;
                position: relative;
                background-color: #f5f5f5;
                border-radius: 8px;
                overflow: hidden;
            }

            .event-card-large_events img {
                width: 100%;
                height: 100%;
                object-fit: fill;
                transition: transform 0.3s ease-in-out;
            }

            .event-card-large_events img:hover {
                transform: scale(1.1);
            }

            .view-btn-large_events {
                position: absolute;
                bottom: 10px;
                left: 10px;
                background-color: #00a651;
                color: white;
                border: none;
                border-radius: 4px;
                padding: 8px 12px;
                cursor: pointer;
                z-index: 10;
            }

            .prev-large_events,
            .next-large_events {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background-color: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                border-radius: 50%;
                width: 35px;
                height: 35px;
                cursor: pointer;
                z-index: 10;
                opacity: 0.3;
                transition: opacity 0.3s ease, background-color 0.3s ease, transform 0.2s ease;
            }

            .prev-large_events:hover,
            .next-large_events:hover {
                opacity: 1;
                background-color: rgba(0, 0, 0, 0.8);
                transform: translateY(-50%) scale(1.1);
            }

            .prev-large_events {
                left: 10px;
            }

            .next-large_events {
                right: 10px;
            }

            .sidebar-large_events {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 20px;
            }

            .calendar-large_events,
            .map-large_events {
                background-color: #f5f5f5;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                padding: 16px;
                width: 100%;
                max-width: 300px;
                margin-bottom: 20px;
            }


            /*Top-Picks-For-You*/
            .title-top_events {
                text-align: center;
            }

            .content-grid-top_events {
                display: flex;
                align-items: center;
                overflow-x: hidden;
                position: relative;
                padding: 20px;
                margin: 0 40px;
            }

            .event-cards-top_events {
                display: flex;
                overflow-x: hidden;
                scroll-behavior: smooth;
                padding: 0;
            }

            .event-card-top_events {
                position: relative;
                background-color: #f5f5f5;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                height: 300px; /* Chiều cao cố định */
                width: 220px; /* Chiều rộng cố định */
                min-width: 220px; /* Đảm bảo không bị co nhỏ quá */
                margin-right: 20px;
            }

            .event-card-top_events img {
                width: 100%;
                height: 100%;
                object-fit: fill; /* Giữ tỷ lệ và cắt phần thừa */
                object-position: center; /* Căn giữa ảnh */
                display: block; /* Loại bỏ khoảng trống dưới ảnh */
            }

            .prev-btn-top_events,
            .next-btn-top_events {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background-color: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                font-size: 20px;
                cursor: pointer;
                z-index: 10;
            }

            .prev-btn-top_events {
                left: 10px;
            }

            .next-btn-top_events {
                right: 10px;
            }


            /*Special-Events*/
            .title-spec_event {
                text-align: center;
            }

            .content-grid-spec_event {
                display: flex;
                align-items: center;
                overflow-x: hidden;
                position: relative;
                padding: 20px;
                margin: 0 9.9%;
            }

            .event-cards-spec_event {
                display: flex;
                overflow-x: hidden;
                scroll-behavior: smooth;
                padding: 0;
            }

            .event-card-spec_event {
                position: relative;
                background-color: #f5f5f5;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                height: 300px;
                min-width: 220px;
                margin-right: 20px;
            }

            .event-card-spec_event img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out, filter 0.3s ease-in-out;
            }

            /* Hiệu ứng hover */
            .event-card-spec_event:hover img {
                transform: scale(1.1);
                box-shadow: 0px 0px 15px rgba(255, 255, 255, 0.5);
                filter: brightness(1.2);
            }

            .prev-btn-spec_event,
            .next-btn-spec_event {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background-color: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                font-size: 20px;
                cursor: pointer;
                z-index: 10;
                opacity: 0.3;
            }

            .prev-btn-spec_event {
                left: 20px;
            }

            .next-btn-spec_event {
                right: 20px;
            }

            /*Trending-Events*/
            .title-trend_events {
                text-align: center;
            }

            .content-grid-trend_events {
                display: flex;
                align-items: center;
                overflow-x: hidden;
                position: relative;
                padding: 20px;
                margin: 0 9.9%;
            }

            .event-cards-trend_events {
                display: flex;
                overflow-x: hidden;
                scroll-behavior: smooth;
                padding: 0;
            }

            .event-card-trend_events {
                position: relative;
                background-color: #f5f5f5;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                height: 180px;
                min-width: 300px;
                margin-right: 20px;
            }

            .event-card-trend_events img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out, filter 0.3s ease-in-out;
            }

            /* Hiệu ứng khi hover */
            .event-card-trend_events:hover img {
                transform: scale(1.1);
                box-shadow: 0px 0px 20px rgba(255, 255, 255, 0.5);
                filter: brightness(1.2);
            }

            .prev-btn-trend_events,
            .next-btn-trend_events {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background-color: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                font-size: 20px;
                cursor: pointer;
                z-index: 10;
                opacity: 0.3;
            }

            .prev-btn-trend_events {
                left: 20px;
            }

            .next-btn-trend_events {
                right: 20px;
            }

            /*Recommendation Events*/
            .title-rec_events {
                text-align: center;
            }

            .content-grid-rec_events {
                display: flex;
                align-items: center;
                overflow-x: hidden;
                position: relative;
                padding: 20px;
                margin: 0 9.9%;
            }

            .event-cards-rec_events {
                display: flex;
                overflow-x: hidden;
                scroll-behavior: smooth;
                padding: 0;
            }

            .event-card-rec_events {
                position: relative;
                background-color: #f5f5f5;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                height: 180px;
                min-width: 300px;
                margin-right: 20px;
            }

            .event-card-rec_events img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            /* Hiệu ứng khi hover */
            .event-card-rec_events:hover img {
                transform: scale(1.1);
                box-shadow: 0px 0px 15px rgba(255, 255, 255, 0.5);
            }

            .prev-btn-rec_events,
            .next-btn-rec_events {
                position: absolute;
                top: 50%;
                transform: translateY(-50%);
                background-color: rgba(0, 0, 0, 0.5);
                color: white;
                border: none;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                font-size: 20px;
                cursor: pointer;
                z-index: 10;
                opacity: 0.3;
            }

            .prev-btn-rec_events {
                left: 20px;
            }

            .next-btn-rec_events {
                right: 20px;
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
            .pagination a {
                text-decoration: none;
            }
            h2.text-xl.font-bold.text-center {
                margin-top: 2%;
                margin-bottom: -1.5rem !important;
                position: relative;
                display: inline-block;
                padding: 10px 20px;
                text-transform: uppercase;
                letter-spacing: 2px;
                transition: transform 0.3s ease-in-out, color 0.3s ease-in-out;
            }
            /* Hiệu ứng hover */
            h2.text-xl.font-bold.text-center:hover {
                transform: scale(1.1);
                color: #e63946; /* Màu đỏ đậm hơn */
            }
            /* Hiệu ứng underline khi xuất hiện */
            h2.text-xl.font-bold.text-center::after {
                content: "";
                position: absolute;
                left: 50%;
                bottom: -5px;
                width: 50%;
                height: 3px;
                background-color: #e63946;
                transform: translateX(-50%) scaleX(0);
                transition: transform 0.3s ease-in-out;
            }
            /* Khi hover, underline hiện ra */
            h2.text-xl.font-bold.text-center:hover::after {
                transform: translateX(-50%) scaleX(1);
            }

            h2.text-xl.font-bold {
                position: relative;
                display: inline-flex;
                align-items: center;
                padding: 0 0;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: transform 0.3s ease-in-out, color 0.3s ease-in-out;
            }

            /* Khi hover, tiêu đề sẽ phóng to nhẹ và đổi màu */
            h2.text-xl.font-bold:hover {
                transform: scale(1.1);
                color: #00ffee; /* Màu đỏ đậm hơn */
            }
        </style>
    </head>
    <body>        
        <!--Large-Events-->
        <div style="text-align: center;">
            <h2 class="text-xl font-bold text-center">
                <i class="fas fa-fire text-red-500 mr-2"></i> Most Popular
            </h2>
        </div>
        <div class="content-grid-large_events">
            <!-- Carousel 1 -->
            <div class="carousel-large_events">
                <div class="slides-large_events">
                    <c:forEach var="event" items="${carousel1}">
                        <div class="event-card-large_events">
                            <c:choose>
                                <c:when test="${not empty event.imageUrl}">
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}">
                                        <img src="${event.imageUrl}" alt="${event.imageTitle}" />
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}">
                                        <img src="${event.imageUrl}" alt="${event.eventName}" />
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
                <!-- Carousel Navigation -->
                <button class="prev-large_events">❮</button>
                <button class="next-large_events">❯</button>
            </div>
            <!-- Carousel 2 -->
            <div class="carousel-large_events">
                <div class="slides-large_events">
                    <c:forEach var="event" items="${carousel2}">
                        <div class="event-card-large_events">
                            <c:choose>
                                <c:when test="${not empty event.imageUrl}">
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}">
                                        <img src="${event.imageUrl}" alt="${event.imageTitle}" />
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}">
                                        <img src="${event.imageUrl}" alt="${event.eventName}" />
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:forEach>
                </div>
                <!-- Carousel Navigation -->
                <button class="prev-large_events">❮</button>
                <button class="next-large_events">❯</button>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/pages/listEventsPage/homeEvents.js"></script>

        <!--New Events-->
        <h2 class="text-xl font-bold mb-4 flex items-center" style="margin-left: 11%; margin-bottom: -0.5rem!important;">
            <i class="fas fa-star text-yellow-500 mr-2"></i> Special Events
        </h2>
        <div class="content-grid-spec_event" id="eventContainer-spec_event">
            <button class="prev-btn-spec_event">❮</button>
            <div class="event-cards-spec_event">
                <c:choose>
                    <c:when test="${not empty listEvents}">
                        <c:forEach var="event" items="${listEvents}">
                            <div class="event-card-spec_event">
                                <a style="text-decoration: none; color: white;" href="eventDetail?id=${event.eventId}">
                                    <img src="${event.imageUrl}" alt="${event.imageTitle}" />
                                </a>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>Empty!</p>
                    </c:otherwise>
                </c:choose>
            </div>
            <button class="next-btn-spec_event">❯</button>
        </div>
        <script>
            /*Specials-Events*/
            document.querySelectorAll(".content-grid-spec_event").forEach((container) => {
                const prevButton = container.querySelector(".prev-btn-spec_event");
                const nextButton = container.querySelector(".next-btn-spec_event");
                const eventCardsContainer = container.querySelector(".event-cards-spec_event");
                const eventCards = container.querySelectorAll(".event-card-spec_event");

                let currentIndex = 0;

                function scrollToEvent(index) {
                    const eventCardWidth = eventCards[0].offsetWidth + 20; // Bao gồm margin-right
                    eventCardsContainer.scrollTo({
                        left: eventCardWidth * index,
                        behavior: "smooth"
                    });
                }

                prevButton.addEventListener("click", () => {
                    currentIndex = Math.max(0, currentIndex - 1);
                    scrollToEvent(currentIndex);
                });

                nextButton.addEventListener("click", () => {
                    currentIndex = Math.min(eventCards.length - 1, currentIndex + 1);
                    scrollToEvent(currentIndex);
                });

                let autoScroll = setInterval(() => {
                    currentIndex = (currentIndex + 1) % eventCards.length;
                    scrollToEvent(currentIndex);
                }, 3000);

                eventCardsContainer.addEventListener("mouseenter", () => {
                    clearInterval(autoScroll);
                });

                eventCardsContainer.addEventListener("mouseleave", () => {
                    autoScroll = setInterval(() => {
                        currentIndex = (currentIndex + 1) % eventCards.length;
                        scrollToEvent(currentIndex);
                    }, 1000);
                });
            });
        </script>

        <!--Upcoming-Events--> 
        <h2 class="text-xl font-bold mb-4 flex items-center" style="margin-left: 11%; margin-bottom: -0.5rem!important;">
            <i class="fas fa-fire text-red-500 mr-2"></i> Upcoming events
        </h2>
        <div class="content-grid-trend_events" id="eventContainer-trend_events">
            <button class="prev-btn-trend_events">❮</button>
            <div class="event-cards-trend_events">
                <c:forEach var="event" items="${upcomingEvents}">
                    <div class="event-card-trend_events">
                        <a style="text-decoration: none; color: white;" href="eventDetail?id=${event.eventId}">
                            <img src="${event.imageUrl}" alt="${event.imageTitle}" />
                        </a>
                    </div>
                </c:forEach>
            </div>
            <button class="next-btn-trend_events">❯</button>
        </div>
        <script>
            document.querySelectorAll(".content-grid-trend_events").forEach((container) => {
                const prevButton = container.querySelector(".prev-btn-trend_events");
                const nextButton = container.querySelector(".next-btn-trend_events");
                const eventCardsContainer = container.querySelector(".event-cards-trend_events");
                const eventCards = container.querySelectorAll(".event-card-trend_events");

                let currentIndex = 0;

                function scrollToEvent(index) {
                    const eventCardWidth = eventCards[0].offsetWidth + 20; // Bao gồm margin-right
                    eventCardsContainer.scrollTo({
                        left: eventCardWidth * index,
                        behavior: "smooth",
                    });
                }

                prevButton.addEventListener("click", () => {
                    currentIndex = Math.max(0, currentIndex - 1);
                    scrollToEvent(currentIndex);
                });

                nextButton.addEventListener("click", () => {
                    currentIndex = Math.min(eventCards.length - 1, currentIndex + 1);
                    scrollToEvent(currentIndex);
                });

                let autoScroll = setInterval(() => {
                    currentIndex = (currentIndex + 1) % eventCards.length;
                    scrollToEvent(currentIndex);
                }, 3000);

                eventCardsContainer.addEventListener("mouseenter", () => {
                    clearInterval(autoScroll);
                });

                eventCardsContainer.addEventListener("mouseleave", () => {
                    autoScroll = setInterval(() => {
                        currentIndex = (currentIndex + 1) % eventCards.length;
                        scrollToEvent(currentIndex);
                    }, 1000);
                });
            });
        </script>

        <!--Recommendation Events--> 
        <h2 class="text-xl font-bold mb-4 flex items-center" style="margin-left: 11%; margin-bottom: -0.5rem!important;">
            <i class="fas fa-thumbs-up text-blue-500 mr-2"></i> Recommendation For You
        </h2>
        <div class="content-grid-rec_events" id="eventContainer-rec_events">
            <button class="prev-btn-rec_events">❮</button>
            <div class="event-cards-rec_events">
                <c:forEach var="event" items="${listRecommendedEvents}">
                    <div class="event-card-rec_events">
                        <a style="text-decoration: none; color: white;" href="eventDetail?id=${event.eventId}">
                            <img src="${event.imageUrl}" alt="${event.imageTitle}"/>
                        </a>
                    </div>
                </c:forEach>
            </div>
            <button class="next-btn-rec_events">❯</button>
        </div>
        <script>
            document.querySelectorAll(".content-grid-rec_events").forEach((container) => {
                const prevButton = container.querySelector(".prev-btn-rec_events");
                const nextButton = container.querySelector(".next-btn-rec_events");
                const eventCardsContainer = container.querySelector(".event-cards-rec_events");
                const eventCards = container.querySelectorAll(".event-card-rec_events");

                if (!prevButton || !nextButton || eventCards.length === 0) {
                    console.warn("Skipping a Recommendation section due to missing elements.");
                    return;
                }

                let currentIndex = 0;
                const totalCards = eventCards.length;
                const cardWidth = eventCards[0].offsetWidth + 20; // Include margin-right

                // Function to scroll to the selected event
                function scrollToEvent(index) {
                    eventCardsContainer.scrollTo({
                        left: cardWidth * index,
                        behavior: "smooth",
                    });
                }

                // Handle previous button click
                prevButton.addEventListener("click", () => {
                    currentIndex = Math.max(0, currentIndex - 1); // Prevent going below 0
                    scrollToEvent(currentIndex);
                });

                // Handle next button click
                nextButton.addEventListener("click", () => {
                    currentIndex = Math.min(totalCards - 1, currentIndex + 1); // Prevent exceeding last item
                    scrollToEvent(currentIndex);
                });

                // Auto-scroll every 3 seconds
                let autoScroll = setInterval(() => {
                    currentIndex = (currentIndex + 1) % totalCards;
                    scrollToEvent(currentIndex);
                }, 3000);

                // Pause auto-scroll when hovering
                eventCardsContainer.addEventListener("mouseenter", () => {
                    clearInterval(autoScroll);
                });

                // Resume auto-scroll when leaving
                eventCardsContainer.addEventListener("mouseleave", () => {
                    autoScroll = setInterval(() => {
                        currentIndex = (currentIndex + 1) % totalCards;
                        scrollToEvent(currentIndex);
                    }, 1000);
                });
            });
        </script>

        <!--All Event--> 
        <div style="text-align: center;">
            <h2 id="all-events-title" class="text-xl font-bold  text-center" style="margin-left: 4%;">
                <i class="fas fa-calendar-week text-green-500 mr-2"></i> All Events For You
            </h2>
        </div>
        <div class="container py-4">
            <div class="row gy-4" id="event-container">
                <!-- Event Cards -->
                <c:forEach var="event" items="${paginatedEvents}">
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
            <!-- Pagination -->
            <jsp:include page="pagination.jsp">
                <jsp:param name="baseUrl" value="/event" />
                <jsp:param name="page" value="${currentPage}" />
                <jsp:param name="totalPages" value="${totalPages}" />
                <jsp:param name="selectedStatus" value="${selectedStatus}" />
            </jsp:include>
        </div>
        <!-- Bootstrap JS for All Events-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
