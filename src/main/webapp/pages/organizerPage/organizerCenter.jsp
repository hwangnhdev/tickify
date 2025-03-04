<%-- 
    Document   : organizerCenter
    Created on : Feb 28, 2025, 5:58:09 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Tickify Organizer</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    </head>
    <body class="bg-gray-900 text-white">
        <div class="flex h-screen">
            <!-- Sidebar -->
            <aside class="w-1/6 bg-gradient-to-b from-green-900 to-black p-4 text-white">
                <div class="flex items-center mb-8">
                    <img alt="Tickify logo" class="mr-2" height="40" src="https://storage.googleapis.com/a1aa/image/8k6Ikw_t95IdEBRzaSbfv_qa-9InZk34-JUibXbK7B4.jpg" width="40"/>
                    <span class="text-lg font-bold text-green-500">Organizer Center</span>
                </div>
                <nav class="space-y-4">
                    <a class="flex items-center text-white w-full p-2 rounded-lg hover:bg-green-700 hover:text-white transition duration-200" href="#">
                        <i class="fas fa-ticket-alt mr-2"></i>My Event
                    </a>
                </nav>
            </aside>
            <!-- Main Content -->
            <main class="flex-1 flex flex-col">
                <!-- Header -->
                <header class="flex justify-between items-center bg-gray-800 p-4">
                    <h1 class="text-xl font-bold">My Event</h1>
                    <div class="flex items-center space-x-4">
                        <!-- Nút + Create Event với chức năng chuyển hướng -->
                        <button type="button" onclick="location.href = 'createEvent.jsp'" class="bg-green-500 text-white px-6 py-3 rounded-full shadow-lg hover:bg-green-600 transition duration-200">
                            + Create Event
                        </button>
                        <button class="flex items-center text-white">
                            <img alt="User avatar" class="mr-2 rounded-full" height="30" src="https://storage.googleapis.com/a1aa/image/_qCewoK0KXQhWyQzRe9zG7PpYaYijDdWdPLzWZ3kkg8.jpg" width="30"/>
                            My Account
                        </button>
                    </div>
                </header>
                <!-- Search and Filters -->
                <section class="p-4">
                    <div class="flex items-center">
                        <!-- Thanh tìm kiếm -->
                        <div class="flex items-center">
                            <div class="relative">
                                <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                                    <i class="fas fa-search text-gray-500"></i>
                                </span>
                                <input
                                    class="w-64 pl-10 pr-4 py-2 rounded-full border border-gray-300 focus:outline-none focus:ring-2 focus:ring-green-500"
                                    type="text"
                                    placeholder="Search event"
                                    />
                            </div>
                            <button class="ml-3 bg-gray-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200">
                                Search
                            </button>
                        </div>
                        <!-- Nút lọc -->
                        <div class="flex flex-1 ml-4 space-x-2">
                            <button class="flex-1 bg-gray-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200">
                                All
                            </button>
                            <button class="flex-1 bg-gray-600 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200">
                                Pending
                            </button>
                            <button class="flex-1 bg-gray-600 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200">
                                Upcoming
                            </button>
                            <button class="flex-1 bg-gray-600 text-white px-4 py-2 rounded-full hover:bg-green-600 transition duration-200">
                                Past
                            </button>
                        </div> 
                    </div>
                </section>
                <!-- Danh sách sự kiện -->
                <section class="flex-1 p-4 overflow-y-auto">
                    <div class="w-full p-4 space-y-6">
                        <!-- Thẻ sự kiện -->
                        <div class="bg-gray-800 rounded-lg shadow-lg overflow-hidden flex w-full">
                            <img alt="Event image" class="w-1/4 object-cover" src="https://storage.googleapis.com/a1aa/image/6h4zJKg-3_dGM5Ou6MDxb9-jMaCM9_XoDCQjw7nRFR4.jpg"/>
                            <div class="p-4 flex-1">
                                <h2 class="text-xl font-bold text-white cursor-pointer hover:text-gray-400" onclick="location.href = 'viewdetail.jsp'">
                                    Duplicate SWP391
                                </h2>
                                <div class="flex items-center text-green-400 mt-2">
                                    <i class="far fa-calendar-alt mr-2"></i>
                                    <span>03:19, Tuesday, Feb 25 2025</span>
                                </div>
                                <div class="flex items-center text-green-400 mt-2">
                                    <i class="fas fa-map-marker-alt mr-2"></i>
                                    <span>FPT Can Tho University</span>
                                </div>
                                <p class="text-gray-400 mt-2">
                                    Sample address, Tra Noc Ward, Binh Thuy District, Can Tho City
                                </p>
                                <!-- Nút chức năng -->
                                <div class="p-4 mt-4 grid grid-cols-2 sm:grid-cols-4 gap-4 text-center">
                                    <button type="button" onclick="location.href = 'eventOverview.jsp'" 
                                            class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                        <i class="fas fa-chart-pie text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Overview</span>
                                    </button>
                                    <button type="button" onclick="location.href = 'viewAllOrders.jsp'" 
                                            class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                        <i class="fas fa-list text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Orders</span>
                                    </button>
                                    <button type="button" onclick="location.href = '${pageContext.request.contextPath}/pages/seatSelectionPage/seatSelection.jsp'" 
                                            class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                        <i class="fas fa-chair text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Seating Chart</span>
                                    </button>
                                    <button type="button" onclick="location.href = '${pageContext.request.contextPath}/updateEvent'" 
                                            class="group flex items-center justify-center bg-transparent p-3 rounded-lg transition duration-200 cursor-pointer hover:bg-gray-700">
                                        <i class="fas fa-edit text-2xl text-green-400 mr-2 group-hover:text-white"></i>
                                        <span class="text-gray-400 group-hover:text-white">Update</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </main>
        </div>
    </body>
</html>