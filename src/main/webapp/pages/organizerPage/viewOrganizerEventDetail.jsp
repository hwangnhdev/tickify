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
        <link
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"
            rel="stylesheet"
            />
        <link
            href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;600&display=swap"
            rel="stylesheet"
            />
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
            /* CSS Grid container cho header */
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
        </style>
    </head>
    <body class="bg-gradient-to-br from-gray-100 to-gray-300">
        <!-- Include Header -->
        <jsp:include page="../../components/header.jsp" />

        <!-- Set các attribute từ Controller -->
        <c:set var="event" value="${organizerEventDetail}" />
        <c:set var="listEventImages" value="${listEventImages}" />
        <c:set var="listShowtimes" value="${listShowtimes}" />
        <c:set var="ticketTypes" value="${listTicketTypes}" />

        <main class="max-w-6xl mx-auto p-6 mt-20 animate-fadeIn">
            <!-- Header: Event Information & Banner (View-only) -->
            <div class="equal-grid min-h-[350px]">
                <!-- Event Information Card -->
                <section class="bg-gray-800 text-white p-8 rounded-2xl shadow-2xl glow-border flex flex-col justify-between h-full">
                    <c:if test="${not empty event}">
                        <div>
                            <h2 class="fancy-text text-3xl font-bold card-title" title="${event.eventName}">
                                ${event.eventName}
                            </h2>
                            <p class="text-sm card-content flex items-center font-inter text-white">
                                <i class="fas fa-calendar-alt mr-2 text-gray-300"></i>
                                <span class="text-white">
                                    <fmt:formatDate value="${event.startDate}" pattern="dd MMM, yyyy" />
                                    -
                                    <fmt:formatDate value="${event.endDate}" pattern="dd MMM, yyyy" />
                                </span>
                            </p>
                            <p class="text-sm card-content flex items-center font-inter text-white">
                                <i class="fas fa-map-marker-alt mr-2 text-gray-300"></i>
                                <span class="text-white" title="${event.location}">${event.location}</span>
                            </p>
                            <!-- Lấy thông tin Category và Event Type từ database -->
                            <p class="text-sm card-content font-inter text-white">
                                <i class="fas fa-tag mr-1 text-gray-300"></i>
                                <strong>Category:</strong> ${event.categoryName}
                            </p>
                            <p class="text-sm card-content font-inter text-white">
                                <i class="fas fa-layer-group mr-1 text-gray-300"></i>
                                <strong>Event Type:</strong> ${event.eventType}
                            </p>

                        </div>
                        <div class="mt-6 border-t border-gray-600 pt-4">
                            <c:choose>
                                <c:when test="${fn:toLowerCase(event.eventStatus) == 'processing'}">
                                    <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-gray-600 px-4 py-2 rounded-full">
                                        <i class="fas fa-hourglass-half mr-2"></i>
                                        <span class="text-sm">Status: ${event.eventStatus}</span>
                                    </div>
                                    <div class="mt-4 flex flex-col sm:flex-row gap-4">
                                        <button type="button" onclick="updateEvent(${event.eventId}, 'Approved')"
                                                class="w-full sm:w-1/2 bg-green-600 text-white py-2 px-6 rounded-full flex items-center justify-center hover:scale-105 transition transform focus:outline-none focus:ring-2 focus:ring-green-500">
                                            <i class="fas fa-check-circle text-xl mr-2"></i>
                                            <span>Approve</span>
                                        </button>
                                        <button type="button" onclick="updateEvent(${event.eventId}, 'Rejected')"
                                                class="w-full sm:w-1/2 bg-red-600 text-white py-2 px-6 rounded-full flex items-center justify-center hover:scale-105 transition transform focus:outline-none focus:ring-2 focus:ring-red-500">
                                            <i class="fas fa-times-circle text-xl mr-2"></i>
                                            <span>Reject</span>
                                        </button>
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
                <!-- Banner Image Section -->
                <section class="relative h-full min-h-[350px]">
                    <c:if test="${not empty event.imageUrl}">
                        <img alt="${event.eventName} Banner" 
                             class="w-full h-full object-cover rounded-2xl shadow-2xl transition duration-500 ease-in-out hover:scale-105" 
                             src="${event.imageUrl}" />
                    </c:if>
                </section>
            </div>

            <!-- About Section -->
            <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                <c:choose>
                    <c:when test="${not empty event.description}">
                        <h3 class="text-2xl font-bold text-gray-800 card-title">About</h3>
                        <hr class="border-gray-300 mb-4" />
                        <p class="text-gray-700 font-inter overflow-auto">${event.description}</p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-gray-700 font-inter">No event description found.</p>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Organizer Information Section -->
            <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                <c:choose>
                    <c:when test="${not empty event.organizationName}">
                        <h3 class="text-2xl font-bold text-gray-800 card-title">Organizer Information</h3>
                        <hr class="border-gray-300 mb-4" />
                        <p class="text-gray-700 flex items-center font-inter">
                            <i class="fas fa-user mr-2 text-blue-500"></i>
                            <span>Organizer: ${event.organizationName}</span>
                        </p>

                    </c:when>
                    <c:otherwise>
                        <p class="text-gray-700 font-inter">No organizer detail found.</p>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Showtimes Section -->
            <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-4">Showtimes</h3>
                <hr class="border-gray-300 mb-4" />
                <c:if test="${not empty listShowtimes}">
                    <div class="space-y-4">
                        <c:forEach var="st" items="${listShowtimes}">
                            <div class="p-4 border rounded-lg flex flex-col gap-1 font-inter">
                                <p class="flex items-center text-gray-700">
                                    <i class="fas fa-play mr-2 text-blue-500"></i>
                                    <span><strong>Start:</strong> <fmt:formatDate value="${st.startDate}" pattern="dd/MM/yyyy HH:mm" /></span>
                                </p>
                                <p class="flex items-center text-gray-700">
                                    <i class="fas fa-stop mr-2 text-blue-500"></i>
                                    <span><strong>End:</strong> <fmt:formatDate value="${st.endDate}" pattern="dd/MM/yyyy HH:mm" /></span>
                                </p>
                                <p class="flex items-center text-gray-700">
                                    <i class="fas fa-signal mr-2 text-blue-500"></i>
                                    <span><strong>Status:</strong> ${st.showtimeStatus}</span>
                                </p>
                                <p class="flex items-center text-gray-700">
                                    <i class="fas fa-users mr-2 text-blue-500"></i>
                                    <span><strong>Total Seats:</strong> ${st.totalSeats}</span>
                                </p>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty listShowtimes}">
                    <p class="text-center text-gray-700 font-inter">No showtime information available.</p>
                </c:if>
            </section>

            <!-- Ticket Types Section -->
            <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-4">Ticket Types</h3>
                <hr class="border-gray-300 mb-4" />
                <c:if test="${not empty ticketTypes}">
                    <div class="space-y-4">
                        <c:forEach var="tt" items="${ticketTypes}">
                            <div class="p-4 border rounded-lg font-inter">
                                <!-- Không hiển thị ID để bảo mật -->
                                <p class="flex items-center text-gray-700">
                                    <i class="fas fa-ticket-alt mr-2 text-blue-500"></i>
                                    <span><strong>Name:</strong> ${tt.name}</span>
                                </p>
                                <p class="flex items-center text-gray-700">
                                    <i class="fas fa-align-left mr-2 text-blue-500"></i>
                                    <span><strong>Description:</strong> ${tt.description}</span>
                                </p>
                                <p class="flex items-center text-gray-700">
                                    <i class="fas fa-dollar-sign mr-2 text-blue-500"></i>
                                    <span><strong>Price:</strong> $${tt.price}</span>
                                </p>
                                <p class="flex items-center text-gray-700">
                                    <i class="fas fa-layer-group mr-2 text-blue-500"></i>
                                    <span><strong>Total Quantity:</strong> ${tt.totalQuantity}</span>
                                </p>
                                <p class="flex items-center text-gray-700">
                                    <i class="fas fa-shopping-cart mr-2 text-blue-500"></i>
                                    <span><strong>Sold Quantity:</strong> ${tt.soldQuantity}</span>
                                </p>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
                <c:if test="${empty ticketTypes}">
                    <p class="text-center text-gray-700 font-inter">No ticket type information available.</p>
                </c:if>
            </section>

            <!-- Admin Images Section -->
            <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-4 text-center">Event Images</h3>
                <hr class="border-gray-300 mb-4" />
                <c:choose>
                    <c:when test="${not empty listEventImages}">
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                            <c:forEach var="img" items="${listEventImages}">
                                <div class="relative group h-48 overflow-hidden">
                                    <img class="w-full h-full object-contain rounded-lg shadow-md transition duration-500 hover:scale-105 cursor-pointer"
                                         src="${img.imageUrl}"
                                         alt="${organizerEventDetail.eventName} - ${img.imageTitle}"
                                         loading="lazy"
                                         onclick="openModal('${img.imageUrl}', '${img.imageTitle}')"/>
                                    <div class="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-25 transition duration-300 rounded-lg"></div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="text-gray-700 text-center">No additional images available.</p>
                    </c:otherwise>
                </c:choose>
            </section>

            <!-- Modal Lightbox -->
            <div id="imageModal" class="modal">
                <div class="relative">
                    <img id="modalImage" class="max-w-full max-h-full rounded-lg" src="" alt="Enlarged Image" />
                    <button onclick="closeModal()" class="absolute top-2 right-2 text-white text-3xl">&times;</button>
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
    </body>
</html>
