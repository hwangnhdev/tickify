<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Event Details</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Include Tailwind Aspect Ratio Plugin -->
        <script>
            tailwind.config = {
                theme: {
                    extend: {},
                },
                plugins: [require('@tailwindcss/aspect-ratio')],
            }
        </script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <!-- Import Google Fonts for fancy headings and modern sans-serif for content -->
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Inter:wght@400;600&display=swap" rel="stylesheet">
        <style>
            /* Custom fadeIn animation for smooth page load */
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(20px); }
                to { opacity: 1; transform: translateY(0); }
            }
            .animate-fadeIn {
                animation: fadeIn 0.8s ease-out forwards;
            }
            /* Fancy text style for headings */
            .fancy-text {
                font-family: 'Playfair Display', serif;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
            }
            /* Consistent spacing for card content */
            .card-title { margin-bottom: 1.5rem; }
            .card-content { margin-bottom: 1rem; }
            /* Glow border effect for emphasis */
            .glow-border {
                border: 2px dashed rgba(74,85,104,0.5);
                box-shadow: 0 0 10px rgba(74,85,104,0.5);
            }
        </style>
    </head>
    <body class="bg-gradient-to-br from-gray-100 to-gray-300 font-sans">
        <!-- Main Content: mt-20 adds spacing below the header -->
        <main class="max-w-6xl mx-auto p-6 mt-20 animate-fadeIn">
            <div class="flex flex-col lg:flex-row gap-6">
                <!-- Event Information Card -->
                <section class="lg:w-1/3 bg-gray-800 text-white p-8 rounded-2xl shadow-2xl glow-border flex flex-col justify-between">
                    <c:if test="${not empty event}">
                        <div>
                            <h2 class="fancy-text text-3xl font-bold card-title">${event.eventName}</h2>
                            <p class="text-sm card-content flex items-center">
                                <i class="fas fa-calendar-alt mr-2"></i>
                                <span class="text-green-400">${event.startDate} - ${event.endDate}</span>
                            </p>
                            <p class="text-sm card-content flex items-center">
                                <i class="fas fa-map-marker-alt mr-2"></i>
                                <span class="text-green-400">${event.location}</span>
                            </p>
                        </div>
                        <div class="mt-6 border-t border-gray-600 pt-4">
                            <c:choose>
                                <c:when test="${event.status == 'Processing'}">
                                    <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-gray-600 px-4 py-2 rounded-full">
                                        <i class="fas fa-hourglass-half mr-2"></i>
                                        <span class="text-sm">Status: ${event.status}</span>
                                    </div>
                           
<!-- Hiển thị 2 nút Approve và Reject khi trạng thái là Processing -->
<c:if test="${fn:toLowerCase(event.status) == 'processing'}">
  <div class="mt-4 flex flex-col sm:flex-row gap-4">
    <button type="button" onclick="updateEvent(${event.eventId}, 'Approved')"
      class="w-full sm:w-1/2 bg-green-600 text-white py-2 px-6 rounded-full flex items-center justify-center hover:scale-105 transition transform focus:outline-none focus:ring-2 focus:ring-green-500">
      <i class="fas fa-check-circle text-xl mr-2"></i>
      <span class="truncate">Approve</span>
    </button>
    <button type="button" onclick="updateEvent(${event.eventId}, 'Rejected')"
      class="w-full sm:w-1/2 bg-red-600 text-white py-2 px-6 rounded-full flex items-center justify-center hover:scale-105 transition transform focus:outline-none focus:ring-2 focus:ring-red-500">
      <i class="fas fa-times-circle text-xl mr-2"></i>
      <span class="truncate">Reject</span>
    </button>
  </div>
</c:if>



                                </c:when>
                                <c:when test="${event.status == 'Approved'}">
                                    <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-green-600 px-4 py-2 rounded-full">
                                        <i class="fas fa-check-circle mr-2"></i>
                                        <span class="text-green-400 text-sm">Status: ${event.status}</span>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-red-900 px-4 py-2 rounded-full">
                                        <i class="fas fa-times-circle mr-2"></i>
                                        <span class="text-sm">Status: ${event.status}</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                    <c:if test="${empty event}">
                        <p class="text-sm text-center">No event information available.</p>
                    </c:if>
                </section>
                <!-- Banner Image Section with fixed aspect ratio -->
                <section class="lg:w-2/3 overflow-hidden">
                    <c:if test="${not empty logoBannerImage}">
                        <div class="aspect-w-16 aspect-h-9">
                            <img alt="${event.eventName} image" 
                                 class="w-full h-full object-contain transition duration-500 ease-in-out hover:scale-105 shadow-2xl" 
                                 src="${logoBannerImage}"/>
                        </div>
                    </c:if>
                </section>
            </div>
            <!-- Event Description Card -->
            <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                <c:choose>
                    <c:when test="${not empty event.description}">
                        <h3 class="text-2xl font-bold text-gray-800 card-title">Description</h3>
                        <hr class="border-gray-300 card-content">
                        <p class="text-gray-700">${event.description}</p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-gray-700">No description available.</p>
                    </c:otherwise>
                </c:choose>
            </section>
            <!-- Organizer Information Card -->
            <section class="bg-white p-6 rounded-xl shadow-lg mt-6">
                <c:choose>
                    <c:when test="${not empty event.organizationName}">
                        <h3 class="text-2xl font-bold text-gray-800 card-title">Organizer</h3>
                        <hr class="border-gray-300 card-content">
                        <p class="text-gray-700 font-medium">${event.organizationName}</p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-gray-700">No organizer information available.</p>
                    </c:otherwise>
                </c:choose>
            </section>
            <!-- Admin Images Section with Full Image Display (No Cropping) -->
            <section class="event-info bg-white p-6 rounded-xl shadow-lg mt-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-4">Admin Images</h3>
                <hr class="border-gray-300 mb-4">
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                    <div>
                        <p class="font-semibold mb-2">Banner:</p>
                        <c:if test="${not empty logoBannerImage}">
                            <div class="w-full h-64 overflow-hidden">
                                <img src="${logoBannerImage}" alt="Banner Image" 
                                     class="w-full h-full object-contain rounded-lg shadow-md transition duration-500 hover:scale-105 cursor-pointer" 
                                     loading="lazy"/>
                            </div>
                        </c:if>
                    </div>
                    <div>
                        <p class="font-semibold mb-2">Event:</p>
                        <c:if test="${not empty logoEventImage}">
                            <div class="w-full h-64 overflow-hidden">
                                <img src="${logoEventImage}" alt="Event Image" 
                                     class="w-full h-full object-contain rounded-lg shadow-md transition duration-500 hover:scale-105 cursor-pointer" 
                                     loading="lazy"/>
                            </div>
                        </c:if>
                    </div>
                    <div>
                        <p class="font-semibold mb-2">Organizer:</p>
                        <c:if test="${not empty logoOrganizerImage}">
                            <div class="w-full h-64 overflow-hidden">
                                <img src="${logoOrganizerImage}" alt="Organizer Image" 
                                     class="w-full h-full object-contain rounded-lg shadow-md transition duration-500 hover:scale-105 cursor-pointer" 
                                     loading="lazy"/>
                            </div>
                        </c:if>
                    </div>
                </div>
            </section>
        </main>
        
        <!-- JavaScript: SweetAlert for confirmation -->
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
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded'
                            },
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
