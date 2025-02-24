<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Login Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
</head>
<body class="flex items-center justify-center min-h-screen bg-gray-100">
    <div class="bg-white rounded-lg shadow-lg w-full max-w-sm">
        <!-- Header -->
        <div class="bg-green-500 p-6 rounded-t-lg flex justify-between items-center relative">
            <h2 class="text-white text-2xl font-bold">Đăng nhập</h2>
            <button class="text-white text-xl">
                <i class="fas fa-times"></i>
            </button>
            <img alt="Cartoon dog waving sticker" class="absolute right-4 bottom-0 w-12 h-12 object-contain" 
                 src="https://storage.googleapis.com/a1aa/image/XqwRCFxsl7gw4O9bn2quqC0VaDE4_jCYdleOS9C7u94.jpg"/>
        </div>

        <!-- Hiển thị thông báo nếu có -->
        <div class="p-6 pt-4">
            <c:if test="${not empty message}">
                <div class="bg-red-500 text-white p-3 rounded mb-4 text-center">
                    ${message}
                </div>
            </c:if>
        </div>

        <!-- Login Form -->
        <div class="p-6 pt-0">
            <form action="${pageContext.request.contextPath}/login" method="post">
                <!-- Username Input -->
                <div class="mb-4 relative">
                    <input class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500" 
                           placeholder="Nhập username" 
                           type="text" name="username" required />
                    <i class="fas fa-user absolute right-4 top-3 text-gray-400"></i>
                </div>

                <!-- Password Input -->
                <div class="mb-4 relative">
                    <input class="w-full p-3 border rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500" 
                           placeholder="Nhập mật khẩu" 
                           type="password" name="password" required />
                    <i class="fas fa-eye-slash absolute right-4 top-3 text-gray-400"></i>
                </div>

                <!-- Submit Button -->
                <button type="submit" class="w-full bg-gray-300 text-gray-700 p-3 rounded-lg font-semibold">
                    Tiếp tục
                </button>
            </form>
        </div>
    </div>
</body>
</html>
