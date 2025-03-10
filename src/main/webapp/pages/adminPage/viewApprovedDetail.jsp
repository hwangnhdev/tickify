<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Admin Approval – Event Detail - ${event.eventName}</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome & Google Fonts -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
  </head>
  <body class="bg-gray-100 font-roboto">
    <!-- Header -->
    <header class="bg-white shadow">
      <div class="max-w-7xl mx-auto px-4 py-6 flex justify-between items-center">
        <h1 class="text-3xl font-bold text-gray-900">Admin Approval Dashboard</h1>
        <nav>
          <ul class="flex space-x-4">
            <li><a href="/admin/dashboard" class="text-gray-600 hover:text-gray-900">Dashboard</a></li>
            <li><a href="/admin/pending" class="text-gray-600 hover:text-gray-900">Pending</a></li>
            <li><a href="/admin/approved" class="text-gray-600 hover:text-gray-900">Approved</a></li>
            <li><a href="/admin/rejected" class="text-gray-600 hover:text-gray-900">Rejected</a></li>
          </ul>
        </nav>
      </div>
    </header>

    <div class="flex">
      <!-- Sidebar -->
      <aside class="w-64 bg-gray-800 text-white min-h-screen">
        <div class="p-6">
          <h2 class="text-xl font-semibold">Admin Menu</h2>
          <ul class="mt-6 space-y-4">
            <li>
              <a href="/admin/pending" class="flex items-center hover:text-gray-300">
                <i class="fas fa-clock mr-2"></i>Pending Approvals
              </a>
            </li>
            <li>
              <a href="/admin/approved" class="flex items-center hover:text-gray-300">
                <i class="fas fa-check mr-2"></i>Approved Events
              </a>
            </li>
            <li>
              <a href="/admin/rejected" class="flex items-center hover:text-gray-300">
                <i class="fas fa-times mr-2"></i>Rejected Events
              </a>
            </li>
          </ul>
        </div>
      </aside>

      <!-- Main Content Area -->
      <main class="flex-1 p-6">
        <!-- Hero Banner -->
        <section class="relative mb-8">
          <img src="${bannerImage != null ? bannerImage : logoBannerImage}" alt="Event Banner" class="w-full h-64 object-cover rounded-lg shadow-md"/>
          <div class="absolute inset-0 bg-black bg-opacity-40 flex items-center justify-center">
            <h2 class="text-white text-4xl font-bold">${event.eventName}</h2>
          </div>
        </section>

        <!-- Event Detail Card -->
        <div class="bg-white rounded-lg shadow-lg p-8">
          <div class="flex flex-col md:flex-row">
            <!-- Left Column: Event Information -->
            <div class="md:w-2/3">
              <h2 class="text-2xl font-bold mb-4">${event.eventName}</h2>
              <p class="mb-2">
                <strong>Date:</strong>
                <c:if test="${not empty event.startDate}">
                  <fmt:formatDate value="${event.startDate}" pattern="dd/MM/yyyy" />
                </c:if>
                -
                <c:if test="${not empty event.endDate}">
                  <fmt:formatDate value="${event.endDate}" pattern="dd/MM/yyyy" />
                </c:if>
              </p>
              <p class="mb-2"><strong>Location:</strong> ${event.location}</p>
              <p class="mb-2"><strong>Category:</strong> ${event.categoryName}</p>
              <p class="mb-2"><strong>Organization:</strong> ${event.organizationName}</p>
              <p class="mb-2"><strong>Event Type:</strong> ${event.eventType}</p>
              <p class="mb-2"><strong>Status:</strong> ${event.status}</p>
              <div class="mb-4">
                <strong>Description:</strong>
                <p class="mt-2 text-gray-700">${event.description}</p>
              </div>
              <p class="mb-2">
                <strong>Created At:</strong>
                <c:if test="${not empty event.createdAt}">
                  <fmt:formatDate value="${event.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                </c:if>
              </p>
              <p class="mb-2">
                <strong>Updated At:</strong>
                <c:if test="${not empty event.updatedAt}">
                  <fmt:formatDate value="${event.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
                </c:if>
              </p>
              <p class="mb-2">
                <strong>Approved At:</strong>
                <c:if test="${not empty event.approvedAt}">
                  <fmt:formatDate value="${event.approvedAt}" pattern="dd/MM/yyyy HH:mm" />
                </c:if>
              </p>
            </div>
            <!-- Right Column: Event Images -->
            <div class="md:w-1/3 flex flex-col items-center md:items-end mt-6 md:mt-0">
              <div class="mb-4 w-full">
                <p class="text-gray-600 font-semibold text-center">Banner</p>
                <img src="${logoBannerImage}" alt="Logo Banner" class="w-full h-auto rounded-lg shadow-md" />
              </div>
              <div class="mb-4 w-full">
                <p class="text-gray-600 font-semibold text-center">Event</p>
                <img src="${logoEventImage}" alt="Logo Event" class="w-full h-auto rounded-lg shadow-md" />
              </div>
              <div class="mb-4 w-full">
                <p class="text-gray-600 font-semibold text-center">Organizer</p>
                <img src="${logoOrganizerImage}" alt="Logo Organizer" class="w-full h-auto rounded-lg shadow-md" />
              </div>
            </div>
          </div>
          <!-- Approval Actions -->
          <div class="mt-8 flex justify-end space-x-4">
            <button class="bg-red-600 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
              Reject
            </button>
            <button class="bg-green-600 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
              Approve
            </button>
          </div>
        </div>
      </main>
    </div>

    <!-- Footer -->
    <footer class="bg-white">
      <div class="max-w-7xl mx-auto py-4 px-4 sm:px-6 lg:px-8 text-center text-gray-600">
        &copy; 2025 Your Company. All rights reserved.
      </div>
    </footer>
  </body>
</html>
