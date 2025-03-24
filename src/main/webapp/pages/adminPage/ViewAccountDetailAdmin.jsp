<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Account Details</title>
        <!-- Tailwind CSS from CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- jQuery for AJAX calls -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- SweetAlert2 for notifications -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <!-- Include header (nav, logo, etc.) -->
        <jsp:include page="header.jsp">
            <jsp:param name="pageTitle" value="Customer Management" />
        </jsp:include>
        <style>
            /* Custom modal overlay style */
            .modal-overlay {
                background-color: rgba(55, 65, 81, 0.85);
            }
            .fadeIn {
                animation: fadeIn 0.3s ease-in-out;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }
        </style>
    </head>
    <body class="bg-gray-50 font-sans">
        <!-- Main container -->
        <main class="container mx-auto p-6">
            <section class="bg-white shadow-xl rounded-xl p-8 max-w-4xl mx-auto">


                <!-- Profile Section -->
                <div class="flex flex-col items-center mt-6">
                    <c:choose>
                        <c:when test="${not empty customer.profilePicture}">
                            <img src="${customer.profilePicture}" alt="Profile Picture" 
                                 class="w-40 h-40 rounded-full border-4 border-blue-500 shadow-md" />
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/default_profile.png" alt="Default Profile Picture" 
                                 class="w-40 h-40 rounded-full border-4 border-blue-500 shadow-md" />
                        </c:otherwise>
                    </c:choose>
                    <h2 id="displayFullName" class="mt-4 text-3xl font-bold text-gray-900">${customer.fullName}</h2>
                    <p id="displayEmail" class="text-gray-600">${customer.email}</p>
                </div>

                <!-- Account Details Grid -->
                <div class="mt-8 grid grid-cols-1 sm:grid-cols-2 gap-6">
                    <div class="flex items-center">
                        <span class="w-32 font-medium text-gray-700">Customer ID:</span>
                        <span id="displayCustomerId" class="text-gray-900">${customer.customerId}</span>
                    </div>
                    <div class="flex items-center">
                        <span class="w-32 font-medium text-gray-700">Address:</span>
                        <span id="displayAddress" class="text-gray-900">
                            <c:choose>
                                <c:when test="${not empty customer.address}">${customer.address}</c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="flex items-center">
                        <span class="w-32 font-medium text-gray-700">Phone:</span>
                        <span id="displayPhone" class="text-gray-900">
                            <c:choose>
                                <c:when test="${not empty customer.phone}">${customer.phone}</c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="flex items-center">
                        <span class="w-32 font-medium text-gray-700">Birth Date:</span>
                        <span id="displayDob" class="text-gray-900">
                            <c:choose>
                                <c:when test="${not empty customer.dob}">
                                    <fmt:formatDate value="${customer.dob}" pattern="yyyy-MM-dd"/>
                                </c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="flex items-center">
                        <span class="w-32 font-medium text-gray-700">Gender:</span>
                        <span id="displayGender" class="text-gray-900">
                            <c:choose>
                                <c:when test="${not empty customer.gender}">${customer.gender}</c:when>
                                <c:otherwise>N/A</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="flex items-center">
                        <span class="w-32 font-medium text-gray-700">Status:</span>
                        <span id="displayStatus" class="text-gray-900">${customer.statusText}</span>
                    </div>
                </div>

                <!-- Update Profile Button -->
                <div class="mt-8 text-center">
                    <button id="openModalBtn" 
                            class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-6 rounded transition duration-300">
                        Update Profile
                    </button>
                </div>
            </section>
        </main>

        <!-- Modal for Profile Update -->
        <div id="modal" class="fixed inset-0 z-50 flex items-center justify-center hidden fadeIn" role="dialog" aria-modal="true">
            <div class="absolute inset-0 modal-overlay"></div>
            <div class="bg-white rounded-lg shadow-xl transform transition-all sm:max-w-lg sm:w-full relative z-10">
                <div class="px-8 py-6">
                    <div class="flex justify-between items-center">
                        <h3 class="text-2xl font-semibold text-gray-800">Update Profile</h3>
                        <button id="closeModalBtn" class="text-gray-600 hover:text-gray-800 text-3xl focus:outline-none" aria-label="Close modal">&times;</button>
                    </div>
                    <!-- Notification Area -->
                    <div id="serverError"></div>
                    <!-- Profile Update Form -->
                    <form id="updateForm" class="mt-4">
                        <input type="hidden" name="customerId" value="${customer.customerId}" />
                        <div class="mb-4">
                            <label class="block text-gray-700 font-semibold">Full Name</label>
                            <input type="text" name="fullName" value="${customer.fullName}" maxlength="50" 
                                   class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300" required>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 font-semibold">Email</label>
                            <input type="email" name="email" value="${customer.email}" maxlength="100" 
                                   class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300" required>
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 font-semibold">Address</label>
                            <input type="text" name="address" value="${customer.address}" maxlength="255" 
                                   class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 font-semibold">Phone</label>
                            <input type="text" name="phone" value="${customer.phone}" maxlength="15" 
                                   class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 font-semibold">Birth Date</label>
                            <input type="date" name="dob" value="<fmt:formatDate value='${customer.dob}' pattern='yyyy-MM-dd'/>" 
                                   class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                        </div>
                        <div class="mb-4">
                            <label class="block text-gray-700 font-semibold">Gender</label>
                            <select name="gender" class="w-full px-3 py-2 border rounded focus:outline-none focus:ring focus:border-blue-300">
                                <option value="">-- Select Gender --</option>
                                <option value="Male" ${customer.gender == 'Male' ? 'selected' : ''}>Male</option>
                                <option value="Female" ${customer.gender == 'Female' ? 'selected' : ''}>Female</option>
                                <option value="Other" ${customer.gender == 'Other' ? 'selected' : ''}>Other</option>
                            </select>
                        </div>
                        <div class="flex justify-end space-x-3">
                            <button type="button" id="modalCancelBtn" 
                                    class="bg-gray-500 hover:bg-gray-600 text-white font-bold py-2 px-4 rounded transition-colors duration-200">
                                Cancel
                            </button>
                            <button type="submit" 
                                    class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded transition-colors duration-200">
                                Save Changes
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- JavaScript for Modal and AJAX Form Submission -->
        <script>
            // Modal control functions
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

            // AJAX field validation on blur/change
            $(document).ready(function () {
                const fields = ["email", "phone", "fullName", "address"];
                fields.forEach(function (field) {
                    $('input[name="' + field + '"]').on('blur change', function () {
                        const fieldValue = $(this).val();
                        const fieldName = $(this).attr("name");
                        const customerId = $('input[name="customerId"]').val();
                        $.ajax({
                            url: '${pageContext.request.contextPath}/admin/updateAccount',
                            type: 'POST',
                            data: {action: "validate", fieldName: fieldName, fieldValue: fieldValue, customerId: customerId},
                            dataType: 'json',
                            success: function (response) {
                                if (!response.valid) {
                                    console.error("Validation error for " + fieldName + ": " + response.message);
                                }
                            },
                            error: function () {
                                console.error("Server connection error for field " + fieldName);
                            }
                        });
                    });
                });

                // Handle form submission via AJAX
                $('#updateForm').on('submit', function (e) {
                    e.preventDefault();
                    const formData = $(this).serialize() + "&action=update";
                    $.ajax({
                        url: '${pageContext.request.contextPath}/admin/updateAccount',
                        type: 'POST',
                        data: formData,
                        dataType: 'json',
                        success: function (response) {
                            if (!response.valid) {
                                Swal.fire({
                                    icon: 'error',
                                    title: 'Error!',
                                    text: response.message,
                                    width: '300px',
                                    timer: 1500,
                                    showConfirmButton: false
                                });
                            } else {
                                Swal.fire({
                                    icon: 'success',
                                    title: 'Update Successful!',
                                    width: '300px',
                                    timer: 1500,
                                    showConfirmButton: false
                                }).then(function () {
                                    window.location.reload();
                                });
                            }
                        },
                        error: function () {
                            Swal.fire({
                                icon: 'error',
                                title: 'Server Error!',
                                text: 'Please try again later.',
                                width: '300px',
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
