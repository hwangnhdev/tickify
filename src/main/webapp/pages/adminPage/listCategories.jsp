<%-- 
    Document   : listCategories
    Created on : Jan 12, 2025, 2:52:16 AM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category Management</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            .success-popup {
                display: none;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                z-index: 1000;
                text-align: center;
            }
            .overlay {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                z-index: 999;
            }
            .suggestions {
                position: absolute;
                top: 100%;
                left: 0;
                width: 100%;
                background: white;
                border: 1px solid #d1d5db;
                border-radius: 0 0 4px 4px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                max-height: 200px;
                overflow-y: auto;
                z-index: 10;
                display: none;
            }
            .suggestion-item {
                padding: 8px 12px;
                cursor: pointer;
            }
            .suggestion-item:hover {
                background-color: #f3f4f6;
            }
        </style>
    </head>
    <body class="bg-gray-100 p-4">
        <div class="flex h-screen">
            <jsp:include page="sidebar.jsp" />
            <div class="max-w-7xl mx-auto bg-white p-6 rounded-lg shadow-md">
                <h1 class="text-2xl font-bold mb-4">Category Management</h1>

                <!-- Navigation Tabs -->
                <div class="flex space-x-4 mb-4">
                    <a href="#" class="text-blue-600 border-b-2 border-blue-600 pb-1">View All</a>
                </div>

                <!-- Filter and Search -->
                <div class="flex items-center mb-4">
                    <div class="relative flex-1">
                        <input type="text" id="searchInput" placeholder="Search categories by name" 
                               class="border border-gray-300 rounded p-2 w-full pl-10" 
                               onkeyup="fetchSuggestions(this.value)">
                        <i class="fas fa-search absolute left-3 top-3 text-gray-400"></i>
                        <div id="suggestions" class="suggestions"></div>
                    </div>
                    <button onclick="searchCategories()" class="bg-blue-600 text-white px-4 py-2 rounded ml-4">Search</button>
                    <button onclick="openCreatePopup()" class="bg-blue-600 text-white px-4 py-2 rounded ml-4">Create New</button>
                </div>

                <!-- Categories Table -->
                <table class="min-w-full bg-white border border-gray-300">
                    <thead>
                        <tr>
                            <th class="border-b p-2 text-left">ID</th>
                            <th class="border-b p-2 text-left">Category Name</th>
                            <th class="border-b p-2 text-left">Description</th>
                            <th class="border-b p-2 text-left">Actions</th>
                        </tr>
                    </thead>
                    <tbody id="categoryTableBody">
                        <c:forEach var="category" items="${listCategories}">
                            <tr>
                                <td class="border-b p-2">${category.categoryId}</td>
                                <td class="border-b p-2 text-blue-600">${category.categoryName}</td>
                                <td class="border-b p-2">${category.description}</td>
                                <td class="border-b p-2">
                                    <button onclick="openEditPopup('${category.categoryId}', '${category.categoryName}', '${category.description}')" 
                                            class="text-yellow-600 hover:text-yellow-800 mr-2">Edit</button>
                                    <button onclick="openDeletePopup('${category.categoryId}', '${category.categoryName}', '${category.description}')" 
                                            class="text-red-600 hover:text-red-800">Delete</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Create Popup -->
            <div id="createPopup" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 hidden transition-opacity duration-300">
                <div class="bg-white rounded-lg p-6 w-full max-w-md transform transition-all duration-300 scale-95">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-xl font-semibold text-gray-800">Create Category</h2>
                        <button onclick="closePopup('createPopup')" class="text-gray-500 hover:text-gray-700 text-2xl">×</button>
                    </div>

                    <c:if test="${not empty errorMessage}">
                        <p class="text-red-500 mb-4">${errorMessage}</p>
                    </c:if>

                    <form id="createForm" method="post">
                        <input type="hidden" name="action" value="create">
                        <div class="mb-4">
                            <label for="createCategoryName" class="block text-sm font-medium text-gray-700 mb-1">Category Name</label>
                            <input type="text" id="createCategoryName" name="categoryName" value="${category.categoryName}" 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                        </div>
                        <div class="mb-4">
                            <label for="createDescription" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                            <input type="text" id="createDescription" name="description" value="${category.description}" 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                        </div>
                        <div class="flex justify-end space-x-2">
                            <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded-md hover:bg-blue-700 transition duration-300">Create</button>
                            <button type="button" onclick="closePopup('createPopup')" 
                                    class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-300 transition duration-300">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Edit Popup -->
            <div id="editPopup" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 hidden transition-opacity duration-300">
                <div class="bg-white rounded-lg p-6 w-full max-w-md transform transition-all duration-300 scale-95">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="text-xl font-semibold text-gray-800">Edit Category</h2>
                        <button onclick="closePopup('editPopup')" class="text-gray-500 hover:text-gray-700 text-2xl">×</button>
                    </div>
                    <p id="editErrorMessage" class="text-red-500 mb-4 hidden"></p>
                    <form id="editForm" action="category" method="post">
                        <input type="hidden" name="action" value="update">
                        <div class="mb-4">
                            <label for="categoryId" class="block text-sm font-medium text-gray-700 mb-1">Category ID</label>
                            <input type="text" id="categoryId" name="categoryID" readonly 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md bg-gray-100">
                        </div>
                        <div class="mb-4">
                            <label for="categoryName" class="block text-sm font-medium text-gray-700 mb-1">Category Name</label>
                            <input type="text" id="categoryName" name="categoryName" 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div class="mb-4">
                            <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                            <input type="text" id="description" name="description" 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">
                        </div>
                        <div class="flex justify-end space-x-2">
                            <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-300">Save</button>
                            <button type="button" onclick="closePopup('editPopup')" 
                                    class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-300 transition duration-300">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Delete Popup -->
            <div id="deletePopup" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 hidden transition-opacity duration-300">
                <div class="bg-white rounded-lg p-6 w-full max-w-md transform transition-all duration-300 scale-95">
                    <form id="deleteForm" action="category" method="post">
                        <div class="flex justify-between items-center mb-4">
                            <h2 class="text-xl font-semibold text-gray-800">Confirm Delete</h2>
                            <button type="button" onclick="closePopup('deletePopup')" class="text-gray-500 hover:text-gray-700 text-2xl">×</button>
                        </div>
                        <p id="deleteConfirmationMessage" class="mb-4 text-gray-600"></p>
                        <div class="mb-4">
                            <label for="deleteCategoryId" class="block text-sm font-medium text-gray-700 mb-1">Category ID</label>
                            <input type="text" id="deleteCategoryId" name="categoryID" readonly 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md bg-gray-100">
                        </div>
                        <div class="mb-4">
                            <label for="deleteCategoryName" class="block text-sm font-medium text-gray-700 mb-1">Category Name</label>
                            <input type="text" id="deleteCategoryName" name="categoryName" readonly 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md bg-gray-100">
                        </div>
                        <div class="mb-4">
                            <label for="deleteDescription" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                            <input type="text" id="deleteDescription" name="description" readonly 
                                   class="w-full px-3 py-2 border border-gray-300 rounded-md bg-gray-100">
                        </div>
                        <input type="hidden" name="action" value="delete">
                        <div class="flex justify-end space-x-2">
                            <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 transition duration-300">Delete</button>
                            <button type="button" onclick="closePopup('deletePopup')" 
                                    class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-300 transition duration-300">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Success Popup -->
            <div id="successPopup" class="success-popup">
                <p id="successMessage" class="text-green-600 mb-4"></p>
                <button onclick="closeSuccessPopup()" class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-300">OK</button>
            </div>
            <div id="overlay" class="overlay"></div>

            <script>
                function openCreatePopup() {
                    document.getElementById('createPopup').classList.remove('hidden');
                }

                function openEditPopup(id, name, desc) {
                    document.getElementById('editPopup').classList.remove('hidden');
                    document.getElementById('categoryId').value = id;
                    document.getElementById('categoryName').value = name;
                    document.getElementById('description').value = desc;
                }

                function openDeletePopup(id, name, desc) {
                    document.getElementById('deletePopup').classList.remove('hidden');
                    document.getElementById('deleteCategoryId').value = id;
                    document.getElementById('deleteCategoryName').value = name;
                    document.getElementById('deleteDescription').value = desc;
                }

                function closePopup(popupId) {
                    document.getElementById(popupId).classList.add('hidden');
                }

                // Xử lý success popup sau khi redirect từ controller
                window.onload = function () {
                    const urlParams = new URLSearchParams(window.location.search);
                    if (urlParams.has('success')) {
                        const action = urlParams.get('success');
                        if (action === 'create') {
                            document.getElementById('successMessage').innerText = 'Category created successfully!';
                        } else if (action === 'update') {
                            document.getElementById('successMessage').innerText = 'Category updated successfully!';
                        } else if (action === 'delete') {
                            document.getElementById('successMessage').innerText = 'Category deleted successfully!';
                        }
                        document.getElementById('successPopup').style.display = 'block';
                        document.getElementById('overlay').style.display = 'block';
                    }
                };

                function closeSuccessPopup() {
                    document.getElementById('successPopup').style.display = 'none';
                    document.getElementById('overlay').style.display = 'none';
                    window.location.href = '${pageContext.request.contextPath}/category'; // Reload trang
                }

                // Hàm lấy gợi ý tìm kiếm
                function fetchSuggestions(query) {
                    if (query.length === 0) {
                        document.getElementById('suggestions').style.display = 'none';
                        return;
                    }

                    fetch(`${pageContext.request.contextPath}/category?action=search&query=` + encodeURIComponent(query))
                            .then(response => response.json())
                            .then(data => {
                                const suggestionsDiv = document.getElementById('suggestions');
                                suggestionsDiv.innerHTML = '';
                                if (data.length > 0) {
                                    data.forEach(category => {
                                        const div = document.createElement('div');
                                        div.className = 'suggestion-item';
                                        div.innerText = category.categoryName;
                                        div.onclick = () => {
                                            document.getElementById('searchInput').value = category.categoryName;
                                            suggestionsDiv.style.display = 'none';
                                            searchCategories(category.categoryName);
                                        };
                                        suggestionsDiv.appendChild(div);
                                    });
                                    suggestionsDiv.style.display = 'block';
                                } else {
                                    suggestionsDiv.style.display = 'none';
                                }
                            })
                            .catch(error => console.error('Error fetching suggestions:', error));
                }

                // Hàm tìm kiếm và cập nhật bảng
                function searchCategories(query = document.getElementById('searchInput').value) {
                    fetch(`${pageContext.request.contextPath}/category?action=search&query=` + encodeURIComponent(query))
                            .then(response => response.json())
                            .then(data => {
                                const tbody = document.getElementById('categoryTableBody');
                                tbody.innerHTML = '';
                                if (data.length === 0) {
                                    tbody.innerHTML = `
                                    <tr>
                                        <td colspan="4" class="border-b p-2 text-center text-gray-600">Not found category</td>
                                    </tr>
                                `;
                                } else {
                                    data.forEach(category => {
                                        const row = document.createElement('tr');
                                        row.innerHTML = `
                                            <td class="border-b p-2">` + category.categoryId + `</td>
                                            <td class="border-b p-2 text-blue-600">` + category.categoryName + `</td>
                                            <td class="border-b p-2">` + category.description + `</td>
                                            <td class="border-b p-2">
                                                <button onclick="openEditPopup('` + category.categoryId + `', '` + category.categoryName + `', '` + category.description + `')" 
                                                        class="text-yellow-600 hover:text-yellow-800 mr-2">Edit</button>
                                                <button onclick="openDeletePopup('` + category.categoryId + `', '` + category.categoryName + `', '` + category.description + `')" 
                                                        class="text-red-600 hover:text-red-800">Delete</button>
                                            </td>
                                        `;
                                        tbody.appendChild(row);
                                    });
                                }
                                document.getElementById('suggestions').style.display = 'none';
                            })
                            .catch(error => console.error('Error searching categories:', error));
                }
            </script>
        </div>
    </body>
</html>