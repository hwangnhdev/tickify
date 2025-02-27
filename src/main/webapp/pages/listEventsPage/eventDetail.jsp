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
        <style>
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
                /* border-top: 2px solid #1db954; */
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
        <!--Header-->
        <jsp:include page="../../components/header.jsp"></jsp:include>

            <div class="container-event_detail">
                <div class="event-card-event_detail">
                    <div class="event-details">
                    <c:set var="event" value="${eventDetail}" />
                    <c:set var="category" value="${eventCategories}" />
                    <h1>${event.eventName}</h1>
                    <p><strong>Date & Time:</strong> ${event.startDate} - ${event.endDate}</p>
                    <p><strong>Category:</strong> ${category.categoryName}</p>
                    <p><strong>Category Description:</strong> ${category.description}</p>
                    <p><strong>Venue:</strong> ${event.location}</p>
                    <p class="price">From 270.000 ₫</p>
                    <p><strong>Description:</strong> ${event.description}</p>
                    <a class="btn" href="pages/seatSelectionPage/seatSelection.jsp">Order Ticket Now</a>
                </div>
                <div class="event-image-event_detail">
                    <c:set var="image" value="${eventImage}" />
                    <img src="${image.imageUrl}" alt="${image.image_title}" />
                </div>
            </div>
        </div>

        <div class="event-info-event_detail">
            <h2>Event Information Details</h2>
            <ul>
                <li>
                    <strong>Performance:</strong> A comedy show filled with joy and
                    laughter.
                </li>
                <li>
                    <strong>Description:</strong> "Cái gì Vui Vẻ thì mình Ưu Tiên" brings
                    you an unforgettable evening of laughter, emotions, and a touch of
                    cultural humor.
                </li>
                <li>
                    <strong>Venue Address:</strong> Số 28 Lê Thánh Tôn, Bến Nghé Ward, 1
                    District, Ho Chi Minh City.
                </li>
                <li><strong>Duration:</strong> 3 hours</li>
                <li><strong>Seating Capacity:</strong> 500 seats</li>
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

        <!--Relevant Events-->
        <jsp:include page="relevantEvents.jsp"></jsp:include>

            <!--Footer-->
        <jsp:include page="../../components/footer.jsp"></jsp:include>
    </body>
</html>
