<%-- 
    Document   : createEvent
    Created on : Feb 25, 2025, 5:44:28 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Create Event - Tickify Organizer</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="https://widget.cloudinary.com/v2.0/global/all.js" type="text/javascript"></script>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/pages/organizerPage/createEvent.css"/>
    </head>
    <body class="bg-gray-900 text-white">
        <div class="flex h-screen">
            <!-- Sidebar -->
            <aside class="w-64 min-w-[16rem] bg-gradient-to-b from-green-900 to-black p-4 text-white">
                <div class="flex items-center mb-8">
                    <img alt="Tickify logo" class="mr-2" height="40" src="https://storage.googleapis.com/a1aa/image/8k6Ikw_t95IdEBRzaSbfv_qa-9InZk34-JUibXbK7B4.jpg" width="40"/>
                    <span class="text-lg font-bold text-green-500">Organizer Center</span>
                </div>
                <nav class="space-y-4">
                    <a class="flex items-center w-full p-2 rounded-lg hover:bg-green-700 transition duration-200" href="${pageContext.request.contextPath}/pages/organizerPage/organizerCenter.jsp">
                        <i class="fas fa-ticket-alt mr-2"></i>My Event
                    </a>
                    <a class="flex items-center w-full p-2 bg-green-700 rounded-lg" href="createEvent.jsp">
                        <i class="fas fa-plus mr-2"></i>Create Event
                    </a>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="flex-1 p-4 overflow-y-auto mt-16">
                <!-- Header -->
                <header class="fixed top-0 left-64 right-0 bg-gray-800 p-4 rounded-t-lg z-50 shadow-md">
                    <div class="flex justify-between items-center">
                        <div class="flex items-center gap-4">
                            <button class="tab-button w-8 h-8 rounded-full bg-gray-600 flex items-center justify-center text-white hover:bg-green-600 transition duration-200" onclick="showTab('event-info')">1</button>
                            <span>Event Information</span>
                            <button class="tab-button w-8 h-8 rounded-full bg-gray-600 flex items-center justify-center text-white hover:bg-green-600 transition duration-200" onclick="showTab('time-logistics')">2</button>
                            <span>Time & Ticket Types</span>
                            <button class="tab-button w-8 h-8 rounded-full bg-gray-600 flex items-center justify-center text-white hover:bg-green-600 transition duration-200" onclick="showTab('payment-info')">3</button>
                            <span>Payment Information</span>
                        </div>
                        <div class="flex gap-3">
                            <button class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600 transition duration-200" onclick="submitEventForm()">Create</button>
                            <button class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition duration-200" onclick="nextTab()">Continue</button>
                        </div>
                    </div>
                </header>

                <!-- Tab Event Info -->
                <section id="event-info" class="tab-content">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-gray-300 mb-2">Event Name</label>
                            <input type="text" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Event Name" required>
                            <span class="error-message" id="eventName_error"></span>
                        </div>
                        <div>
                            <label class="block text-gray-300 mb-2">Event Category</label>
                            <select class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" required>
                                <option value="">-- Please Select Category --</option>
                                <c:forEach var="category" items="${listCategories}">
                                    <option value="${category.categoryId}">${category.categoryName}</option>
                                </c:forEach>
                            </select>
                            <span class="error-message" id="eventCategory_error"></span>
                        </div>
                        <!-- Event Location with Province/City, District, and Ward -->
                        <div>
                            <label class="block text-gray-300 mb-2">Province/City</label>
                            <select id="province" name="province" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" onchange="updateDistricts(); updateFullAddress();" required>
                                <option value="">-- Select Province/City --</option>
                            </select>
                            <span class="error-message" id="province_error"></span>
                        </div>
                        <div>
                            <label class="block text-gray-300 mb-2">District</label>
                            <select id="district" name="district" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" onchange="updateWards(); updateFullAddress();" required>
                                <option value="">-- Select District --</option>
                            </select>
                            <span class="error-message" id="district_error"></span>
                        </div>
                        <div>
                            <label class="block text-gray-300 mb-2">Ward</label>
                            <select id="ward" name="ward" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" onchange="updateFullAddress();" required>
                                <option value="">-- Select Ward --</option>
                            </select>
                            <span class="error-message" id="ward_error"></span>
                        </div>
                        <div class="md:col-span-2">
                            <label class="block text-gray-300 mb-2">Full Address</label>
                            <input type="text" id="fullAddress" name="fullAddress" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Building number, Street name, Ward, District, Province/City" required>
                            <!--<span class="error-message" id="fullAddress_error"></span>-->
                        </div>
                        <!-- Trong phần tab Event Info, thay thế hoặc thêm vào phần textarea hiện có -->
                        <div class="md:col-span-2">
                            <label class="block text-gray-300 mb-2">Event Information</label>
                            <textarea class="event-info-textarea" placeholder="Description" required>Event Introduction:

