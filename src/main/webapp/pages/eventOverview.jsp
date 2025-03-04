<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

                    <a class="flex items-center text-white bg-green-700 p-2 rounded" href="eventOverview.jsp">
                        <i class="fas fa-chart-pie mr-2"></i>Overview
                    </a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="eventAnalyst.jsp">
                        <i class="fas fa-chart-line mr-2"></i>Analyst
                    </a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="editEvent.jsp">
                        <i class="fas fa-edit mr-2"></i>Edit Event
                    </a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="seatingChart.jsp">
                        <i class="fas fa-chair mr-2"></i>Seat Map
                    </a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="vouchers.jsp">
                        <i class="fas fa-tags mr-2"></i>Voucher
                    </a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="/Tickify/organizerOrders">
                        <i class="fas fa-list mr-2"></i>Order List
                    </a>
                </nav>
            </aside>
            <!-- Main Content -->
            <main class="flex-1 flex flex-col">
                <!-- Header -->
                <header class="flex justify-between items-center bg-gray-800 p-4">
                    <h1 class="text-xl font-bold">Event Overview</h1>
                    <div class="flex items-center space-x-4">
                        <button type="button" onclick="location.href = 'createEvent.jsp'" class="bg-green-500 text-white px-6 py-3 rounded-full shadow-lg hover:bg-green-600 transition duration-200">
                            + Create Event
                        </button>
                        <button class="flex items-center text-white">
                            <img alt="User avatar" class="mr-2 rounded-full" height="30" src="https://storage.googleapis.com/a1aa/image/_qCewoK0KXQhWyQzRe9zG7PpYaYijDdWdPLzWZ3kkg8.jpg" width="30"/>
                            My Account
                        </button>
                    </div>
                </header>
                <!-- Nội dung chính: Thống kê sự kiện -->
                <section class="flex-1 p-4 overflow-y-auto">
                    <div class="w-full p-4 space-y-6">
                        <!-- Các widget hiển thị số liệu thống kê -->
                        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                            <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                                <h3 class="text-lg font-bold text-green-400">Total Revenue</h3>
                                <p class="text-3xl font-bold text-white mt-2">$12,345</p>
                            </div>
                            <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                                <h3 class="text-lg font-bold text-green-400">Tickets Sold</h3>
                                <p class="text-3xl font-bold text-white mt-2">567</p>
                            </div>
                            <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                                <h3 class="text-lg font-bold text-green-400">Tickets Remaining</h3>
                                <p class="text-3xl font-bold text-white mt-2">123</p>
                            </div>
                            <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                                <h3 class="text-lg font-bold text-green-400">Fill Rate</h3>
                                <p class="text-3xl font-bold text-white mt-2">82%</p>
                            </div>
                        </div>
                        <!-- Biểu đồ doanh thu -->
                        <div class="bg-gray-800 rounded-lg shadow-lg p-6 mt-6">
                            <h3 class="text-lg font-bold text-green-400">Revenue Over Time</h3>
                            <div class="h-64 bg-gray-700 rounded mt-4">
                                <!-- Có thể tích hợp Chart.js để hiển thị biểu đồ thực tế -->
                            </div>
                        </div>
                    </div>
                </section>
            </main>
        </div>
    </body>
</html>