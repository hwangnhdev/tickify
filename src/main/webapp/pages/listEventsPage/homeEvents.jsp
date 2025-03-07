<%-- 
    Document   : homeevents
    Created on : Feb 11, 2025, 2:57:33 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <style>
            body {
                background-color: black;
                color: white;
            }

            /* Large Event */
            .content-grid-large_events {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                grid-gap: 10px;
                padding: 30px;
                margin: 0 40px;
            }

            .carousel-large_events {
                position: relative;
                overflow: hidden;
                width: 100%;
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
                width: 40px;
                height: 40px;
                cursor: pointer;
                z-index: 10;
            }

            .prev-large_events {
                left: 20px;
            }

            .next-large_events {
                right: 20px;
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


            /*Large Event*/
            .content-grid-large_events {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                grid-gap: 5px;
                padding: 30px;
                margin: 0 40px;
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
                margin: 0 40px;
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
                object-fit: fill;
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
            }

            .prev-btn-spec_event {
                left: 10px;
            }

            .next-btn-spec_event {
                right: 10px;
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
                margin: 0 40px;
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
                object-fit: fill;
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
            }

            .prev-btn-trend_events {
                left: 10px;
            }

            .next-btn-trend_events {
                right: 10px;
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
                margin: 0 40px;
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
                object-fit: fill;
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
            }

            .prev-btn-rec_events {
                left: 10px;
            }

            .next-btn-rec_events {
                right: 10px;
            }

            /*All Events*/
            .title-all_events {
                text-align: center;
                font-size: 24px;
                font-weight: bold;
            }
            .event-card-all_events {
                background-color: #ffffff;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                text-align: center;
                /* width: 320px; */
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .event-card-all_events:hover {
                transform: translateY(-10px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .event-card-all_events img {
                width: 100%;
                height: 150px;
                object-fit: fill;
                background-color: #f0f0f0;
                display: block;
                transition: filter 0.3s;
            }

            .event-card-all_events:hover img {
                filter: brightness(1.1);
            }
            .event-card-all_events h4 {
                font-size: 16px;
                margin: 10px 0 5px;
                color: #000000;
            }
            .event-card-all_events p {
                font-size: 14px;
                margin: 5px 0;
                color: #000000;
            }
            .pagination a {
                text-decoration: none;
            }
        </style>
    </head>
    <body>        
        <!--Large-Events-->
        <div class="content-grid-large_events">
            <!-- Carousel 1 -->
            <div class="carousel-large_events">
                <div class="slides-large_events">
                    <c:forEach var="event" items="${carousel1}">
                        <div class="event-card-large_events">
                            <c:choose>
                                <c:when test="${not empty event.imageUrl}">
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}&categoryId=${event.categoryId}">
                                        <img src="${event.imageUrl}" alt="${event.imageTitle}" />
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}&categoryId=${event.categoryId}">
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
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}&categoryId=${event.categoryId}">
                                        <img src="${event.imageUrl}" alt="${event.imageTitle}" />
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}&categoryId=${event.categoryId}">
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
        <h2 class="title-spec_event">New Events</h2>
        <div class="content-grid-spec_event" id="eventContainer-spec_event">
            <button class="prev-btn-spec_event">❮</button>
            <div class="event-cards-spec_event">
                <c:choose>
                    <c:when test="${not empty listEvents}">
                        <c:forEach var="event" items="${listEvents}">
                            <div class="event-card-trend_events">
                                <a style="text-decoration: none; color: white;" href="eventDetail?id=${event.eventId}&categoryId=${event.categoryId}">
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
        <h2 class="title-trend_events">Upcoming events</h2>
        <div class="content-grid-trend_events" id="eventContainer-trend_events">
            <button class="prev-btn-trend_events">❮</button>
            <div class="event-cards-trend_events">
                <c:forEach var="event" items="${upcomingEvents}">
                    <div class="event-card-trend_events">
                        <a style="text-decoration: none; color: white;" href="eventDetail?id=${event.eventId}&categoryId=${event.categoryId}">
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
        <h2 class="title-rec_events">Recommendation For You</h2>
        <div class="content-grid-rec_events" id="eventContainer-rec_events">
            <button class="prev-btn-rec_events">❮</button>
            <div class="event-cards-rec_events">
                <c:forEach var="event" items="${listRecommendedEvents}">
                    <div class="event-card-rec_events">
                        <a style="text-decoration: none; color: white;" href="eventDetail?id=${event.eventId}&categoryId=${event.categoryId}">
                            <img src="${event.imageUrl}" alt="${event.imageTitle}" />
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
        <h2 class="title-all_events">All Events</h2>
        <div class="container py-4">
            <div class="row gy-4" id="event-container">
                <!-- Event Cards -->
                <c:forEach var="event" items="${paginatedEvents}">
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="event-card-all_events">
                            <a style="text-decoration: none; color: white;" href="eventDetail?id=${event.eventId}&categoryId=${event.categoryId}">
                                <img src="${event.imageUrl}" alt="${event.imageTitle}" />
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