[Brief summary of the event: Location of the event, time, specific venue, and reasons why attendees shouldn’t miss it]

Event Theme:

Main Program: [List the standout activities in the event: performances, special guests, specific schedules for different segments]
Guests: [Information about special guests, artists, or speakers attending the event. This may include a brief description of them and their roles in the event]
Special Experiences: [Highlight other unique activities such as workshops, experience zones, photo booths, check-in areas, or exclusive gifts/discounts for attendees.]
Target Audience and Conditions:

[Terms and Conditions (T&C)] of the event

Notes and Additional Terms

Notes and VAT Terms</textarea>
                            <span class="error-message" id="eventInfo_error"></span>
                        </div>
                        <!-- Nhóm Event Image và Background Image -->
                        <div class="md:col-span-2 p-4 rounded bg-gray-800 text-center">
                            <div class="image-group">
                                <!-- Event Logo -->
                                <div id="logoPreview" class="w-36 h-48 bg-gray-700 border border-gray-600 rounded cursor-pointer flex items-center justify-center flex-col hover:bg-gray-600 transition duration-200">
                                    <i class="fas fa-upload text-2xl mb-2 text-green-500 upload-icon"></i>
                                    <p class="text-gray-300 text-sm upload-text">Event Logo (720x958)</p>
                                    <input type="file" id="logoEventInput" class="hidden">
                                    <img id="logoImage" src="" alt="Event Logo Preview" class="w-full h-full object-cover rounded hidden">
                                    <span class="error-message" id="logoEvent_error"></span>
                                </div>

                                <!-- Event Background Image -->
                                <div id="backgroundPreview" class="w-36 h-48 bg-gray-700 border border-gray-600 rounded cursor-pointer flex items-center justify-center flex-col hover:bg-gray-600 transition duration-200">
                                    <i class="fas fa-upload text-2xl mb-2 text-green-500 upload-icon"></i>
                                    <p class="text-gray-300 text-sm upload-text">Add Event Background Image (1280x720)</p>
                                    <input type="file" id="backgroundInput" class="hidden">
                                    <img id="backgroundImage" src="" alt="Event Background Preview" class="w-full h-full object-cover rounded hidden">
                                    <span class="error-message" id="backgroundImage_error"></span>
                                </div>
                            </div>
                        </div>
                        <div class="md:col-span-2 p-4 rounded bg-gray-800 text-center">
                            <!-- Organizer Image và Organizer Name nằm ngang nhau -->
                            <div class="organizer-row grid grid-cols-1 md:grid-cols-2 gap-4">
                                <!-- Organizer Logo -->
                                <div id="organizerLogoPreview" class="w-36 h-48 bg-gray-700 border border-gray-600 rounded cursor-pointer flex items-center justify-center flex-col hover:bg-gray-600 transition duration-200">
                                    <i class="fas fa-upload text-2xl mb-2 text-green-500 upload-icon"></i>
                                    <p class="text-gray-300 text-sm upload-text">Organizer Logo (275x275)</p>
                                    <input type="file" id="organizerLogoInput" class="hidden">
                                    <img id="organizerLogoImage" src="" alt="Organizer Logo Preview" class="w-full h-full object-cover rounded hidden">
                                    <span class="error-message" id="organizerLogo_error"></span>
                                </div>

                                <div class="input-container">
                                    <label class="block text-gray-300 mb-2">Organizer Name</label>
                                    <input type="text" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Organizer Name" required>
                                    <span class="error-message" id="organizerName_error"></span>
                                </div>

                            </div>
                        </div>
                    </div>
                </section>

                <!-- Tab Time & Logistics -->
                <section id="time-logistics" class="tab-content hidden">
                    <div class="space-y-6">
                        <div>
                            <label class="block text-gray-300 mb-2">Type Of Event</label>
                            <select id="eventType" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" onchange="toggleEventType()" required>
                                <option value="">-- Please Select Type --</option>
                                <option value="standingevent">Standing Event</option>
                                <option value="seatedevent">Seated Event</option>
                            </select>
                            <span class="error-message" id="eventType_error"></span>
                        </div>
                        <div id="seatSection" class="hidden">
                            <h5 class="text-white mb-3">Seat Management (Seated Event)</h5>
                            <div id="seatsContainer" class="space-y-4">
                                <div class="seat-input flex flex-col md:flex-row gap-4">
                                    <div class="flex-1">
                                        <label class="text-gray-300">Row:</label>
                                        <input type="text" name="seatRow[]" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" required>
                                        <span class="error-message" id="seatRow_error"></span>
                                    </div>
                                    <div class="flex-1">
                                        <label class="text-gray-300">Number of Seats:</label>
                                        <input type="text" name="seatNumber[]" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" required>
                                        <span class="error-message" id="seatNumber_error"></span>
                                    </div>
                                    <button type="button" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition duration-200" onclick="removeSeat(this)">Delete</button>
                                    <button type="button" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition duration-200" onclick="saveSeat(this)">Save Seat</button>
                                </div>
                            </div>
                            <!-- Add error message container -->
                            <div id="seatError" class="mt-2 text-red-500 hidden"></div>
                            <button type="button" class="mt-3 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition duration-200" onclick="addSeat()">+ Add Seat</button>
                            <div id="seatSummary" class="mt-3 text-gray-300"></div>
                        </div>
                        <div id="showTimeSection">
                            <div class="flex justify-between items-center mb-3">
                                <h5 class="text-white">Event Show Times</h5>
                                <button class="toggle-btn" onclick="toggleShowTimeSection(this)">
                                    <i class="fas fa-chevron-down"></i>
                                </button>
                            </div>
                            <div id="showTimeContent" class="collapsible-content">
                                <div id="showTimeList" class="space-y-4">
                                    <div class="show-time bg-gray-800 p-4 rounded">
                                        <div class="flex justify-between items-center mb-3">
                                            <h6 class="text-white"><span class="show-time-label">Show Time #${showTimeCount}</span></h6>
                                            <div class="flex gap-2">
                                                <button class="toggle-btn" onclick="toggleShowTime(this)">
                                                    <i class="fas fa-chevron-down"></i>
                                                </button>
                                                <button class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600 transition duration-200" onclick="removeShowTime(this)">Delete</button>
                                            </div>
                                        </div>
                                        <div class="collapsible-content show-time-details">
                                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                <div>
                                                    <label class="text-gray-300">Start Date</label>
                                                    <input type="datetime-local" name="showStartDate" id="showStartDate_${showTimeCount}" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" onchange="updateShowTimeLabel(this)" required>
                                                    <span class="error-message" id="showStartDate_${showTimeCount}_error"></span>
                                                </div>
                                                <div>
                                                    <label class="text-gray-300">End Date</label>
                                                    <input type="datetime-local" name="showEndDate" id="showEndDate_${showTimeCount}" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" onchange="updateShowTimeLabel(this)" required>
                                                    <span class="error-message" id="showEndDate_${showTimeCount}_error"></span>
                                                </div>
                                            </div>
                                            <div id="ticketList_${showTimeCount}" class="mt-3 space-y-2"></div>
                                            <button class="mt-3 w-full bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition duration-200" data-show-time="${showTimeCount}" onclick="openModal(this)">+ Add Ticket Type</button>
                                        </div>
                                    </div>
                                </div>
                                <button class="mt-3 w-full bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition duration-200" onclick="addNewShowTime()">+ Create New Show Time</button>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Tab Payment Info -->
                <section id="payment-info" class="tab-content hidden">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div>
                            <label class="block text-gray-300 mb-2">Payment Method</label>
                            <input type="text" name="paymentMethod" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" value="Bank Transfer" readonly>
                        </div>
                        <div>
                            <label class="block text-gray-300 mb-2">Bank Name</label>
                            <select id="bank" name="bankName" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" required>
                                <option value="">Bank Name</option>
                            </select>
                            <span class="error-message" id="bank_error"></span>
                        </div>
                        <div>
                            <label class="block text-gray-300 mb-2">Bank Account</label>
                            <input type="text" name="bankAccount" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Bank Account" required>
                            <span class="error-message" id="bankAccount_error"></span>
                        </div>
                        <div>
                            <label class="block text-gray-300 mb-2">Account Holder</label>
                            <input type="text" name="accountHolder" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Account Holder" required>
                            <span class="error-message" id="accountHolder_error"></span>
                        </div>
                    </div>
                </section>
            </main>
        </div>

        <!-- Modal -->
        <div id="newTicketModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center">
            <div class="bg-gray-800 rounded-lg w-full max-w-4xl p-6">
                <div class="flex justify-between items-center mb-4">
                    <h5 class="text-xl font-bold">Create New Ticket Type</h5>
                    <button class="text-gray-400 hover:text-white text-2xl" onclick="closeModal()">×</button>
                </div>
                <div class="space-y-4">
                    <!-- Ticket Type Name -->
                    <div>
                        <label class="block text-gray-300 mb-2">Ticket Type Name</label>
                        <input type="text" id="modalTicketName" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" placeholder="e.g., VIP">
                        <span class="error-message" id="modalTicketName_error"></span>
                    </div>
                    <!-- Description -->
                    <div>
                        <label class="block text-gray-300 mb-2">Description</label>
                        <textarea id="modalTicketDescription" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" rows="2" placeholder="e.g., VIP seating"></textarea>
                        <span class="error-message" id="modalTicketDescription_error"></span>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <!-- Price -->
                        <div>
                            <label class="block text-gray-300 mb-2">Price (VND)</label>
                            <input type="number" id="modalTicketPrice" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" placeholder="e.g., 150000" step="1000">
                            <span class="error-message" id="modalTicketPrice_error"></span>
                        </div>
                        <!-- Quantity -->
                        <div>
                            <label class="block text-gray-300 mb-2">Quantity</label>
                            <input type="number" id="modalTicketQuantity" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" placeholder="e.g., 50">
                            <span class="error-message" id="modalTicketQuantity_error"></span>
                        </div>
                    </div>
                    <!-- Color -->
                    <div class="color-picker-container flex items-center gap-3">
                        <div class="flex-1">
                            <label class="block text-gray-300 mb-2">Color</label>
                            <div class="relative">
                                <input type="color" id="modalTicketColor" class="w-full h-10 rounded bg-gray-700 border border-gray-600 cursor-pointer">
                                <span id="colorValue" class="absolute right-2 top-1/2 transform -translate-y-1/2 text-gray-300 text-sm bg-gray-800 px-2 py-1 rounded"></span>
                            </div>
                            <span class="error-message" id="modalTicketColor_error"></span>
                        </div>
                    </div>
                    <!-- Phần chọn ghế -->
                    <div id="seatSelection" class="space-y-2">
                        <label class="block text-gray-300 mb-2">Select Seat Rows (VIP: A, B; Normal: C):</label>
                        <!-- Các checkbox sẽ được thêm động bằng JS -->
                    </div>
                </div>
                <div class="mt-4 flex justify-end gap-3">
                    <button class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600 transition duration-200" onclick="closeModal()">Cancel</button>
                    <button id="saveTicketBtn" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition duration-200" onclick="saveNewTicket()">Save</button>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/pages/organizerPage/createEvent.js"></script>
    </body>
</html>