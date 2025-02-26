<%-- 
    Document   : createEvent
    Created on : Feb 25, 2025, 5:44:28 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Event</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
        <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/vi.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/vietblogdao/js/districts.min.js"></script>
        <style>
            body {
                background-color: #1F2937;
                color: white;
            }
            .sidebar {
                background-color: #15803D;
            }
            .tab-button {
                width: 32px;
                height: 32px;
                background-color: #4B5563;
            }
            .tab-button.active {
                background-color: #15803D;
            }
            .upload-area {
                background-color: #4B5563;
            }
            .form-control, .form-select {
                background-color: #4B5563;
                color: white;
                border: none;
            }
            .form-control::placeholder {
                color: #D1D5DB;
            }
            .ticket-section {
                background-color: #374151;
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px;
            }
            .add-ticket-btn {
                background-color: #15803D;
                color: white;
                border: none;
                padding: 8px 16px;
                border-radius: 4px;
                cursor: pointer;
            }
            .add-ticket-btn:hover {
                background-color: #166534;
            }
            .date-input {
                background-color: #4B5563;
                color: white;
                border: none;
                padding: 8px;
                border-radius: 4px;
            }

            /* Add this to your existing style section */
            .show-time {
                background-color: #374151; /* Ensure the background matches your design */
                border-radius: 8px;
                padding: 20px;
                margin-bottom: 20px; /* Add space between each Show Time section */
                border: 1px solid #4B5563; /* Optional: Add a border for better visual separation */
            }

            /* Ensure the container for show times has some padding or spacing */
            #showTimeList {
                padding: 10px 0; /* Add some padding to the list container */
            }

            /* Date Input Styling with Flatpickr */
            .filter-group input[type="text"].flatpickr-input {
                padding: 10px 12px;
                border: 2px solid #dfe6e9;
                border-radius: 8px;
                font-size: 14px;
                background-color: #4B5563;
                color: white;
                cursor: pointer; /* Ensure cursor is pointer for clickable behavior */
                height: 40px;
                width: 100%;
                box-sizing: border-box;
            }

            .filter-group input[type="text"].flatpickr-input:hover,
            .filter-group input[type="text"].flatpickr-input:focus {
                border-color: #3498db;
                box-shadow: 0 0 8px rgba(52, 152, 219, 0.3);
                outline: none;
            }

            /* Tùy chỉnh giao diện Flatpickr */
            .flatpickr-calendar {
                border: none;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                background: #ffffff;
                font-family: Arial, sans-serif;
            }

            .flatpickr-day.selected {
                background-color: #3498db;
                border-color: #3498db;
                color: #fff;
            }

            .flatpickr-day.today {
                background-color: #e9ecef;
                color: #2c3e50;
            }

            .flatpickr-day:hover {
                background-color: #dfe6e9;
                color: #2c3e50;
            }

            .flatpickr-months .flatpickr-month {
                background: #28a745;
                color: #fff;
                border-radius: 8px 8px 0 0;
            }

            .flatpickr-weekdays {
                background: #f8f9fa;
                color: #2c3e50;
            }

            .flatpickr-rContainer .flatpickr-days {
                border-top: none;
            }

            /* Tùy chỉnh nút preset (Tất cả các ngày, Hôm nay, v.v.) */
            .flatpickr-ranges {
                padding: 10px;
                border-bottom: 1px solid #e9ecef;
                background: #f8f9fa;
            }

            .flatpickr-ranges button {
                background: #fff;
                border: 1px solid #dfe6e9;
                border-radius: 4px;
                padding: 5px 10px;
                margin-right: 5px;
                cursor: pointer;
                font-size: 14px;
                color: #2c3e50;
                transition: all 0.3s ease;
            }

            .flatpickr-ranges button:hover {
                background: #dfe6e9;
                border-color: #3498db;
                color: #2c3e50;
            }

            /* Nút Apply và Reset */
            .flatpickr-footer {
                padding: 10px;
                background: #fff;
                border-top: 1px solid #e9ecef;
                text-align: right;
            }

            .flatpickr-footer button {
                background: #2ecc71;
                border: none;
                border-radius: 25px;
                padding: 8px 20px;
                font-size: 14px;
                color: #fff;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .flatpickr-footer button:hover {
                background: #27ae60;
                transform: translateY(-2px);
            }

            .flatpickr-footer button:active {
                transform: translateY(1px);
            }
        </style>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar (unchanged) -->
                <div class="col-md-3 col-lg-2 sidebar p-4 min-vh-100">
                    <div class="d-flex align-items-center mb-4">
                        <div class="rounded-circle bg-success me-3" style="width: 40px; height: 40px;"></div>
                        <span class="fs-4 fw-bold">Organizer Center</span>
                    </div>
                    <ul class="list-unstyled">
                        <li class="mb-3">
                            <a href="#" class="text-white text-decoration-none d-flex align-items-center">
                                <i class="fas fa-calendar-alt me-2"></i>
                                <span>Sự kiện của tôi</span>
                            </a>
                        </li>
                        <li class="mb-3">
                            <a href="#" class="text-white text-decoration-none d-flex align-items-center">
                                <i class="fas fa-file-alt me-2"></i>
                                <span>Quản lý báo cáo</span>
                            </a>
                        </li>
                        <li class="mb-3">
                            <a href="#" class="text-white text-decoration-none d-flex align-items-center">
                                <i class="fas fa-users me-2"></i>
                                <span>Điều khoản cho Ban tổ chức</span>
                            </a>
                        </li>
                    </ul>
                </div>
                <!-- Main Content -->
                <div class="col-md-9 col-lg-10 p-4">
                    <!-- Header -->
                    <div class="bg-dark p-3 rounded-top mb-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center gap-3">
                                <button class="tab-button rounded-circle d-flex align-items-center justify-content-center text-white" onclick="showTab('event-info')">1</button>
                                <span>Thông tin sự kiện</span>
                                <button class="tab-button rounded-circle d-flex align-items-center justify-content-center text-white" onclick="showTab('time-logistics')">2</button>
                                <span>Thời gian & Loại vé</span>
                            </div>
                            <div class="d-flex gap-3">
                                <button class="btn btn-light text-success">Lưu</button>
                                <button class="btn btn-success" onclick="nextTab()">Tiếp tục</button>
                            </div>
                        </div>
                    </div>

                    <!-- Tabs Content -->
                    <div id="event-info" class="tab-content">
                        <div class="row g-4">
                            <!-- Upload Images (unchanged) -->
                            <div class="col-md-6">
                                <div class="upload-area p-4 rounded text-center">
                                    <i class="fas fa-upload fs-2 mb-2"></i>
                                    <p>Thêm logo sự kiện (720x958)</p>
                                    <input type="file" name="logoEvent" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="upload-area p-4 rounded text-center">
                                    <i class="fas fa-upload fs-2 mb-2"></i>
                                    <p>Thêm ảnh nền sự kiện (1280x720)</p>
                                    <input type="file" name="logoBanner" class="form-control">
                                </div>
                            </div>

                            <!-- Organizer Information (unchanged) -->
                            <div class="col-md-6">
                                <div class="upload-area p-4 rounded text-center">
                                    <i class="fas fa-upload fs-2 mb-2"></i>
                                    <p>Logo Organizer (275x275)</p>
                                    <input type="file" name="logoBanner" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Organizer Name</label>
                                <input type="text" class="form-control" placeholder="Organizer Name">
                            </div>

                            <!-- Event Name (unchanged) -->
                            <div class="col-12">
                                <label class="form-label">Event Name</label>
                                <input type="text" class="form-control" placeholder="Event Name">
                            </div>

                            <!-- Type Of Event (unchanged) -->
                            <div class="col-12">
                                <label class="form-label">Type Of Event</label>
                                <select class="form-select">
                                    <option value="">-- Please Select Type --</option>
                                    <option value="standingevent">Standing Event</option>
                                    <option value="seatedevent">Seated Event</option>
                                </select>
                            </div>

                            <!-- Event Category (unchanged) -->
                            <div class="col-12">
                                <label class="form-label">Event Category</label>
                                <select class="form-select">
                                    <option value="">-- Please Select Category --</option>
                                    <c:forEach var="category" items="${listCategories}">
                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <!-- Event Location (unchanged) -->
                            <div class="col-12">
                                <label class="form-label">Event Location</label>
                                <input type="text" class="form-control" placeholder="Enter location name">
                            </div>

                            <!-- Event Information (unchanged) -->
                            <div class="col-12">
                                <label class="form-label">Event Information</label>
                                <textarea class="form-control" rows="5" placeholder="Description"></textarea>
                            </div>
                        </div>
                    </div>

                    <!--Create ticket for event-->
                    <div id="time-logistics" class="tab-content d-none">
                        <div class="row g-4">
                            <!-- Show Times -->
                            <div class="col-12 ticket-section">
                                <h5>Thời gian diễn ra sự kiện</h5>
                                <div id="showTimeList">
                                    <!-- Default Show Time -->
                                    <div class="show-time">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h6>Show Time</h6>
                                            <button class="add-ticket-btn" onclick="removeShowTime(this)">Xóa</button>
                                        </div>
                                        <div class="form-group filter-group">
                                            <label for="showStartDate_1">Ngày bắt đầu</label>
                                            <input type="text" name="showStartDate" id="showStartDate_1" class="flatpickr-input" placeholder="Chọn ngày bắt đầu" readonly>
                                        </div>
                                        <div class="form-group filter-group">
                                            <label for="showEndDate_1">Ngày kết thúc</label>
                                            <input type="text" name="showEndDate" id="showEndDate_1" class="flatpickr-input" placeholder="Chọn ngày kết thúc" readonly>
                                        </div>
                                        <div id="ticketList_1" class="mt-3"></div>
                                        <button class="add-ticket-btn w-100 mt-3" data-bs-toggle="modal" data-bs-target="#newTicketModal" data-show-time="1">+ Thêm loại vé</button>
                                    </div>
                                </div>
                            </div>

                            <!-- Nút tạo sự kiện -->
                            <div class="col-12 text-center mt-3">
                                <button class="add-ticket-btn w-100 mt-3" onclick="addNewShowTime()">+ Create New Show Time</button>
                            </div>
                        </div>
                    </div>

                    <!-- Modal for creating new ticket -->
                    <div class="modal fade" id="newTicketModal" tabindex="-1" aria-labelledby="newTicketModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content" style="background-color: #4B5563; color: white;">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="newTicketModalLabel">Tạo loại vé mới</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="ticket-form">
                                        <div class="form-group">
                                            <label for="modalTicketName">Tên loại vé</label>
                                            <input type="text" class="form-control" id="modalTicketName" placeholder="Ví dụ: VIP">
                                        </div>
                                        <div class="form-group">
                                            <label for="modalTicketDescription">Mô tả</label>
                                            <textarea class="form-control" id="modalTicketDescription" placeholder="Ví dụ: VIP seating" rows="2"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="modalTicketPrice">Giá (VND)</label>
                                            <input type="number" class="form-control" id="modalTicketPrice" placeholder="Ví dụ: 150.00" step="0.01">
                                        </div>
                                        <div class="form-group">
                                            <label for="modalTicketQuantity">Số lượng</label>
                                            <input type="number" class="form-control" id="modalTicketQuantity" placeholder="Ví dụ: 50">
                                        </div>
                                        <div class="form-group filter-group">
                                            <label for="modalTicketStartDate">Ngày bắt đầu bán</label>
                                            <input type="text" name="modalTicketStartDate" id="modalTicketStartDate" class="flatpickr-input" placeholder="Chọn ngày bắt đầu bán" readonly>
                                        </div>
                                        <div class="form-group filter-group">
                                            <label for="modalTicketEndDate">Ngày kết thúc bán</label>
                                            <input type="text" name="modalTicketEndDate" id="modalTicketEndDate" class="flatpickr-input" placeholder="Chọn ngày kết thúc bán" readonly>
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                    <button type="button" class="btn btn-success" onclick="saveNewTicket()">Lưu</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>
                        // Hàm để thêm Show Time mới
                        let showTimeCount = 1;
                        function addNewShowTime() {
                            showTimeCount++;
                            const showTimeList = document.getElementById('showTimeList');
                            const newShowTime = document.createElement('div');
                            newShowTime.className = 'show-time';
                            newShowTime.innerHTML = `
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6>Show Time</h6>
                                    <button class="add-ticket-btn" onclick="removeShowTime(this)">Xóa</button>
                                </div>
                                <div class="form-group filter-group">
                                    <label for="showStartDate_${showTimeCount}">Ngày bắt đầu</label>
                                    <input type="text" name="showStartDate" id="showStartDate_${showTimeCount}" class="flatpickr-input" placeholder="Chọn ngày bắt đầu" readonly>
                                </div>
                                <div class="form-group filter-group">
                                    <label for="showEndDate_${showTimeCount}">Ngày kết thúc</label>
                                    <input type="text" name="showEndDate" id="showEndDate_${showTimeCount}" class="flatpickr-input" placeholder="Chọn ngày kết thúc" readonly>
                                </div>
                                <div id="ticketList_${showTimeCount}" class="mt-3"></div>
                                <button class="add-ticket-btn w-100 mt-3" data-bs-toggle="modal" data-bs-target="#newTicketModal" data-show-time="${showTimeCount}">+ Thêm loại vé</button>
                            `;

                            showTimeList.appendChild(newShowTime);

                            // Khởi tạo Flatpickr cho Show Time mới
                            initializeFlatpickrForShowTime(`showStartDate_${showTimeCount}`, `showEndDate_${showTimeCount}`);
                        }

                        // Hàm để xóa Show Time
                        function removeShowTime(button) {
                            button.closest('.show-time').remove();
                        }

                        // Hàm để mở modal khi thêm loại vé
                        function addNewTicket(showTimeId) {
                            const modal = new bootstrap.Modal(document.getElementById('newTicketModal'));
                            modal.show();
                            document.getElementById('newTicketModal').setAttribute('data-show-time', showTimeId);
                        }

                        // Hàm để lưu loại vé mới từ modal và hiển thị trên trang
                        function saveNewTicket() {
                            const showTimeId = document.getElementById('newTicketModal').getAttribute('data-show-time');
                            const ticketName = document.getElementById('modalTicketName').value;
                            const ticketDescription = document.getElementById('modalTicketDescription').value;
                            const ticketPrice = document.getElementById('modalTicketPrice').value;
                            const ticketQuantity = document.getElementById('modalTicketQuantity').value;
                            const ticketStartDate = document.getElementById('modalTicketStartDate').value;
                            const ticketEndDate = document.getElementById('modalTicketEndDate').value;

                            if (ticketName && ticketDescription && ticketPrice && ticketQuantity && ticketStartDate && ticketEndDate) {
                                const ticketList = document.getElementById(`ticketList_${showTimeId}`);
                                const newTicket = document.createElement('div');
                                newTicket.className = 'saved-ticket';
                                newTicket.innerHTML = `
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <h6>${ticketName}</h6>
                                        <button class="add-ticket-btn" onclick="removeTicket(this, '${showTimeId}')">Xóa</button>
                                    </div>
                                    <div class="form-group">
                                        <label>Mô tả</label>
                                        <input type="text" class="form-control" value="${ticketDescription}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Giá (VND)</label>
                                        <input type="number" class="form-control" value="${ticketPrice}" readonly step="0.01">
                                    </div>
                                    <div class="form-group">
                                        <label>Số lượng</label>
                                        <input type="number" class="form-control" value="${ticketQuantity}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày bắt đầu bán</label>
                                        <input type="text" class="form-control" value="${ticketStartDate}" readonly>
                                    </div>
                                    <div class="form-group">
                                        <label>Ngày kết thúc bán</label>
                                        <input type="text" class="form-control" value="${ticketEndDate}" readonly>
                                    </div>
                                `;

                                ticketList.appendChild(newTicket);
                                const modal = bootstrap.Modal.getInstance(document.getElementById('newTicketModal'));
                                modal.hide();

                                // Xóa dữ liệu trong modal sau khi lưu
                                document.getElementById('modalTicketName').value = '';
                                document.getElementById('modalTicketDescription').value = '';
                                document.getElementById('modalTicketPrice').value = '';
                                document.getElementById('modalTicketQuantity').value = '';
                                document.getElementById('modalTicketStartDate').value = '';
                                document.getElementById('modalTicketEndDate').value = '';
                            } else {
                                alert("Vui lòng điền đầy đủ thông tin!");
                            }
                        }

                        // Hàm để xóa loại vé trong một Show Time cụ thể
                        function removeTicket(button, showTimeId) {
                            button.closest('.saved-ticket').remove();
                        }

                        // Hàm khởi tạo Flatpickr cho Show Time
                        function initializeFlatpickrForShowTime(startId, endId) {
                            flatpickr(`#${startId}`, {
                                dateFormat: "Y-m-d H:i",
                                enableTime: true,
                                time_24hr: true,
                                defaultDate: null,
                                locale: "vi",
                                maxDate: new Date().fp_incr(365), // Giới hạn tối đa là 1 năm từ hôm nay
                                minDate: "today", // Giới hạn tối thiểu là ngày hôm nay
                                onChange: function (selectedDates, dateStr, instance) {
                                    document.getElementById(startId).value = dateStr;
                                    const endDatePicker = document.getElementById(endId)._flatpickr;
                                    const endDateValue = document.getElementById(endId).value;

                                    if (selectedDates[0]) {
                                        const minEndDate = new Date(selectedDates[0]);
                                        minEndDate.setMinutes(minEndDate.getMinutes() + 1); // Tăng 1 phút
                                        endDatePicker.set("minDate", minEndDate);

                                        if (endDateValue && new Date(endDateValue) <= selectedDates[0]) {
                                            endDatePicker.clear();
                                            document.getElementById(endId).value = "";
                                        }
                                    }
                                },
                                onReady: function (selectedDates, dateStr, instance) {
                                    const ranges = document.createElement('div');
                                    ranges.className = 'flatpickr-ranges';
                                    ranges.innerHTML = `
                                        <button data-range="today">Hôm nay</button>
                                        <button data-range="tomorrow">Ngày mai</button>
                                        <button data-range="weekend">Cuối tuần này</button>
                                        <button data-range="month">Tháng này</button>
                                    `;
                                    instance.calendarContainer.insertBefore(ranges, instance.calendarContainer.firstChild);

                                    ranges.querySelectorAll('button').forEach(button => {
                                        button.addEventListener('click', function () {
                                            const range = this.getAttribute('data-range');
                                            let date;
                                            const now = new Date();
                                            switch (range) {
                                                case 'today':
                                                    date = now;
                                                    break;
                                                case 'tomorrow':
                                                    date = new Date(now.getTime() + 24 * 60 * 60 * 1000);
                                                    break;
                                                case 'weekend':
                                                    date = new Date(now);
                                                    date.setDate(date.getDate() + (6 - date.getDay() + 1) % 7);
                                                    break;
                                                case 'month':
                                                    date = new Date(now.getFullYear(), now.getMonth(), 1);
                                                    break;
                                            }
                                            instance.setDate(date);
                                            document.getElementById(startId).value = instance.formatDate(date, "Y-m-d H:i");
                                            const endDatePicker = document.getElementById(endId)._flatpickr;
                                            const minEndDate = new Date(date);
                                            minEndDate.setMinutes(minEndDate.getMinutes() + 1);
                                            endDatePicker.set("minDate", minEndDate);
                                            if (document.getElementById(endId).value && new Date(document.getElementById(endId).value) <= date) {
                                                endDatePicker.clear();
                                                document.getElementById(endId).value = "";
                                            }
                                        });
                                    });
                                }
                            });

                            flatpickr(`#${endId}`, {
                                dateFormat: "Y-m-d H:i",
                                enableTime: true,
                                time_24hr: true,
                                defaultDate: null,
                                locale: "vi",
                                maxDate: new Date().fp_incr(365), // Giới hạn tối đa là 1 năm từ hôm nay
                                minDate: "tomorrow", // Mặc định là ngày mai, sẽ được cập nhật từ startDate
                                onChange: function (selectedDates, dateStr, instance) {
                                    document.getElementById(endId).value = dateStr;
                                    const startDateValue = document.getElementById(startId).value;
                                    const startDate = startDateValue ? new Date(startDateValue) : null;

                                    if (startDate && selectedDates[0] <= startDate) {
                                        alert("Ngày kết thúc phải lớn hơn ngày bắt đầu!");
                                        instance.clear();
                                        document.getElementById(endId).value = "";
                                    }
                                },
                                onReady: function (selectedDates, dateStr, instance) {
                                    const ranges = document.createElement('div');
                                    ranges.className = 'flatpickr-ranges';
                                    ranges.innerHTML = `
                    <button data-range="today">Hôm nay</button>
                    <button data-range="tomorrow">Ngày mai</button>
                    <button data-range="weekend">Cuối tuần này</button>
                    <button data-range="month">Tháng này</button>
                `;
                                    instance.calendarContainer.insertBefore(ranges, instance.calendarContainer.firstChild);

                                    ranges.querySelectorAll('button').forEach(button => {
                                        button.addEventListener('click', function () {
                                            const range = this.getAttribute('data-range');
                                            let date;
                                            const now = new Date();
                                            switch (range) {
                                                case 'today':
                                                    date = now;
                                                    break;
                                                case 'tomorrow':
                                                    date = new Date(now.getTime() + 24 * 60 * 60 * 1000);
                                                    break;
                                                case 'weekend':
                                                    date = new Date(now);
                                                    date.setDate(date.getDate() + (6 - date.getDay() + 1) % 7);
                                                    break;
                                                case 'month':
                                                    date = new Date(now.getFullYear(), now.getMonth() + 1, 0); // Ngày cuối tháng
                                                    break;
                                            }
                                            const startDateValue = document.getElementById(startId).value;
                                            const startDate = startDateValue ? new Date(startDateValue) : null;

                                            if (startDate && date <= startDate) {
                                                alert("Ngày kết thúc phải lớn hơn ngày bắt đầu!");
                                                return;
                                            }
                                            instance.setDate(date);
                                            document.getElementById(endId).value = instance.formatDate(date, "Y-m-d H:i");
                                        });
                                    });
                                }
                            });
                        }

                        // Hàm khởi tạo Flatpickr cho ticketStartDate và ticketEndDate trong modal
                        function initializeFlatpickrForModal() {
                            flatpickr("#modalTicketStartDate", {
                                dateFormat: "Y-m-d H:i",
                                enableTime: true,
                                time_24hr: true,
                                defaultDate: null,
                                locale: "vi",
                                maxDate: new Date().fp_incr(365), // Giới hạn tối đa là 1 năm từ hôm nay
                                minDate: "today", // Giới hạn tối thiểu là ngày hôm nay
                                onChange: function (selectedDates, dateStr, instance) {
                                    document.getElementById('modalTicketStartDate').value = dateStr;
                                    const endDatePicker = document.getElementById('modalTicketEndDate')._flatpickr;
                                    const endDateValue = document.getElementById('modalTicketEndDate').value;

                                    if (selectedDates[0]) {
                                        const minEndDate = new Date(selectedDates[0]);
                                        minEndDate.setMinutes(minEndDate.getMinutes() + 1); // Tăng 1 phút
                                        endDatePicker.set("minDate", minEndDate);

                                        if (endDateValue && new Date(endDateValue) <= selectedDates[0]) {
                                            endDatePicker.clear();
                                            document.getElementById('modalTicketEndDate').value = "";
                                        }
                                    }
                                },
                                onReady: function (selectedDates, dateStr, instance) {
                                    const ranges = document.createElement('div');
                                    ranges.className = 'flatpickr-ranges';
                                    ranges.innerHTML = `
                    <button data-range="today">Hôm nay</button>
                    <button data-range="tomorrow">Ngày mai</button>
                    <button data-range="weekend">Cuối tuần này</button>
                    <button data-range="month">Tháng này</button>
                `;
                                    instance.calendarContainer.insertBefore(ranges, instance.calendarContainer.firstChild);

                                    ranges.querySelectorAll('button').forEach(button => {
                                        button.addEventListener('click', function () {
                                            const range = this.getAttribute('data-range');
                                            let date;
                                            const now = new Date();
                                            switch (range) {
                                                case 'today':
                                                    date = now;
                                                    break;
                                                case 'tomorrow':
                                                    date = new Date(now.getTime() + 24 * 60 * 60 * 1000);
                                                    break;
                                                case 'weekend':
                                                    date = new Date(now);
                                                    date.setDate(date.getDate() + (6 - date.getDay() + 1) % 7);
                                                    break;
                                                case 'month':
                                                    date = new Date(now.getFullYear(), now.getMonth(), 1);
                                                    break;
                                            }
                                            instance.setDate(date);
                                            document.getElementById('modalTicketStartDate').value = instance.formatDate(date, "Y-m-d H:i");
                                            const endDatePicker = document.getElementById('modalTicketEndDate')._flatpickr;
                                            const minEndDate = new Date(date);
                                            minEndDate.setMinutes(minEndDate.getMinutes() + 1);
                                            endDatePicker.set("minDate", minEndDate);
                                            if (document.getElementById('modalTicketEndDate').value && new Date(document.getElementById('modalTicketEndDate').value) <= date) {
                                                endDatePicker.clear();
                                                document.getElementById('modalTicketEndDate').value = "";
                                            }
                                        });
                                    });
                                }
                            });

                            flatpickr("#modalTicketEndDate", {
                                dateFormat: "Y-m-d H:i",
                                enableTime: true,
                                time_24hr: true,
                                defaultDate: null,
                                locale: "vi",
                                maxDate: new Date().fp_incr(365), // Giới hạn tối đa là 1 năm từ hôm nay
                                minDate: "tomorrow", // Mặc định là ngày mai, sẽ được cập nhật từ startDate
                                onChange: function (selectedDates, dateStr, instance) {
                                    document.getElementById('modalTicketEndDate').value = dateStr;
                                    const startDateValue = document.getElementById('modalTicketStartDate').value;
                                    const startDate = startDateValue ? new Date(startDateValue) : null;

                                    if (startDate && selectedDates[0] <= startDate) {
                                        alert("Ngày kết thúc bán phải lớn hơn ngày bắt đầu bán!");
                                        instance.clear();
                                        document.getElementById('modalTicketEndDate').value = "";
                                    }
                                },
                                onReady: function (selectedDates, dateStr, instance) {
                                    const ranges = document.createElement('div');
                                    ranges.className = 'flatpickr-ranges';
                                    ranges.innerHTML = `
                    <button data-range="today">Hôm nay</button>
                    <button data-range="tomorrow">Ngày mai</button>
                    <button data-range="weekend">Cuối tuần này</button>
                    <button data-range="month">Tháng này</button>
                `;
                                    instance.calendarContainer.insertBefore(ranges, instance.calendarContainer.firstChild);

                                    ranges.querySelectorAll('button').forEach(button => {
                                        button.addEventListener('click', function () {
                                            const range = this.getAttribute('data-range');
                                            let date;
                                            const now = new Date();
                                            switch (range) {
                                                case 'today':
                                                    date = now;
                                                    break;
                                                case 'tomorrow':
                                                    date = new Date(now.getTime() + 24 * 60 * 60 * 1000);
                                                    break;
                                                case 'weekend':
                                                    date = new Date(now);
                                                    date.setDate(date.getDate() + (6 - date.getDay() + 1) % 7);
                                                    break;
                                                case 'month':
                                                    date = new Date(now.getFullYear(), now.getMonth() + 1, 0); // Ngày cuối tháng
                                                    break;
                                            }
                                            const startDateValue = document.getElementById('modalTicketStartDate').value;
                                            const startDate = startDateValue ? new Date(startDateValue) : null;

                                            if (startDate && date <= startDate) {
                                                alert("Ngày kết thúc bán phải lớn hơn ngày bắt đầu bán!");
                                                return;
                                            }
                                            instance.setDate(date);
                                            document.getElementById('modalTicketEndDate').value = instance.formatDate(date, "Y-m-d H:i");
                                        });
                                    });
                                }
                            });
                        }

                        // Khởi tạo Flatpickr cho Show Time và Ticket mặc định khi trang load
                        document.addEventListener('DOMContentLoaded', () => {
                            initializeFlatpickrForShowTime('showStartDate_1', 'showEndDate_1');
                            initializeFlatpickrForModal(); // Khởi tạo Flatpickr cho modal
                        });

                        // Các hàm showTab và nextTab giữ nguyên
                        function showTab(tabId) {
                            // Hide all tab contents
                            document.querySelectorAll('.tab-content').forEach(tab => {
                                tab.classList.add('d-none');
                            });

                            // Show the selected tab content
                            document.getElementById(tabId).classList.remove('d-none');

                            // Update button styles
                            document.querySelectorAll('.tab-button').forEach(button => {
                                button.classList.remove('active');
                                button.classList.add('bg-gray-600');
                            });

                            // Highlight the active button
                            event.target.classList.add('active');
                            event.target.classList.remove('bg-gray-600');
                        }

                        function nextTab() {
                            // Lấy tab hiện tại (giả sử bắt đầu từ event-info)
                            const currentTab = document.querySelector('.tab-content:not(.d-none)').id;
                            if (currentTab === 'event-info') {
                                showTab('time-logistics');
                            } else if (currentTab === 'time-logistics') {
                                showTab('settings');
                            } else if (currentTab === 'settings') {
                                showTab('payment-info');
                            }
                        }

                        // Khởi tạo tab mặc định
                        document.addEventListener('DOMContentLoaded', () => {
                            showTab('event-info');
                        });
                    </script>
                </div>
            </div>
        </div>

        <script>
            function showTab(tabId) {
                // Hide all tab contents
                document.querySelectorAll('.tab-content').forEach(tab => {
                    tab.classList.add('d-none');
                });

                // Show the selected tab content
                document.getElementById(tabId).classList.remove('d-none');

                // Update button styles
                document.querySelectorAll('.tab-button').forEach(button => {
                    button.classList.remove('active');
                    button.classList.add('bg-gray-600');
                });

                // Highlight the active button
                event.target.classList.add('active');
                event.target.classList.remove('bg-gray-600');
            }

            function nextTab() {
                // Lấy tab hiện tại (giả sử bắt đầu từ event-info)
                const currentTab = document.querySelector('.tab-content:not(.d-none)').id;
                if (currentTab === 'event-info') {
                    showTab('time-logistics');
                } else if (currentTab === 'time-logistics') {
                    showTab('settings');
                } else if (currentTab === 'settings') {
                    showTab('payment-info');
                }
            }

            // Khởi tạo tab mặc định
            document.addEventListener('DOMContentLoaded', () => {
                showTab('event-info');
            });
        </script>
    </body>
</html>