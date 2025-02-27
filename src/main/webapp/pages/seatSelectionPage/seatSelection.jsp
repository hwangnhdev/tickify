<%-- 
    Document   : seatSelection
    Created on : Jan 26, 2025, 12:21:29 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page import="models.Seat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seat Selection</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"></link>
    <style>
        .seat {
            width: 40px;
            height: 40px;
            margin: 5px;
            text-align: center;
            line-height: 40px;
            border-radius: 5px;
            cursor: pointer;
        }
        .seat.available {
            background-color: white;
            border: 1px solid black;
        }
        .seat.selected {
            background-color: #0d6efd;
            color: white;
        }
        .seat.not-available {
            background-color: red;
            color: white;
            cursor: not-allowed;
        }
        .seat-container {
            display: grid;
            grid-template-columns: repeat(16, 1fr);
        }
    </style>
</head>
<body class="bg-gray-100">
    <div class="container mx-10 py-5">
        <div class="flex flex-wrap -mx-4">
            <div class="w-full md:w-2/3 px-4">
                <h1 class="text-center text-2xl font-bold mb-4">Seat Selection</h1>
                <div class="flex items-center justify-center space-x-4 mb-4">
                    <div class="flex items-center">
                        <div class="w-3 h-3 bg-white border border-black rounded-full mr-2"></div>
                        <span>Available</span>
                    </div>
                    <div class="flex items-center">
                        <div class="w-3 h-3 bg-red-500 rounded-full mr-2"></div>
                        <span>Selected</span>
                    </div>
                    <div class="flex items-center">
                        <div class="w-3 h-3 bg-green-500 rounded-full mr-2"></div>
                        <span>Not Available</span>
                    </div>
                </div>
                <form action="<%= request.getContextPath()%>/pages/confirmSelectionPage/confirmSelection.jsp" method="post" id="seatForm">
                    <div class="seat-container" id="seatContainer">
                        <c:forEach var="seat" items="${seatsForEvent}">
                            <c:set var="seatClass" value="seat available" />
                            <c:if test="${seat.status eq 'not available'}">
                                <c:set var="seatClass" value="seat not-available" />
                            </c:if>
                            <div class="${seatClass}" data-seat="${seat.seatRow}${seat.seatNumber}">
                                ${seat.seatRow}${seat.seatNumber}
                            </div>
                        </c:forEach>
                    </div>
                    <input type="hidden" id="selectedSeats" name="selectedSeats" value="">
                    <div class="mt-4 text-center">
                        <button type="button" class="btn btn-primary" id="confirmSelection">Confirm Selection</button>
                    </div>
                </form>
            </div>
            <aside class="w-full md:w-1/3 px-4 mt-8 md:mt-0 bg-gray-200 p-4 rounded-lg">
                <h4 class="text-lg font-bold mb-4">Nhà Hát Kịch IDECAF: BÍCH HOA - Cô là ai?</h4>
                <div class="mb-4">
                    <div class="flex items-center mb-2">
                        <i class="fas fa-calendar-alt mr-2"></i>
                        <span>19:30, 7 February, 2025</span>
                    </div>
                    <div class="flex items-center">
                        <i class="fas fa-map-marker-alt mr-2"></i>
                        <span>Nhà Hát Kịch IDECAF</span>
                    </div>
                </div>
                <h5 class="text-lg font-bold mb-2">Pricing</h5>
                <div class="mb-2">
                    <div class="flex justify-between">
                        <span>Hạng VIP (Không dành cho trẻ dưới 8 tuổi)</span>
                        <span class="text-green-500">320.000 đ</span>
                    </div>
                    <div class="flex justify-between">
                        <span>Hạng Regular (Không dành cho trẻ dưới 8 tuổi)</span>
                        <span class="text-green-500">270.000 đ</span>
                    </div>
                </div>
                <h5 class="text-lg font-bold mb-2">Selected Seats</h5>
                <ul id="selectedSeatsList" class="list-group list-disc pl-5"></ul>
                <div class="mt-4">
                    <a type="button" href="<%= request.getContextPath()%>/pages/paymentPage/payment.jsp" class="btn btn-success w-full" id="confirmSelection">Continue - <span id="totalPrice">0</span> đ</a>
                </div>
            </aside>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const seats = document.querySelectorAll(".seat.available");
            const selectedSeatsList = document.getElementById("selectedSeatsList");

            seats.forEach(seat => {
                seat.addEventListener("click", function () {
                    if (this.classList.contains("selected")) {
                        this.classList.remove("selected");
                        removeSeatFromList(this.dataset.seat);
                    } else {
                        this.classList.add("selected");
                        addSeatToList(this.dataset.seat);
                    }
                });
            });

            function addSeatToList(seat) {
                const li = document.createElement("li");
                li.classList.add("list-group-item");
                li.textContent = seat;
                li.setAttribute("data-seat", seat);
                selectedSeatsList.appendChild(li);
            }

            function removeSeatFromList(seat) {
                const items = selectedSeatsList.querySelectorAll("li");
                items.forEach(item => {
                    if (item.dataset.seat === seat) {
                        item.remove();
                    }
                });
            }

            document.getElementById("confirmSelection").addEventListener("click", () => {
                const selectedSeats = Array.from(document.querySelectorAll(".seat.selected"))
                        .map(seat => seat.dataset.seat);

                if (selectedSeats.length === 0) {
                    alert("Please select at least one seat.");
                } else {
                    alert(`You have selected: ${selectedSeats.join(", ")}`);
                }
            });
        });
    </script>
</body>
</html>
