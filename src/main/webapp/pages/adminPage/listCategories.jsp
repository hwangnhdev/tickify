<%-- 
    Document   : category
    Created on : Feb 20, 2025, 4:26:07 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /* Popup Background */
            .popup-container {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.5);
                justify-content: center;
                align-items: center;
            }

            /* Popup Content */
            .popup-content {
                background: white;
                padding: 20px;
                border-radius: 10px;
                width: 400px;
                text-align: center;
                position: relative;
                box-shadow: 0px 0px 10px gray;
            }

            /* Close Button */
            .close-btn {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 18px;
                cursor: pointer;
            }

            /* Error Message */
            .error-message {
                color: red;
                font-weight: bold;
                margin-bottom: 15px;
            }
        </style>
    </head>
    <body>
        <h1>Category Managements</h1>
        <a href="pages/admin/createCategory.jsp">New Category</a>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            <c:forEach var="category" items="${listCategories}">
                <tr>
                    <td>${category.categoryId}</td>
                    <td>${category.categoryName}</td>
                    <td>${category.description}</td>
                    <td>
                        <button onclick="openEditPopup('${category.categoryId}', '${category.categoryName}', '${category.description}')">Edit</button> |
                        <a href="category?action=delete&categoryID=${category.categoryId}">Delete</a>
                    </td>
                </tr>
            </c:forEach>
        </table>

        <!-- Popup Edit Category -->
        <div id="editPopup" class="popup-container">
            <div class="popup-content">
                <span class="close-btn" onclick="closePopup('editPopup')">×</span>
                <h2>Edit Category</h2>

                <p id="editErrorMessage" class="error-message" style="display: none;"></p>

                <form id="editForm" action="category" method="post">
                    <input type="hidden" name="action" value="update">

                    <label for="categoryId">Category ID:</label>
                    <input type="text" id="categoryId" name="categoryID" readonly><br><br>

                    <label for="categoryName">Category Name:</label>
                    <input type="text" id="categoryName" name="categoryName"><br><br>

                    <label for="description">Description:</label>
                    <input type="text" id="description" name="description"><br><br>

                    <button type="submit">Confirm Edit</button>
                    <button type="button" onclick="closePopup('editPopup')">Cancel</button>
                </form>
            </div>
        </div>

        <!-- Popup Notification Error -->
        <div id="errorPopup" class="popup-container">
            <div class="popup-content">
                <span class="close-btn" onclick="closePopup('errorPopup')">×</span>
                <h2>Error</h2>
                <p id="errorPopupMessage" class="error-message"></p>
                <button onclick="closePopup('errorPopup')">OK</button>
            </div>
        </div>

        <script>
            function openEditPopup(categoryId, categoryName, description) {
                document.getElementById("categoryId").value = categoryId;
                document.getElementById("categoryName").value = categoryName;
                document.getElementById("description").value = description;
                document.getElementById("editPopup").style.display = "flex";
            }

            function closePopup(popupId) {
                document.getElementById(popupId).style.display = "none";
            }

            function showErrorPopup(message) {
                document.getElementById("errorPopupMessage").innerText = message;
                document.getElementById("errorPopup").style.display = "flex";
            }

            document.getElementById("editForm").onsubmit = function (event) {
                event.preventDefault();
                var formData = new FormData(this);

                fetch("category", {
                    method: "POST",
                    body: formData
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.error) {
                                showErrorPopup(data.error);
                            } else {
                                window.location.reload();
                            }
                        })
                        .catch(error => {
                            showErrorPopup("Failed to connect to the server.");
                        });
            };
        </script>
    </body>
</html>
