<%-- 
    Document   : updateEvent
    Created on : Mar 3, 2025, 12:13:21 AM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            /* General styling */
            body {
                background-color: #1F2937;
                color: #D1D5DB;
                font-family: 'Arial', sans-serif;
            }

            /* Sidebar */
            .sidebar {
                background-color: #15803D;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.3);
                transition: all 0.3s ease;
            }
            .sidebar a:hover {
                color: #A7F3D0;
                transition: color 0.2s ease;
            }
            /*Header*/
            /* Thêm vào phần <style> hiện có */
            header.fixed {
                position: fixed;
                top: 0;
                left: 16rem; /* Độ rộng của sidebar (16rem = 256px) */
                right: 0;
                z-index: 50; /* Đảm bảo header nằm trên các nội dung khác */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.3); /* Thêm shadow để phân biệt khi cuộn */
                background-color: #1F2937; /* Giữ màu nền phù hợp với giao diện */
            }

            main {
                margin-top: 4rem; /* margin-top để tránh nội dung bị che bởi header (4rem ~ 64px) */
                padding-top: 1rem; /* Padding thêm cho nội dung bên dưới header */
            }
            /* Tab buttons */
            .tab-button {
                width: 32px;
                height: 32px;
                background-color: #4B5563;
                border: none;
                transition: background-color 0.3s ease;
            }
            .tab-button.active {
                background-color: #15803D;
                transform: scale(1.1);
            }
            .tab-button:hover {
                background-color: #6B7280;
            }

            /* Upload area */
            .upload-area {
                background-color: #4B5563;
                border: 2px dashed #6B7280;
                border-radius: 8px;
                transition: all 0.3s ease;
            }
            .upload-area:hover {
                border-color: #15803D;
                background-color: #374151;
            }

            /* Form elements */
            .form-control, .form-select {
                background-color: #4B5563;
                color: #FFFFFF;
                border: 1px solid #6B7280;
                border-radius: 6px;
                transition: border-color 0.3s ease, box-shadow 0.3s ease;
            }
            .form-control:focus, .form-select:focus {
                border-color: #15803D;
                box-shadow: 0 0 5px rgba(21, 128, 61, 0.5);
                background-color: #374151;
                color: #FFFFFF;
            }
            .form-control::placeholder {
                color: #D1D5DB;
            }
            .form-label {
                font-weight: 500;
                color: #E5E7EB;
            }

            /* Seat section */
            .seat-container {
                background-color: #374151;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }
            .seat-grid {
                display: grid;
                gap: 15px;
                margin-top: 15px;
            }
            .seat-input {
                display: flex;
                align-items: center;
                gap: 10px;
                background-color: #4B5563;
                padding: 10px;
                border-radius: 6px;
                border: 1px solid #6B7280;
                transition: transform 0.2s ease, box-shadow 0.3s ease;
            }
            .seat-input:hover {
                transform: translateY(-2px);
                box-shadow: 0 2px 8px rgba(21, 128, 61, 0.3);
            }
            .seat-input label {
                display: block;
                margin-bottom: 5px;
                color: #D1D5DB;
                font-weight: 400;
                flex: 0 0 auto;
            }
            .seat-input input {
                width: 150px;
                margin-bottom: 0;
                color: #FFFFFF;
                flex: 1;
            }
            .seat-input button {
                margin-top: 30px;
                flex: 0 0 auto;
            }
            #seatSummary {
                color: #34D399;
                font-weight: bold;
                margin-top: 15px;
                padding: 10px;
                background-color: #4A5568;
                border-radius: 6px;
                border-left: 4px solid #10B981;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
                display: block;
            }

            /* Show time section */
            .ticket-section {
                background-color: #374151;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }
            .show-time {
                background-color: #4B5563;
                border-radius: 6px;
                padding: 0; /* Đã giảm padding từ 15px về 0 */
                margin-bottom: 15px;
                transition: all 0.3s ease;
                border: 1px solid #6B7280;
                overflow: hidden; /* Đảm bảo nội dung không tràn ra ngoài */
            }
            .show-time:hover {
                background-color: #6B7280;
                box-shadow: 0 2px 8px rgba(21, 128, 61, 0.3);
            }
            .saved-ticket {
                background-color: #374151;
                border-radius: 6px;
                padding: 0; /* Đã giảm padding từ 10px về 0 */
                margin-top: 10px;
                border-left: 4px solid #15803D;
                box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
                overflow: hidden; /* Đảm bảo nội dung không tràn ra ngoài */
            }
            .show-time-details {
                padding: auto; /* Giữ padding nhưng đảm bảo không làm tràn nội dung */
                margin: 0;
                min-height: 0; /* Xóa min-height cố định nếu có */
            }
            .grid.grid-cols-1.md:grid-cols-2.gap-4 {
                gap: 8px; /* Giảm gap từ 1rem (16px) về 8px */
            }

            .space-y-2 {
                margin-top: 0; /* Xóa margin-top dư thừa */
                margin-bottom: 0;
            }
            /* Toggle buttons */
            .toggle-btn {
                background-color: #4B5563;
                color: #FFFFFF;
                border: none;
                padding: 6px 12px;
                border-radius: 6px;
                transition: background-color 0.3s ease, transform 0.2s ease;
                margin-right: 10px;
            }
            .toggle-btn:hover {
                background-color: #6B7280;
                transform: translateY(-2px);
            }
            .collapsible-content {
                height: auto; /* Đảm bảo chiều cao tự động khi không bị thu gọn */
                transition: height 0.3s ease-out, opacity 0.3s ease-out, padding 0.3s ease-out;
                overflow: hidden;
            }
            .collapsible-content.collapsed {
                height: 0;
                opacity: 0;
                padding: 0; /* Xóa padding khi thu gọn */
            }
            /* Buttons */
            .add-ticket-btn, .save-seat-btn {
                background-color: #15803D;
                color: white;
                border: none;
                padding: 6px 12px;
                border-radius: 6px;
                transition: background-color 0.3s ease, transform 0.2s ease;
                margin-left: 5px;
            }
            .add-ticket-btn:hover, .save-seat-btn:hover {
                background-color: #166534;
                transform: translateY(-2px);
            }
            .btn-danger {
                background-color: #DC2626;
                border: none;
                padding: 6px 12px;
                border-radius: 6px;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .btn-danger:hover {
                background-color: #B91C1C;
                transform: translateY(-2px);
            }

            /* Datetime-local inputs */
            .datetime-local {
                background-color: #4B5563;
                color: #FFFFFF;
                border: 1px solid #6B7280;
                border-radius: 6px;
                padding: 8px;
                width: 100%;
                cursor: pointer;
            }
            .datetime-local:focus {
                border-color: #15803D;
                box-shadow: 0 0 5px rgba(21, 128, 61, 0.5);
                color: #FFFFFF;
            }

            /* Modal */
            .modal-content {
                background-color: #374151;
                border: none;
                border-radius: 8px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            }
            .modal-header {
                border-bottom: 1px solid #6B7280;
            }
            .modal-footer {
                border-top: 1px solid #6B7280;
            }
            .btn-secondary {
                background-color: #6B7280;
                border: none;
                transition: background-color 0.3s ease;
            }
            .btn-secondary:hover {
                background-color: #4B5563;
            }
            .btn-success {
                background-color: #15803D;
                border: none;
                transition: background-color 0.3s ease, transform 0.2s ease;
            }
            .btn-success:hover {
                background-color: #166534;
                transform: translateY(-2px);
            }

            /* Color picker container */
            .color-picker-container {
                position: relative;
            }

            .color-picker-container input[type="color"] {
                padding: 0;
                height: 40px;
                appearance: none;
                -webkit-appearance: none;
                border: none;
                background: none;
                cursor: pointer;
            }

            .color-picker-container input[type="color"]::-webkit-color-swatch-wrapper {
                padding: 0;
            }

            .color-picker-container input[type="color"]::-webkit-color-swatch {
                border: 1px solid #6B7280;
                border-radius: 4px;
            }

            .color-picker-container input[type="color"]::-moz-color-swatch {
                border: 1px solid #6B7280;
                border-radius: 4px;
            }

            /* Event Logo (720x958) */
            #logoPreview {
                width: 284px; /* Giữ chiều rộng cố định dựa trên thiết kế (w-36 ~ 9rem) */
                height: 420px; /* Giữ chiều cao cố định (h-48 ~ 12rem) */
                background-color: #4B5563; /* Màu xám của giao diện */
                border: 1px solid #6B7280; /* Viền */
                border-radius: 8px; /* Bo góc */
                display: flex;
                flex-direction: column; /* Căn thẳng đứng */
                justify-content: center;
                align-items: center;
                cursor: pointer;
                transition: background-color 0.3s ease;
                overflow: hidden; /* Đảm bảo nội dung không vượt ra ngoài */
            }

            #logoPreview:hover {
                background-color: #374151; /* Màu tối hơn khi hover */
            }

            #logoPreview i {
                font-size: 1.5rem; /* text-2xl */
                margin-bottom: 0.5rem; /* mb-2 */
                color: #10B981; /* Màu xanh lá */
            }

            #logoPreview p {
                font-size: 0.875rem; /* text-sm */
                color: #D1D5DB; /* Màu chữ xám nhạt */
                text-align: center;
            }

            /* Event Logo (720x958) */
            #logoImage {
                width: 100%;
                height: 100%;
                object-fit: cover; /* Thay đổi từ contain thành cover để phủ toàn bộ khung */
                border-radius: 8px; /* Bo góc */
                display: block; /* Đảm bảo hiển thị đúng */
            }

            /* Background Image (1280x720) */
            #backgroundPreview {
                width: 856px; /* Giữ chiều rộng cố định (khoảng 53.5rem, phù hợp với layout) */
                height: 418px; /* Giữ chiều cao cố định (khoảng 26.125rem, phù hợp với tỷ lệ 1280x720) */
                background-color: #4B5563; /* Màu xám của giao diện */
                border: 1px solid #6B7280; /* Viền */
                border-radius: 8px; /* Bo góc */
                display: flex;
                flex-direction: column; /* Căn thẳng đứng */
                justify-content: center;
                align-items: center;
                cursor: pointer;
                transition: background-color 0.3s ease;
                overflow: hidden; /* Đảm bảo nội dung không vượt ra ngoài */
            }

            #backgroundPreview:hover {
                background-color: #374151; /* Màu tối hơn khi hover */
            }

            #backgroundPreview i {
                font-size: 1.5rem; /* text-2xl */
                margin-bottom: 0.5rem; /* mb-2 */
                color: #10B981; /* Màu xanh lá */
            }

            #backgroundPreview p {
                font-size: 0.875rem; /* text-sm */
                color: #D1D5DB; /* Màu chữ xám nhạt */
                text-align: center;
            }

            /* Background Image (1280x720) */
            #backgroundImage {
                width: 100%;
                height: 100%;
                object-fit: cover; /* Thay đổi từ contain thành cover để phủ toàn bộ khung */
                border-radius: 8px; /* Bo góc */
                display: block; /* Đảm bảo hiển thị đúng */
            }

            /* Organizer Logo (275x275) */
            #organizerLogoPreview {
                width: 170px; /* Giữ chiều rộng cố định (khoảng 10.625rem, phù hợp với layout) */
                height: 216px; /* Giữ chiều cao cố định (khoảng 13.5rem, phù hợp với tỷ lệ 275x275 khi giữ tỷ lệ) */
                background-color: #4B5563; /* Màu xám của giao diện */
                border: 1px solid #6B7280; /* Viền */
                border-radius: 8px; /* Bo góc */
                display: flex;
                flex-direction: column; /* Căn thẳng đứng */
                justify-content: center;
                align-items: center;
                cursor: pointer;
                transition: background-color 0.3s ease;
                overflow: hidden; /* Đảm bảo nội dung không vượt ra ngoài */
            }

            #organizerLogoPreview:hover {
                background-color: #374151; /* Màu tối hơn khi hover */
            }

            #organizerLogoPreview i {
                font-size: 1.5rem; /* text-2xl */
                margin-bottom: 0.5rem; /* mb-2 */
                color: #10B981; /* Màu xanh lá */
            }

            #organizerLogoPreview p {
                font-size: 0.875rem; /* text-sm */
                color: #D1D5DB; /* Màu chữ xám nhạt */
                text-align: center;
            }

            /* Organizer Logo (275x275) */
            #organizerLogoImage {
                width: 100%;
                height: 100%;
                object-fit: cover; /* Thay đổi từ contain thành cover để phủ toàn bộ khung */
                border-radius: 8px; /* Bo góc */
                display: block; /* Đảm bảo hiển thị đúng */
            }

            /* Các class hiện có vẫn giữ nguyên */
            .image-group {
                display: flex;
                gap: 20px; /* Khoảng cách giữa Event Image và Background Image */
                justify-content: center; /* Căn giữa theo chiều ngang */
                flex-wrap: wrap; /* Cho phép xuống dòng nếu không đủ không gian */
            }

            .organizer-row {
                display: flex;
                align-items: center; /* Căn giữa theo chiều dọc */
                gap: 20px; /* Khoảng cách giữa Organizer Image và Organizer Name */
                justify-content: center; /* Căn giữa theo chiều ngang */
                margin-top: 20px; /* Khoảng cách giữa group ảnh và organizer-row */
            }

            .organizer-row .input-container {
                flex: 1; /* Cho phép input mở rộng để điền đủ chiều dài */
                max-width: 300px; /* Giới hạn chiều rộng của input để không quá dài */
            }

            /* Thêm vào phần <style> hiện có */
            .upload-icon.hidden, .upload-text.hidden {
                display: none; /* Đảm bảo các phần tử ẩn hoàn toàn khi có class 'hidden' */
            }
            .image-error {
                color: #EF4444;
                font-size: 0.875rem;
                margin-top: 0.5rem;
                text-align: center;
            }
            .error-message {
                color: #EF4444; /* Màu đỏ */
                font-size: 0.875rem; /* text-sm */
                margin-top: 0.25rem; /* mt-1 */
                display: none; /* Mặc định ẩn */
            }
            /* Thêm hoặc cập nhật class cho textarea */
            .event-info-textarea {
                width: 100%; /* Đảm bảo textarea chiếm toàn bộ chiều rộng của container */
                padding: 0.5rem; /* p-2 tương ứng 0.5rem trong Tailwind */
                border-radius: 0.375rem; /* rounded */
                background-color: #4B5563; /* bg-gray-700 */
                border: 1px solid #6B7280; /* border-gray-600 */
                color: #FFFFFF; /* Màu chữ trắng */
                outline: none; /* focus:outline-none */
                resize: vertical; /* Cho phép người dùng kéo dọc để thay đổi kích thước */
                min-height: 100px; /* Chiều cao tối thiểu */
                max-height: 400px; /* Chiều cao tối đa (tùy chỉnh theo nhu cầu) */
                overflow-y: auto; /* Hiển thị thanh cuộn nếu nội dung vượt quá chiều cao tối đa */
                box-shadow: 0 0 0 2px transparent; /* focus:ring-2 focus:ring-green-500 (ban đầu ẩn) */
                transition: border-color 0.3s ease, box-shadow 0.3s ease; /* Hiệu ứng chuyển đổi */
            }
            .event-info-textarea:focus {
                border-color: #15803D; /* focus:ring-green-500 */
                box-shadow: 0 0 0 2px #15803D; /* focus:ring-2 focus:ring-green-500 */
                background-color: #374151; /* Tối hơn khi focus */
                color: #FFFFFF; /* Giữ màu chữ trắng */
            }
            /* Tự động mở rộng theo nội dung (dùng JavaScript nếu cần, nhưng CSS có thể hỗ trợ cơ bản) */
            .event-info-textarea {
                height: 300px;
                line-height: 1; /* Điều chỉnh dòng chữ để tính chiều cao chính xác */
            }
            .event-info-textarea {
                transition: height 0.3s ease;
            }
            .btn-success:disabled {
                background-color: #6B7280; /* Màu xám khi bị vô hiệu hóa */
                cursor: not-allowed;
                transform: none; /* Không có hiệu ứng hover khi disabled */
            }
            .btn-success:disabled:hover {
                background-color: #6B7280; /* Giữ nguyên màu khi hover */
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
                    <a class="flex items-center w-full p-2 rounded-lg hover:bg-green-700 transition duration-200" href="${pageContext.request.contextPath}/pages/organizerPage/organizerCenter.jsp">
                        <i class="fas fa-ticket-alt mr-2"></i>My Event
                    </a>
                    <a class="flex items-center w-full p-2 bg-green-700 rounded-lg" href="updateEvent.jsp">
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
                        </div>
                    </div>
                </header>

                <!-- Tab Event Info -->
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
                            <span class="error-message" id="fullAddress_error"></span>
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
                                </div>
                                <span class="error-message" id="logoEvent_error"></span>

                                <!-- Event Background Image -->
                                <div id="backgroundPreview" class="w-36 h-48 bg-gray-700 border border-gray-600 rounded cursor-pointer flex items-center justify-center flex-col hover:bg-gray-600 transition duration-200">
                                    <i class="fas fa-upload text-2xl mb-2 text-green-500 upload-icon"></i>
                                    <p class="text-gray-300 text-sm upload-text">Add Event Background Image (1280x720)</p>
                                    <input type="file" id="backgroundInput" class="hidden">
                                    <img id="backgroundImage" src="" alt="Event Background Preview" class="w-full h-full object-cover rounded hidden">
                                </div>
                                <span class="error-message" id="backgroundImage_error"></span>
                            </div>
                        </div>
                        <div class="md:col-span-2 p-4 rounded bg-gray-800 text-center">
                            <!-- Organizer Image và Organizer Name nằm ngang nhau -->
                            <div class="organizer-row">
                                <!-- Organizer Logo -->
                                <div id="organizerLogoPreview" class="w-36 h-48 bg-gray-700 border border-gray-600 rounded cursor-pointer flex items-center justify-center flex-col hover:bg-gray-600 transition duration-200">
                                    <i class="fas fa-upload text-2xl mb-2 text-green-500 upload-icon"></i>
                                    <p class="text-gray-300 text-sm upload-text">Organizer Logo (275x275)</p>
                                    <input type="file" id="organizerLogoInput" class="hidden">
                                    <img id="organizerLogoImage" src="" alt="Organizer Logo Preview" class="w-full h-full object-cover rounded hidden">
                                </div>
                                <span class="error-message" id="organizerLogo_error"></span>

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

        <script src="${pageContext.request.contextPath}/pages/organizerPage/updateEvent.js"></script>
    </body>
</html>
