<%-- 
    Document   : searchVoucher
    Created on : 7 Mar 2025, 16:21:24
    Author     : Dinh Minh Tien CE190701
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <form action="searchVoucher" method="get" class="flex items-center">
        <input type="text" name="searchVoucher" placeholder="Search by Voucher code" 
               class="p-2 rounded bg-gray-700 text-white border border-gray-600 focus:ring-2 focus:ring-green-500" />
        <button type="submit" 
                class="bg-green-500 hover:bg-green-600 text-white p-2 rounded ml-2 transition-colors duration-200">
            Search
        </button>
    </form>
</html>
