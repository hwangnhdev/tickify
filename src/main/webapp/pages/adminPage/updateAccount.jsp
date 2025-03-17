<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Account Detail</title>
    <!-- Tailwind CSS từ CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <jsp:include page="header.jsp">
      <jsp:param name="pageTitle" value="Customer Management" />
    </jsp:include>
    <style>
      .modal-overlay {
        background-color: rgba(55, 65, 81, 0.75); /* bg-gray-700 với opacity */
      }
    </style>
  </head>
  <body class="bg-gradient-to-r from-gray-100 to-gray-200 min-h-screen">
    <!-- View Detail Section -->
    <main class="container mx-auto p-6">
      <section class="bg-white rounded-xl shadow-xl p-8 max-w-4xl mx-auto">
        <!-- Header & Back Button -->
        <div class="flex justify-between items-center mb-6">
          <h1 class="text-3xl font-bold text-blue-700">Account Detail</h1>
          <a href="${pageContext.request.contextPath}/admin/viewAllCustomers" class="text-blue-600 hover:underline">
            <i class="fas fa-arrow-left"></i> Back to Customer List
          </a>
        </div>
        <!-- Profile Header -->
        <div class="flex flex-col items-center mb-6">
          <c:choose>
            <c:when test="${not empty customer.profilePicture}">
              <img src="${customer.profilePicture}" alt="Profile Picture" class="w-40 h-40 rounded-full border-4 border-blue-600 shadow-md">
            </c:when>
            <c:otherwise>
              <img src="${pageContext.request.contextPath}/images/default_profile.png" alt="Default Profile Picture" class="w-40 h-40 rounded-full border-4 border-blue-600 shadow-md">
            </c:otherwise>
          </c:choose>
          <h2 class="mt-4 text-3xl font-bold text-gray-800">${customer.fullName}</h2>
          <p class="text-gray-500">${customer.email}</p>
        </div>
        <!-- Account Details -->
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
          <div class="flex items-center">
            <span class="w-32 font-semibold text-gray-700">Customer ID:</span>
            <span class="text-gray-900">${customer.customerId}</span>
          </div>
          <div class="flex items-center">
            <span class="w-32 font-semibold text-gray-700">Address:</span>
            <span class="text-gray-900">
              <c:choose>
                <c:when test="${not empty customer.address}">${customer.address}</c:when>
                <c:otherwise>N/A</c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="flex items-center">
            <span class="w-32 font-semibold text-gray-700">Phone:</span>
            <span class="text-gray-900">
              <c:choose>
                <c:when test="${not empty customer.phone}">${customer.phone}</c:when>
                <c:otherwise>N/A</c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="flex items-center">
            <span class="w-32 font-semibold text-gray-700">Status:</span>
            <span class="text-gray-900">${customer.statusText}</span>
          </div>
        </div>
        <!-- Button Update Profile -->
        <div class="mt-6 text-center">
          <button id="openModalBtn" class="bg-blue-600 hover:bg-blue-800 text-white font-bold py-2 px-6 rounded transition duration-300">
            Update Profile
          </button>
        </div>
      </section>
    </main>

    <!-- Popup Modal Update Profile -->
    <div id="modal" class="fixed inset-0 z-50 flex items-center justify-center hidden" role="dialog" aria-modal="true">
      <div class="absolute inset-0 modal-overlay"></div>
      <div class="bg-white rounded-lg shadow-2xl transform transition-all sm:max-w-lg sm:w-full z-10">
        <div class="px-8 py-6">
          <div class="flex justify-between items-center">
            <h3 class="text-2xl font-semibold text-gray-800">Update Profile</h3>
            <button id="closeModalBtn" class="text-gray-600 hover:text-gray-800 text-3xl leading-none focus:outline-none" aria-label="Close modal">&times;</button>
          </div>
          <!-- Thông báo lỗi (nếu update không thành công) -->
          <c:if test="${not empty errors}">
            <div class="mt-4 p-4 bg-red-100 border border-red-400 text-red-800 rounded">
              <p class="font-bold mb-2">Update not successful. Please fix the errors below:</p>
              <ul class="list-disc list-inside">
                <c:forEach var="error" items="${errors}">
                  <li>${error}</li>
                </c:forEach>
              </ul>
            </div>
          </c:if>
          <!-- Form Update Profile -->
          <form action="${pageContext.request.contextPath}/admin/updateAccount" method="post" class="mt-6 space-y-4">
            <input type="hidden" name="customerId" value="${customer.customerId}" />
            <div>
              <label class="block text-gray-700 font-semibold mb-1">Full Name</label>
              <input type="text" name="fullName" value="${customer.fullName}" placeholder="Enter your full name" class="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-400" required>
            </div>
            <div>
              <label class="block text-gray-700 font-semibold mb-1">Email</label>
              <input type="email" name="email" value="${customer.email}" placeholder="user@example.com" class="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-400" required>
            </div>
            <div>
              <label class="block text-gray-700 font-semibold mb-1">Address</label>
              <input type="text" name="address" value="${customer.address}" placeholder="Enter your address" class="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
            </div>
            <div>
              <label class="block text-gray-700 font-semibold mb-1">Phone</label>
              <input type="text" name="phone" value="${customer.phone}" placeholder="Enter your phone number" class="w-full border border-gray-300 px-3 py-2 rounded focus:outline-none focus:ring-2 focus:ring-blue-400">
            </div>
            <div class="flex justify-end space-x-3 pt-4">
              <button type="button" id="modalCancelBtn" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded transition duration-200">
                Cancel
              </button>
              <button type="submit" class="bg-blue-600 hover:bg-blue-800 text-white font-bold py-2 px-4 rounded transition duration-200">
                Save Changes
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- JavaScript điều khiển Modal -->
    <script>
      const openModalBtn = document.getElementById('openModalBtn');
      const closeModalBtn = document.getElementById('closeModalBtn');
      const modalCancelBtn = document.getElementById('modalCancelBtn');
      const modal = document.getElementById('modal');

      function openModal() {
        modal.classList.remove('hidden');
        document.body.style.overflow = 'hidden';
      }

      function closeModal() {
        modal.classList.add('hidden');
        document.body.style.overflow = '';
      }

      openModalBtn.addEventListener('click', openModal);
      closeModalBtn.addEventListener('click', closeModal);
      modalCancelBtn.addEventListener('click', closeModal);

      // Tự động mở modal nếu có lỗi từ server
      <c:if test="${not empty errors}">
        document.addEventListener('DOMContentLoaded', openModal);
      </c:if>
    </script>
  </body>
</html>
