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
      /* Custom styles */
      .profile-badge {
        position: absolute;
        bottom: 0;
        right: 0;
        background-color: #6366F1; /* Indigo-500 */
        color: white;
        font-size: 0.75rem;
        padding: 0.25rem 0.5rem;
        border-radius: 9999px;
      }
    </style>
  </head>
  <body class="bg-gradient-to-r from-gray-100 to-gray-200 min-h-screen">
    <main class="container mx-auto p-6">
      <section class="bg-white rounded-xl shadow-xl p-8 max-w-4xl mx-auto text-center">
        <!-- Tiêu đề và nút Back -->
        <div class="flex justify-between items-center mb-6">
          <h1 class="text-3xl font-bold text-blue-700">Account Detail</h1>
          <a href="${pageContext.request.contextPath}/admin/viewAllCustomers" class="text-blue-600 hover:underline">
            <i class="fas fa-arrow-left"></i> Back to Customer List
          </a>
        </div>
        <!-- Profile Header -->
        <div class="relative flex flex-col items-center mb-6">
          <c:choose>
            <c:when test="${not empty customer.profilePicture}">
              <img src="${customer.profilePicture}" alt="Profile Picture" class="w-40 h-40 rounded-full border-4 border-indigo-500 shadow-lg transition-transform duration-300 hover:scale-110">
            </c:when>
            <c:otherwise>
              <img src="${pageContext.request.contextPath}/images/default_profile.png" alt="Default Profile Picture" class="w-40 h-40 rounded-full border-4 border-indigo-500 shadow-lg transition-transform duration-300 hover:scale-110">
            </c:otherwise>
          </c:choose>
          <h2 class="mt-4 text-3xl font-bold text-gray-800">${customer.fullName}</h2>
          <p class="text-gray-500">${customer.email}</p>
        </div>
        <!-- Account Details -->
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-6">
          <div class="flex items-center justify-center">
            <span class="w-32 font-semibold text-gray-700">Customer ID:</span>
            <span class="text-gray-900">${customer.customerId}</span>
          </div>
          <div class="flex items-center justify-center">
            <span class="w-32 font-semibold text-gray-700">Address:</span>
            <span class="text-gray-900">
              <c:choose>
                <c:when test="${not empty customer.address}">
                  ${customer.address}
                </c:when>
                <c:otherwise>N/A</c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="flex items-center justify-center">
            <span class="w-32 font-semibold text-gray-700">Phone:</span>
            <span class="text-gray-900">
              <c:choose>
                <c:when test="${not empty customer.phone}">
                  ${customer.phone}
                </c:when>
                <c:otherwise>N/A</c:otherwise>
              </c:choose>
            </span>
          </div>
          <div class="flex items-center justify-center">
            <span class="w-32 font-semibold text-gray-700">Status:</span>
            <span class="text-gray-900">${customer.statusText}</span>
          </div>
        </div>
        <!-- Nút Update Profile -->
        <div class="mt-6">
          <button id="openModalBtn" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded transition-all duration-300">
            Update Profile
          </button>
        </div>
      </section>
    </main>

    <!-- Modal Popup cho Update Profile (Modern UX) -->
    <div id="modal" class="fixed inset-0 z-50 overflow-y-auto hidden" role="dialog" aria-modal="true">
      <div class="flex items-center justify-center min-h-screen px-4">
        <!-- Modal overlay -->
        <div class="fixed inset-0 bg-gray-700 bg-opacity-75 transition-opacity"></div>
        <!-- Modal content -->
        <div class="relative bg-white rounded-lg shadow-xl transform transition-all sm:max-w-lg sm:w-full z-10">
          <div class="px-6 py-4">
            <div class="flex justify-between items-center">
              <h3 class="text-xl font-semibold text-gray-800" id="modal-title">Update Profile</h3>
              <button id="closeModalBtn" class="text-gray-600 hover:text-gray-800 focus:outline-none" aria-label="Close modal">&times;</button>
            </div>
            <!-- Hiển thị lỗi nếu có -->
            <c:if test="${not empty errors}">
              <div class="mt-4 p-3 bg-red-100 border border-red-400 text-red-700 rounded">
                <ul>
                  <c:forEach var="error" items="${errors}">
                    <li>${error}</li>
                  </c:forEach>
                </ul>
              </div>
            </c:if>
            <!-- Form cập nhật thông tin cá nhân -->
            <form action="${pageContext.request.contextPath}/admin/updateAccount" method="post" class="mt-4">
              <input type="hidden" name="customerId" value="${customer.customerId}" />
              <div class="mb-4">
                <label class="block text-gray-700 font-semibold">Full Name</label>
                <input type="text" name="fullName" value="${customer.fullName}" class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300" required>
              </div>
              <div class="mb-4">
                <label class="block text-gray-700 font-semibold">Email</label>
                <input type="email" name="email" value="${customer.email}" class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300" required>
              </div>
              <div class="mb-4">
                <label class="block text-gray-700 font-semibold">Address</label>
                <input type="text" name="address" value="${customer.address}" class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
              </div>
              <div class="mb-4">
                <label class="block text-gray-700 font-semibold">Phone</label>
                <input type="text" name="phone" value="${customer.phone}" class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
              </div>
              <div class="flex justify-end space-x-3">
                <button type="button" id="modalCancelBtn" class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded transition-colors duration-200">
                  Cancel
                </button>
                <button type="submit" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded transition-colors duration-200">
                  Save Changes
                </button>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>

    <!-- JavaScript để điều khiển Modal -->
    <script>
      const openModalBtn = document.getElementById('openModalBtn');
      const closeModalBtn = document.getElementById('closeModalBtn');
      const modalCancelBtn = document.getElementById('modalCancelBtn');
      const modal = document.getElementById('modal');

      // Mở modal và khoá cuộn nền
      openModalBtn.addEventListener('click', () => {
        modal.classList.remove('hidden');
        document.body.style.overflow = 'hidden';
      });

      // Hàm đóng modal và mở cuộn lại
      function closeModal() {
        modal.classList.add('hidden');
        document.body.style.overflow = '';
      }

      // Đóng modal khi nhấn nút "X" hoặc "Cancel"
      closeModalBtn.addEventListener('click', closeModal);
      modalCancelBtn.addEventListener('click', closeModal);
    </script>
  </body>
</html>
