<%-- 
    Document   : eventOverviewStatistic
    Created on : Mar 6, 2025, 5:44:28 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Event Overview Statistic</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chartjs-plugin-datalabels"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <style>
            .truncate-text {
                max-width: 100px;
                width: 20%;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }
            .total-row {
                font-weight: bold;
                background-color: #4b5563;
            }
        </style>
    </head>
    <body class="bg-gray-900 text-white">
        <div class="flex h-screen">
            <jsp:include page="sideBar.jsp"></jsp:include>
            <input type="hidden" id="eventId" value="${eventId}">
            <section class="flex-1 p-4 overflow-y-auto">
                <div class="w-full p-4 space-y-6">
                    <!-- Thống kê tổng quan -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                        <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                            <h3 class="text-lg font-bold text-green-400">Total Revenue</h3>
                            <p id="totalRevenue" class="text-3xl font-bold text-white mt-2"><fmt:formatNumber value="${totalRevenue}" currencyCode="VND" minFractionDigits="0" /> VND</p>
                        </div>
                        <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                            <h3 class="text-lg font-bold text-green-400">Tickets Sold</h3>
                            <p id="ticketsSold" class="text-3xl font-bold text-white mt-2">${ticketsSold}</p>
                        </div>
                        <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                            <h3 class="text-lg font-bold text-green-400">Tickets Remaining</h3>
                            <p id="ticketsRemaining" class="text-3xl font-bold text-white mt-2">${ticketsRemaining}</p>
                        </div>
                        <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                            <h3 class="text-lg font-bold text-green-400">Total Tickets</h3>
                            <p id="ticketsSold" class="text-3xl font-bold text-white mt-2">${totalTickets}</p>
                        </div>
                        <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                            <h3 class="text-lg font-bold text-green-400">Fill Rate</h3>
                            <p id="fillRate" class="text-3xl font-bold text-white mt-2">${fillRate}%</p>
                        </div>
                        <div>
                            <canvas id="fillRateChart" class="h-48"></canvas>
                        </div>
                    </div>

                    <!-- Biểu đồ doanh thu -->
                    <div class="bg-gray-800 rounded-lg shadow-lg p-6 mt-6">
                        <!-- Bộ lọc năm -->
                        <!-- Bộ lọc thời gian -->
                        <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                            <h3 class="text-lg font-bold text-green-400 mb-4">Select Time Range</h3>
                            <div class="flex space-x-4">
                                <select id="timeRangeSelect" class="bg-gray-700 text-white p-2 rounded">
                                    <option value="year" selected>Year</option>
                                    <option value="30days">30 Days</option>
                                    <option value="24hours">24 Hours</option>
                                </select>
                                <span id="yearSelectContainer">
                                    <select id="yearSelect" class="bg-gray-700 text-white p-2 rounded">
                                        <option value="2020">2020</option>
                                        <option value="2021">2021</option>
                                        <option value="2022">2022</option>
                                        <option value="2023">2023</option>
                                        <option value="2024">2024</option>
                                        <option value="2025" selected>2025</option>
                                        <option value="2026">2026</option>
                                    </select>
                                </span>
                            </div>
                        </div>
                    </div>
                    <h3 class="text-lg font-bold text-green-400">Revenue Over Time</h3>
                    <div class="h-64 mt-4">
                        <canvas id="revenueChart"></canvas>
                    </div>
                    <h3 class="text-lg font-bold text-green-400">Ticket Over Time</h3>
                    <div class="h-64 mt-4">
                        <canvas id="ticketChart"></canvas>
                    </div>
                </div>
                <div class="container mx-auto p-4">
                    <h2 class="text-lg font-bold mb-4 text-center">Details</h2>
                    <h3 class="text-md mb-2 text-center">Sold Tickets</h3>
                    <hr class="border-gray-700 mb-4">
                    <div class="overflow-x-auto">
                        <c:if test="${empty showtimeTicketMap}">
                            <p class="text-center">No ticket revenue data available for this event.</p>
                        </c:if>
                        <c:forEach var="entry" items="${showtimeTicketMap}" varStatus="loop">
                            <c:if test="${not empty entry.value}">
                                <h3 class="text-md mb-2 cursor-pointer" onclick="toggleShowtime('showtime${entry.key}', 'icon${entry.key}')">
                                    <i id="icon${entry.key}" class="fas fa-chevron-up"></i>
                                    Showtime ${loop.count}: 
                                    <c:choose>
                                        <c:when test="${not empty entry.value[0].startDate}">
                                            <fmt:formatDate value="${entry.value[0].startDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </c:when>
                                        <c:otherwise>
                                            N/A
                                        </c:otherwise>
                                    </c:choose> - 
                                    <c:choose>
                                        <c:when test="${not empty entry.value[0].endDate}">
                                            <fmt:formatDate value="${entry.value[0].endDate}" pattern="dd/MM/yyyy HH:mm"/>
                                        </c:when>
                                        <c:otherwise>
                                            N/A
                                        </c:otherwise>
                                    </c:choose>
                                </h3>
                                <table id="showtime${entry.key}" class="min-w-full bg-gray-800 text-white border-separate" style="border-spacing: 0 10px; display: table;">
                                    <thead>
                                        <tr>
                                            <th class="px-4 py-2 border-r border-gray-700">Ticket Type</th>
                                            <th class="px-4 py-2 border-r border-gray-700">Total Ticket</th>
                                            <th class="px-4 py-2 border-r border-gray-700">Price of Ticket</th>
                                            <th class="px-4 py-2 border-r border-gray-700">Sold</th>
                                            <th class="px-4 py-2 border-r border-gray-700">Remaining</th>
                                            <th class="px-4 py-2 border-r border-gray-700">Total Revenue</th>
                                            <th class="px-4 py-2">Fill Rate</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="ticket" items="${entry.value}">
                                            <tr>
                                                <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700 truncate-text">${ticket.ticketType}</td>
                                                <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">${ticket.totalTicket}</td>
                                                <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">
                                                    <fmt:formatNumber value="${ticket.priceOfTicket}" pattern="#,##0"/>đ
                                                </td>
                                                <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">${ticket.sold}</td>
                                                <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">${ticket.remaining}</td>
                                                <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">
                                                    <fmt:formatNumber value="${ticket.totalRevenue}" pattern="#,##0"/>đ
                                                </td>
                                                <td class="border-t border-gray-700 px-4 py-2">
                                                    <div class="relative w-full h-4 bg-gray-700">
                                                        <div class="absolute top-0 left-0 h-4 bg-yellow-500" style="width: ${ticket.fillRate}%;"></div>
                                                    </div>
                                                    <div class="text-right">
                                                        <fmt:formatNumber value="${ticket.fillRate}" pattern="#,##0.00"/>%
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        <!-- Hàng tổng -->
                                        <c:set var="totalTypes" value="${entry.value.size()}" />
                                        <c:set var="totalTickets" value="0" />
                                        <c:set var="totalSold" value="0" />
                                        <c:set var="totalRemaining" value="0" />
                                        <c:set var="totalRevenueSum" value="0" />
                                        <c:set var="totalFillRate" value="0" />
                                        <c:forEach var="ticket" items="${entry.value}">
                                            <c:set var="totalTickets" value="${totalTickets + ticket.totalTicket}" />
                                            <c:set var="totalSold" value="${totalSold + ticket.sold}" />
                                            <c:set var="totalRemaining" value="${totalRemaining + ticket.remaining}" />
                                            <c:set var="totalRevenueSum" value="${totalRevenueSum + ticket.totalRevenue}" />
                                            <c:set var="totalFillRate" value="${totalFillRate + ticket.fillRate}" />
                                        </c:forEach>
                                        <c:set var="averageFillRate" value="${totalFillRate / totalTypes}" />
                                        <tr class="total-row">
                                            <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">Total</td>
                                            <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">${totalTickets}</td>
                                            <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">-</td>
                                            <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">${totalSold}</td>
                                            <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">${totalRemaining}</td>
                                            <td class="border-t border-gray-700 px-4 py-2 border-r border-gray-700">
                                                <fmt:formatNumber value="${totalRevenueSum}" pattern="#,##0"/>đ
                                            </td>
                                            <td class="border-t border-gray-700 px-4 py-2">
                                                <div class="relative w-full h-4 bg-gray-700">
                                                    <div class="absolute top-0 left-0 h-4 bg-yellow-500" style="width: ${averageFillRate}%;"></div>
                                                </div>
                                                <div class="text-right">
                                                    <fmt:formatNumber value="${averageFillRate}" pattern="#,##0.00"/>%
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <hr class="border-gray-700 mt-4">
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
        </div>
    </section>

    <script>
        // Lấy eventId từ input hidden
        const eventId = document.getElementById('eventId').value;

        // Lấy năm hiện tại
        const currentYear = new Date().getFullYear();

        // Đặt năm mặc định cho dropdown
        const yearSelect = document.getElementById('yearSelect');
        yearSelect.value = currentYear;

        // Khai báo biến biểu đồ
        let revenueChart;
        let ticketChart;

        // Hàm kiểm tra và hiển thị/ẩn yearSelectContainer
        function toggleYearSelect() {
            const timeRange = document.getElementById('timeRangeSelect').value;
            const yearSelectContainer = document.getElementById('yearSelectContainer');

            if (timeRange === 'year') {
                yearSelectContainer.style.display = 'inline-block'; // Hiển thị khi chọn "Year"
            } else {
                yearSelectContainer.style.display = 'none'; // Ẩn khi chọn "30 Days" hoặc "24 Hours"
            }
        }

        // Gọi hàm toggleYearSelect khi tải trang để thiết lập trạng thái ban đầu for selec time and day and year
        toggleYearSelect();

        // Thêm sự kiện change cho timeRangeSelect
        document.getElementById('timeRangeSelect').addEventListener('change', function () {
            toggleYearSelect(); // Cập nhật trạng thái hiển thị của yearSelectContainer
            const selectedYear = yearSelect.value;
            const timeRange = this.value;
            fetchRevenueData(eventId, selectedYear, timeRange);
        });

        function initFillRateChart(fillRate) {
            const ctx = document.getElementById('fillRateChart').getContext('2d');
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: ['Filled', 'Remaining'],
                    datasets: [{
                            data: [fillRate, 100 - fillRate],
                            backgroundColor: ['#22c55e', '#374151'],
                            borderWidth: 2,
                            hoverOffset: 5
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: {color: '#fff'}
                        },
                        datalabels: {
                            color: '#fff',
                            font: {
                                weight: 'bold',
                                size: 16
                            },
                            formatter: (value, context) => {
                                return value + '%';
                            }
                        }
                    }
                },
                plugins: [ChartDataLabels]
            });
        }

        const fillRateText = document.getElementById('fillRate').innerText;
        const fillRateValue = parseFloat(fillRateText.replace('%', '')) || 0;
        initFillRateChart(fillRateValue);

        // Hàm khởi tạo biểu đồ doanh thu
        function initChart() {
            const revenueCtx = document.getElementById('revenueChart').getContext('2d');
            revenueChart = new Chart(revenueCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                            label: 'Doanh thu',
                            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                            backgroundColor: 'rgba(34, 197, 94, 0.2)',
                            borderColor: 'rgba(34, 197, 94, 1)',
                            borderWidth: 2,
                            fill: true,
                            pointBackgroundColor: 'rgba(34, 197, 94, 1)',
                            pointBorderColor: '#fff',
                            pointHoverBackgroundColor: '#fff',
                            pointHoverBorderColor: 'rgba(34, 197, 94, 1)',
                            tension: 0.4
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            min: 0,
                            ticks: {color: '#fff'},
                            grid: {color: 'rgba(255, 255, 255, 0.1)'}
                        },
                        x: {
                            ticks: {color: '#fff'},
                            grid: {color: 'rgba(255, 255, 255, 0.1)'}
                        }
                    },
                    plugins: {
                        legend: {
                            display: true,
                            labels: {color: 'rgba(34, 197, 94, 1)'}
                        }
                    }
                }
            });
        }

        // Hàm khởi tạo biểu đồ vé
        function initTicketChart() {
            const ticketCtx = document.getElementById('ticketChart').getContext('2d');
            ticketChart = new Chart(ticketCtx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
                    datasets: [{
                            label: 'Số vé bán được',
                            data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
                            backgroundColor: 'rgba(59, 130, 246, 0.2)',
                            borderColor: 'rgba(59, 130, 246, 1)',
                            borderWidth: 2,
                            fill: true,
                            pointBackgroundColor: 'rgba(59, 130, 246, 1)',
                            pointBorderColor: '#fff',
                            pointHoverBackgroundColor: '#fff',
                            pointHoverBorderColor: 'rgba(59, 130, 246, 1)',
                            tension: 0.4
                        }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            min: 0,
                            ticks: {color: '#fff'},
                            grid: {color: 'rgba(255, 255, 255, 0.1)'}
                        },
                        x: {
                            ticks: {color: '#fff'},
                            grid: {color: 'rgba(255, 255, 255, 0.1)'}
                        }
                    },
                    plugins: {
                        legend: {
                            display: true,
                            labels: {color: 'rgba(59, 130, 246, 1)'}
                        }
                    }
                }
            });
        }

        // Cập nhật nhãn và dữ liệu biểu đồ dựa trên timeRange
        function updateCharts(data, timeRange) {
            let labels;

            if (timeRange === 'year') {
                labels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                revenueChart.data.datasets[0].data = data.monthlyRevenue;
                ticketChart.data.datasets[0].data = data.monthlyTickets;
            } else if (timeRange === '30days') {
                labels = Array.from({length: 30}, (_, i) => {
                    const date = new Date();
                    date.setDate(date.getDate() - (29 - i));
                    return date.toLocaleDateString('en-US', {month: 'short', day: 'numeric'});
                });
                revenueChart.data.datasets[0].data = data.revenueLast30Days;
                ticketChart.data.datasets[0].data = data.ticketsLast30Days;
            } else if (timeRange === '24hours') {
                labels = Array.from({length: 24}, (_, i) => {
                    const date = new Date();
                    date.setHours(date.getHours() - (23 - i));
                    return date.toLocaleTimeString('en-US', {hour: '2-digit', hour12: false});
                });
                revenueChart.data.datasets[0].data = data.revenueLast24Hours;
                ticketChart.data.datasets[0].data = data.ticketsLast24Hours;
            }

            // Cập nhật nhãn cho cả hai biểu đồ
            revenueChart.data.labels = labels;
            ticketChart.data.labels = labels;

            // Cập nhật biểu đồ
            revenueChart.update();
            ticketChart.update();
        }

        // Hàm gửi yêu cầu lấy dữ liệu
        function fetchRevenueData(eventId, year, timeRange) {
            fetch(`${pageContext.request.contextPath}/eventOverview`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                },
                body: JSON.stringify({eventId: eventId, year: year, timeRange: timeRange})
            })
                    .then(response => response.json())
                    .then(data => updateCharts(data, timeRange))
                    .catch(error => console.error('Error fetching data:', error));
        }

        // Khởi tạo biểu đồ
        initChart();
        initTicketChart();
        fetchRevenueData(eventId, currentYear, 'year');

        // Xử lý sự kiện thay đổi bộ lọc
        yearSelect.addEventListener('change', function () {
            const selectedYear = this.value;
            const timeRange = document.getElementById('timeRangeSelect').value;
            fetchRevenueData(eventId, selectedYear, timeRange);
        });

        document.getElementById('timeRangeSelect').addEventListener('change', function () {
            const selectedYear = yearSelect.value;
            const timeRange = this.value;
            fetchRevenueData(eventId, selectedYear, timeRange);
        });

        // Toggle for ticket details
        function toggleShowtime(id, iconId) {
            var element = document.getElementById(id);
            var icon = document.getElementById(iconId);
            if (element.style.display === "none") {
                element.style.display = "table";
                icon.classList.remove("fa-chevron-down");
                icon.classList.add("fa-chevron-up");
            } else {
                element.style.display = "none";
                icon.classList.remove("fa-chevron-up");
                icon.classList.add("fa-chevron-down");
            }
        }
    </script>
</div>
</body>
</html>