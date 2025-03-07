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
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Seat Selection</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <style>
            body {
                background-color: #222;
            }
            .seat {
                height: 40px;
                margin: 5px;
                text-align: center;
                line-height: 40px;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s, transform 0.3s;
            }
            .seat.available:hover {
                background-color: #e0f7fa; /* Light blue on hover */
            }
            .seat.selected {
                background-color: #0d6efd;
                color: white;
                transform: scale(1.1);
                border: 3px solid #FFF;
            }
            .seat.not-available {
                background-color: #f44336; /* Red */
                color: white;
                cursor: not-allowed;
            }
            .seat-container {
                display: grid;
                grid-template-columns: repeat(16, 1fr);
                gap: 5px; /* Add gap between seats */
            }

            .ticket-item {
                display: flex;
                align-items: center;
                justify-content: center;
                background: white;
                color: black;
                padding: 4px 14px;
                margin-bottom: 5px;
                position: relative;
                font-weight: bold;
                box-shadow: 2px 2px 5px rgba(0, 0, 0, 0.2);
            }

            /* Tạo hình tam giác */
            .ticket-item::before,
            .ticket-item::after {
                content: "";
                position: absolute;
                width: 0;
                height: 0;
                border-style: solid;
            }

            .ticket-item::before {
                left: 0;
                top: 50%;
                transform: translateY(-50%);
                border-width: 10px 0 10px 8px;
                border-color: transparent transparent transparent rgb(56, 56, 61);
            }

            .ticket-item::after {
                right: 0;
                top: 50%;
                transform: translateY(-50%);
                border-width: 10px 8px 10px 0;
                border-color: transparent rgb(56, 56, 61) transparent transparent;
            }
            .truncate-text {
                width: 300px;  /* Giới hạn độ rộng */
                white-space: nowrap;  /* Không cho xuống dòng */
                overflow: hidden;  /* Ẩn phần bị tràn */
                text-overflow: ellipsis;  /* Hiển thị dấu "..." */
            }
        </style>
    </head>
    <body>
        <div class="container mx-auto py-5">
            <div class="flex flex-wrap -mx-4">
                <div class="w-full md:w-2/3 px-4">
                    <h1 class="text-center text-3xl font-bold mb-6" style="color: rgb(45, 194, 117);">Seat Selection</h1>
                    <div class="flex items-center justify-center space-x-6 mb-6">
                        <div class="flex items-center">
                            <div class="w-4 h-4 transparent border border-black rounded-lg mr-2 border-4 border-white" style="border-radius: 4px; height: 26px; width: 38px;"></div>
                            <span class="text-white">Selected</span>
                        </div>
                        <div class="flex items-center">
                            <div class="w-4 h-4 bg-gray-500 border border-black rounded-lg mr-2" style="border-radius: 4px; height: 26px; width: 38px;"></div>
                            <span class="text-white">Not Available</span>
                        </div>
                    </div>
                    <form action="<%= request.getContextPath()%>/viewPayment" method="post" id="seatForm">
                        <div class="seat-container" id="seatContainer">
                            <c:forEach var="seat" items="${seatsForEvent}">
                                <c:set var="seatClass" value="seat available" />
                                <c:set var="seatColor" value="${seat.color}" />
                                <c:set var="seatCursor" value="pointer" />

                                <c:if test="${seat.status eq 'unavailable'}">
                                    <c:set var="seatClass" value="seat unavailable" />
                                    <c:set var="seatColor" value="#808080" />  <%-- Màu xám --%>
                                    <c:set var="seatCursor" value="not-allowed" />
                                </c:if>
                                <div class="${seatClass}" 
                                     data-ticket_type_id="${seat.ticketTypeId}" 
                                     data-seat_id="${seat.seatId}" 
                                     data-seat="${seat.seatRow}${seat.seatCol}" 
                                     data-price="${seat.price * 1000}" 
                                     data-type="${seat.name}"
                                     style="background-color: ${seatColor}; color: #FFF; cursor: ${seatCursor}">
                                    ${seat.seatRow}${seat.seatCol}
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Input ẩn để lưu ghế và giá đã chọn -->
                        <input type="hidden" id="selectedSeats" name="selectedSeats">
                        <input type="hidden" id="selectedData" name="selectedData">
                        <input type="hidden" id="subtotal" name="subtotal">
                    </form>
                </div>
                <aside class="w-full md:w-1/3 px-4 mt-8 md:mt-0 text-white shadow-lg rounded-lg p-6" style="background-color: rgb(56, 56, 61); border-radius: 12px;">
                    <h4 class="text-xl font-bold mb-4">${event.eventName}</h4>
                    <div class="mb-4">
                        <div class="flex items-center mb-2">
                            <i class="fas fa-calendar-alt mr-2" style="color: rgb(45, 194, 117);"></i>
                            <!-- Hiển thị thời gian suất chiếu -->
                            <fmt:formatDate value="${sessionScope.showtime.startDate}" pattern="HH:mm" var="startTime"/>
                            <fmt:formatDate value="${sessionScope.showtime.endDate}" pattern="HH:mm" var="endTime"/>
                            <fmt:formatDate value="${sessionScope.showtime.startDate}" pattern="dd MMM, yyyy" var="formattedDate"/>

                            <p>${startTime} - ${endTime}, ${formattedDate}</p>
                        </div>
                        <div class="flex items-center">
                            <i class="fas fa-map-marker-alt mr-2" style="color: rgb(45, 194, 117);"></i>
                            <span>${event.location}</span>
                        </div>
                    </div>
                    <h5 class="text-lg font-bold mb-2">Pricing</h5>
                    <div class="mb-2">
                        <c:forEach var="ticketType" items="${ticketTypes}">
                            <div class="flex justify-between mb-2">
                                <div class="flex justify-between items-center" style="width: 50%;">
                                    <div class="w-4 h-4 bg-white border border-black mr-2" style="border-radius: 4px; height: 26px; width: 68px; background-color: ${ticketType.color};"></div>
                                    <p class="truncate-text">${ticketType.name}</p>
                                </div>
                                <span class="text-green-500">
                                    <fmt:formatNumber value="${ticketType.price * 1000}" currencyCode="VND" minFractionDigits="0" /> VND
                                </span>
                            </div>
                        </c:forEach>
                    </div>
                    <h5 class="text-lg font-bold mb-2">Selected Seats</h5>
                    <ul id="selectedSeatsList" class="list-disc mb-4 grid grid-cols-6 gap-2"></ul>
                    <div class="mt-4" style="width: 100%">
                        <button id="btnSubmit" class="bg-green-500 text-white w-full p-2 rounded-md" style="display: block; text-align: center">
                            Continue - <span id="totalPrice">Total Price: 0 VND</span>
                        </button>
                    </div>
                </aside>
            </div>
        </div>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const seats = document.querySelectorAll(".seat.available");
                const selectedSeatsList = document.getElementById("selectedSeatsList");
                const totalPriceElement = document.getElementById("totalPrice");
                const btnSubmit = document.getElementById("btnSubmit");
                const selectedSeatsInput = document.getElementById("selectedSeats");
                const selectedDataInput = document.getElementById("selectedData");
                const subtotalInput = document.getElementById("subtotal");

                let selectedSeats = [];
                let seatDataMap = new Map(); // Key: "ticketTypeId-color-price-name", Value: { count, seats[] }

                seats.forEach(seat => {
                    seat.addEventListener("click", function () {
                        const ticketTypeId = this.dataset.ticket_type_id; // Lấy Ticket Type ID
                        const seatId = this.dataset.seat_id; // Lấy Seat ID
                        const seatName = this.dataset.seat;
                        const seatPrice = parseFloat(this.dataset.price);
                        const seatColor = this.style.backgroundColor;
                        const ticketType = this.dataset.type;

                        if (this.classList.contains("selected")) {
                            this.classList.remove("selected");
                            removeSeat(ticketTypeId, seatId, seatName, seatPrice, seatColor, ticketType);
                        } else {
                            this.classList.add("selected");
                            addSeat(ticketTypeId, seatId, seatName, seatPrice, seatColor, ticketType);
                        }

                        updateTotalPrice();
                        updateHiddenInputs();
                    });
                });

                function addSeat(ticketTypeId, seatId, seat, price, color, ticketType) {
                    selectedSeats.push(seat);

                    const li = document.createElement("li");
                    li.classList.add("ticket-item");
                    li.setAttribute("data-seat", seat);
                    li.setAttribute("data-price", price);
                    li.style.backgroundColor = color;
                    li.style.color = "#FFF";
                    li.textContent = seat;
                    selectedSeatsList.appendChild(li);

                    const key = ticketTypeId + "-" + color + "-" + price + "-" + ticketType;
                    if (seatDataMap.has(key)) {
                        let seatInfo = seatDataMap.get(key);
                        seatInfo.count++;
                        seatInfo.seats.push({id: seatId, name: seat});
                    } else {
                        seatDataMap.set(key, {
                            ticketTypeId, // Lưu Ticket Type ID
                            price,
                            color,
                            name: ticketType,
                            count: 1,
                            seats: [{id: seatId, name: seat}]
                        });
                    }
                }

                function removeSeat(ticketTypeId, seatId, seat, price, color, ticketType) {
                    const index = selectedSeats.indexOf(seat);
                    if (index > -1) {
                        selectedSeats.splice(index, 1);
                    }

                    const key = ticketTypeId + "-" + color + "-" + price + "-" + ticketType;
                    if (seatDataMap.has(key)) {
                        let seatInfo = seatDataMap.get(key);
                        if (seatInfo.count > 1) {
                            seatInfo.count--;
                            seatInfo.seats = seatInfo.seats.filter(s => s.id !== seatId);
                        } else {
                            seatDataMap.delete(key);
                        }
                    }

                    const items = selectedSeatsList.querySelectorAll("li");
                    items.forEach(item => {
                        if (item.dataset.seat === seat) {
                            item.remove();
                        }
                    });
                }

                function updateTotalPrice() {
                    let total = 0;
                    seatDataMap.forEach(value => {
                        total += value.price * value.count;
                    });

                    totalPriceElement.textContent = "Total Price: " + total.toLocaleString("vi-VN") + " VND";
                    subtotalInput.value = total;
                }

                function updateHiddenInputs() {
                    selectedSeatsInput.value = selectedSeats.join(",");

                    let seatDataArray = [];
                    seatDataMap.forEach((value, key) => {
                        seatDataArray.push({
                            ticketTypeId: value.ticketTypeId, // Gửi Ticket Type ID
                            name: value.name,
                            color: value.color,
                            price: value.price,
                            count: value.count,
                            seats: value.seats
                        });
                    });

                    selectedDataInput.value = JSON.stringify(seatDataArray);
                }

                btnSubmit.addEventListener("click", function (event) {
                    if (selectedSeats.length === 0) {
                        alert("Please select at least one seat.");
                        event.preventDefault();
                    } else {
                        updateHiddenInputs();
                        document.getElementById("seatForm").submit();
                    }
                });
            });
        </script>
    </body>
</html>
