<%-- 
    Document   : createCategory
    Created on : Feb 20, 2025, 9:50:44 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Create Category</h1>

        <c:if test="${not empty errorMessage}">
            <!-- Display error message in red if the category already exists -->
            <p style="color: red;">${errorMessage}</p>
        </c:if>

        <form action="${pageContext.request.contextPath}/category" method="post">
            <input type="hidden" name="action" value="create">

            <label for="categoryName">Category Name:</label>
            <input type="text" id="categoryName" name="categoryName" value="${category.categoryName}" required=""><br>

            <label for="description">Description:</label>
            <input type="text" id="description" name="description" value="${category.description}" required=""><br>

            <button type="submit">Create New Category</button>
            <a href="${pageContext.request.contextPath}/category">Cancel</a>
        </form>
    </body>
</html>
