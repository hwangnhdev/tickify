<%-- 
    Document   : createEvent
    Created on : Feb 25, 2025, 5:44:28 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Event</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .hidden {
                display: none;
            }
        </style>
    </head>
    <body class="bg-gray-900 text-white">
        <div class="flex">
            <!-- Sidebar remains unchanged -->
            <div class="w-1/5 bg-green-900 p-4">
                <div class="flex items-center mb-6">
                    <div class="w-10 h-10 bg-green-700 rounded-full mr-3"></div>
                    <span class="text-xl font-bold">Organizer Center</span>
                </div>
                <ul>
                    <li class="mb-4">
                        <a href="#" class="flex items-center">
                            <i class="fas fa-calendar-alt mr-3"></i>
                            <span>Sự kiện của tôi</span>
                        </a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="flex items-center">
                            <i class="fas fa-file-alt mr-3"></i>
                            <span>Quản lý báo cáo</span>
                        </a>
                    </li>
                    <li class="mb-4">
                        <a href="#" class="flex items-center">
                            <i class="fas fa-users mr-3"></i>
                            <span>Điều khoản cho Ban tổ chức</span>
                        </a>
                    </li>
                </ul>
                <div class="mt-6">
                    <div class="flex items-center justify-between mb-4">
                        <span>Ngôn ngữ</span>
                        <label class="switch">
                            <input type="checkbox" checked>
                            <span class="slider round"></span>
                        </label>
                    </div>
                    <div class="flex items-center justify-between">
                        <span>Ngôn ngữ</span>
                        <label class="switch">
                            <input type="checkbox">
                            <span class="slider round"></span>
                        </label>
                    </div>
                </div>
            </div>
            <!-- Main Content -->
            <div class="w-4/5 p-6">
                <!-- Updated Header -->
                <div class="flex justify-between items-center mb-6 bg-gray-900 p-4 rounded-t">
                    <div class="flex space-x-4 items-center">
                        <button class="flex items-center justify-center w-8 h-8 bg-gray-800 rounded-full text-white mr-4" onclick="showTab('event-info')">1</button>
                        <span class="text-white">Thông tin sự kiện</span>
                        <button class="flex items-center justify-center w-8 h-8 bg-gray-800 rounded-full text-white mx-4" onclick="showTab('time-logistics')">2</button>
                        <span class="text-white">Thời gian & Loại vé</span>
                        <button class="flex items-center justify-center w-8 h-8 bg-gray-800 rounded-full text-white mx-4" onclick="showTab('settings')">3</button>
                        <span class="text-white">Cài đặt</span>
                        <button class="flex items-center justify-center w-8 h-8 bg-gray-800 rounded-full text-white mx-4" onclick="showTab('payment-info')">4</button>
                        <span class="text-white">Thông tin thanh toán</span>
                    </div>
                    <div class="flex space-x-4">
                        <button class="bg-white text-green-700 px-4 py-2 rounded">Lưu</button>
                        <button class="bg-green-700 text-white px-4 py-2 rounded">Tiếp tục</button>
                    </div>
                </div>
                <!-- Tabs Content remains unchanged -->
                <div id="event-info" class="tab-content">
                    <!-- Form -->
                    <div class="space-y-6">
                        <!-- Upload Images -->
                        <div class="flex space-x-4">
                            <div class="w-1/2 bg-gray-800 p-6 rounded flex items-center justify-center">
                                <div class="text-center">
                                    <i class="fas fa-upload text-3xl mb-2"></i>
                                    <p>Thêm logo sự kiện (720x458)</p>
                                </div>
                            </div>
                            <div class="w-1/2 bg-gray-800 p-6 rounded flex items-center justify-center">
                                <div class="text-center">
                                    <i class="fas fa-upload text-3xl mb-2"></i>
                                    <p>Thêm ảnh nền sự kiện (1280x720)</p>
                                </div>
                            </div>
                        </div>
                        <!-- Event Name -->
                        <div>
                            <label class="block mb-2">Tên sự kiện</label>
                            <input type="text" class="w-full p-3 bg-gray-800 rounded" placeholder="Tên sự kiện">
                        </div>
                        <!-- Event Location -->
                        <div>
                            <label class="block mb-2">Địa chỉ sự kiện</label>
                            <div class="flex items-center mb-4">
                                <input type="radio" name="event_type" class="mr-2"> Sự kiện Offline
                                <input type="radio" name="event_type" class="ml-6 mr-2"> Sự kiện Online
                            </div>
                            <input type="text" class="w-full p-3 bg-gray-800 rounded mb-4" placeholder="Tên địa điểm">
                            <div class="flex space-x-4">
                                <input type="text" class="w-1/2 p-3 bg-gray-800 rounded" placeholder="Tỉnh/Thành">
                                <input type="text" class="w-1/2 p-3 bg-gray-800 rounded" placeholder="Quận/Huyện">
                            </div>
                            <div class="flex space-x-4 mt-4">
                                <input type="text" class="w-1/2 p-3 bg-gray-800 rounded" placeholder="Phường/Xã">
                                <input type="text" class="w-1/2 p-3 bg-gray-800 rounded" placeholder="Số nhà, đường">
                            </div>
                        </div>
                        <!-- Event Type -->
                        <div>
                            <label class="block mb-2">Thể loại sự kiện</label>
                            <input type="text" class="w-full p-3 bg-gray-800 rounded" placeholder="Vui lòng chọn">
                        </div>
                        <!-- Event Information -->
                        <div>
                            <label class="block mb-2">Thông tin sự kiện</label>
                            <textarea class="w-full p-3 bg-gray-800 rounded h-40" placeholder="Giới thiệu sự kiện..."></textarea>
                        </div>
                        <!-- Organizer Information -->
                        <div class="flex space-x-4">
                            <div class="w-1/2 bg-gray-800 p-6 rounded flex items-center justify-center">
                                <div class="text-center">
                                    <i class="fas fa-upload text-3xl mb-2"></i>
                                    <p>Thêm logo ban tổ chức (275x275)</p>
                                </div>
                            </div>
                            <div class="w-1/2">
                                <label class="block mb-2">Tên ban tổ chức</label>
                                <input type="text" class="w-full p-3 bg-gray-800 rounded mb-4" placeholder="Tên ban tổ chức">
                                <label class="block mb-2">Thông tin ban tổ chức</label>
                                <textarea class="w-full p-3 bg-gray-800 rounded h-24" placeholder="Thông tin ban tổ chức"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="time-logistics" class="tab-content hidden">
                    <!-- Time & Logistics Content -->
                    <p>Thời gian & Logi vé content goes here...</p>
                </div>
                <div id="settings" class="tab-content hidden">
                    <!-- Settings Content -->
                    <p>Cài đặt content goes here...</p>
                </div>
                <div id="payment-info" class="tab-content hidden">
                    <!-- Payment Info Content -->
                    <p>Thông tin thanh toán content goes here...</p>
                </div>
            </div>
        </div>

        <script>
            function showTab(tabId) {
                // Hide all tab contents
                document.querySelectorAll('.tab-content').forEach(tab => {
                    tab.classList.add('hidden');
                });

                // Show the selected tab content
                document.getElementById(tabId).classList.remove('hidden');

                // Update button styles
                document.querySelectorAll('.flex.space-x-4 button').forEach(button => {
                    button.classList.remove('bg-green-700');
                    button.classList.add('bg-gray-800');
                });

                // Highlight the active button
                event.target.classList.remove('bg-gray-800');
                event.target.classList.add('bg-green-700');
            }
        </script>
    </body>
</html>
