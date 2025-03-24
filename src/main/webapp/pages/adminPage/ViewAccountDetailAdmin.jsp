<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0"
    />
    <title>Account Details</title>
    <!-- Tailwind CSS từ CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- jQuery cho AJAX -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- SweetAlert2 cho thông báo -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <!-- Heroicons (nếu muốn dùng icon) -->
    <script src="https://unpkg.com/heroicons@1.0.6/dist/heroicons.js"></script>

    <!-- Include header (nav, logo, etc.) -->
    <jsp:include page="header.jsp">
      <jsp:param name="pageTitle" value="Customer Management" />
    </jsp:include>

    <style>
      /* Gradient background toàn trang */
      body {
        background: white(to bottom right, #dbeafe, #fef9c3);
      }
      /* Modal overlay */
      .modal-overlay {
        background-color: rgba(55, 65, 81, 0.85);
      }
      .fadeIn {
        animation: fadeIn 0.3s ease-in-out;
      }
      @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
      }
    </style>
  </head>
  <body class="font-sans antialiased">
    <!-- Bọc toàn bộ nội dung trong 1 flex để canh giữa -->
    <div class="min-h-screen flex flex-col">
     
      <!-- Phần chính -->
      <div class="flex-1 flex items-center justify-center p-6">
        <!-- Card chính -->
        <div class="w-full max-w-3xl bg-white rounded-xl shadow-lg p-8">
          <!-- Tiêu đề -->
          <h2 class="text-3xl font-bold text-gray-800 text-center mb-8">
            Account Details
          </h2>

          <!-- Profile Section -->
          <div class="flex flex-col items-center">
            <c:choose>
              <c:when test="${not empty customer.profilePicture}">
                <img
                  src="${customer.profilePicture}"
                  alt="Profile Picture"
                  class="w-40 h-40 rounded-full border-4 border-blue-500 shadow-md"
                />
              </c:when>
              <c:otherwise>
                <img
                  src="${pageContext.request.contextPath}/images/default_profile.png"
                  alt="Default Profile Picture"
                  class="w-40 h-40 rounded-full border-4 border-blue-500 shadow-md"
                />
              </c:otherwise>
            </c:choose>
            <h2
              id="displayFullName"
              class="mt-4 text-3xl font-bold text-gray-900"
            >
              ${customer.fullName}
            </h2>
            <p id="displayEmail" class="text-gray-600">
              ${customer.email}
            </p>
          </div>

          <!-- Account Details (Table/Card style) -->
          <div class="mt-8">
            <table class="w-full">
              <tbody>
                <!-- Customer ID -->
                <tr class="border-b last:border-b-0">
                  <td class="py-3">
                    <div class="flex items-center space-x-2">
                      <!-- Icon Heroicons -->
                      <svg
                        class="w-5 h-5 text-blue-600"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M13 16h-1v-4h-1m2 4v-4m4-2h.01M4 6h16M4 10h16M4 14h16M4 18h16"
                        ></path>
                      </svg>
                      <span class="text-gray-700 font-medium">Customer ID</span>
                    </div>
                  </td>
                  <td
                    id="displayCustomerId"
                    class="py-3 text-gray-900 text-right"
                  >
                    ${customer.customerId}
                  </td>
                </tr>

                <!-- Address -->
                <tr class="border-b last:border-b-0">
                  <td class="py-3">
                    <div class="flex items-center space-x-2">
                      <svg
                        class="w-5 h-5 text-green-600"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M17.657 16.657L13.414 12m0 0L9.172 7.757m4.242 4.243l4.243-4.243M13.414 12l4.243 4.243M7 7h.01M7 12h.01M7 17h.01"
                        ></path>
                      </svg>
                      <span class="text-gray-700 font-medium">Address</span>
                    </div>
                  </td>
                  <td
                    id="displayAddress"
                    class="py-3 text-gray-900 text-right"
                  >
                    <c:choose>
                      <c:when test="${not empty customer.address}">
                        ${customer.address}
                      </c:when>
                      <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                  </td>
                </tr>

                <!-- Phone -->
                <tr class="border-b last:border-b-0">
                  <td class="py-3">
                    <div class="flex items-center space-x-2">
                      <svg
                        class="w-5 h-5 text-indigo-600"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M3 5h2m4 0h2m4 0h2m4 0h2m-6 6h2m-2 4h2m-6 0h2m-2 4h2m-6-8h2m-2 4h2m-6 0h2m-2 4h2"
                        ></path>
                      </svg>
                      <span class="text-gray-700 font-medium">Phone</span>
                    </div>
                  </td>
                  <td
                    id="displayPhone"
                    class="py-3 text-gray-900 text-right"
                  >
                    <c:choose>
                      <c:when test="${not empty customer.phone}">
                        ${customer.phone}
                      </c:when>
                      <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                  </td>
                </tr>

                <!-- Birth Date -->
                <tr class="border-b last:border-b-0">
                  <td class="py-3">
                    <div class="flex items-center space-x-2">
                      <svg
                        class="w-5 h-5 text-pink-600"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M8 7V3m8 4V3M3 11h18M5 19h14a2 2 0 002-2v-5H3v5a2 2 0 002 2z"
                        ></path>
                      </svg>
                      <span class="text-gray-700 font-medium">Birth Date</span>
                    </div>
                  </td>
                  <td
                    id="displayDob"
                    class="py-3 text-gray-900 text-right"
                  >
                    <c:choose>
                      <c:when test="${not empty customer.dob}">
                        <fmt:formatDate value="${customer.dob}" pattern="yyyy-MM-dd"/>
                      </c:when>
                      <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                  </td>
                </tr>

                <!-- Gender -->
                <tr class="border-b last:border-b-0">
                  <td class="py-3">
                    <div class="flex items-center space-x-2">
                      <svg
                        class="w-5 h-5 text-red-600"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M11 11V9m2 2v2m-2-2h2m2-5a2 2 0 100-4 2 2 0 000 4zM7 7h.01M3 21h18"
                        ></path>
                      </svg>
                      <span class="text-gray-700 font-medium">Gender</span>
                    </div>
                  </td>
                  <td
                    id="displayGender"
                    class="py-3 text-gray-900 text-right"
                  >
                    <c:choose>
                      <c:when test="${not empty customer.gender}">
                        ${customer.gender}
                      </c:when>
                      <c:otherwise>N/A</c:otherwise>
                    </c:choose>
                  </td>
                </tr>

                <!-- Status -->
                <tr>
                  <td class="py-3">
                    <div class="flex items-center space-x-2">
                      <svg
                        class="w-5 h-5 text-gray-700"
                        fill="none"
                        stroke="currentColor"
                        viewBox="0 0 24 24"
                        xmlns="http://www.w3.org/2000/svg"
                      >
                        <path
                          stroke-linecap="round"
                          stroke-linejoin="round"
                          stroke-width="2"
                          d="M9 12l2 2l4 -4M7 20h10a2 2 0 002-2v-5a9 9 0 10-14 0v5a2 2 0 002 2z"
                        ></path>
                      </svg>
                      <span class="text-gray-700 font-medium">Status</span>
                    </div>
                  </td>
                  <td
                    id="displayStatus"
                    class="py-3 text-gray-900 text-right"
                  >
                    ${customer.statusText}
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <!-- Update Profile Button -->
          <div class="mt-8 text-center">
            <button
              id="openModalBtn"
              class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded transition duration-300 focus:outline-none"
            >
              Update Profile
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal for Profile Update -->
    <div
      id="modal"
      class="fixed inset-0 z-50 flex items-center justify-center hidden fadeIn"
      role="dialog"
      aria-modal="true"
    >
      <div class="absolute inset-0 modal-overlay"></div>
      <div
        class="bg-white rounded-lg shadow-xl transform transition-all sm:max-w-lg sm:w-full relative z-10"
      >
        <div class="px-8 py-6">
          <div class="flex justify-between items-center">
            <h3 class="text-2xl font-semibold text-gray-800">
              Update Profile
            </h3>
            <button
              id="closeModalBtn"
              class="text-gray-600 hover:text-gray-800 text-3xl focus:outline-none"
              aria-label="Close modal"
            >
              &times;
            </button>
          </div>
          <!-- Notification Area -->
          <div id="serverError"></div>
          <!-- Profile Update Form -->
          <form id="updateForm" class="mt-4">
            <input
              type="hidden"
              name="customerId"
              value="${customer.customerId}"
            />

            <!-- Full Name -->
            <div class="mb-4">
              <label class="block text-gray-700 font-semibold">Full Name</label>
              <input
                type="text"
                name="fullName"
                value="${customer.fullName}"
                maxlength="50"
                class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300"
                required
              />
            </div>

            <!-- Email -->
            <div class="mb-4">
              <label class="block text-gray-700 font-semibold">Email</label>
              <input
                type="email"
                name="email"
                value="${customer.email}"
                maxlength="100"
                class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300"
                required
              />
            </div>

            <!-- Address -->
            <div class="mb-4">
              <label class="block text-gray-700 font-semibold">Address</label>
              <input
                type="text"
                name="address"
                value="${customer.address}"
                maxlength="255"
                class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300"
              />
            </div>

            <!-- Phone -->
            <div class="mb-4">
              <label class="block text-gray-700 font-semibold">Phone</label>
              <input
                type="text"
                name="phone"
                value="${customer.phone}"
                maxlength="15"
                class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300"
              />
            </div>

            <!-- Birth Date -->
            <div class="mb-4">
              <label class="block text-gray-700 font-semibold">Birth Date</label>
              <input
                type="date"
                name="dob"
                value="<fmt:formatDate value='${customer.dob}' pattern='yyyy-MM-dd'/>"
                class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300"
              />
            </div>

            <!-- Gender -->
            <div class="mb-4">
              <label class="block text-gray-700 font-semibold">Gender</label>
              <select
                name="gender"
                class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300"
              >
                <option value="">-- Select Gender --</option>
                <option value="Male" ${customer.gender == 'Male' ? 'selected' : ''}>
                  Male
                </option>
                <option value="Female" ${customer.gender == 'Female' ? 'selected' : ''}>
                  Female
                </option>
                <option value="Other" ${customer.gender == 'Other' ? 'selected' : ''}>
                  Other
                </option>
              </select>
            </div>

            <!-- Nút -->
            <div class="flex justify-end space-x-3">
              <button
                type="button"
                id="modalCancelBtn"
                class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded transition-colors duration-200 focus:outline-none"
              >
                Cancel
              </button>
              <button
                type="submit"
                class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded transition-colors duration-200 focus:outline-none"
              >
                Save Changes
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Script Modal + AJAX (giữ nguyên logic) -->
    <script>
      // Modal control
      const openModalBtn = document.getElementById("openModalBtn");
      const closeModalBtn = document.getElementById("closeModalBtn");
      const modalCancelBtn = document.getElementById("modalCancelBtn");
      const modal = document.getElementById("modal");

      function openModal() {
        modal.classList.remove("hidden");
        document.body.style.overflow = "hidden";
      }
      function closeModal() {
        modal.classList.add("hidden");
        document.body.style.overflow = "";
      }

      openModalBtn.addEventListener("click", openModal);
      closeModalBtn.addEventListener("click", closeModal);
      modalCancelBtn.addEventListener("click", closeModal);

      // AJAX field validation
      $(document).ready(function () {
        const fields = ["email", "phone", "fullName", "address"];
        fields.forEach(function (field) {
          $('input[name="' + field + '"]').on("blur change", function () {
            const fieldValue = $(this).val();
            const fieldName = $(this).attr("name");
            const customerId = $('input[name="customerId"]').val();
            $.ajax({
              url: '${pageContext.request.contextPath}/admin/updateAccount',
              type: "POST",
              data: {
                action: "validate",
                fieldName: fieldName,
                fieldValue: fieldValue,
                customerId: customerId
              },
              dataType: "json",
              success: function (response) {
                if (!response.valid) {
                  console.error(
                    "Validation error for " + fieldName + ": " + response.message
                  );
                }
              },
              error: function () {
                console.error("Server connection error for field " + fieldName);
              }
            });
          });
        });

        // Handle form submission
        $("#updateForm").on("submit", function (e) {
          e.preventDefault();
          const formData = $(this).serialize() + "&action=update";
          $.ajax({
            url: '${pageContext.request.contextPath}/admin/updateAccount',
            type: "POST",
            data: formData,
            dataType: "json",
            success: function (response) {
              if (!response.valid) {
                Swal.fire({
                  icon: "error",
                  title: "Error!",
                  text: response.message,
                  width: "300px",
                  timer: 1500,
                  showConfirmButton: false
                });
              } else {
                Swal.fire({
                  icon: "success",
                  title: "Update Successful!",
                  width: "300px",
                  timer: 1500,
                  showConfirmButton: false
                }).then(function () {
                  window.location.reload();
                });
              }
            },
            error: function () {
              Swal.fire({
                icon: "error",
                title: "Server Error!",
                text: "Please try again later.",
                width: "300px",
                timer: 1500,
                showConfirmButton: false
              });
            }
          });
        });
      });
    </script>
  </body>
</html>
