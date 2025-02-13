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
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/listEventsPage/homeEvents.css"/>
    </head>
    <body>        
        <!--Large-Events-->
        <div class="content-grid-large_events">
            <div class="carousel-large_events">
                <div class="slides-large_events">
                    <div class="event-card-large_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F608%2F332%2Fts%2Fds%2Feb%2F3d%2F05%2F7c43bc9234ec67b4f08651f6e892bad4.jpg&w=640&q=75"
                            alt="Event Image 1"
                            />
                        <button class="view-btn-large_events">View details</button>
                    </div>
                    <div class="event-card-large_events">
                        <img
                            src="https://i.ytimg.com/vi/TdDnx2fr5gg/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLB92DiHoE9AXstayS9XIcghkC9wSw"
                            alt="Event Image 2"
                            />
                        <button class="view-btn-large_events">View details</button>
                    </div>
                    <div class="event-card-large_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F608%2F332%2Fts%2Fds%2Fbc%2F39%2F97%2F0bcedd8331d17bee81b65261a29976c2.jpg&w=384&q=75"
                            alt="Event Image 3"
                            />
                        <button class="view-btn-large_events">View details</button>
                    </div>
                </div>
                <button class="prev-large_events">❮</button>
                <button class="next-large_events">❯</button>
            </div>

            <div class="carousel-large_events">
                <div class="slides-large_events">
                    <div class="event-card-large_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F608%2F332%2Fts%2Fds%2Fd0%2F00%2Fd7%2F0596146f09bc0a37f14f2d8b0aeb3d1b.jpeg&w=384&q=75"
                            alt="Event Image 1"
                            />
                        <button class="view-btn-large_events">View details</button>
                    </div>
                    <div class="event-card-large_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F608%2F332%2Fts%2Fds%2F51%2Fb4%2F2f%2F753fa09de83c3b675867be409387e713.jpg&w=384&q=75"
                            alt="Event Image 2"
                            />
                        <button class="view-btn-large_events">View details</button>
                    </div>
                    <div class="event-card-large_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F608%2F332%2Fts%2Fds%2Ff7%2Fc2%2F1a%2Fd8b6343fa22566789a9be23530d0dc41.png&w=384&q=75"
                            alt="Event Image 3"
                            />
                        <button class="view-btn-large_events">View details</button>
                    </div>
                </div>
                <button class="prev-large_events">❮</button>
                <button class="next-large_events">❯</button>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/pages/listEventsPage/homeEvents.js"></script>

        <!--Special-Events-->
        <h2 class="title-spec_event">Special Events</h2>
        <div class="content-grid-spec_event" id="eventContainer-spec_event">
            <button class="prev-btn-spec_event">❮</button>
            <div class="event-cards-spec_event">
                <c:choose>
                    <c:when test="${not empty listEvents}">
                        <c:forEach var="event" items="${listEvents}">
                            <div class="event-card-spec_event">
                                <img src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F1a%2Fd9%2F5e%2F0f23b6fa6b7c6693c3bc9fd76ada848c.jpg&w=384&q=75" alt="${event.eventName}" />
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

        <!--Trending-Events--> 
        <h2 class="title-trend_events">Trending events</h2>
        <div class="content-grid-trend_events" id="eventContainer-trend_events">
            <button class="prev-btn-trend_events">❮</button>
            <div class="event-cards-trend_events">
                <div class="event-card-trend_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F8b%2Ffe%2Ff6%2Fa177577e2936c881cf05fba1903b2b44.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-trend_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-trend_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F8b%2Ffe%2Ff6%2Fa177577e2936c881cf05fba1903b2b44.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-trend_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F1a%2Fd9%2F5e%2F0f23b6fa6b7c6693c3bc9fd76ada848c.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-trend_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-trend_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F8b%2Ffe%2Ff6%2Fa177577e2936c881cf05fba1903b2b44.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-trend_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-trend_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-trend_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-trend_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
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

        <!--Top-Picks-For-You-->
        <h2 class="title-top_events">Top Picks For You</h2>
        <div class="content-grid-top_events" id="eventContainer-top_events">
            <button class="prev-btn-top_events">❮</button>
            <div class="event-cards-top_events">
                <div class="event-card-top_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-top_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-top_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-top_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F8b%2Fbf%2Fc6%2F3178ade25c2e3cd10fd2517f523cf060.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-top_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-top_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F8b%2Fbf%2Fc6%2F3178ade25c2e3cd10fd2517f523cf060.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-top_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-top_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2Faf%2Fc4%2F05%2F9425feab8d0b777666bcb598cba719f3.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-top_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-top_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2Faf%2Fc4%2F05%2F9425feab8d0b777666bcb598cba719f3.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
            </div>
            <button class="next-btn-top_events">❯</button>
        </div>

        <script>
            document.querySelectorAll(".content-grid-top_events").forEach((container) => {
                const prevButton = container.querySelector(".prev-btn-top_events");
                const nextButton = container.querySelector(".next-btn-top_events");
                const eventCardsContainer = container.querySelector(".event-cards-top_events");
                const eventCards = container.querySelectorAll(".event-card-top_events");

                if (!prevButton || !nextButton || eventCards.length === 0) {
                    console.warn("Skipping a Top Picks section due to missing elements.");
                    return;
                }

                let currentIndex = 0;
                const totalCards = eventCards.length;
                const cardWidth = eventCards[0].offsetWidth + 20; // Add margin

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

        <!--Recommendation Events--> 
        <h2 class="title-rec_events">Recommendation For You</h2>
        <div class="content-grid-rec_events" id="eventContainer-rec_events">
            <button class="prev-btn-rec_events">❮</button>
            <div class="event-cards-rec_events">
                <div class="event-card-rec_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F8b%2Ffe%2Ff6%2Fa177577e2936c881cf05fba1903b2b44.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-rec_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-rec_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F8b%2Ffe%2Ff6%2Fa177577e2936c881cf05fba1903b2b44.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-rec_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F1a%2Fd9%2F5e%2F0f23b6fa6b7c6693c3bc9fd76ada848c.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-rec_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-rec_events">
                    <img
                        src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F8b%2Ffe%2Ff6%2Fa177577e2936c881cf05fba1903b2b44.jpg&w=384&q=75"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-rec_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-rec_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-rec_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
                <div class="event-card-rec_events">
                    <img
                        src="https://kenh14cdn.com/thumb_w/660/2019/4/12/latmat-15550565414841068539616.jpg"
                        alt="Event Image"
                        />
                </div>
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
            <div class="row gy-4">
                <!-- Event Cards -->
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://images.tkbcdn.com/2/608/332/ts/ds/d1/91/35/4b4ca883013ffa19ccd3ce6889e96d69.png"
                            alt="Event Image"
                            />
                        <h4>9X GARDEN</h4>
                        <p>From 439.000đ</p>
                        <p>25 Jan, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://images.tkbcdn.com/2/608/332/ts/ds/d4/e9/12/b9cdaf59b65d91e9977e882902eb9e3d.jpg"
                            alt="Event Image"
                            />
                        <h4>Terrarium Workshop</h4>
                        <p>From 500.000đ</p>
                        <p>30 Jan, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://images.tkbcdn.com/2/608/332/ts/ds/d4/12/c6/0076baaaee9b8c4d13afc0b3aaeeedec.jpg"
                            alt="Event Image"
                            />
                        <h4>Spring Celebration</h4>
                        <p>From 300.000đ</p>
                        <p>1 Feb, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://images.tkbcdn.com/2/608/332/ts/ds/d1/91/35/4b4ca883013ffa19ccd3ce6889e96d69.png"
                            alt="Event Image"
                            />
                        <h4>Art & Music</h4>
                        <p>From 250.000đ</p>
                        <p>5 Feb, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F99%2F2d%2Fda%2F6bd5f943fb17da4ef4d3458ae3e400f8.jpg&w=384&q=75"
                            alt="Event Image"
                            />
                        <h4>9X GARDEN</h4>
                        <p>From 439.000đ</p>
                        <p>25 Jan, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2Faf%2Fc4%2F05%2F9425feab8d0b777666bcb598cba719f3.jpg&w=384&q=75"
                            alt="Event Image"
                            />
                        <h4>Terrarium Workshop</h4>
                        <p>From 500.000đ</p>
                        <p>30 Jan, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://images.tkbcdn.com/2/608/332/ts/ds/d4/12/c6/0076baaaee9b8c4d13afc0b3aaeeedec.jpg"
                            alt="Event Image"
                            />
                        <h4>Spring Celebration</h4>
                        <p>From 300.000đ</p>
                        <p>1 Feb, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2F99%2F2d%2Fda%2F6bd5f943fb17da4ef4d3458ae3e400f8.jpg&w=384&q=75"
                            alt="Event Image"
                            />
                        <h4>Art & Music</h4>
                        <p>From 250.000đ</p>
                        <p>5 Feb, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2Faf%2Fc4%2F05%2F9425feab8d0b777666bcb598cba719f3.jpg&w=384&q=75"
                            alt="Event Image"
                            />
                        <h4>9X GARDEN</h4>
                        <p>From 439.000đ</p>
                        <p>25 Jan, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://images.tkbcdn.com/2/608/332/ts/ds/d4/e9/12/b9cdaf59b65d91e9977e882902eb9e3d.jpg"
                            alt="Event Image"
                            />
                        <h4>Terrarium Workshop</h4>
                        <p>From 500.000đ</p>
                        <p>30 Jan, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F360%2F479%2Fts%2Fds%2Faf%2Fc4%2F05%2F9425feab8d0b777666bcb598cba719f3.jpg&w=384&q=75"
                            alt="Event Image"
                            />
                        <h4>Spring Celebration</h4>
                        <p>From 300.000đ</p>
                        <p>1 Feb, 2025</p>
                    </div>
                </div>
                <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                    <div class="event-card-all_events">
                        <img
                            src="https://images.tkbcdn.com/2/608/332/ts/ds/d1/91/35/4b4ca883013ffa19ccd3ce6889e96d69.png"
                            alt="Event Image"
                            />
                        <h4>Art & Music</h4>
                        <p>From 250.000đ</p>
                        <p>5 Feb, 2025</p>
                    </div>
                </div>
            </div>

            <!-- Pagination -->
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <li class="page-item">
                        <a class="page-link" href="#">&laquo; Previous</a>
                    </li>
                    <li class="page-item active"><a class="page-link" href="#">1</a></li>
                    <li class="page-item"><a class="page-link" href="#">2</a></li>
                    <li class="page-item"><a class="page-link" href="#">3</a></li>
                    <li class="page-item">
                        <a class="page-link" href="#">Next &raquo;</a>
                    </li>
                </ul>
            </nav>
        </div>

        <!-- Bootstrap JS for All Events-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
