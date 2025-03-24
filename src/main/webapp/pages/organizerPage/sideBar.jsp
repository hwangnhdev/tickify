<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sidebar</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    </head>
    <body>
        <!-- Sidebar -->
        <aside class="fixed inset-y-0 left-0 transform w-64 bg-gradient-to-b from-green-900 to-black p-4 text-white transition-transform duration-300 md:w-1/6 md:relative md:transform-none z-50">
            <button class="md:hidden text-white absolute top-4 right-4" onclick="document.querySelector('aside').classList.toggle('-translate-x-full')">
                <i class="fas fa-bars"></i>
            </button>
            <div class="flex items-center mb-8">
                <img alt="Tickify logo" class="mr-2" height="40" src="https://storage.googleapis.com/a1aa/image/8k6Ikw_t95IdEBRzaSbfv_qa-9InZk34-JUibXbK7B4.jpg" width="40"/>
                <span class="text-lg font-bold text-green-500">Organizer Center</span>
            </div>
            <nav class="space-y-4">
                <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" 
                   href="${pageContext.request.contextPath}/eventOverview?eventId=${eventId}">
                    <i class="fas fa-chart-pie mr-2"></i>Overview
                </a>
                
                <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" 
                   href="${pageContext.request.contextPath}/updateEvent?eventId=${eventId}">
                    <i class="fas fa-edit mr-2"></i>Edit Event
                </a>
                <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" 
                   href="${pageContext.request.contextPath}/seatingChart?eventId=${eventId}">
                    <i class="fas fa-chair mr-2"></i>Seat Map
                </a>
                <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" 
                   href="${pageContext.request.contextPath}/vouchers?eventId=${eventId}">
                    <i class="fas fa-tags mr-2"></i>Voucher
                </a>
                <a class="flex items-center text-white hover:bg-green-700 p-2 rounded" 
                   href="${pageContext.request.contextPath}/organizerOrders?eventId=${eventId}">
                    <i class="fas fa-list mr-2"></i>Order List
                </a>
            </nav>
        </aside>
    </body>
</html>
