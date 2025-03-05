<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>
            Admin Dashboard
        </title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen">
            <!-- Sidebar -->
            <div class="bg-gradient-to-b from-blue-900 to-blue-700 text-white w-64 p-6 flex flex-col">
                <div class="flex items-center mb-8">
                    <i class="fas fa-cogs text-3xl mr-3"></i>
                    <span class="text-2xl font-bold">
                        Admin Panel
                    </span>
                </div>
                <nav class="flex-1">
                    <ul>
                        <li class="mb-4">
                            <a class="flex items-center p-2 rounded hover:bg-blue-800" href="#">
                                <i class="fas fa-home mr-3"></i>
                                Home
                            </a>
                        </li>
                        <li class="mb-4">
                            <a class="flex items-center p-2 rounded hover:bg-blue-800" href="#">
                                <i class="fas fa-tachometer-alt mr-3"></i>
                                Dashboard
                            </a>
                        </li>
                        <li class="mb-4">
                            <a class="flex items-center p-2 rounded hover:bg-blue-800" href="#">
                                <i class="fas fa-users mr-3"></i>
                                Manage Users
                            </a>
                        </li>
                        <li class="mb-4">
                            <a class="flex items-center p-2 rounded hover:bg-blue-800" href="#">
                                <i class="fas fa-calendar-alt mr-3"></i>
                                Manage Events
                            </a>
                        </li>
                        <li class="mb-4">
                            <a class="flex items-center p-2 rounded hover:bg-blue-800" href="#">
                                <i class="fas fa-chart-line mr-3"></i>
                                Manage Revenue
                            </a>
                        </li>
                        <li class="mb-4">
                            <a class="flex items-center p-2 rounded hover:bg-blue-800" href="#">
                                <i class="fas fa-cog mr-3"></i>
                                Settings
                            </a>
                        </li>
                    </ul>
                </nav>
                <div class="mt-auto">
                    <div class="flex items-center space-x-2 mb-4">
                        <img alt="User avatar" class="rounded-full w-10 h-10" height="40" src="https://storage.googleapis.com/a1aa/image/gs8rTrxL87my4PShzKcXjAQerwQ9S-Cb5WerTbhOZFE.jpg" width="40"/>
                        <span>
                            Admin
                        </span>
                    </div>
                    <a class="flex items-center p-2 rounded hover:bg-blue-800" href="#">
                        <i class="fas fa-sign-out-alt mr-3"></i>
                        Logout
                    </a>
                </div>
            </div>
            <!-- Main Content -->
            <div class="flex-1 p-6">
                <!-- Dashboard Overview -->
                <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h2 class="text-xl font-bold mb-4">
                            Total Users
                        </h2>
                        <p class="text-3xl">
                            1,234
                        </p>
                    </div>
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h2 class="text-xl font-bold mb-4">
                            Pending Events
                        </h2>
                        <p class="text-3xl">
                            56
                        </p>
                    </div>
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h2 class="text-xl font-bold mb-4">
                            Recent Orders
                        </h2>
                        <p class="text-3xl">
                            789
                        </p>
                    </div>
                </div>
                <!-- Alerts -->
                <div class="bg-white p-6 rounded-lg shadow mb-6">
                    <h2 class="text-xl font-bold mb-4">
                        Alerts
                    </h2>
                    <p>
                        No new alerts
                    </p>
                </div>
                <!-- User Management -->
                <div class="bg-white p-6 rounded-lg shadow mb-6">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-xl font-bold">
                            User Management
                        </h2>
                        <button class="bg-blue-600 text-white py-2 px-4 rounded">
                            Add New User
                        </button>
                    </div>
                    <div class="relative mb-4">
                        <input class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" placeholder="Search users" type="text"/>
                        <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                    </div>
                    <table class="w-full text-left">
                        <thead>
                            <tr>
                                <th class="py-2">
                                    Name
                                </th>
                                <th class="py-2">
                                    Email
                                </th>
                                <th class="py-2">
                                    Status
                                </th>
                                <th class="py-2">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="border-t">
                                <td class="py-2">
                                    John Doe
                                </td>
                                <td class="py-2">
                                    john@example.com
                                </td>
                                <td class="py-2">
                                    Active
                                </td>
                                <td class="py-2">
                                    <button class="text-gray-500 hover:text-gray-700">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="text-red-500 hover:text-red-700 ml-2">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr class="border-t">
                                <td class="py-2">
                                    Jane Smith
                                </td>
                                <td class="py-2">
                                    jane@example.com
                                </td>
                                <td class="py-2">
                                    Inactive
                                </td>
                                <td class="py-2">
                                    <button class="text-gray-500 hover:text-gray-700">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="text-red-500 hover:text-red-700 ml-2">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- Event Management -->
                <div class="bg-white p-6 rounded-lg shadow mb-6">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-xl font-bold">
                            Event Management
                        </h2>
                        <button class="bg-blue-600 text-white py-2 px-4 rounded">
                            Add New Event
                        </button>
                    </div>
                    <div class="relative mb-4">
                        <input class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" placeholder="Search events" type="text"/>
                        <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                    </div>
                    <table class="w-full text-left">
                        <thead>
                            <tr>
                                <th class="py-2">
                                    Event Name
                                </th>
                                <th class="py-2">
                                    Date
                                </th>
                                <th class="py-2">
                                    Status
                                </th>
                                <th class="py-2">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="border-t">
                                <td class="py-2">
                                    Music Concert
                                </td>
                                <td class="py-2">
                                    12 Nov 2024
                                </td>
                                <td class="py-2">
                                    Pending
                                </td>
                                <td class="py-2">
                                    <button class="text-green-500 hover:text-green-700">
                                        <i class="fas fa-check"></i>
                                    </button>
                                    <button class="text-red-500 hover:text-red-700 ml-2">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr class="border-t">
                                <td class="py-2">
                                    Art Exhibition
                                </td>
                                <td class="py-2">
                                    15 Nov 2024
                                </td>
                                <td class="py-2">
                                    Approved
                                </td>
                                <td class="py-2">
                                    <button class="text-gray-500 hover:text-gray-700">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="text-red-500 hover:text-red-700 ml-2">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- Revenue Management -->
                <div class="bg-white p-6 rounded-lg shadow mb-6">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-xl font-bold">
                            Revenue Management
                        </h2>
                    </div>
                    <div class="relative mb-4">
                        <input class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" placeholder="Search revenue reports" type="text"/>
                        <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                    </div>
                    <table class="w-full text-left">
                        <thead>
                            <tr>
                                <th class="py-2">
                                    Report Name
                                </th>
                                <th class="py-2">
                                    Date
                                </th>
                                <th class="py-2">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="border-t">
                                <td class="py-2">
                                    Monthly Revenue
                                </td>
                                <td class="py-2">
                                    Nov 2024
                                </td>
                                <td class="py-2">
                                    <button class="text-gray-500 hover:text-gray-700">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr class="border-t">
                                <td class="py-2">
                                    Annual Revenue
                                </td>
                                <td class="py-2">
                                    2024
                                </td>
                                <td class="py-2">
                                    <button class="text-gray-500 hover:text-gray-700">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <!-- Voucher and Category Management -->
                <div class="bg-white p-6 rounded-lg shadow mb-6">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-xl font-bold">
                            Voucher and Category Management
                        </h2>
                        <button class="bg-blue-600 text-white py-2 px-4 rounded">
                            Add New Category
                        </button>
                    </div>
                    <div class="relative mb-4">
                        <input class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" placeholder="Search categories" type="text"/>
                        <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                    </div>
                    <table class="w-full text-left">
                        <thead>
                            <tr>
                                <th class="py-2">
                                    Category Name
                                </th>
                                <th class="py-2">
                                    Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="border-t">
                                <td class="py-2">
                                    Music
                                </td>
                                <td class="py-2">
                                    <button class="text-gray-500 hover:text-gray-700">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="text-red-500 hover:text-red-700 ml-2">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                            <tr class="border-t">
                                <td class="py-2">
                                    Art
                                </td>
                                <td class="py-2">
                                    <button class="text-gray-500 hover:text-gray-700">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="text-red-500 hover:text-red-700 ml-2">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <!-- Toast Notification -->
        <div class="fixed bottom-4 right-4 bg-green-500 text-white p-4 rounded-lg shadow-lg hidden" id="toast">
            <p id="toast-message">
                Action successful!
            </p>
        </div>
        <script>
            // Example function to show toast notification
            function showToast(message) {
                const toast = document.getElementById('toast');
                const toastMessage = document.getElementById('toast-message');
                toastMessage.textContent = message;
                toast.classList.remove('hidden');
                setTimeout(() => {
                    toast.classList.add('hidden');
                }, 3000);
            }
        </script>
    </body>
</html>
