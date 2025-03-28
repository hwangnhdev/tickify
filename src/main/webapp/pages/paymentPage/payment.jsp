<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>Booking Page</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet"/>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #222;
            }
            .countdown {
                background-color: rgb(56, 56, 61);
                padding: 2rem;
                border-radius: 8px;
                text-align: center;
            }
            .countdown p {
                font-size: 1rem;
            }
            .countdown .time {
                font-size: 1.5rem;
                font-weight: bold;
                color: #48BB78;
            }
        </style>
    </head>
    <body class="bg-dark-100">
        <div class="max-w-7xl mx-auto p-4">
            <!-- Event Header -->
            <div class="bg-cover bg-center h-48 relative" style="background-image: url('https://placehold.co/800x200');">
                <div class="absolute inset-0 bg-black opacity-50"></div>
                <div class="absolute inset-0 flex justify-between items-center text-white">
                    <div class="ml-8">
                        <h1 class="text-2xl font-bold">${event.eventName}</h1>
                        <div class="flex items-center mt-2">
                            <i class="fas fa-map-marker-alt mr-2"></i>
                            <p>${event.location}</p>
                        </div>
                        <div class="flex items-center mt-2">
                            <i class="fas fa-clock mr-2"></i>
                            <fmt:formatDate value="${sessionScope.showtime.startDate}" pattern="HH:mm" var="startTime"/>
                            <fmt:formatDate value="${sessionScope.showtime.endDate}" pattern="HH:mm" var="endTime"/>
                            <fmt:formatDate value="${sessionScope.showtime.startDate}" pattern="dd MMM, yyyy" var="formattedDate"/>
                            <p>${startTime} - ${endTime}, ${formattedDate}</p>
                        </div>
                    </div>
                    <div class="p-2 mr-8 rounded-md text-center countdown">
                        <p class="text-sm">Complete your booking within</p>
                        <div class="time" id="countdown">15:00</div>
                    </div>
                </div>
            </div>

            <!-- Payment Info -->
            <div class="flex justify-between items-center mt-4">
                <h2 class="text-lg font-bold text-green-500">PAYMENT INFO</h2>
            </div>
            <div class="grid grid-cols-12 gap-4 mt-4">
                <div class="col-span-9 text-white">
                    <!-- Ticket Receiving Info -->
                    <div class="p-4" style="background-color: rgb(56, 56, 61); border-radius: 12px;">
                        <h3 class="text-md font-bold" style="color: rgb(45, 194, 117);">Ticket receiving info</h3>
                        <div class="rounded-md flex justify-between items-start mt-2">
                            <div>
                                <span>${customer.fullName}</span>
                                <span class="ml-2">${customer.phone}</span>
                                <p>${customer.email}</p>
                            </div>
                            <a class="text-blue-500 underline" href="#" style="color: rgb(45, 194, 117);">Edit</a>
                        </div>
                    </div>
                    <!-- Payment Method -->
                    <div class="mt-4 p-4" style="background-color: rgb(56, 56, 61); border-radius: 12px;">
                        <h3 class="text-md font-bold" style="color: rgb(45, 194, 117);">Payment method</h3>
                        <div class="p-4 rounded-md mt-2 text-white">
                            <form action="<%= request.getContextPath()%>/vnPayAjax" id="frmCreateOrder" method="post">       
                                <input id="amount" name="amount" type="hidden" value="${subtotal}"/>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" type="radio" checked="" id="bankCode" name="bankCode" value="">
                                    <label class="flex items-center" for="vnpay">
                                        <img alt="VNPAY logo" class="mr-2" height="24" src="https://salt.tkbcdn.com/ts/ds/e5/6d/9a/a5262401410b7057b04114ad15b93d85.png" width="24"/>
                                        <span>Mobile banking app (VNPAY)</span>
                                        <span class="bg-red-500 text-white text-xs ml-2 px-2 py-1 rounded">New</span>
                                    </label>
                                </div>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" type="radio" id="bankCode" name="bankCode" value="VNBANK">
                                    <label class="flex items-center" for="atm">
                                        <img alt="ATM Card/Internet Banking logos" class="mr-2" height="24" src="https://salt.tkbcdn.com/ts/ds/03/97/87/6bbb3f032e1013ebdf406c93c3a8c1c7.png" width="24"/>
                                        <span>ATM Card/Internet Banking</span>
                                    </label>
                                </div>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" type="radio" id="bankCode" name="bankCode" value="INTCARD">
                                    <label class="flex items-center" for="creditcard">
                                        <img alt="Credit/Debit Card logos" class="mr-2" height="24" src="https://salt.tkbcdn.com/ts/ds/db/74/b5/5eee074088b8549fe8417dd82d17dabc.png" width="24"/>
                                        <span>International Credit/Debit Card</span>
                                    </label>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-span-3">
                    <!-- Ticket Information -->
                    <div class="bg-white p-4 shadow-md" style="border-radius: 12px;">
                        <h3 class="text-md font-bold">Ticket information</h3>
                        <div class="flex justify-between items-start mt-2">
                            <div><p class="font-bold">Ticket type</p></div>
                            <div class="flex flex-col items-end"><p class="font-bold">Quantity</p></div>
                        </div>
                        <c:forEach var="seatData" items="${sessionScope.seatDataList}">
                            <div class="flex justify-between items-start mt-2">
                                <div style="width: 50%;">
                                    <p>${seatData.name}</p>
                                    <p><c:forEach var="seat" items="${seatData.seats}">${seat.name} </c:forEach></p>
                                    </div>
                                    <div class="flex flex-col items-end">
                                        <p><fmt:formatNumber value="${seatData.price}" currencyCode="VND" minFractionDigits="0"/> VND</p>
                                    <p>x<fmt:formatNumber value="${seatData.count}" currencyCode="VND" minFractionDigits="0"/></p>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="mt-2"><a class="text-blue-500 underline" href="#">Reselect Ticket</a></div>
                    </div>
                    <!-- Discount Section -->
                    <div class="bg-white p-4 mt-4 shadow-md" style="border-radius: 12px;">
                        <h3 class="text-md font-bold">Discount</h3>
                        <div class="flex items-center mt-2">
                            <input id="voucherCode" class="border p-2 w-full" placeholder="ENTER DISCOUNT CODE" type="text"/>
                            <button id="applyVoucher" class="bg-gray-300 text-gray-700 p-2 ml-2">Apply</button>
                        </div>
                        <p id="voucherMessage" class="text-sm mt-2 text-red-500 hidden">Invalid voucher code</p>
                    </div>
                    <!-- Order Information -->
                    <div class="bg-white p-4 mt-4 shadow-md" style="border-radius: 12px;">
                        <h3 class="text-md font-bold">Order information</h3>
                        <div class="flex justify-between items-center mt-2">
                            <p>Subtotal</p>
                            <p class="font-bold"><fmt:formatNumber value="${subtotal}" currencyCode="VND" minFractionDigits="0"/> VND</p>
                        </div>
                        <div id="discountRow" class="flex justify-between items-center mt-2 hidden">
                            <p>Discount</p>
                            <p id="discountAmount" class="font-bold text-red-500">0 VND</p>
                        </div>
                        <div class="flex justify-between items-center mt-2">
                            <p>Total</p>
                            <p id="totalAmount" class="font-bold text-green-500"><fmt:formatNumber value="${subtotal}" currencyCode="VND" minFractionDigits="0"/> VND</p>
                        </div>
                        <div class="mt-2">
                            <p class="text-sm">By proceeding the order, you agree to the <a class="text-blue-500 underline" href="#">General Trading Conditions</a></p>
                        </div>
                        <div class="mt-4" style="width: 100%">
                            <button id="btnSubmit" class="bg-green-500 text-white w-full p-2 rounded-md" style="display: block; text-align: center">Payment</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JavaScript -->
        <script>
            let subtotal = ${subtotal}; // Get subtotal from session
            let discount = 0;
            let total = subtotal;

            $("#applyVoucher").click(function () {
                let voucherCode = $("#voucherCode").val().trim();
                if (!voucherCode) {
                    $("#voucherMessage").text("Please enter a voucher code").show();
                    return;
                }

                $.ajax({
                    url: "<%= request.getContextPath()%>/applyVoucher",
                    type: "POST",
                    data: {voucherCode: voucherCode, eventId: ${event.eventId}},
                    dataType: "json",
                    success: function (response) {
                        console.log("AJAX Response: ", response); // Log the response
                        if (response.success) {
                            discount = parseFloat(response.discount); // Ensure discount is a number
                            total = subtotal - discount;
                            $("#discountRow").removeClass("hidden");
                            $("#discountAmount").text(formatCurrency(discount) + " VND");
                            $("#totalAmount").text(formatCurrency(total) + " VND");
                            $("#amount").val(total); // Update hidden input for payment
                            $("#voucherMessage").hide();
                        } else {
                            $("#voucherMessage").text(response.message).show();
                            $("#discountRow").addClass("hidden");
                            discount = 0;
                            total = subtotal;
                            $("#totalAmount").text(formatCurrency(total) + " VND");
                            $("#amount").val(total);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("AJAX Error: ", status, error);
                        $("#voucherMessage").text("Error applying voucher").show();
                    }
                });
            });

            function formatCurrency(amount) {
                return amount.toLocaleString('vi-VN');
            }

            document.getElementById("btnSubmit").addEventListener("click", function () {
                document.getElementById("frmCreateOrder").submit();
            });

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

            // Countdown Logic (unchanged)
            let COUNTDOWN_DURATION = 15 * 60;
            let countdownTimer;
            let timeLeft;

            function startCountdown(duration) {
                let countdownDisplay = document.getElementById("countdown");
                let startTime = localStorage.getItem("countdownStartTime");
                let currentTime = Date.now();

                if (!startTime) {
                    startTime = currentTime;
                    localStorage.setItem("countdownStartTime", startTime);
                } else {
                    startTime = parseInt(startTime);
                }

                let elapsedTime = Math.floor((currentTime - startTime) / 1000);
                timeLeft = duration - elapsedTime;

                if (timeLeft <= 0) {
                    resetCountdown();
                    return;
                }

                updateCountdownDisplay();

                function countdownStep() {
                    if (timeLeft > 0) {
                        updateCountdownDisplay();
                        countdownTimer = setTimeout(countdownStep, 1000);
                        timeLeft--;
                    } else {
                        resetCountdown();
                        alert("Time is up!");
                    }
                }

                countdownStep();
            }

            function updateCountdownDisplay() {
                let countdownDisplay = document.getElementById("countdown");
                let minutes = Math.floor(timeLeft / 60);
                let seconds = timeLeft % 60;
                minutes = minutes < 10 ? "0" + minutes : minutes;
                seconds = seconds < 10 ? "0" + seconds : seconds;
                countdownDisplay.textContent = minutes + ":" + seconds;
            }

            function resetCountdown() {
                localStorage.removeItem("countdownStartTime");
                localStorage.setItem("countdownStartTime", Date.now());
                timeLeft = COUNTDOWN_DURATION;
                updateCountdownDisplay();
                startCountdown(COUNTDOWN_DURATION);
            }

            window.onload = function () {
                startCountdown(COUNTDOWN_DURATION);
            };

            window.onbeforeunload = function (event) {
                event.preventDefault();
                event.returnValue = "Are you sure you want to leave? Your booking progress will be lost.";
            };

            window.addEventListener("popstate", function (event) {
                clearTimeout(countdownTimer);
                let confirmLeave = confirm("Are you sure you want to go back? Your booking progress will be lost.");
                if (confirmLeave) {
                    resetCountdown();
                    history.back();
                } else {
                    startCountdown(timeLeft);
                    history.pushState(null, null, window.location.href);
                }
            });

            history.pushState(null, null, window.location.href);
        </script>
    </body>
</html>