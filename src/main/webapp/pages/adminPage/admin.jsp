<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
        <title>Admin Dashboard</title>
        <!-- Tailwind CSS từ CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <!-- Include header -->
        <jsp:include page="/pages/adminPage/header.jsp">
            <jsp:param name="pageTitle" value="Approved Event Detail" />
        </jsp:include>

        <!-- Include sidebar -->
        <jsp:include page="/pages/adminPage/sidebar.jsp" />

        <!-- Nội dung chính của trang Admin Dashboard -->
        <div class="p-6 ml-64">  <!-- Giả sử sidebar có width cố định là 64 (16rem) -->
            <h1 class="text-3xl font-bold text-gray-800 mb-4">Admin Dashboard</h1>
            <p class="text-gray-600">
                Đây là nội dung trang quản trị. Bạn có thể thay đổi nội dung và thêm các chức năng khác theo nhu cầu.
            </p>
            <!-- Các nội dung, bảng điều khiển, biểu đồ,... -->
        </div>
    </body>
</html>
