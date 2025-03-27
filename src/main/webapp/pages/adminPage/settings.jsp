<%-- 
    Document   : settings
    Created on : 25 Mar 2025, 17:10:12
    Author     : Dinh Minh Tien CE190701
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Change Admin Password</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Inter', sans-serif;
            }
        </style>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen">
            <jsp:include page="sidebar.jsp" />
            <div class="flex-1 p-6">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Change Password</h2>

                    <!-- Success/Error Messages -->
                    <c:if test="${not empty message}">
                        <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                            <p>${message}</p>
                        </div>
                    </c:if>
                    <c:if test="${not empty error}">
                        <div class="bg-red-100 border-l-4 border-red-500 text-red-700 p-4 mb-6" role="alert">
                            <p>${error}</p>
                        </div>
                    </c:if>

                    <!-- Change Password Form -->
                    <form action="settings" method="POST" class="space-y-6">
                        <div>
                            <label for="currentPassword" class="block text-sm font-medium text-gray-700">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword" 
                                   class="mt-1 block w-1/2 px-2 py-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 text-sm" 
                                   required>
                        </div>

                        <div>
                            <label for="newPassword" class="block text-sm font-medium text-gray-700">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" 
                                   class="mt-1 block w-1/2 px-2 py-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 text-sm" 
                                   required>
                        </div>

                        <div>
                            <label for="confirmPassword" class="block text-sm font-medium text-gray-700">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" 
                                   class="mt-1 block w-1/2 px-2 py-1 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-blue-500 focus:border-blue-500 text-sm" 
                                   required>
                        </div>

                        <div class="flex justify-end space-x-4">
                            <button type="submit" 
                                    class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                Change Password
                            </button>
                            <a href="adminDashboard" 
                               class="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500">
                                Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>