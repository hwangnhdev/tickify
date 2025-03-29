<%-- 
    Document   : vnpay_return
    Created on : Mar 5, 2025, 3:00:13 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page import="utils.VnPayUtils"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.nio.charset.StandardCharsets"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>
            Payment Result
        </title>
        <script src="https://cdn.tailwindcss.com">
        </script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&amp;display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <div class="container mx-auto p-4">
            <div class="bg-white shadow-md rounded-lg p-6">
                <div class="flex items-center justify-between mb-4">
                    <h1 class="text-2xl font-bold text-gray-800">Payment Result</h1>
                </div>

                <div class="text-center mb-6">
                    <h2 class="text-xl font-semibold text-green-600">
                        <c:choose>
                            <c:when test="${signValue eq vnp_SecureHash and vnp_TransactionStatus eq '00'}">
                                Payment Successful!
                            </c:when>
                            <c:when test="${signValue eq vnp_SecureHash}">
                                Payment Unsuccessful.
                            </c:when>
                            <c:otherwise>
                                Invalid Signature.
                            </c:otherwise>
                        </c:choose>
                    </h2>
                    <p class="text-gray-600">
                        Thank you for your purchase. Your order has been processed.
                    </p>
                </div>

                <div class="mb-6">
                    <h3 class="text-lg font-semibold text-gray-800 mb-2">Transaction Details</h3>
                    <div class="bg-gray-50 p-4 rounded-lg shadow-inner">
                        <div class="flex justify-between mb-2">
                            <span class="text-gray-600">Transaction ID:</span>
                            <span class="font-semibold text-gray-800">${requestScope.vnp_TransactionNo}</span>
                        </div>
                        <div class="flex justify-between mb-2">
                            <span class="text-gray-600">Payment Bank Code:</span>
                            <span class="font-semibold text-gray-800">${requestScope.vnp_BankCode}</span>
                        </div>
                        <div class="flex justify-between mb-2">
                            <span class="text-gray-600">Amount:</span>
                            <span class="font-semibold text-gray-800">
                                <fmt:formatNumber value="${requestScope.vnp_Amount / 100}" currencyCode="VND" minFractionDigits="0" /> VND
                            </span>
                        </div>
                        <div class="flex justify-between mb-2">
                            <span class="text-gray-600">Payment Time:</span>
                            <fmt:parseDate value="${requestScope.vnp_PayDate}" pattern="yyyyMMddHHmmss" var="payDate" type="both"/>
                            <fmt:formatDate value="${payDate}" pattern="HH:mm" var="formattedTime"/>
                            <fmt:formatDate value="${payDate}" pattern="dd MMM, yyyy" var="formattedDate"/>
                            <span class="font-semibold text-gray-800">${formattedTime} - ${formattedDate}</span>
                        </div>
                    </div>
                </div>

                <div class="text-center">
                    <a class="bg-blue-500 text-white px-4 py-2 rounded-lg shadow hover:bg-blue-600" href="<%= request.getContextPath()%>/event">
                        Back to Home
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>
