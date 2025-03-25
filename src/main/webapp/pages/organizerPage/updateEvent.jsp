<%-- 
    Document   : updateEvent
    Created on : Mar 3, 2025, 12:13:21 AM
    Author     : Tang Thanh Vui - CE180901
--%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Update Event - Tickify Organizer</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="https://widget.cloudinary.com/v2.0/global/all.js" type="text/javascript"></script>
        <style>
            body {
                background-color: #1F2937; /* Dark gray background */
                color: #D1D5DB; /* Light gray text color */
                font-family: 'Arial', sans-serif; /* Default font */
            }

            /* Sidebar Styling */
            .sidebar {
                background-color: #15803D; /* Green background for sidebar */
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.3); /* Shadow effect on right side */
                transition: all 0.3s ease; /* Smooth transition for all properties */
            }
            .sidebar a:hover {
                color: #A7F3D0; /* Light green text on hover */
                transition: color 0.2s ease; /* Smooth color transition */
            }

            /* Header Styling */
            header.fixed {
                position: fixed; /* Fixed position at the top */
                top: 0; /* Align to top */
                left: 16rem; /* Offset to accommodate sidebar width (256px) */
                right: 0; /* Extend to the right edge */
                z-index: 50; /* Ensure header stays above other content */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3); /* Shadow to distinguish when scrolled */
                background-color: #1F2937; /* Same dark gray as body */
            }

            /* Main Content Styling */
            main {
                margin-top: 4rem; /* Space to avoid overlap with fixed header (64px) */
                padding-top: 1rem; /* Additional padding below header */
            }

            /* Tab Button Styling */
            .tab-button {
                width: 32px; /* Fixed width */
                height: 32px; /* Fixed height */
                background-color: #4B5563; /* Medium gray background */
                border: none; /* No border */
                transition: background-color 0.3s ease; /* Smooth background color change */
            }
            .tab-button.active {
                background-color: #15803D; /* Green background when active */
                transform: scale(1.1); /* Slightly larger when active */
            }
            .tab-button:hover {
                background-color: #6B7280; /* Lighter gray on hover */
            }

            /* Upload Area Styling */
            .upload-area {
                background-color: #4B5563; /* Medium gray background */
                border: 2px dashed #6B7280; /* Dashed light gray border */
                border-radius: 8px; /* Rounded corners */
                transition: all 0.3s ease; /* Smooth transition for all properties */
            }
            .upload-area:hover {
                border-color: #15803D; /* Green border on hover */
                background-color: #374151; /* Darker gray background on hover */
            }

            /* Form Elements Styling */
            .form-control, .form-select {
                background-color: #4B5563; /* Medium gray background */
                color: #FFFFFF; /* White text */
                border: 1px solid #6B7280; /* Light gray border */
                border-radius: 6px; /* Rounded corners */
                transition: border-color 0.3s ease, box-shadow 0.3s ease; /* Smooth transitions */
            }
            .form-control:focus, .form-select:focus {
                border-color: #15803D; /* Green border on focus */
                box-shadow: 0 0 5px rgba(21, 128, 61, 0.5); /* Green glow effect */
                background-color: #374151; /* Darker gray background */
                color: #FFFFFF; /* White text */
            }
            .form-control::placeholder {
                color: #D1D5DB; /* Light gray placeholder text */
            }
            .form-label {
                font-weight: 500; /* Medium font weight */
                color: #E5E7EB; /* Very light gray text */
            }

            /* Seat Section Styling */
            .seat-container {
                background-color: #374151; /* Dark gray background */
                border-radius: 8px; /* Rounded corners */
                padding: 20px; /* Inner padding */
                margin-bottom: 20px; /* Space below */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2); /* Subtle shadow */
            }
            .seat-grid {
                display: grid; /* Grid layout */
                gap: 15px; /* Spacing between items */
                margin-top: 15px; /* Space above */
            }
            .seat-input {
                display: flex; /* Flexbox layout */
                align-items: center; /* Center vertically */
                gap: 10px; /* Spacing between children */
                background-color: #4B5563; /* Medium gray background */
                padding: 10px; /* Inner padding */
                border-radius: 6px; /* Rounded corners */
                border: 1px solid #6B7280; /* Light gray border */
                transition: transform 0.2s ease, box-shadow 0.3s ease; /* Smooth transitions */
            }
            .seat-input:hover {
                transform: translateY(-2px); /* Slight lift on hover */
                box-shadow: 0 2px 8px rgba(21, 128, 61, 0.3); /* Green shadow */
            }
            .seat-input label {
                display: block; /* Block display */
                margin-bottom: 5px; /* Space below */
                color: #D1D5DB; /* Light gray text */
                font-weight: 400; /* Normal font weight */
                flex: 0 0 auto; /* Fixed size */
            }
            .seat-input input {
                width: 150px; /* Fixed width */
                margin-bottom: 0; /* No margin below */
                color: #FFFFFF; /* White text */
                flex: 1; /* Flexible width */
            }
            .seat-input button {
                margin-top: 30px; /* Space above */
                flex: 0 0 auto; /* Fixed size */
            }
            #seatSummary {
                color: #34D399; /* Light green text */
                font-weight: bold; /* Bold text */
                margin-top: 15px; /* Space above */
                padding: 10px; /* Inner padding */
                background-color: #4A5568; /* Slightly lighter gray background */
                border-radius: 6px; /* Rounded corners */
                border-left: 4px solid #10B981; /* Green left border */
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
                display: block; /* Block display */
            }

            /* Show Time Section Styling */
            .ticket-section {
                background-color: #374151; /* Dark gray background */
                border-radius: 8px; /* Rounded corners */
                padding: 20px; /* Inner padding */
                margin-bottom: 20px; /* Space below */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2); /* Subtle shadow */
            }
            .show-time {
                background-color: #4B5563; /* Medium gray background */
                border-radius: 6px; /* Rounded corners */
                padding: 0; /* No padding (adjusted from 15px) */
                margin-bottom: 15px; /* Space below */
                transition: all 0.3s ease; /* Smooth transition */
                border: 1px solid #6B7280; /* Light gray border */
                overflow: hidden; /* Prevent content overflow */
            }
            .show-time:hover {
                background-color: #6B7280; /* Lighter gray on hover */
                box-shadow: 0 2px 8px rgba(21, 128, 61, 0.3); /* Green shadow */
            }
            .saved-ticket {
                background-color: #374151; /* Dark gray background */
                border-radius: 6px; /* Rounded corners */
                padding: 0; /* No padding (adjusted from 10px) */
                margin-top: 10px; /* Space above */
                border-left: 4px solid #15803D; /* Green left border */
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1); /* Subtle shadow */
                overflow: hidden; /* Prevent content overflow */
            }
            .show-time-details {
                padding: auto; /* Auto padding */
                margin: 0; /* No margin */
                min-height: 0; /* No fixed minimum height */
            }
            .grid.grid-cols-1.md:grid-cols-2.gap-4 {
                gap: 8px; /* Reduced gap from 16px to 8px */
            }
            .space-y-2 {
                margin-top: 0; /* Remove excess top margin */
                margin-bottom: 0; /* Remove excess bottom margin */
            }

            /* General Buttons Styling */
            .add-ticket-btn, .save-seat-btn {
                background-color: #15803D; /* Green background */
                color: white; /* White text */
                border: none; /* No border */
                padding: 6px 12px; /* Padding */
                border-radius: 6px; /* Rounded corners */
                transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transitions */
                margin-left: 5px; /* Space to the left */
            }
            .add-ticket-btn:hover, .save-seat-btn:hover {
                background-color: #166534; /* Darker green on hover */
                transform: translateY(-2px); /* Slight lift */
            }
            .btn-danger {
                background-color: #DC2626; /* Red background */
                border: none; /* No border */
                padding: 6px 12px; /* Padding */
                border-radius: 6px; /* Rounded corners */
                transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transitions */
            }
            .btn-danger:hover {
                background-color: #B91C1C; /* Darker red on hover */
                transform: translateY(-2px); /* Slight lift */
            }

            /* Datetime Inputs Styling */
            .datetime-local {
                background-color: #4B5563; /* Medium gray background */
                color: #FFFFFF; /* White text */
                border: 1px solid #6B7280; /* Light gray border */
                border-radius: 6px; /* Rounded corners */
                padding: 8px; /* Inner padding */
                width: 100%; /* Full width */
                cursor: pointer; /* Pointer cursor */
            }
            .datetime-local:focus {
                border-color: #15803D; /* Green border on focus */
                box-shadow: 0 0 5px rgba(21, 128, 61, 0.5); /* Green glow */
                color: #FFFFFF; /* White text */
            }

            /* Modal Styling */
            .modal-content {
                background-color: #374151; /* Dark gray background */
                border: none; /* No border */
                border-radius: 8px; /* Rounded corners */
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3); /* Deep shadow */
            }
            .modal-header {
                border-bottom: 1px solid #6B7280; /* Light gray bottom border */
            }
            .modal-footer {
                border-top: 1px solid #6B7280; /* Light gray top border */
            }
            .btn-secondary {
                background-color: #6B7280; /* Light gray background */
                border: none; /* No border */
                transition: background-color 0.3s ease; /* Smooth transition */
            }
            .btn-secondary:hover {
                background-color: #4B5563; /* Darker gray on hover */
            }
            .btn-success {
                background-color: #15803D; /* Green background */
                border: none; /* No border */
                transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transitions */
            }
            .btn-success:hover {
                background-color: #166534; /* Darker green on hover */
                transform: translateY(-2px); /* Slight lift */
            }
            .btn-success:disabled {
                background-color: #6B7280; /* Gray when disabled */
                cursor: not-allowed; /* Disabled cursor */
                transform: none; /* No transform */
            }
            .btn-success:disabled:hover {
                background-color: #6B7280; /* Same gray on hover when disabled */
            }

            /* Color Picker Styling */
            .color-picker-container {
                position: relative; /* Relative positioning */
            }
            .color-picker-container input[type="color"] {
                padding: 0; /* No padding */
                height: 40px; /* Fixed height */
                appearance: none; /* Remove default styling */
                -webkit-appearance: none; /* Remove default styling for Webkit */
                border: none; /* No border */
                background: none; /* Transparent background */
                cursor: pointer; /* Pointer cursor */
            }
            .color-picker-container input[type="color"]::-webkit-color-swatch-wrapper {
                padding: 0; /* No padding */
            }
            .color-picker-container input[type="color"]::-webkit-color-swatch,
            .color-picker-container input[type="color"]::-moz-color-swatch {
                border: 1px solid #6B7280; /* Light gray border */
                border-radius: 4px; /* Rounded corners */
            }

            /* Event Logo Preview Styling (720x958) */
            #logoPreview {
                width: 284px; /* Fixed width (approx. 9rem) */
                height: 420px; /* Fixed height (approx. 12rem) */
                background-color: #4B5563; /* Medium gray background */
                border: 1px solid #6B7280; /* Light gray border */
                border-radius: 8px; /* Rounded corners */
                display: flex; /* Flexbox layout */
                flex-direction: column; /* Vertical alignment */
                justify-content: center; /* Center vertically */
                align-items: center; /* Center horizontally */
                cursor: pointer; /* Pointer cursor */
                transition: background-color 0.3s ease; /* Smooth background change */
                overflow: hidden; /* Prevent overflow */
            }
            #logoPreview:hover {
                background-color: #374151; /* Darker gray on hover */
            }
            #logoPreview i {
                font-size: 1.5rem; /* Large icon (text-2xl) */
                margin-bottom: 0.5rem; /* Space below (mb-2) */
                color: #10B981; /* Green icon */
            }
            #logoPreview p {
                font-size: 0.875rem; /* Small text (text-sm) */
                color: #D1D5DB; /* Light gray text */
                text-align: center; /* Centered text */
            }
            #logoImage {
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                object-fit: fill; /* Cover entire area */
                border-radius: 8px; /* Rounded corners */
            }

            /* Background Image Preview Styling (1280x720) */
            #backgroundPreview {
                width: 856px; /* Fixed width (approx. 53.5rem) */
                height: 418px; /* Fixed height (approx. 26.125rem) */
                background-color: #4B5563; /* Medium gray background */
                border: 1px solid #6B7280; /* Light gray border */
                border-radius: 8px; /* Rounded corners */
                display: flex; /* Flexbox layout */
                flex-direction: column; /* Vertical alignment */
                justify-content: center; /* Center vertically */
                align-items: center; /* Center horizontally */
                cursor: pointer; /* Pointer cursor */
                transition: background-color 0.3s ease; /* Smooth background change */
                overflow: hidden; /* Prevent overflow */
            }
            #backgroundPreview:hover {
                background-color: #374151; /* Darker gray on hover */
            }
            #backgroundPreview i {
                font-size: 1.5rem; /* Large icon (text-2xl) */
                margin-bottom: 0.5rem; /* Space below (mb-2) */
                color: #10B981; /* Green icon */
            }
            #backgroundPreview p {
                font-size: 0.875rem; /* Small text (text-sm) */
                color: #D1D5DB; /* Light gray text */
                text-align: center; /* Centered text */
            }
            #backgroundImage {
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                object-fit: fill; /* Cover entire area */
                border-radius: 8px; /* Rounded corners */
            }

            /* Organizer Logo Preview Styling (275x275) */
            #organizerLogoPreview {
                width: 170px; /* Fixed width (approx. 10.625rem) */
                height: 216px; /* Fixed height (approx. 13.5rem) */
                background-color: #4B5563; /* Medium gray background */
                border: 1px solid #6B7280; /* Light gray border */
                border-radius: 8px; /* Rounded corners */
                display: flex; /* Flexbox layout */
                flex-direction: column; /* Vertical alignment */
                justify-content: center; /* Center vertically */
                align-items: center; /* Center horizontally */
                cursor: pointer; /* Pointer cursor */
                transition: background-color 0.3s ease; /* Smooth background change */
                overflow: hidden; /* Prevent overflow */
                margin-left: 39%; /* Left for image */
            }
            #organizerLogoPreview:hover {
                background-color: #374151; /* Darker gray on hover */
            }
            #organizerLogoPreview i {
                font-size: 1.5rem; /* Large icon (text-2xl) */
                margin-bottom: 0.5rem; /* Space below (mb-2) */
                color: #10B981; /* Green icon */
            }
            #organizerLogoPreview p {
                font-size: 0.875rem; /* Small text (text-sm) */
                color: #D1D5DB; /* Light gray text */
                text-align: center; /* Centered text */
            }
            #organizerLogoImage {
                width: 100%; /* Full width */
                height: 100%; /* Full height */
                object-fit: fill; /* Cover entire area */
                border-radius: 8px; /* Rounded corners */
            }

            /* Image Layout Styling */
            .image-group {
                display: flex; /* Flexbox layout */
                gap: 20px; /* Space between images */
                justify-content: center; /* Center horizontally */
                flex-wrap: wrap; /* Wrap to next line if needed */
            }
            .organizer-row {
                display: flex; /* Flexbox layout */
                align-items: center; /* Center vertically */
                gap: 20px; /* Space between items */
                justify-content: center; /* Center horizontally */
                margin-top: 20px; /* Space above */
            }
            .organizer-row .input-container {
                flex: 1; /* Flexible width */
                max-width: 300px; /* Maximum width */
            }

            /* Miscellaneous Styling */
            .upload-icon.hidden, .upload-text.hidden {
                display: none; /* Hide elements with 'hidden' class */
            }
            .image-error, .error-message {
                color: #EF4444; /* Red text */
                font-size: 0.875rem; /* Small text (text-sm) */
                margin-top: 0.5rem; /* Space above (mt-2) */
                text-align: center; /* Centered text */
            }
            .error-message {
                margin-top: 0.25rem; /* Reduced space (mt-1) */
                display: none; /* Hidden by default */
            }

            /* Textarea Styling */
            .event-info-textarea {
                width: 100%; /* Full width */
                padding: 0.5rem; /* Inner padding (p-2) */
                border-radius: 0.375rem; /* Rounded corners */
                background-color: #4B5563; /* Medium gray background */
                border: 1px solid #6B7280; /* Light gray border */
                color: #FFFFFF; /* White text */
                outline: none; /* No outline on focus */
                resize: vertical; /* Vertical resize only */
                min-height: 100px; /* Minimum height */
                max-height: 400px; /* Maximum height */
                overflow-y: auto; /* Scroll if content overflows */
                box-shadow: 0 0 0 2px transparent; /* Transparent ring by default */
                transition: border-color 0.3s ease, box-shadow 0.3s ease, height 0.3s ease; /* Smooth transitions */
                height: 300px; /* Fixed height */
                line-height: 1; /* Consistent line height */
            }
            .event-info-textarea:focus {
                border-color: #15803D; /* Green border on focus */
                box-shadow: 0 0 0 2px #15803D; /* Green ring on focus */
                background-color: #374151; /* Darker gray background */
                color: #FFFFFF; /* White text */
            }

            /* CSS cho cả successPopup và errorPopup */
            #successPopup, #errorPopup {
                display: none; /* Ẩn mặc định */
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 50;
                justify-content: center;
                align-items: center;
                opacity: 0;
                transition: opacity 0.3s ease-in-out;
            }

            #successPopup.show, #errorPopup.show {
                display: flex; /* Hiển thị khi có class show */
                opacity: 1;
            }
            /* Toggle Buttons Styling */
            .toggle-btn {
                background-color: #4B5563; /* Medium gray background */
                color: #FFFFFF; /* White text */
                border: none; /* No border */
                padding: 6px 12px; /* Padding */
                border-radius: 6px; /* Rounded corners */
                transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transitions */
                margin-right: 10px; /* Space to the right */
            }
            .toggle-btn:hover {
                background-color: #6B7280; /* Lighter gray on hover */
                transform: translateY(-2px); /* Slight lift */
            }
            .collapsible-content {
                height: auto; /* Auto height when expanded */
                transition: height 0.3s ease-out, opacity 0.3s ease-out, padding 0.3s ease-out; /* Smooth collapse/expand */
                overflow: hidden; /* Hide overflow */
            }
            .collapsible-content.collapsed {
                height: 0; /* Collapsed height */
                opacity: 0; /* Fully transparent */
                padding: 0; /* No padding when collapsed */
            }
        </style>
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
                    <a class="flex items-center w-full p-2 rounded-lg hover:bg-green-700 transition duration-200" href="${pageContext.request.contextPath}/OrganizerEventController">
                        <i class="fas fa-ticket-alt mr-2"></i>My Events
                    </a>
                    <a class="flex items-center w-full p-2 bg-green-700 rounded-lg" href="createEvent.jsp">
                        <i class="fas fa-plus mr-2"></i>Update Event
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
                            <button class="bg-gray-500 text-white px-4 py-2 rounded hover:bg-gray-600 transition duration-200" onclick="submitEventForm()">Update</button>
                            <button class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition duration-200" onclick="nextTab()">Continue</button>
                            <a class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition duration-200" href="${pageContext.request.contextPath}/OrganizerEventController">Cancel</a>
                        </div>
                    </div>
                </header>

                <!-- Tab Event Info -->
                <section id="event-info" class="tab-content">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <!-- Event Name -->
                        <div>
                            <label class="block text-gray-300 mb-2">Event Name</label>
                            <input type="text" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" 
                                   value="${event.eventName}" placeholder="Event Name" required>
                            <span class="error-message" id="eventName_error"></span>
                        </div>
                        <!-- Event Category -->
                        <div>
                            <label class="block text-gray-300 mb-2">Event Category</label>
                            <select class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" required>
                                <option value="">-- Please Select Category --</option>
                                <c:forEach var="cat" items="${listCategories}">
                                    <option value="${cat.categoryId}" 
                                            <c:if test="${category.categoryId == cat.categoryId}">selected</c:if>>
                                        ${cat.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                            <span class="error-message" id="eventCategory_error"></span>
                        </div>
                        <!-- Location (Province/City, District, Ward, Full Address) -->
                        <div>
                            <label class="block text-gray-300 mb-2">Province/City</label>
                            <input type="hidden" id="original_province" value="${province != null ? province : ''}">
                            <select id="province" name="province" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" onchange="handleProvinceChange(this); updateDistricts(); updateFullAddress();" required>
                                <option value="">-- Select Province/City --</option>
                                <c:forEach var="prov" items="${provinces}">
                                    <option value="${prov.name}" data-code="${prov.code}" ${prov.name eq province ? 'selected' : ''}>${prov.name}</option>
                                </c:forEach>
                            </select>
                            <span class="error-message" id="province_error"></span>
                        </div>

                        <!-- District -->
                        <div>
                            <label class="block text-gray-300 mb-2">District</label>
                            <input type="hidden" id="original_district" value="${district != null ? district : ''}">
                            <select id="district" name="district" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" onchange="updateWards(); updateFullAddress();" required>
                                <option value="">-- Select District --</option>
                            </select>
                            <span class="error-message" id="district_error"></span>
                        </div>

                        <!-- Ward -->
                        <div>
                            <label class="block text-gray-300 mb-2">Ward</label>
                            <input type="hidden" id="original_ward" value="${ward != null ? ward : ''}">
                            <select id="ward" name="ward" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" onchange="updateFullAddress();" required>
                                <option value="">-- Select Ward --</option>
                            </select>
                            <span class="error-message" id="ward_error"></span>
                        </div>

                        <!-- Full Address -->
                        <div class="md:col-span-2">
                            <label class="block text-gray-300 mb-2">Full Address</label>
                            <input type="text" id="fullAddress" name="fullAddress" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" 
                                   value="${event.location}" placeholder="Ward, District, Province/City" required>
                            <span class="error-message" id="fullAddress_error"></span>
                        </div>
                        <!-- Event Information (Description) -->
                        <div class="md:col-span-2">
                            <label class="block text-gray-300 mb-2">Event Information</label>
                            <textarea class="event-info-textarea" placeholder="Description" required>${event.description}</textarea>
                            <span class="error-message" id="eventInfo_error"></span>
                        </div>
                        <!-- Event Logo, Background Image, Organizer Logo -->
                        <div class="md:col-span-2 p-4 rounded bg-gray-800 text-center">
                            <div class="image-group">
                                <div id="logoPreview" class="w-36 h-48 bg-gray-700 border border-gray-600 rounded cursor-pointer flex items-center justify-center flex-col hover:bg-gray-600 transition duration-200">
                                    <c:if test="${not empty eventImages}">
                                        <c:forEach var="image" items="${eventImages}">
                                            <c:if test="${image.imageTitle == 'logo_event'}">
                                                <img id="logoImage" src="${image.imageUrl}" alt="Event Logo Preview" class="w-full h-full object-cover rounded">
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <i class="fas fa-upload text-2xl mb-2 text-green-500 upload-icon hidden"></i>
                                    <p class="text-gray-300 text-sm upload-text hidden">Event Logo (720x958)</p>
                                    <input type="file" id="logoEventInput" class="hidden" 
                                           data-url="<c:forEach var='image' items='${eventImages}'><c:if test='${image.imageTitle == "logo_event"}'>${image.imageUrl}</c:if></c:forEach>">
                                               <span class="error-message" id="logoEvent_error"></span>
                                           </div>

                                           <div id="backgroundPreview" class="w-36 h-48 bg-gray-700 border border-gray-600 rounded cursor-pointer flex items-center justify-center flex-col hover:bg-gray-600 transition duration-200">
                                    <c:if test="${not empty eventImages}">
                                        <c:forEach var="image" items="${eventImages}">
                                            <c:if test="${image.imageTitle == 'logo_banner'}">
                                                <img id="backgroundImage" src="${image.imageUrl}" alt="Event Background Preview" class="w-full h-full object-cover rounded">
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <i class="fas fa-upload text-2xl mb-2 text-green-500 upload-icon hidden"></i>
                                    <p class="text-gray-300 text-sm upload-text hidden">Add Event Background Image (1280x720)</p>
                                    <input type="file" id="backgroundInput" class="hidden" 
                                           data-url="<c:forEach var='image' items='${eventImages}'><c:if test='${image.imageTitle == "logo_banner"}'>${image.imageUrl}</c:if></c:forEach>">
                                               <span class="error-message" id="backgroundImage_error"></span>
                                           </div>
                                    </div>
                                </div>

                                <div class="md:col-span-2 p-4 rounded bg-gray-800 text-center">
                                    <div class="organizer-row grid grid-cols-1 md:grid-cols-2 gap-4">
                                        <div id="organizerLogoPreview" class="w-36 h-48 bg-gray-700 border border-gray-600 rounded cursor-pointer flex items-center justify-center flex-col hover:bg-gray-600 transition duration-200">
                                    <c:if test="${not empty eventImages}">
                                        <c:forEach var="image" items="${eventImages}">
                                            <c:if test="${image.imageTitle == 'logo_organizer'}">
                                                <img id="organizerLogoImage" src="${image.imageUrl}" alt="Organizer Logo Preview" class="w-full h-full object-cover rounded">
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                    <i class="fas fa-upload text-2xl mb-2 text-green-500 upload-icon hidden"></i>
                                    <p class="text-gray-300 text-sm upload-text hidden">Organizer Logo (275x275)</p>
                                    <input type="file" id="organizerLogoInput" class="hidden" 
                                           data-url="<c:forEach var='image' items='${eventImages}'><c:if test='${image.imageTitle == "logo_organizer"}'>${image.imageUrl}</c:if></c:forEach>">
                                               <span class="error-message" id="organizerLogo_error"></span>
                                           </div>

                                           <div class="input-container">
                                               <label class="block text-gray-300 mb-2">Organizer Name</label>
                                               <input type="text" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" 
                                                      value="${organizer.organizationName}" placeholder="Organizer Name" required>
                                    <input value="${organizer.customerId}" hidden name="customerId">
                                    <span class="error-message" id="organizerName_error"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Tab Time & Logistics -->
                <section id="time-logistics" class="tab-content hidden">
                    <div class="space-y-6">
                        <!-- Type Of Event -->
                        <div>
                            <label class="block text-gray-300 mb-2">Type Of Event</label>
                            <select id="eventType" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" onchange="toggleEventType()" required>
                                <option value="">-- Please Select Type --</option>
                                <option value="Standing Event" <c:if test="${event.eventType == 'Standing Event'}">selected</c:if>>Standing Event</option>
                                <option value="Seating Event" <c:if test="${event.eventType == 'Seating Event'}">selected</c:if>>Seated Event</option>
                                </select>
                                <span class="error-message" id="eventType_error"></span>
                            </div>

                            <!-- Seat Management (if seated event) -->
                            <div id="seatSection" class="">
                                <h5 class="text-white mb-3">Seat Management (Seated Event)</h5>
                                <div id="seatsContainer" class="space-y-4">
                                <c:forEach var="seat" items="${uniqueSeatTypes}" varStatus="loop">
                                    <div class="seat-input flex flex-col md:flex-row gap-4">
                                        <div class="flex-1">
                                            <label class="text-gray-300">Row:</label>
                                            <input type="text" name="seatRow[]" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" 
                                                   value="${seat.seatRow}" required>
                                            <span class="error-message" id="seatRow_error"></span>
                                        </div>
                                        <div class="flex-1">
                                            <label class="text-gray-300">Number of Seats:</label>
                                            <input type="text" name="seatNumber[]" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" 
                                                   value="${seat.seatCol}" required>
                                            <span class="error-message" id="seatNumber_error"></span>
                                        </div>
                                        <button type="button" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition duration-200" onclick="removeSeat(this)">Delete</button>
                                        <button type="button" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition duration-200" onclick="saveSeat(this)">Save Seat</button>
                                    </div>
                                </c:forEach>
                            </div>
                            <!-- Add error message container -->
                            <div id="seatError" class="mt-2 text-red-500 hidden"></div>
                            <button type="button" class="mt-3 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition duration-200" onclick="addSeat()">+ Add Seat</button>
                            <div id="seatSummary" class="mt-3 text-gray-300"></div>         
                        </div>

                        <!-- Show Times -->
                        <div id="showTimeSection">
                            <div class="flex justify-between items-center mb-3">
                                <h5 class="text-white">Event Show Times</h5>
                                <button class="toggle-btn" onclick="toggleShowTimeSection(this)">
                                    <i class="fas fa-chevron-down"></i>
                                </button>
                            </div>
                            <div id="showTimeContent" class="collapsible-content">
                                <div id="showTimeList" class="space-y-4">
                                    <c:forEach var="showTime" items="${showTimes}" varStatus="loop">
                                        <div class="show-time bg-gray-800 p-4 rounded">
                                            <div class="flex justify-between items-center mb-3">
                                                <h6 class="text-white"><span class="show-time-label">Show Time #1</span></h6>
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
                                                        <input type="datetime-local" name="showStartDate" id="showStartDate_${loop.count}"
                                                               class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none"
                                                               value="<c:if test="${not empty showTime.startDate}"><fmt:formatDate value='${showTime.startDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/></c:if>"
                                                                   onchange="updateShowTimeLabel(this)" required>
                                                               <span class="error-message" id="showStartDate_${loop.count}_error"></span>
                                                    </div>
                                                    <div>
                                                        <label class="text-gray-300">End Date</label>
                                                        <input type="datetime-local" name="showEndDate" id="showEndDate_${loop.count}"
                                                               class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none"
                                                               value="<c:if test="${not empty showTime.endDate}"><fmt:formatDate value='${showTime.endDate}' pattern='yyyy-MM-dd\'T\'HH:mm'/></c:if>"
                                                                   onchange="updateShowTimeLabel(this)" required>
                                                               <span class="error-message" id="showEndDate_${loop.count}_error"></span>
                                                    </div>
                                                </div>
                                                <div id="ticketList_${loop.count}" class="mt-3 space-y-2">
                                                    <c:forEach var="ticket" items="${ticketTypes}" varStatus="ticketLoop">
                                                        <c:if test="${ticket.showtimeId == showTime.showtimeId}">
                                                            <div class="saved-ticket bg-gray-700 p-3 rounded">
                                                                <div class="flex justify-between items-center mb-2">
                                                                    <h6 class="text-white"><span class="ticket-label" data-ticket-name="${ticket.name}" data-ticket-id="${ticket.ticketTypeId}">${ticket.name}</span></h6>
                                                                    <div class="flex gap-2">
                                                                        <button class="toggle-btn" onclick="toggleTicket(this)">
                                                                            <i class="fas fa-chevron-down"></i>
                                                                        </button>
                                                                        <button class="bg-yellow-500 text-white px-2 py-1 rounded hover:bg-yellow-600 transition duration-200" onclick="editTicket(this, '${loop.count}')">Edit</button>
                                                                        <button class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600 transition duration-200" onclick="removeTicket(this, '${loop.count}')">Delete</button>
                                                                    </div>
                                                                </div>
                                                                <div class="collapsible-content ticket-details">
                                                                    <div class="space-y-2 text-gray-300">
                                                                        <div><label>Description:</label> <span>${ticket.description}</span></div>
                                                                        <div><label>Price (VND):</label> <span>${ticket.price}</span></div>
                                                                        <div><label>Quantity:</label> <span>${ticket.totalQuantity}</span></div>
                                                                        <div><label>Color:</label> <span style="color: ${ticket.color}">${ticket.color}</span></div>
                                                                        <c:forEach var="seat" items="${seats}">
                                                                            <c:if test="${seat.ticketTypeId == ticket.ticketTypeId}">
                                                                                <div class="seat-info"><label>Seats:</label> <span>${seat.seatRow} ${seat.seatCol}</span></div>
                                                                            </c:if>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </c:if>
                                                    </c:forEach>
                                                </div>
                                                <button class="mt-3 w-full bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition duration-200" data-show-time="${loop.count}" onclick="openModal(this)">+ Add Ticket Type</button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                                <button class="mt-3 w-full bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition duration-200" onclick="addNewShowTime()">+ Create New Show Time</button>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Tab Payment Info -->
                <section id="payment-info" class="tab-content hidden">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <!-- Payment Method (readonly) -->
                        <div>
                            <label class="block text-gray-300 mb-2">Payment Method</label>
                            <input type="text" name="paymentMethod" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" value="Bank Transfer" readonly>
                        </div>

                        <!-- Bank Name -->
                        <div>
                            <label class="block text-gray-300 mb-2">Bank Name</label>
                            <input type="hidden" id="organizerBankName" value="${organizer.bankName}">
                            <select id="bank" name="bankName" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" required>
                                <option value="">Bank Name</option>
                            </select>
                            <span class="error-message" id="bank_error"></span>
                        </div>

                        <!-- Bank Account -->
                        <div>
                            <label class="block text-gray-300 mb-2">Bank Account</label>
                            <input type="text" name="bankAccount" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" 
                                   value="${organizer.accountNumber}" placeholder="Bank Account" required>
                            <span class="error-message" id="bankAccount_error"></span>
                        </div>

                        <!-- Account Holder -->
                        <div>
                            <label class="block text-gray-300 mb-2">Account Holder</label>
                            <input type="text" name="accountHolder" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none focus:ring-2 focus:ring-green-500" 
                                   value="${organizer.accountHolder}" placeholder="Account Holder" required>
                            <span class="error-message" id="accountHolder_error"></span>
                        </div>
                    </div>
                </section>
            </main>
        </div>

        <!-- Modal -->
        <div id="newTicketModal" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center" style="overflow: auto;">
            <div class="bg-gray-800 rounded-lg w-full max-w-4xl p-6" style="margin-top: 10%;">
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
                    <!-- Description Update Price for modal -->
                    <div>
                        <label class="block text-gray-300 mb-2">Description</label>
                        <textarea id="modalTicketDescription" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" rows="2" placeholder="e.g., VIP seating"></textarea>
                        <span class="error-message" id="modalTicketDescription_error"></span>
                    </div>
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                        <div style="display: block !important;">
                            <label class="block text-gray-300 mb-2">Price (VND)</label> 
                            <input type="number" id="modalTicketPrice" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" placeholder="e.g., 150000">
                            <span class="error-message" id="modalTicketPrice_error"></span>
                        </div>
                        <div style="display: block !important;">
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
        <!-- Success Popup -->
        <div id="successPopup" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
            <div class="bg-gray-800 rounded-lg p-6 max-w-sm w-full text-center">
                <div class="flex justify-center mb-4">
                    <i class="fas fa-check-circle text-green-500 text-4xl"></i>
                </div>
                <h3 class="text-xl font-bold text-white mb-2">Success</h3>
                <p class="text-gray-300 mb-4">Update Event Successfully!</p>
                <button class="bg-green-500 text-white px-4 py-2 rounded hover:bg-green-600 transition duration-200" onclick="closeSuccessPopup()">OK</button>
            </div>
        </div>
        <!-- Error Popup -->
        <div id="errorPopup" class="fixed inset-0 bg-black bg-opacity-50 hidden flex items-center justify-center z-50">
            <div class="bg-gray-800 rounded-lg p-6 max-w-sm w-full text-center">
                <div class="flex justify-center mb-4">
                    <i class="fas fa-exclamation-circle text-red-500 text-4xl"></i>
                </div>
                <h3 class="text-xl font-bold text-white mb-2">Error</h3>
                <p class="text-gray-300 mb-4" id="errorMessage">Please complete all required fields.</p>
                <button class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition duration-200" onclick="closeErrorPopup()">OK</button>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/pages/organizerPage/updateEvent.js"></script>
    </body>
</html>