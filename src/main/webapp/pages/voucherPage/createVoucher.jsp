<%-- 
    Document   : createVoucher
    Created on : 1 Mar 2025, 23:20:53
    Author     : Dinh Minh Tien CE190701
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Tickify Organizer - Create Voucher</title>
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
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="eventOverview.jsp"><i class="fas fa-chart-pie mr-2"></i>Overview</a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="eventAnalyst.jsp"><i class="fas fa-chart-line mr-2"></i>Analyst</a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="editEvent.jsp"><i class="fas fa-edit mr-2"></i>Edit Event</a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="seatingChart.jsp"><i class="fas fa-chair mr-2"></i>Seat Map</a>
                    <a class="flex items-center text-white bg-green-700 p-2 rounded" href="VoucherController"><i class="fas fa-tags mr-2"></i>Voucher</a>
                    <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" href="orders.jsp"><i class="fas fa-list mr-2"></i>Order List</a>
                </nav>
            </aside>

            <!-- Main Content -->
            <main class="flex-1 flex flex-col">
                <!-- Header -->
                <header class="flex justify-between items-center bg-gray-800 p-4">
                    <h1 class="text-xl font-bold text-white">Create Voucher</h1>
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

                <!-- Create Form -->
                <section class="flex-1 p-6 overflow-y-auto">
                    <div class="bg-gray-800 rounded-lg shadow-lg p-6 w-full max-w-3xl mx-auto">
                        <!-- Back Button -->
                        <div class="mb-6">
                            <a href="ViewAllVouchersController" class="inline-flex items-center text-white hover:text-green-500 transition duration-200">
                                <svg class="w-6 h-6 mr-2" fill="currentColor" viewBox="0 0 1024 1024" xmlns="http://www.w3.org/2000/svg">
                                    <path d="M872 474H286.9l350.2-304c5.6-4.9 2.2-14-5.2-14h-88.5c-3.9 0-7.6 1.4-10.5 3.9L155 487.8a31.96 31.96 0 000 48.3L535.1 866c1.5 1.3 3.3 2 5.2 2h91.5c7.4 0 10.8-9.2 5.2-14L286.9 550H872c4.4 0 8-3.6 8-8v-60c0-4.4-3.6-8-8-8z"/>
                                </svg>
                                <span>Back to All Vouchers</span>
                            </a>
                        </div>

                        <form action="CreateVoucherController" method="post" class="space-y-6">
                            <input type="hidden" name="eventId" value="<%= request.getParameter("eventId") != null ? request.getParameter("eventId") : "" %>">

                            <!-- Basic Information -->
                            <div class="space-y-4">
                                <h2 class="text-lg font-semibold">Basic Information</h2>

                                <div>
                                    <label class="block text-sm font-medium text-white">Voucher code:</label>
                                    <input type="text" name="code" 
                                           class="mt-1 w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white focus:outline-none focus:ring-2 focus:ring-green-500"
                                           minlength="6" maxlength="20" required>
                                    <span class="text-xs text-gray-500">Only alphanumeric values are allowed (A-Z and 0-9), 6-20 characters</span>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-white">Voucher description:</label>
                                    <input type="text" name="description" 
                                           class="mt-1 w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white focus:outline-none focus:ring-2 focus:ring-green-500" 
                                           maxlength="80" required>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-white">Voucher expiration time:</label>
                                    <div class="flex space-x-2">
                                        <input type="datetime-local" name="startDate" 
                                               class="mt-1 w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white focus:outline-none focus:ring-2 focus:ring-green-500" required>
                                        <span class="mt-2">→</span>
                                        <input type="datetime-local" name="endDate" 
                                               class="mt-1 w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white focus:outline-none focus:ring-2 focus:ring-green-500" required>
                                    </div>
                                    <span class="text-xs text-gray-500">Select the start and end times for the voucher validity</span>
                                </div>
                            </div>

                            <!-- Voucher Settings -->
                            <div class="space-y-4">
                                <h2 class="text-lg font-semibold">Voucher Settings</h2>

                                <div>
                                    <label class="block text-sm font-medium text-white">Voucher type:</label>
                                    <select name="discountType" id="discountType"
                                            class="mt-1 w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white focus:outline-none focus:ring-2 focus:ring-green-500" required>
                                        <option value="fixed">Fixed Amount</option>
                                        <option value="percentage">Percentage</option>
                                    </select>
                                </div>

                                <div class="relative">
                                    <label class="block text-sm font-medium text-white">Discount value:</label>
                                    <div class="flex items-center mt-1">
                                        <input type="number" name="discountValue" id="discountValue" 
                                               class="w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white focus:outline-none focus:ring-2 focus:ring-green-500 pr-8" 
                                               required step="1" min="0">
                                        <span id="unit" class="absolute right-2 text-white pointer-events-none"></span>
                                    </div>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-white">Total number of tickets applied:</label>
                                    <input type="number" name="usageLimit" 
                                           class="mt-1 w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-lg text-white focus:outline-none focus:ring-2 focus:ring-green-500" 
                                           min="0" required>
                                    <span class="text-xs text-gray-500">Number of tickets that can be redeemed (must be ≥ 0)</span>
                                </div>

                                <div>
                                    <label class="block text-sm font-medium text-white">Activate:</label>
                                    <label class="relative inline-flex items-center cursor-pointer">
                                        <input type="checkbox" name="status" class="sr-only peer" value="true" checked>
                                        <div class="w-11 h-6 bg-gray-200 peer-focus:outline-none peer-focus:ring-4 peer-focus:ring-green-500 rounded-full peer peer-checked:after:translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:left-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-green-600"></div>
                                    </label>
                                    <input type="hidden" name="status" value="false">
                                    <br>
                                    <span class="text-xs text-gray-500">Off: Voucher cannot be used under any circumstances</span><br>
                                    <span class="text-xs text-gray-500">On: Voucher can be used during expiration time</span>
                                </div>
                            </div>

                            <div class="flex justify-end space-x-4">
                                <button type="button" onclick="location.href = 'ViewAllVouchersController'" 
                                        class="px-4 py-2 bg-gray-300 text-black rounded-lg hover:bg-white transition duration-200">Cancel</button>
                                <button type="submit" 
                                        class="px-4 py-2 bg-green-500 text-white rounded-lg hover:bg-green-600 transition duration-200">Create Voucher</button>
                            </div>
                        </form>
                        <% if (request.getAttribute("error") != null) { %>
                            <p class="text-red-500 mt-4"><%= request.getAttribute("error") %></p>
                        <% } %>
                    </div>
                </section>
            </main>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const discountType = document.getElementById('discountType');
                const discountValue = document.getElementById('discountValue');
                const unit = document.getElementById('unit');

                function updateUnit() {
                    if (discountType.value === 'percentage') {
                        unit.textContent = '%';
                        discountValue.setAttribute('min', '0');
                        discountValue.setAttribute('max', '100');
                        discountValue.value = discountValue.value ? Math.min(Math.max(parseFloat(discountValue.value), 0), 100).toFixed(2) : '';
                    } else {
                        unit.textContent = 'VND';
                        discountValue.removeAttribute('max');
                        discountValue.setAttribute('min', '0');
                    }
                }

                updateUnit();
                discountType.addEventListener('change', updateUnit);

                discountValue.addEventListener('input', function () {
                    if (discountType.value === 'percentage') {
                        this.value = Math.min(Math.max(parseFloat(this.value) || 0, 0), 100).toFixed(2);
                    }
                });
            });
        </script>
    </body>
</html>