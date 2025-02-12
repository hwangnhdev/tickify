<%-- 
    Document   : homeevents
    Created on : Feb 11, 2025, 2:57:33 PM
    Author     : thanh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <!--        <link
                    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
                    rel="stylesheet"
                    />-->
        <style>
            /* Large Event */
            /*            body {
                            margin: 0;
                            font-family: Arial, sans-serif;
                        }
            
                        header {
                            background-color: #00a651;
                            color: white;
                            display: flex;
                            justify-content: space-between;
                            align-items: center;
                            padding: 10px 20px;
                        }*/

            .logo-large_events {
                font-size: 24px;
                font-weight: bold;
            }

            .logo-large_events span {
                color: #ffdd00;
            }

            .search-bar-large_events {
                display: flex;
                align-items: center;
            }

            .search-bar-large_events input {
                padding: 8px 12px;
                border: none;
                border-radius: 4px;
                margin-right: 10px;
            }

            .search-bar-large_events button {
                background-color: #ffdd00;
                color: #00a651;
                border: none;
                border-radius: 4px;
                padding: 8px 12px;
                cursor: pointer;
                margin-right: 10px;
            }

            nav-large_events {
                background-color: #333;
                color: white;
                display: flex;
                justify-content: center;
                padding: 10px 0;
            }

            nav-large_events a {
                color: white;
                text-decoration: none;
                margin: 0 20px;
            }

            .content-grid-large_events {
                display: grid;
                grid-template-columns: repeat(2, 1fr);
                grid-gap: 5px;
                padding: 10px;
                margin: 0 40px;
            }

            .carousel-large_events {
                position: relative;
                overflow: hidden;
                width: 100%;
                height: 300px; /* Kích thước cố định cho carousel */
                display: flex;
                justify-content: center; /* Đảm bảo cân bằng hai bên */
                border-radius: 8px;
            }

            .slides-large_events {
                display: flex;
                transition: transform 0.5s ease-in-out;
            }

            .event-card-large_events {
                flex: 0 0 100%; /* Đảm bảo mỗi card chiếm toàn bộ carousel */
                box-sizing: border-box;
                padding: 0; /* Loại bỏ khoảng cách */
                position: relative;
                background-color: #f5f5f5;
                border-radius: 8px;
                overflow: hidden;
            }

            .event-card-large_events img {
                width: 100%;
                height: 100%; /* Đặt ảnh luôn vừa khung */
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
                z-index: 10; /* Đảm bảo nút nằm trên ảnh */
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
                left: 20px; /* Căn cố định vị trí nút trái */
            }

            .next-large_events {
                right: 20px; /* Căn cố định vị trí nút phải */
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
                height: 300px;
                min-width: 220px;
                margin-right: 20px;
            }

            .event-card-top_events img {
                width: 100%;
                height: 100%;
                object-fit: fill;
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
            <div class="carousel-large_events">
                <div class="slides-large_events">
                    <div class="event-card-large_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F608%2F332%2Fts%2Fds%2Feb%2F3d%2F05%2F7c43bc9234ec67b4f08651f6e892bad4.jpg&w=640&q=75"
                            alt="Event Image"
                            />
                        <button class="view-btn-large_events">View details</button>
                    </div>
                    <div class="event-card-large_events">
                        <img
                            src="https://i.ytimg.com/vi/TdDnx2fr5gg/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLB92DiHoE9AXstayS9XIcghkC9wSw"
                            alt="Event Image"
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
                            alt="Event Image"
                            />
                        <button class="view-btn-large_events">View details</button>
                    </div>
                    <div class="event-card-large_events">
                        <img
                            src="https://ticketbox.vn/_next/image?url=https%3A%2F%2Fimages.tkbcdn.com%2F2%2F608%2F332%2Fts%2Fds%2F51%2Fb4%2F2f%2F753fa09de83c3b675867be409387e713.jpg&w=384&q=75"
                            alt="Event Image"
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

        <script>
            // Lấy tất cả các carousel trong trang
            const carousels = document.querySelectorAll(".carousel-large_events");

            // Lặp qua từng carousel để thêm logic hoạt động
            carousels.forEach((carousel, index) => {
                const slides = carousel.querySelector(".slides-large_events");
                const eventCards = carousel.querySelectorAll(".event-card-large_events");
                const prevButton = carousel.querySelector(".prev-large_events");
                const nextButton = carousel.querySelector(".next-large_events");

                let currentIndex = 0;
                const totalSlides = eventCards.length;

                // Hàm cập nhật vị trí slide
                function updateSlide(index) {
                    slides.style.transform = `translateX(-${index * 100}%)`;
                }

                // Hàm tự động chuyển slide
                function autoSlide() {
                    currentIndex = (currentIndex + 1) % totalSlides;
                    updateSlide(currentIndex);
                }

                // Xử lý sự kiện nút "Next"
                nextButton.addEventListener("click", () => {
                    currentIndex = (currentIndex + 1) % totalSlides;
                    updateSlide(currentIndex);
                });

                // Xử lý sự kiện nút "Previous"
                prevButton.addEventListener("click", () => {
                    currentIndex = (currentIndex - 1 + totalSlides) % totalSlides;
                    updateSlide(currentIndex);
                });

                // Tự động chuyển slide với thời gian riêng biệt cho từng carousel
                let slideInterval = setInterval(autoSlide, 2000 + index * 1000); // Thời gian khác nhau cho mỗi carousel

                // Dừng tự động chuyển khi rê chuột vào carousel
                carousel.addEventListener("mouseenter", () => {
                    clearInterval(slideInterval);
                });

                // Tiếp tục tự động chuyển khi rê chuột ra ngoài
                carousel.addEventListener("mouseleave", () => {
                    slideInterval = setInterval(autoSlide, 2000 + index * 1000);
                });
            });
            // Đảm bảo nút luôn căn giữa hình ảnh
            window.addEventListener("resize", () => {
                const carousels = document.querySelectorAll(".carousel-large_events");
                carousels.forEach((carousel) => {
                    const slides = carousel.querySelector(".slides-large_events");
                    const eventCard = carousel.querySelector(".event-card-large_events img");
                    const prevButton = carousel.querySelector(".prev-large_events");
                    const nextButton = carousel.querySelector(".next-large_events");

                    if (eventCard) {
                        const cardHeight = eventCard.clientHeight; // Lấy chiều cao ảnh
                        prevButton.style.top = `${cardHeight / 2}px`; // Căn giữa nút trái
                        nextButton.style.top = `${cardHeight / 2}px`; // Căn giữa nút phải
                    }
                });
            });
        </script>

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
        <!--        <h2 class="title-spec_event">Special Events</h2>
                <div class="content-grid-spec_event" id="eventContainer-spec_event">
                    <button class="prev-btn-spec_event">❮</button>
                    <div class="event-cards-spec_event">
                        <div class="event-card-spec_event">
                            <img
                                src=""
                                alt="Event Image"
                                />
                        </div>
                    </div>
                    <button class="next-btn-spec_event">❯</button>
                </div>-->

        <script>
            const prevButton = document.querySelector(".prev-btn-spec_event");
            const nextButton = document.querySelector(".next-btn-spec_event");
            const eventCardsContainer = document.querySelector(".event-cards-spec_event"); // Đúng phần cần cuộn
            const eventCards = document.querySelectorAll(".event-card-spec_event");
            let currentIndex = 0;

            // Hàm cuộn đến sự kiện theo chỉ mục
            function scrollToEvent(index) {
                const eventCardWidth = eventCards[0].offsetWidth + 20; // Bao gồm margin-right
                eventCardsContainer.scrollTo({
                    left: eventCardWidth * index,
                    behavior: "smooth",
                });
            }

            // Sự kiện bấm nút ❮
            prevButton.addEventListener("click", () => {
                currentIndex = Math.max(0, currentIndex - 1); // Giới hạn về đầu
                scrollToEvent(currentIndex);
            });

            // Sự kiện bấm nút ❯
            nextButton.addEventListener("click", () => {
                currentIndex = Math.min(eventCards.length - 1, currentIndex + 1); // Giới hạn về cuối
                scrollToEvent(currentIndex);
            });

            // Tự động cuộn mỗi 3 giây
            let autoScroll = setInterval(() => {
                currentIndex = (currentIndex + 1) % eventCards.length; // Vòng lặp cuộn lại từ đầu
                scrollToEvent(currentIndex);
            }, 3000); // 3000ms = 3 giây

            // Dừng tự động cuộn khi rê chuột vào carousel
            eventCardsContainer.addEventListener("mouseenter", () => {
                clearInterval(autoScroll);
            });

            // Tiếp tục tự động cuộn khi chuột rời khỏi carousel
            eventCardsContainer.addEventListener("mouseleave", () => {
                autoScroll = setInterval(() => {
                    currentIndex = (currentIndex + 1) % eventCards.length;
                    scrollToEvent(currentIndex);
                }, 3000); // 3000ms = 3 giây
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
                    }, 3000);
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
                    }, 3000);
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
                    }, 3000);
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
