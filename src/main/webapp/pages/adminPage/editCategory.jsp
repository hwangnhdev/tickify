<%-- 
    Document   : editCategory
    Created on : Feb 20, 2025, 9:49:12 PM
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
            #editPopup {
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
            }

            /* Close Button */
            .close-btn {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 18px;
                cursor: pointer;
            }
        </style>
    </head>
    <body>
        <h1>Edit Category</h1>

        <c:if test="${not empty errorMessage}">
            <!-- Display error message in red if the category already exists -->
            <p style="color: red;">${errorMessage}</p>
        </c:if>

        <form action="category" method="post">
            <input type="hidden" name="action" value="update">
            <label for="categoryId">Category ID:</label>
            <input type="text" id="categoryId" name="categoryID" value="${category.categoryId}" readonly><br>

            <label for="categoryName">Category Name:</label>
            <input type="text" id="categoryName" name="categoryName" value="${category.categoryName}"><br>

            <label for="description">Description:</label>
            <input type="text" id="description" name="description" value="${category.description}"><br>

            <button type="submit">Confirm Edit</button>
            <a href="category">Cancel</a>
        </form>
    </body>
</html>
