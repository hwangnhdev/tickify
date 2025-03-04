<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <!-- Responsive meta tag cho thiết bị di động -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Organizer Event Detail</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <style>
            .ticket {
                position: relative;
                border: 2px dashed #4a5568;
                border-radius: 10px;
                padding: 20px;
                background-color: #2d3748;
                color: white;
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
        </style>
    </head>
    <body class="bg-gray-100">
        <!-- Header -->
        <header class="bg-green-500 p-4 flex justify-between items-center">
            <div class="text-white text-2xl font-bold">ticketbox</div>
            <div class="flex items-center space-x-4">
                <input class="p-2 rounded" placeholder="What are you looking for today" type="text" aria-label="Search"/>
                <button class="bg-white text-green-500 px-4 py-2 rounded">Search</button>
                <button class="bg-white text-green-500 px-4 py-2 rounded">Create Event</button>
                <button class="text-white">My Tickets</button>
                <button class="text-white">My Account</button>
                <button class="text-white" aria-label="Select Language"><i class="fas fa-globe"></i></button>
            </div>
        </header>

        <!-- Navigation -->
        <nav class="bg-black text-white p-2" role="navigation">
            <ul class="flex justify-center space-x-4">
                <li><a class="hover:underline" href="#">Music</a></li>
                <li><a class="hover:underline" href="#">Theaters &amp; Art</a></li>
                <li><a class="hover:underline" href="#">Sport</a></li>
                <li><a class="hover:underline" href="#">Others</a></li>
            </ul>
        </nav>

        <!-- Main Content -->
        <main class="max-w-6xl mx-auto p-4">
            <div class="flex flex-col lg:flex-row items-stretch">
                <!-- Ticket-like container for event info -->
                <section class="ticket lg:w-1/3 flex flex-col justify-between bg-gray-700 text-white p-6 rounded-lg shadow-lg w-full max-w-md">
                    <c:if test="${not empty organizerEventDetail}">
                        <div>
                            <h2 class="text-2xl font-bold mb-2">${organizerEventDetail.eventName}</h2>

                            <p class="text-sm mb-2">
                                <i class="fas fa-calendar-alt mr-2"></i>
                                <span class="text-green-500">
                                    <fmt:formatDate value="${organizerEventDetail.startDate}" pattern="dd MMM, yyyy"/> -
                                    <fmt:formatDate value="${organizerEventDetail.endDate}" pattern="dd MMM, yyyy"/>
                                </span>
                            </p>
                            <p class="text-sm mb-2">
                                <i class="fas fa-map-marker-alt mr-2"></i>
                                <span class="text-green-500">${organizerEventDetail.location}</span>
                            </p>
                            <p class="text-sm mb-2"><strong>Payment Status:</strong> ${organizerEventDetail.paymentStatus}</p>
                        </div>
                        <hr class="border-gray-600 mt-4 mb-2">
                    </c:if>
                    <c:if test="${empty organizerEventDetail}">
                        <p class="text-sm text-center">No event details available.</p>
                    </c:if>
                </section>

                <!-- Image container -->
                <section class="lg:w-2/3 mt-4 lg:mt-0 lg:ml-4">
                    <c:if test="${not empty organizerEventDetail.imageURL}">
                        <img alt="${organizerEventDetail.eventName} image" 
                             class="rounded-lg w-full h-full object-cover" 
                             src="${organizerEventDetail.imageURL}"/>
                    </c:if>
                </section>
            </div>



            <!-- About Section -->
            <section class="mt-8">
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <c:choose>
                        <c:when test="${not empty organizerEventDetail.description}">
                            <h3 class="text-2xl font-bold mb-4">About</h3>
                            <hr class="border-gray-300 mb-4">
                            <p class="mt-2 text-gray-700">${organizerEventDetail.description}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-gray-700">No event description found.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <!-- Organizer Section -->
            <section class="mt-8">
                <div class="bg-white p-6 rounded-lg shadow-md">
                    <c:choose>
                        <c:when test="${not empty organizerEventDetail.organizationName}">
                            <h3 class="text-2xl font-bold mb-4">Organizer</h3>
                            <hr class="border-gray-300 mb-4">
                            <p class="font-bold">${organizerEventDetail.organizationName}</p>
                        </c:when>
                        <c:otherwise>
                            <p class="text-gray-700">No organizer detail found.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>
        </main>
    </body>
</html>
