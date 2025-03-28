<%-- 
    Document   : listCategories
    Created on : Jan 12, 2025, 2:52:16 AM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            .hidden {
                display: none;
            }
        </style>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen">
            <jsp:include page="sidebar.jsp" />
            <!-- Main Content -->
            <div class="flex-1 p-6 overflow-y-auto">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Category Management</h2>

                    <!-- Filter and Search Bar -->
                    <form id="filterForm" action="${viewAllCategoriesUrl}" method="get" class="mb-6 flex flex-wrap items-center justify-end gap-4">
                        <div class="relative w-64">
                            <input type="text" id="searchInput" name="search" placeholder="Search categories by name" 
                                   class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" 
                                   onkeyup="fetchSuggestions(this.value)" value="${param.search}">
                            <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                            <div id="suggestions" class="suggestions"></div>
                        </div>
                        <input type="submit" value="Search" onclick="searchCategories(); return false;" class="bg-blue-600 text-white py-2 px-4 rounded">
                        <button type="button" onclick="openCreatePopup()" class="bg-blue-600 text-white py-2 px-4 rounded">Create New</button>
                    </form>

                    <!-- Categories Table -->
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">ID</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Category Name</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Description</th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="categoryTableBody" class="bg-white divide-y divide-gray-100">
                                <c:forEach var="category" items="${listCategories}">
                                    <tr class="hover:bg-gray-50 transition duration-150">
                                        <td class="px-6 py-4 text-sm text-gray-600">${category.categoryId}</td>
                                        <td class="px-6 py-4 text-sm text-gray-600">${category.categoryName}</td>
                                        <td class="px-6 py-4 text-sm text-gray-600 truncate" title="${category.description}">${category.description}</td>
                                        <td class="px-6 py-4 text-sm">
                                            <button onclick="openEditPopup('${category.categoryId}', '${category.categoryName}', '${category.description}')" 
                                                    class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-300 mr-2">Edit</button>
                                            <button onclick="openDeletePopup('${category.categoryId}', '${category.categoryName}', '${category.description}')" 
                                                    class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 transition duration-300">Delete</button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listCategories}">
                                    <tr>
                                        <td class="px-6 py-4 text-center text-gray-500" colspan="4">
                                            No categories found.
                                        </td>
                                    </tr>
                                </c:if>
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
                            <form id="createForm" onsubmit="createCategory(event)">
                                <input type="hidden" name="action" value="create">
                                <div class="mb-4">
                                    <label for="createCategoryName" class="block text-sm font-medium text-gray-700 mb-1">Category Name</label>
                                    <input type="text" id="createCategoryName" name="categoryName" 
                                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                                    <div id="createErrorMessage" class="text-red-500 mt-2 hidden"></div>
                                </div>
                                <div class="mb-4">
                                    <label for="createDescription" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                                    <input type="text" id="createDescription" name="description" 
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
                            <form id="editForm" onsubmit="updateCategory(event)">
                                <input type="hidden" name="action" value="update">
                                <div class="mb-4">
                                    <label for="categoryId" class="block text-sm font-medium text-gray-700 mb-1">Category ID</label>
                                    <input type="text" id="categoryId" name="categoryID" readonly 
                                           class="w-full px-3 py-2 border border-gray-300 rounded-md bg-gray-100">
                                </div>
                                <div class="mb-4">
                                    <label for="categoryName" class="block text-sm font-medium text-gray-700 mb-1">Category Name</label>
                                    <input type="text" id="categoryName" name="categoryName" 
                                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
                                    <div id="editErrorMessage" class="text-red-500 mt-2 hidden"></div>
                                </div>
                                <div class="mb-4">
                                    <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Description</label>
                                    <input type="text" id="description" name="description" 
                                           class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
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
                            <div class="flex justify-between items-center mb-4">
                                <h2 class="text-xl font-semibold text-gray-800">Confirm Delete</h2>
                                <button type="button" onclick="closePopup('deletePopup')" class="text-gray-500 hover:text-gray-700 text-2xl">×</button>
                            </div>
                            <form id="deleteForm" onsubmit="deleteCategory(event)">
                                <input type="hidden" name="action" value="delete">
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
                </div>
            </div>
        </div>

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
                        document.getElementById('createErrorMessage')?.classList.add('hidden');
                        document.getElementById('editErrorMessage')?.classList.add('hidden');
            }

            function closeSuccessPopup() {
                document.getElementById('successPopup').style.display = 'none';
                document.getElementById('overlay').style.display = 'none';
            }

            function createCategory(event) {
                event.preventDefault();
                const form = document.getElementById('createForm');
                const formData = new FormData(form);
                const data = Object.fromEntries(formData);
                console.log('Data gửi đi:', data); // Log dữ liệu gửi đi

                fetch('${pageContext.request.contextPath}/category', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                })
                        .then(response => {
                            console.log('Response status:', response.status); // Log trạng thái phản hồi
                            if (!response.ok)
                                throw new Error('Network response was not ok');
                            return response.json();
                        })
                        .then(data => {
                            console.log('Response data:', data); // Log dữ liệu nhận về
                            const errorDiv = document.getElementById('createErrorMessage');
                            if (data.success) {
                                errorDiv.classList.add('hidden');
                                closePopup('createPopup');
                                showSuccess('Category created successfully!');
                                refreshCategoryList();
                            } else {
                                errorDiv.innerText = data.message || 'Unknown error';
                                errorDiv.classList.remove('hidden');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            const errorDiv = document.getElementById('createErrorMessage');
                            errorDiv.innerText = 'An error occurred: ' + error.message;
                            errorDiv.classList.remove('hidden');
                        });
            }

            function updateCategory(event) {
                event.preventDefault();
                const form = document.getElementById('editForm');
                const formData = new FormData(form);
                const data = Object.fromEntries(formData);

                fetch('${pageContext.request.contextPath}/category', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                })
                        .then(response => response.json())
                        .then(data => {
                            const errorDiv = document.getElementById('editErrorMessage');
                            if (data.success) {
                                errorDiv.classList.add('hidden');
                                closePopup('editPopup');
                                showSuccess('Category updated successfully!');
                                refreshCategoryList();
                            } else {
                                errorDiv.innerText = data.message;
                                errorDiv.classList.remove('hidden');
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            document.getElementById('editErrorMessage').innerText = 'An error occurred. Please try again.';
                            document.getElementById('editErrorMessage').classList.remove('hidden');
                        });
            }

            function deleteCategory(event) {
                event.preventDefault();
                const form = document.getElementById('deleteForm');
                const formData = new FormData(form);
                const data = Object.fromEntries(formData);

                fetch('${pageContext.request.contextPath}/category', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify(data)
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                closePopup('deletePopup');
                                showSuccess('Category deleted successfully!');
                                refreshCategoryList();
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }

            function showSuccess(message) {
                document.getElementById('successMessage').innerText = message;
                document.getElementById('successPopup').style.display = 'block';
                document.getElementById('overlay').style.display = 'block';
            }

            function refreshCategoryList() {
                fetch('${pageContext.request.contextPath}/category?action=search&query=')
                        .then(response => response.json())
                        .then(data => {
                            const tbody = document.getElementById('categoryTableBody');
                            tbody.innerHTML = '';
                            if (data.length === 0) {
                                tbody.innerHTML = `
                            <tr>
                                <td class="px-6 py-4 text-center text-gray-500" colspan="4">No categories found.</td>
                            </tr>
                        `;
                            } else {
                                data.forEach(category => {
                                    tbody.innerHTML +=
                                            '<tr class="hover:bg-gray-50 transition duration-150">' +
                                            '<td class="px-6 py-4 text-sm text-gray-600">' + category.categoryId + '</td>' +
                                            '<td class="px-6 py-4 text-sm text-gray-600">' + category.categoryName + '</td>' +
                                            '<td class="px-6 py-4 text-sm text-gray-600 truncate" title="' + category.description + '">' + category.description + '</td>' +
                                            '<td class="px-6 py-4 text-sm">' +
                                            '<button onclick="openEditPopup(\'' + category.categoryId + '\', \'' + category.categoryName + '\', \'' + category.description + '\')" ' +
                                            'class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-300 mr-2">Edit</button>' +
                                            '<button onclick="openDeletePopup(\'' + category.categoryId + '\', \'' + category.categoryName + '\', \'' + category.description + '\')" ' +
                                            'class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 transition duration-300">Delete</button>' +
                                            '</td>' +
                                            '</tr>';
                                });
                            }
                        })
                        .catch(error => console.error('Error refreshing list:', error));
            }

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
                                    suggestionsDiv.innerHTML += `
                                <div class="suggestion-item" onclick="document.getElementById('searchInput').value = '` + category.categoryName + `'; searchCategories('` + category.categoryName + `'); document.getElementById('suggestions').style.display = 'none';">
                                    ` + category.categoryName + `
                                </div>
                            `;
                                });
                                suggestionsDiv.style.display = 'block';
                            } else {
                                suggestionsDiv.style.display = 'none';
                            }
                        })
                        .catch(error => console.error('Error fetching suggestions:', error));
            }

            function searchCategories(query = document.getElementById('searchInput').value) {
                fetch(`${pageContext.request.contextPath}/category?action=search&query=` + encodeURIComponent(query))
                        .then(response => response.json())
                        .then(data => {
                            const tbody = document.getElementById('categoryTableBody');
                            tbody.innerHTML = '';
                            if (data.length === 0) {
                                tbody.innerHTML = `
                            <tr>
                                <td class="px-6 py-4 text-center text-gray-500" colspan="4">No categories found.</td>
                            </tr>
                        `;
                            } else {
                                data.forEach(category => {
                                    tbody.innerHTML +=
                                            '<tr class="hover:bg-gray-50 transition duration-150">' +
                                            '<td class="px-6 py-4 text-sm text-gray-600">' + category.categoryId + '</td>' +
                                            '<td class="px-6 py-4 text-sm text-gray-600">' + category.categoryName + '</td>' +
                                            '<td class="px-6 py-4 text-sm text-gray-600 truncate" title="' + category.description + '">' + category.description + '</td>' +
                                            '<td class="px-6 py-4 text-sm">' +
                                            '<button onclick="openEditPopup(\'' + category.categoryId + '\', \'' + category.categoryName + '\', \'' + category.description + '\')" ' +
                                            'class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-300 mr-2">Edit</button>' +
                                            '<button onclick="openDeletePopup(\'' + category.categoryId + '\', \'' + category.categoryName + '\', \'' + category.description + '\')" ' +
                                            'class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 transition duration-300">Delete</button>' +
                                            '</td>' +
                                            '</tr>';
                                });
                            }
                            document.getElementById('suggestions').style.display = 'none';
                        })
                        .catch(error => console.error('Error searching categories:', error));
            }
        </script>
    </body>
</html>