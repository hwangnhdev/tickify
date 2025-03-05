<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- searchorder.jsp: Thanh tìm kiếm đơn hàng theo tên khách hàng -->
<form action="SearchOrderController" method="get" class="flex items-center">
    <input type="text" name="searchOrder" placeholder="Tìm theo tên khách hàng" 
           class="p-2 rounded bg-gray-700 text-white border border-gray-600 focus:ring-2 focus:ring-green-500" />
    <button type="submit" 
            class="bg-green-500 hover:bg-green-600 text-white p-2 rounded ml-2 transition-colors duration-200">
        Search
    </button>
</form>
