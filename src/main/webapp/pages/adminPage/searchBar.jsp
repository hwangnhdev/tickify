<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="mb-6 flex items-center justify-end space-x-4">
    <div class="relative w-64">
        <input class="bg-gray-200 rounded-full py-2 px-4 pl-10 focus:outline-none w-full" 
               placeholder="Search events" type="text" name="search" value="${param.search}" />
        <i class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"></i>
    </div>
    <input class="bg-blue-600 text-white py-2 px-4 rounded" type="submit" value="Search"/>
</div>
