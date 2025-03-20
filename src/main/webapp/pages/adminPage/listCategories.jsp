<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html lang="en">
    <!-- Include header with dynamic page title -->
    <jsp:include page="header.jsp">
        <jsp:param name="pageTitle" value="Category Management" />
    </jsp:include>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp" />
            <!-- Main Content -->
            <div class="flex-1 p-6">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Category Management</h2>

                    <!-- Navigation Tabs -->
                    <div class="flex space-x-4 mb-4">
                        <a href="#" class="text-blue-600 border-b-2 border-blue-600 pb-1">View All</a>
                    </div>

                    <!-- Filter and Search Bar -->
                    <form id="filterForm" action="${pageContext.request.contextPath}/category" method="get" class="mb-6 flex flex-wrap items-center justify-end gap-4">
                        <div class="relative w-64">
                            <input type="text" id="searchInput" name="search" placeholder="Search categories by name" 
                                   class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" 
                                   value="${param.search}">
                            <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
                            <div id="suggestions" class="suggestions"></div>
                        </div>
                        <input type="submit" value="Search" class="bg-blue-600 text-white py-2 px-4 rounded">
                        <button type="button" onclick="openCreatePopup()" class="bg-blue-600 text-white py-2 px-4 rounded">Create New</button>
                    </form>

                    <!-- Categories Table -->
                    <div class="overflow-x-auto">
                        <table class="min-w-full bg-white border border-gray-300">
                            <thead class="bg-gray-200">
                                <tr>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">ID</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Category Name</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Description</th>
                                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-700 uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody id="categoryTableBody" class="bg-white divide-y divide-gray-100">
                                <c:forEach var="category" items="${listCategories}">
                                    <tr class="hover:bg-gray-50 transition duration-150">
                                        <td class="px-6 py-4 text-sm text-gray-600">${category.categoryId}</td>
                                        <td class="px-6 py-4 text-sm text-blue-600">${category.categoryName}</td>
                                        <td class="px-6 py-4 text-sm text-gray-600">${category.description}</td>
                                        <td class="px-6 py-4 text-sm">
                                            <button onclick="openEditPopup('${category.categoryId}', '${category.categoryName}', '${category.description}')" 
        class="bg-yellow-500 text-white hover:bg-yellow-600 px-3 py-1 rounded transition duration-300 mr-2">
    Edit
</button>
<button onclick="openDeletePopup('${category.categoryId}', '${category.categoryName}', '${category.description}')" 
        class="bg-red-500 text-white hover:bg-red-600 px-3 py-1 rounded transition duration-300">
    Delete
