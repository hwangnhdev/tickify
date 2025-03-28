<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Event Details - Admin</title>
        <!-- Tailwind CSS CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <script>
            // Nếu muốn sử dụng plugin aspect-ratio, bạn cần thêm cấu hình đúng hoặc load script plugin riêng.
            tailwind.config = {
                theme: {extend: {}},
                // plugins: [] // Nếu không dùng plugin thì để rỗng
            }
        </script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <style>
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
        </style>
    </head>
    <body class="bg-gradient-to-br from-gray-100 to-gray-300 font-sans">
        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp" />
            <!-- Main Content -->
            <div class="flex-1 p-6 overflow-y-auto">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Event Detail</h2>

                    <div class="flex flex-col lg:flex-row gap-6 items-stretch min-h-[350px]">
                        <!-- Event Information Card -->
                        <section class="lg:w-1/3 bg-gray-800 text-white p-8 rounded-2xl shadow-2xl glow-border flex flex-col justify-between h-full min-h-[350px]">
                            <c:if test="${not empty event}">
                                <div>
                                    <h2 class="fancy-text text-3xl font-bold card-title" title="${event.eventName}">
                                        ${event.eventName}
                                    </h2>
                                    <p class="text-sm card-content flex items-center font-inter">
                                        <i class="fas fa-calendar-alt mr-2 text-gray-300"></i>
                                        <span class="text-white">
                                            <fmt:formatDate value="${event.startDate}" pattern="dd MMM, yyyy" />
                                            -
                                            <fmt:formatDate value="${event.endDate}" pattern="dd MMM, yyyy" />
                                        </span>
                                    </p>
                                    <p class="text-sm card-content flex items-center font-inter">
                                        <i class="fas fa-map-marker-alt mr-2 text-gray-300"></i>
                                        <span class="text-white" title="${event.location}">${event.location}</span>
                                    </p>
                                    <p class="text-sm card-content font-inter">
                                        <i class="fas fa-tag mr-1 text-gray-300"></i>
                                        <strong>Category:</strong> ${event.categoryName}
                                    </p>
                                    <p class="text-sm card-content font-inter">
                                        <i class="fas fa-layer-group mr-1 text-gray-300"></i>
                                        <strong>Event Type:</strong> ${event.eventType}
                                    </p>
                                </div>
                                <!-- Xử lý trạng thái event -->
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
                                            <div class="mt-4 h-0"></div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-red-900 px-4 py-2 rounded-full">
                                                <i class="fas fa-times-circle mr-2"></i>
                                                <span class="text-sm">Status: ${event.eventStatus}</span>
                                            </div>
                                            <div class="mt-4 h-0"></div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>
                            <c:if test="${empty event}">
                                <p class="text-sm text-center">No event information available.</p>
                            </c:if>
                        </section>

                        <!-- Banner Image Section -->
                        <section class="flex-1 relative">
                            <c:if test="${not empty logoBannerImage}">
                                <img alt="${event.eventName} Banner" 
                                     class="w-full h-full object-contain rounded-2xl shadow-2xl transition duration-500 ease-in-out hover:scale-105" 
                                     src="${logoBannerImage}"style="object-fit: fill" />
                            </c:if>
                        </section>
                    </div>

                    <!-- Event Description Card -->
                    <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                        <c:choose>
                            <c:when test="${not empty event.description}">
                                <h3 class="text-2xl font-bold text-gray-800 card-title">Description</h3>
                                <hr class="border-gray-300 card-content">
                                <textarea readonly 
                                          class="w-full p-4 border rounded-lg shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 resize-none" 
                                          rows="5">${event.description}</textarea>
                            </c:when>
                            <c:otherwise>
                                <p class="text-gray-700">No description available.</p>
                            </c:otherwise>
                        </c:choose>
                    </section>
                      </div>

                    <!-- Organizer Information Card -->
                    <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                        <c:choose>
                            <c:when test="${not empty event.organizationName}">
                                <h3 class="text-2xl font-bold text-gray-800 card-title">Organizer Information</h3>
                                <hr class="border-gray-300 card-content" />
                                <p class="text-gray-700 flex items-center font-inter">
                                    <i class="fas fa-user mr-2 text-blue-500"></i>
                                    <span>Organizer: ${event.organizationName}</span>
                                </p>
                                <p class="text-gray-700 flex items-center font-inter">
                                    <i class="fas fa-id-badge mr-2 text-blue-500"></i>
                                    <span>Account Holder: ${event.accountHolder}</span>
                                </p>
                                <p class="text-gray-700 flex items-center font-inter">
                                    <i class="fas fa-credit-card mr-2 text-blue-500"></i>
                                    <span>Account Number: ${event.accountNumber}</span>
                                </p>
                                <p class="text-gray-700 flex items-center font-inter">
                                    <i class="fas fa-landmark mr-2 text-blue-500"></i>
                                    <span>Bank: ${event.bankName}</span>
                                </p>
                            </c:when>
                            <c:otherwise>
                                <p class="text-gray-700 font-inter">No organizer information available.</p>
                            </c:otherwise>
                        </c:choose>
                    </section>

                    <!-- Showtimes Section -->
                    <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                        <h3 class="text-2xl font-bold text-gray-800 mb-4">Showtimes</h3>
                        <hr class="border-gray-300 mb-4" />
                        <c:if test="${not empty showtimes}">
                            <div class="space-y-4">
                                <c:forEach var="st" items="${showtimes}">
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
                        <c:if test="${empty showtimes}">
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
                                            <span><strong>Price:</strong> đ${tt.price}</span>
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
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                            <div>
                                <p class="font-semibold mb-2 text-center">Banner</p>
                                <c:if test="${not empty logoBannerImage}">
                                    <div class="w-full h-64 overflow-hidden">
                                        <img src="${logoBannerImage}" alt="Banner Image" 
                                             class="w-full h-full object-contain rounded-lg shadow-md transition duration-500 hover:scale-105 cursor-pointer" 
                                             loading="lazy" />
                                    </div>
                                </c:if>
                            </div>
                            <div>
                                <p class="font-semibold mb-2 text-center">Event</p>
                                <c:if test="${not empty logoEventImage}">
                                    <div class="w-full h-64 overflow-hidden">
                                        <img src="${logoEventImage}" alt="Event Image" 
                                             class="w-full h-full object-contain rounded-lg shadow-md transition duration-500 hover:scale-105 cursor-pointer" 
                                             loading="lazy" />
                                    </div>
                                </c:if>
                            </div>
                            <div>
                                <p class="font-semibold mb-2 text-center">Organizer</p>
                                <c:if test="${not empty logoOrganizerImage}">
                                    <div class="w-full h-64 overflow-hidden">
                                        <img src="${logoOrganizerImage}" alt="Organizer Image" 
                                             class="w-full h-full object-contain rounded-lg shadow-md transition duration-500 hover:scale-105 cursor-pointer" 
                                             loading="lazy" />
                                    </div>
                                </c:if>
                            </div>
                        </div>
                </div>

                </section>
                </main>

                <!-- SweetAlert & Update Event Script -->
                <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
                <script>
                                                    function updateEvent(eventId, newStatus) {
                                                        var popupTitle, popupMessage, popupIcon;
                                                        if (newStatus === 'Approved') {
                                                            popupTitle = "Approve Event";
                                                            popupMessage = "Are you sure you want to approve event #" + eventId + "?";
                                                            popupIcon = "info";
                                                        } else if (newStatus === 'Rejected') {
                                                            popupTitle = "Reject Event";
                                                            popupMessage = "Are you sure you want to reject event #" + eventId + "?";
                                                            popupIcon = "error";
                                                        } else {
                                                            popupTitle = "Confirm";
                                                            popupMessage = "Do you want to update event #" + eventId + "?";
                                                            popupIcon = "warning";
                                                        }
                                                        swal({
                                                            title: popupTitle,
                                                            text: popupMessage,
                                                            icon: popupIcon,
                                                            buttons: true,
                                                            dangerMode: true,
                                                        }).then((willUpdate) => {
                                                            if (willUpdate) {
                                                                fetch('${pageContext.request.contextPath}/admin/approveEvent', {
                                                                    method: 'POST',
                                                                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                                                                    body: 'eventId=' + eventId + '&newStatus=' + newStatus
                                                                })
                                                                        .then(response => response.text())
                                                                        .then(result => {
                                                                            if (result.trim() === 'success') {
                                                                                swal("Success", "Event updated successfully!", "success")
                                                                                        .then(() => window.location.reload());
                                                                            } else {
                                                                                swal("Failed", "Failed to update event.", "error");
                                                                            }
                                                                        })
                                                                        .catch(error => {
                                                                            swal("Error", "Error: " + error, "error");
                                                                        });
                                                            }
                                                        });
                                                    }
                </script>
                </body>
                </html>
