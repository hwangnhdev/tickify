<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>
            Admin Dashboard
        </title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <!-- Include header -->
        <jsp:include page="/pages/adminPage/header.jsp">
            <jsp:param name="pageTitle" value="Approved Event Detail" />
        </jsp:include>

        <!-- Include sidebar -->
        <jsp:include page="/pages/adminPage/sidebar.jsp" />
    </body>
</html>
