<%-- 
    Document   : largevent
    Created on : Feb 12, 2025, 11:40:10 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                width: 300%; /* Giả sử có 3 ảnh, nếu ảnh động thì cần tính động */
                transition: transform 0.5s ease-in-out;
                white-space: nowrap; /* Giữ tất cả ảnh trên cùng một hàng */
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
            document.querySelectorAll(".carousel-large_events").forEach((carousel, index) => {
                const slides = carousel.querySelector(".slides-large_events");
                const eventCards = carousel.querySelectorAll(".event-card-large_events");
                const prevButton = carousel.querySelector(".prev-large_events");
                const nextButton = carousel.querySelector(".next-large_events");

                // Ensure all elements exist before proceeding
                if (!slides || !prevButton || !nextButton || eventCards.length === 0) {
                    console.warn(`Skipping Large Event carousel ${index}: Missing required elements.`);
                    return;
                }

                let currentIndex = 0;
                const totalSlides = eventCards.length;

                // Ensure slides container is wide enough to hold all cards
                slides.style.display = "flex";
                slides.style.width = `${totalSlides * 100}%`; // Dynamic width

                // Ensure each event card takes up full space
                eventCards.forEach(card => {
                    card.style.flex = "0 0 100%";
                });

                // Function to update the slide position
                function updateSlide(index) {
                    slides.style.transform = `translateX(-${index * 100}%)`;
                }

                // Auto-slide function
                function autoSlide() {
                    currentIndex = (currentIndex + 1) % totalSlides;
                    updateSlide(currentIndex);
                }

                // Handle "Next" button click
                nextButton.addEventListener("click", () => {
                    currentIndex = (currentIndex + 1) % totalSlides;
                    updateSlide(currentIndex);
                });

                // Handle "Previous" button click
                prevButton.addEventListener("click", () => {
                    currentIndex = (currentIndex - 1 + totalSlides) % totalSlides;
                    updateSlide(currentIndex);
                });

                // Start auto-slide with unique timing per carousel
                let slideInterval = setInterval(autoSlide, 3000 + index * 1000);

                // Pause auto-slide on mouse enter
                carousel.addEventListener("mouseenter", () => {
                    clearInterval(slideInterval);
                });

                // Resume auto-slide on mouse leave
                carousel.addEventListener("mouseleave", () => {
                    slideInterval = setInterval(autoSlide, 3000 + index * 1000);
                });

                // Ensure buttons are always centered
                function centerButtons() {
                    const eventCard = carousel.querySelector(".event-card-large_events img");
                    if (eventCard) {
                        const cardHeight = eventCard.clientHeight;
                        prevButton.style.top = `${cardHeight / 2}px`;
                        nextButton.style.top = `${cardHeight / 2}px`;
                    }
                }

                // Center buttons on load and resize
                window.addEventListener("resize", centerButtons);
                centerButtons();
            });
        </script>
    </body>
</html>