<%-- 
    Document   : payment
    Created on : Jan 27, 2025, 4:26:45 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>
            Booking Page
        </title>
        <script src="https://cdn.tailwindcss.com">
        </script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #222;
            }
        </style>
    </head>
    <body class="bg-dark-100">
        <div class="max-w-7xl mx-auto p-4">
            <div class="bg-cover bg-center h-48 relative" style="background-image: url('https://placehold.co/800x200');">
                <div class="absolute inset-0 bg-black opacity-50">
                </div>
                <div class="absolute inset-0 flex justify-between items-center text-white">
                    <div class="ml-8">
                        <h1 class="text-2xl font-bold">
                            ${event.eventName}
                        </h1>
                        <div class="flex items-center mt-2">
                            <i class="fas fa-map-marker-alt mr-2">
                            </i>
                            <p>
                                ${event.location}
                            </p>
                        </div>
                        <div class="flex items-center mt-2">
                            <i class="fas fa-clock mr-2">
                            </i>
                            <!-- Hiển thị thời gian suất chiếu -->
                            <fmt:formatDate value="${sessionScope.showtime.startDate}" pattern="HH:mm" var="startTime"/>
                            <fmt:formatDate value="${sessionScope.showtime.endDate}" pattern="HH:mm" var="endTime"/>
                            <fmt:formatDate value="${sessionScope.showtime.startDate}" pattern="dd MMM, yyyy" var="formattedDate"/>

                            <p>${startTime} - ${endTime}, ${formattedDate}</p>
                        </div>
                    </div>
                    <div class="p-2 mr-8 rounded-md text-center" style="background-color: rgb(56, 56, 61);">
                        <p class="text-sm">
                            Complete your booking within
                        </p>
                        <div class="text-green-500 text-xl font-bold">
                            14 : 46
                        </div>
                    </div>
                </div>
            </div>
            <div class="flex justify-between items-center mt-4">
                <h2 class="text-lg font-bold text-green-500">
                    PAYMENT INFO
                </h2>
            </div>
            <div class="grid grid-cols-12 gap-4 mt-4">
                <div class="col-span-9 text-white">
                    <div class="p-4" style="background-color: rgb(56, 56, 61); border-radius: 12px;">
                        <h3 class="text-md font-bold" style="color: rgb(45, 194, 117);">
                            Ticket receiving info
                        </h3>
                        <div class="rounded-md flex justify-between items-start mt-2">
                            <div>
                                <span>
                                    ${customer.fullName}
                                </span>
                                <span class="ml-2">
                                    ${customer.phone}
                                </span>
                                <p>
                                    ${customer.email}
                                </p>
                            </div>
                            <a class="text-blue-500 underline" href="#" style="color: rgb(45, 194, 117);">
                                Edit
                            </a>
                        </div>
                    </div>
                    <div class="mt-4 p-4" style="background-color: rgb(56, 56, 61); border-radius: 12px;">
                        <h3 class="text-md font-bold" style="color: rgb(45, 194, 117);">
                            Payment method
                        </h3>
                        <div class="p-4 rounded-md mt-2 text-white">
                            <form action="<%= request.getContextPath()%>/vnPayAjax" id="frmCreateOrder" method="post">       
                                <input id="amount" name="amount" type="hidden" value="${subtotal}" />

                                <div class="flex items-center mb-4">
                                    <input class="mr-2" type="radio" Checked="True" id="bankCode" name="bankCode" value="">
                                    <label class="flex items-center" for="vnpay">
                                        <img alt="VNPAY logo" class="mr-2" height="24" src="https://salt.tkbcdn.com/ts/ds/e5/6d/9a/a5262401410b7057b04114ad15b93d85.png" width="24"/>
                                        <span>
                                            Mobile banking app (VNPAY)
                                        </span>
                                        <span class="bg-red-500 text-white text-xs ml-2 px-2 py-1 rounded">
                                            New
                                        </span>
                                    </label>
                                </div>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" type="radio" id="bankCode" name="bankCode" value="VNBANK">
                                    <label class="flex items-center" for="atm">
                                        <img alt="ATM Card/Internet Banking logos" class="mr-2" height="24" src="https://salt.tkbcdn.com/ts/ds/03/97/87/6bbb3f032e1013ebdf406c93c3a8c1c7.png" width="24"/>
                                        <span>
                                            ATM Card/Internet Banking
                                        </span>
                                    </label>
                                </div>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" type="radio" id="bankCode" name="bankCode" value="INTCARD">
                                    <label class="flex items-center" for="creditcard">
                                        <img alt="Credit/Debit Card logos" class="mr-2" height="24" src="https://salt.tkbcdn.com/ts/ds/db/74/b5/5eee074088b8549fe8417dd82d17dabc.png" width="24"/>
                                        <span>
                                            International Credit/Debit Card
                                        </span>
                                    </label>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
                <div class="col-span-3">
                    <div class="bg-white p-4 shadow-md" style="border-radius: 12px;">
                        <h3 class="text-md font-bold">
                            Ticket information
                        </h3>
                        <div class="flex justify-between items-start mt-2">
                            <div>
                                <p class="font-bold">
                                    Ticket type
                                </p>
                            </div>
                            <div class="flex flex-col items-end">
                                <p class="font-bold">
                                    Quantity
                                </p>
                            </div>
                        </div>
                        <c:forEach var="seatData" items="${sessionScope.seatDataList}">
                            <div class="flex justify-between items-start mt-2">
                                <div style="width: 50%;">
                                    <p>
                                        ${seatData.name}
                                    </p>
                                    <!--style="background-color: ${seatData.color}"-->
                                    <p >
                                        ${seatData.seats}
                                    </p>
                                </div>
                                <div class="flex flex-col items-end">
                                    <p>
                                        x<fmt:formatNumber value="${seatData.count}" currencyCode="VND" minFractionDigits="0" />
                                    </p>
                                    <p>
                                        <fmt:formatNumber value="${seatData.price}" currencyCode="VND" minFractionDigits="0" /> VND
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="mt-2">
                            <a class="text-blue-500 underline" href="#">
                                Reselect Ticket
                            </a>
                        </div>
                    </div>
                    <div class="bg-white p-4 mt-4 shadow-md" style="border-radius: 12px;">
                        <h3 class="text-md font-bold">
                            Discount
                        </h3>
                        <div class="flex items-center mt-2">
                            <input class="border p-2 w-full" placeholder="ENTER DISCOUNT CODE" type="text"/>
                            <button class="bg-gray-300 text-gray-700 p-2 ml-2">
                                Apply
                            </button>
                        </div>
                    </div>
                    <div class="bg-white p-4 mt-4 shadow-md" style="border-radius: 12px;">
                        <h3 class="text-md font-bold">
                            Order information
                        </h3>
                        <div class="flex justify-between items-center mt-2">
                            <p>Subtotal</p>
                            <p class="font-bold">
                                <fmt:formatNumber value="${subtotal}" currencyCode="VND" minFractionDigits="0" /> VND
                            </p>
                        </div>
                        <div class="flex justify-between items-center mt-2">
                            <p>Total</p>
                            <p class="font-bold text-green-500">
                                <fmt:formatNumber value="${subtotal}" currencyCode="VND" minFractionDigits="0" /> VND
                            </p>
                        </div>
                        <div class="mt-2">
                            <p class="text-sm">
                                By proceeding the order, you agree to the
                                <a class="text-blue-500 underline" href="#">
                                    General Trading Conditions
                                </a>
                            </p>
                        </div>
                        <div class="mt-4" style="width: 100%">
                            <button id="btnSubmit" class="bg-green-500 text-white w-full p-2 rounded-md" style="display: block; text-align: center">
                                Payment
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script>
            document.getElementById("btnSubmit").addEventListener("click", function () {
                document.getElementById("frmCreateOrder").submit();
            });
        </script>
        <script type="text/javascript">
            $("#frmCreateOrder").submit(function () {
                var postData = $("#frmCreateOrder").serialize();
                var submitUrl = $("#frmCreateOrder").attr("action");
                $.ajax({
                    type: "POST",
                    url: submitUrl,
                    data: postData,
                    dataType: 'JSON',
                    success: function (x) {
                        if (x.code === '00') {
                            if (window.vnpay) {
                                vnpay.open({width: 768, height: 600, url: x.data});
                            } else {
                                location.href = x.data;
                            }
                            return false;
                        } else {
                            alert(x.Message);
                        }
                    }
                });
                return false;
            });
        </script>  
    </body>
</html>