</button>

                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty listCategories}">
                                    <tr>
                                        <td colspan="4" class="px-6 py-4 text-center text-gray-500">No categories found.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <jsp:include page="pagination.jsp">
                        <jsp:param name="baseUrl" value="${pageContext.request.contextPath}/category" />
                        <jsp:param name="page" value="${page}" />
                        <jsp:param name="totalPages" value="${totalPages}" />
                    </jsp:include>
                </div>
            </div>
        </div>

        <!-- Popups Section -->
        <!-- Create Popup -->
        <div id="createPopup" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 hidden transition-opacity duration-300">
            <div class="bg-white rounded-lg p-6 w-full max-w-md transform transition-all duration-300 scale-95">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-semibold text-gray-800">Create Category</h2>
                    <button onclick="closePopup('createPopup')" class="text-gray-500 hover:text-gray-700 text-2xl">×</button>
                </div>
                <form id="createForm" method="post" action="${pageContext.request.contextPath}/category">
                    <input type="hidden" name="action" value="create">
                    <div class="mb-4">
                        <label for="createCategoryName" class="block text-sm font-medium text-gray-700 mb-1">Category Name</label>
                        <input type="text" id="createCategoryName" name="categoryName" 
                               class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500" required>
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
                <form id="editForm" action="${pageContext.request.contextPath}/category" method="post">
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
                <form id="deleteForm" action="${pageContext.request.contextPath}/category" method="post">
                    <input type="hidden" name="action" value="delete">
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
                    <div class="flex justify-end space-x-2">
                        <button type="submit" class="bg-red-600 text-white px-4 py-2 rounded-md hover:bg-red-700 transition duration-300">Delete</button>
                        <button type="button" onclick="closePopup('deletePopup')" 
                                class="bg-gray-200 text-gray-700 px-4 py-2 rounded-md hover:bg-gray-300 transition duration-300">Cancel</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Success Popup -->
        <div id="successPopup" class="fixed inset-0 flex items-center justify-center bg-white rounded-lg p-6 shadow-md hidden">
            <p id="successMessage" class="text-green-600 mb-4"></p>
            <button onclick="closeSuccessPopup()" class="bg-green-600 text-white px-4 py-2 rounded-md hover:bg-green-700 transition duration-300">OK</button>
        </div>
        <div id="overlay" class="fixed inset-0 bg-black opacity-50 hidden"></div>

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

            function closeSuccessPopup() {
                document.getElementById('successPopup').classList.add('hidden');
                document.getElementById('overlay').classList.add('hidden');
                window.location.href = '${pageContext.request.contextPath}/category';
            }

            // Hàm lấy gợi ý tìm kiếm
            function fetchSuggestions(query) {
                if (query.length === 0) {
                    document.getElementById('suggestions').style.display = 'none';
                    return;
                }
                fetch('${pageContext.request.contextPath}/category?action=search&query=' + encodeURIComponent(query))
                    .then(response => response.json())
                    .then(data => {
                        const suggestionsDiv = document.getElementById('suggestions');
                        suggestionsDiv.innerHTML = '';
                        if (data.length > 0) {
                            data.forEach(category => {
                                const div = document.createElement('div');
                                div.className = 'suggestion-item px-2 py-1 cursor-pointer hover:bg-gray-100';
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
                fetch('${pageContext.request.contextPath}/category?action=search&query=' + encodeURIComponent(query))
                    .then(response => response.json())
                    .then(data => {
                        const tbody = document.getElementById('categoryTableBody');
                        tbody.innerHTML = '';
                        if (data.length === 0) {
                            tbody.innerHTML = `<tr>
                                <td colspan="4" class="px-6 py-4 text-center text-gray-500">No categories found.</td>
                            </tr>`;
                        } else {
                            data.forEach(category => {
                                const row = document.createElement('tr');
                                row.className = "hover:bg-gray-50 transition duration-150";
                                row.innerHTML = `
                                    <td class="px-6 py-4 text-sm text-gray-600">${category.categoryId}</td>
                                    <td class="px-6 py-4 text-sm text-blue-600">${category.categoryName}</td>
                                    <td class="px-6 py-4 text-sm text-gray-600">${category.description}</td>
                                    <td class="px-6 py-4 text-sm">
                                        <button onclick="openEditPopup('${category.categoryId}', '${category.categoryName}', '${category.description}')" class="text-yellow-600 hover:text-yellow-800 mr-2">Edit</button>
                                        <button onclick="openDeletePopup('${category.categoryId}', '${category.categoryName}', '${category.description}')" class="text-red-600 hover:text-red-800">Delete</button>
                                    </td>
                                `;
                                tbody.appendChild(row);
                            });
                        }
                        document.getElementById('suggestions').style.display = 'none';
                    })
                    .catch(error => console.error('Error searching categories:', error));
            }

            // Hiển thị success popup nếu có parameter "success" trong URL
            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                if (urlParams.has('success')) {
                    const action = urlParams.get('success');
                    let message = '';
                    if (action === 'create') {
                        message = 'Category created successfully!';
                    } else if (action === 'update') {
                        message = 'Category updated successfully!';
                    } else if (action === 'delete') {
                        message = 'Category deleted successfully!';
                    }
                    document.getElementById('successMessage').innerText = message;
                    document.getElementById('successPopup').classList.remove('hidden');
                    document.getElementById('overlay').classList.remove('hidden');
                }
            };
        </script>
    </body>
</html>
