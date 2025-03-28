<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Customer" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Profile</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    </head>
    <%
        Customer profile = (Customer) request.getAttribute("profile");
        String successMessage = (String) request.getAttribute("successMessage");
        String errorMessage = (String) request.getAttribute("errorMessage");
    %>
    <body class="bg-gray-900 text-white">
        <jsp:include page="../../components/header.jsp"></jsp:include>

            <div class="pt-16 flex">
            <jsp:include page="../ticketPage/sidebar.jsp" />

            <main class="w-3/5">
                <h1 class="text-3xl font-bold mb-6 ml-7">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbspMy Profile</h1>
                <div class="divider"></div>
                <div class="max-w-xl mx-auto bg-gray-800 rounded-lg shadow-lg p-8 border border-gray-800">

                    <form action="profile" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                        <div class="flex flex-col items-center mb-6">
                            <img name="profile_picture" id="profile_picture" 
                                 class="w-32 h-32 rounded-full object-cover border-4 border-gray-700"
                                 src="<%= profile.getProfilePicture() != null && !profile.getProfilePicture().isEmpty() ? profile.getProfilePicture() : "default-avatar.jpg"%>" 
                                 alt="Profile Picture" />
                            <label for="imageUpload" class="mt-2 w-8 h-8 bg-green-500 rounded-full text-white p-2 cursor-pointer hover:bg-green-600">
                                <i class="fas fa-camera"></i>
                            </label>
                            <input type="file" id="imageUpload" name="profile_picture" accept="image/*" onchange="previewImage(event)" class="hidden" />
                        </div>

                        <div class="space-y-4">
                            <input type="hidden" name="customerId" value="<%= profile.getCustomerId()%>" />

                            <div>
                                <label for="fullname" class="block mb-2 text-sm font-medium">Full Name</label>
                                <input type="text" id="fullname" name="fullname" maxlength="50" 
                                       value="<%= profile.getFullName()%>" required 
                                       class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500" />
                            </div>

                            <div>
                                <label for="email" class="block mb-2 text-sm font-medium">Email</label>
                                <input type="email" id="email" name="email" maxlength="40" 
                                       value="<%= profile.getEmail()%>" disabled 
                                       class="w-full px-3 py-2 bg-gray-600 border border-gray-500 rounded-md cursor-not-allowed" />
                            </div>

                            <div>
                                <label for="address" class="block mb-2 text-sm font-medium">Address</label>
                                <input type="text" id="address" name="address" maxlength="80" 
                                       value="<%= profile.getAddress() != null ? profile.getAddress() : ""%>" 
                                       class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" />
                            </div>

                            <div>
                                <label for="phone" class="block mb-2 text-sm font-medium">Phone Number</label>
                                <input type="text" id="phone" name="phone" pattern="[0-9]{10}" maxlength="10" 
                                       value="<%= profile.getPhone() != null ? profile.getPhone() : ""%>" 
                                       placeholder="10 digits only" required 
                                       class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" />
                            </div>

                            <div>
                                <label for="dob" class="block mb-2 text-sm font-medium">Date of Birth</label>
                                <input type="date" id="dob" name="dob" 
                                       value="<%= profile.getDob() != null ? profile.getDob() : ""%>" 
                                       class="w-full px-3 py-2 bg-gray-700 border border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-green-500" />
                            </div>

                            <div class="mb-4">
                                <label class="block mb-2 text-sm font-medium">Gender</label>
                                <div class="flex space-x-4">
                                    <label class="inline-flex items-center">
                                        <input type="radio" name="gender" value="male" 
                                               <%= "male".equals(profile.getGender()) ? "checked" : ""%> 
                                               class="form-radio text-green-500 bg-gray-700 border-gray-600"/>
                                        <span class="ml-2">Male</span>
                                    </label>
                                    <label class="inline-flex items-center">
                                        <input type="radio" name="gender" value="female" 
                                               <%= "female".equals(profile.getGender()) ? "checked" : ""%> 
                                               class="form-radio text-green-500 bg-gray-700 border-gray-600"/>
                                        <span class="ml-2">Female</span>
                                    </label>
                                    <label class="inline-flex items-center">
                                        <input type="radio" name="gender" value="others" 
                                               <%= "others".equals(profile.getGender()) ? "checked" : ""%> 
                                               class="form-radio text-green-500 bg-gray-700 border-gray-600"/>
                                        <span class="ml-2">Others</span>
                                    </label>
                                </div>
                            </div>

                            <button type="submit" class="w-full bg-green-500 text-white py-2 rounded-md hover:bg-green-600 transition duration-300">
                                Update Profile
                            </button>
                        </div>
                    </form>

                    <a href="<%= request.getContextPath()%>/changePassword" 
                       class="block text-center text-green-500 hover:text-green-400 mt-4 transition duration-300">
                        Change Password
                    </a>
                </div>
            </main>
        </div>

        <!-- Popup Notification -->
        <div class="fixed inset-0 bg-black bg-opacity-50 z-40 hidden" id="popupBackdrop"></div>
        <div class="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-gray-800 p-6 rounded-lg z-50 hidden" id="successPopup">
            <h3 class="text-xl font-bold mb-4 text-green-500">Success!</h3>
            <p class="mb-4 text-white">Your profile has been updated successfully.</p>
            <button onclick="closePopup()" class="w-full bg-green-500 text-white py-2 rounded-md hover:bg-green-600">
                OK
            </button>
        </div>
        <div class="fixed top-1/2 left-1/2 transform -translate-x-1/2 -translate-y-1/2 bg-gray-800 p-6 rounded-lg z-50 hidden" id="errorPopup">
            <h3 class="text-xl font-bold mb-4 text-red-500">Error!</h3>
            <p class="mb-4 text-white"><%= errorMessage != null ? errorMessage : "Something went wrong."%></p>
            <button onclick="closeErrorPopup()" class="w-full bg-red-500 text-white py-2 rounded-md hover:bg-red-600">
                OK
            </button>
        </div>

        <script>
            function previewImage(event) {
                const file = event.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('profile_picture').src = e.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            }

            function validateForm() {
                const phone = document.getElementById('phone').value;
                const fullName = document.getElementById('fullname').value;
                const dob = document.getElementById('dob').value;
                const phonePattern = /^[0-9]{10}$/;

                if (!phonePattern.test(phone)) {
                    alert('Please enter a valid 10-digit phone number.');
                    return false;
                }
                if (fullName.trim() === '') {
                    alert('Full Name cannot be empty.');
                    return false;
                }
                if (dob) {
                    const dobDate = new Date(dob);
                    const today = new Date();
                    today.setHours(0, 0, 0, 0);

                    if (dobDate >= today) {
                        alert('Date of Birth must be earlier than today.');
                        return false;
                    }
                }
                return true;
            }

            function showPopup() {
                document.getElementById('successPopup').classList.remove('hidden');
                document.getElementById('popupBackdrop').classList.remove('hidden');
            }

            function closePopup() {
                document.getElementById('successPopup').classList.add('hidden');
                document.getElementById('popupBackdrop').classList.add('hidden');
                window.location.href = 'event';
            }

            function showErrorPopup() {
                document.getElementById('errorPopup').classList.remove('hidden');
                document.getElementById('popupBackdrop').classList.remove('hidden');
            }

            function closeErrorPopup() {
                document.getElementById('errorPopup').classList.add('hidden');
                document.getElementById('popupBackdrop').classList.add('hidden');
            }

            <% if (successMessage != null && !successMessage.isEmpty()) { %>
            showPopup();
            <% } %>
            <% if (errorMessage != null && !errorMessage.isEmpty()) { %>
            showErrorPopup();
            <% }%>
        </script>
    </body>
</html>