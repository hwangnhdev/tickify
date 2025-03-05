<%@page import="models.Voucher"%>
<%@page import="java.util.List"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Tickify Organizer - Vouchers</title>
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
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="eventOverview.jsp">
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
                    <a class="flex items-center text-white bg-green-700 p-2 rounded" href="listVoucher.jsp">
                        <i class="fas fa-tags mr-2"></i>Voucher
                    </a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="orders.jsp">
                        <i class="fas fa-list mr-2"></i>Order List
                    </a>
                </nav>
            </aside>


            <!-- Main Content -->
            <main class="flex-1 flex flex-col">
                <!-- Header -->
                <header class="flex justify-between items-center bg-gray-800 p-4">
                    <h1 class="text-xl font-bold">Vouchers</h1>
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

                <!-- Voucher Content -->
                <section class="flex-1 p-4 overflow-y-auto">
                    <div class="w-full p-4 space-y-6">
                        <div class="flex justify-between items-center mb-4">
                            <div class="flex items-center space-x-4">
                                <input type="text" class="w-64 px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-green-500" placeholder="Search by Voucher code" />
                            </div>
                            <div class="flex items-center space-x-4">
                                <button onclick="location.href = 'CreateVoucherController'" class="bg-green-500 text-white px-4 py-2 rounded-lg hover:bg-green-600 transition duration-200">Create voucher</button>
                            </div>
                        </div>

                        <div class="bg-gray-800 rounded-lg shadow-lg p-4">
                            <table class="w-full text-left border-collapse">
                                <thead>
                                    <tr class="bg-gray-700">
                                        <th class="py-3 px-4 border-b border-gray-600 text-center">Voucher code</th>
                                        <th class="py-3 px-4 border-b border-gray-600 text-center">Voucher description</th>
                                        <th class="py-3 px-4 border-b border-gray-600 text-center">Expiration time</th>
                                        <th class="py-3 px-4 border-b border-gray-600 text-center">Status</th>
                                        <th class="py-3 px-4 border-b border-gray-600 text-center">Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        List<Voucher> vouchers = (List<Voucher>) request.getAttribute("vouchers");
                                        if (vouchers != null && !vouchers.isEmpty()) {
                                            for (Voucher v : vouchers) {
                                    %>
                                    <tr class="hover:bg-gray-700 transition duration-200">
                                        <td class="py-3 px-4 border-b border-gray-600 text-center"><%= v.getCode()%></td>
                                        <td class="py-3 px-4 border-b border-gray-600 text-center"><%= v.getDescription()%></td>
                                        <td class="py-3 px-4 border-b border-gray-600 text-center"><%= v.getFormattedExpirationTime()%></td>
                                        <td class="py-3 px-4 border-b border-gray-600 text-center">
                                            <div class="flex flex-col items-center">
                                                <span class="<%= v.isStatus() ? "text-green-500" : "text-red-500"%> font-bold">
                                                    <%= v.isStatus() ? "Active" : "Inactive"%>
                                                </span>
                                                <span class="<%= v.getStatusLabel().equals("Ongoing") ? "text-green-500" : "text-red-500"%> font-bold">
                                                    <%= v.getStatusLabel()%>
                                                </span>
                                            </div>
                                        </td>
                                        <td class="py-3 px-4 border-b border-gray-600">
                                            <div class="flex items-center space-x-2">
                                                <button onclick="location.href = 'VoucherController?voucherId=<%= v.getVoucherId()%>'" 
                                                        class="text-white bg-gray-600 hover:bg-gray-700 px-2 py-1 rounded-lg transition duration-200">Edit</button>
                                                <button class="text-white bg-gray-600 hover:bg-gray-700 px-2 py-1 rounded-lg transition duration-200">Delete</button>
                                            </div>
                                        </td>
                                    </tr>
                                    <% }
                                    } else { %>
                                    <tr>
                                        <td colspan="5" class="py-3 px-4 text-center border-b border-gray-600">No vouchers available</td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </section>
            </main>
        </div>
    </body>
</html>