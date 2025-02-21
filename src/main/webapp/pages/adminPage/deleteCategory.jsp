<%-- 
    Document   : deleteCategory
    Created on : Feb 20, 2025, 10:04:32 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Delete Category</h1>
        <form action="category" method="post">
            <input type="hidden" name="action" value="delete">
            <label for="categoryId">Category ID:</label>
            <input type="text" id="categoryId" name="categoryID" value="${category.categoryId}" readonly><br>

            <label for="categoryName">Category Name:</label>
            <input type="text" id="categoryName" name="categoryName" value="${category.categoryName}" readonly><br>

            <label for="description">Description:</label>
            <input type="text" id="description" name="description" value="${category.description}" readonly><br>

            <button type="submit">Confirm Delete</button>
            <a href="category">Cancel</a>
        </form>
    </body>
</html>
