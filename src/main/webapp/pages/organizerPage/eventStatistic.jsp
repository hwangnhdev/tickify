<%-- 
    Document   : eventStatistic
    Created on : Feb 22, 2025, 10:40:01 AM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Event Statistics</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet" />
        <style>
            /* Căn bản cho body */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f9;
                color: #333;
                padding: 20px;
                min-height: 100vh;
            }

            .title_summary_event {
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 10px;
            }

            /* Tiêu đề chính */
            h1 {
                font-size: 2.5rem;
                font-weight: bold;
                color: #1f2937;
                text-align: center;
                margin-bottom: 20px;
            }

            /* Tiêu đề phụ */
            h2 {
                font-size: 1.5rem;
                color: #4b5563;
                margin: 10px 0;
            }

            /* Bảng */
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                background-color: #fff;
                border-radius: 8px;
                overflow: hidden;
            }

            th, td {
                padding: 12px 15px;
                text-align: center;
                border-bottom: 1px solid #e5e7eb;
            }

            th {
                background-color: #1f2937;
                color: #fff;
                font-weight: 600;
            }

            tr:nth-child(even) {
                background-color: #f9fafb;
            }

            tr:hover {
                background-color: #f3f4f6;
                transition: background-color 0.3s ease;
            }

            .overview {
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 24px;
                margin-top: 20px;
            }

            /* Card container */
            .p-6 {
                background-color: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                padding: 24px;
                margin-top: 20px;
            }

            .p-6 h1 {
                font-size: 1.75rem;
                text-align: left;
                color: #1f2937;
            }

            .p-6 h2 {
                font-size: 1.25rem;
                color: #6b7280;
            }

            .bg-gray-800 {
                background-color: #1f2937;
                color: #fff;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .bg-gray-800:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }

            svg circle:first-child {
                stroke: #4b5563;
            }

            svg circle:nth-child(2) {
                stroke: #facc15;
                transition: stroke-dasharray 0.5s ease;
            }

            .text-green-500 {
                font-weight: bold;
            }

            /* Style cho biểu đồ đường */
            .chart-container {
                background: linear-gradient(135deg, #1a1a2e, #16213e);
                border-radius: 1.5rem;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
                border: 1px solid rgba(255, 255, 255, 0.1);
                overflow: hidden;
                margin-top: 20px;
                padding: 2rem;
                font-family: "Inter", sans-serif;
                color: white;
            }

            .chart-container .flex.justify-between {
                padding: 1.5rem 2rem;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .w-4.h-4 {
                transition: all 0.3s ease;
                box-shadow: 0 0 10px rgba(255, 255, 255, 0.3);
            }

            .w-4.h-4:hover {
                transform: scale(1.3);
            }

            button {
                transition: all 0.3s ease;
                font-weight: 600;
                border: 1px solid rgba(255, 255, 255, 0.2);
                border-radius: 9999px;
            }

            .bg-gray-800-chart {
                background: rgba(255, 255, 255, 0.08);
            }

            .bg-gray-800-chart:hover {
                background: rgba(255, 255, 255, 0.15);
                transform: translateY(-2px);
            }

            .bg-green-500 {
                background: linear-gradient(45deg, #22c55e, #16a34a);
                color: white;
            }

            .bg-green-500:hover {
                background: linear-gradient(45deg, #16a34a, #15803d);
                transform: translateY(-2px);
            }

            .h-96 {
                background: rgba(255, 255, 255, 0.03);
                border-radius: 1rem;
                padding: 1.5rem;
                position: relative;
                z-index: 10;
            }

            @media (max-width: 768px) {
                .flex-col {
                    flex-direction: column;
                }

                table, th, td {
                    font-size: 0.9rem;
                }

                .chart-container .flex.justify-between {
                    flex-direction: column;
                    gap: 1.5rem;
                    padding: 1rem;
                }

                .chart-container .flex.space-x-2 {
                    width: 100%;
                    justify-content: center;
                    flex-wrap: wrap;
                    gap: 0.5rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="title_summary_event">
            <h1>Summary for Event: <c:out value="${salesSummary.eventName}" default="Unknown Event"/></h1>
        </div>

        <div class="overview">
            <fmt:setLocale value="vi_VN"/>
            <h2>Revenue: <fmt:formatNumber value="${salesSummary != null ? (salesSummary.grossSales * 1000) : 0}" pattern="#,##0 VND" /></h2>
            <h2>Total Tickets Sold: <c:out value="${salesSummary != null ? salesSummary.totalTicketsSold : 0}" default="0"/></h2>
        </div>

        <table border="1">
            <tr>
                <th>Ticket Type</th>
                <th>Total Tickets</th>
                <th>Tickets Sold</th>
                <th>Tickets Remaining</th>
                <th>Sold Percentage</th>
            </tr>
            <c:forEach var="summary" items="${ticketSummaries}">
                <tr>
                    <td><c:out value="${summary.ticketTypeName}"/></td>
                    <td><c:out value="${summary.totalTickets}"/></td>
                    <td><c:out value="${summary.ticketsSold}"/></td>
                    <td><c:out value="${summary.ticketsRemaining}"/></td>
                    <td><c:out value="${summary.soldPercentage}"/>%</td>
                </tr>
            </c:forEach>
        </table>

        <div class="p-6">
            <h1 class="text-xl font-semibold mb-4">Revenue</h1>
            <h2 class="text-lg mb-4">Overview</h2>
            <div class="flex flex-col md:flex-row gap-4">
                <div class="bg-gray-800 p-4 rounded-lg flex-1 flex items-center justify-between">
                    <div>
                        <h3 class="text-lg">Revenue</h3>
                        <fmt:setLocale value="vi_VN"/>
                        <p class="text-2xl font-bold">
                            <fmt:formatNumber value="${salesSummary != null ? (salesSummary.grossSales * 1000) : 0}" pattern="#,##0 VND" />
                        </p>
                        <p class="text-sm">Total Revenue: 
                            <fmt:formatNumber value="${salesSummary != null ? (salesSummary.grossSales * 1000) : 0}" pattern="#,##0 VND" />
                        </p>
                    </div>
                    <div class="flex items-center justify-center">
                        <div class="relative">
                            <svg class="w-16 h-16">
                            <circle class="text-gray-700" stroke-width="4" stroke="currentColor" fill="transparent" r="30" cx="32" cy="32" />
                            <circle class="text-yellow-500 progress-circle-revenue" stroke-width="4" stroke-dasharray="0, 188.4" stroke-linecap="round" stroke="currentColor" fill="transparent" r="30" cx="32" cy="32" />
                            </svg>
                            <div class="absolute inset-0 flex items-center justify-center">
                                <span class="text-green-500 text-lg font-semibold revenue-percentage">0%</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="bg-gray-800 p-4 rounded-lg flex-1 flex items-center justify-between">
                    <div>
                        <h3 class="text-lg">Sold Tickets</h3>
                        <p class="text-2xl font-bold">
                            <c:out value="${salesSummary != null ? salesSummary.totalTicketsSold : 0}" default="0"/> Ticket(s)
                        </p>
                        <p class="text-sm">Total Tickets: 
                            <c:set var="totalTickets" value="0"/>
                            <c:forEach var="summary" items="${ticketSummaries}">
                                <c:set var="totalTickets" value="${totalTickets + summary.totalTickets}"/>
                            </c:forEach>
                            <c:out value="${totalTickets}"/>
                        </p>
                    </div>
                    <div class="flex items-center justify-center">
                        <div class="relative">
                            <svg class="w-16 h-16">
                            <circle class="text-gray-700" stroke-width="4" stroke="currentColor" fill="transparent" r="30" cx="32" cy="32" />
                            <circle class="text-yellow-500 progress-circle-tickets" stroke-width="4" stroke-dasharray="0, 188.4" stroke-linecap="round" stroke="currentColor" fill="transparent" r="30" cx="32" cy="32" />
                            </svg>
                            <div class="absolute inset-0 flex items-center justify-center">
                                <span class="text-green-500 text-lg font-semibold tickets-percentage">0%</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Thêm biểu đồ đường phía dưới -->
        <div class="chart-container">
            <div class="flex justify-between items-center mb-4">
                <div class="flex items-center space-x-4">
                    <div class="flex items-center space-x-2">
                        <span class="w-4 h-4 bg-purple-600 rounded-full"></span>
                        <span class="font-medium">Doanh thu</span>
                    </div>
                    <div class="flex items-center space-x-2">
                        <span class="w-4 h-4 bg-green-600 rounded-full"></span>
                        <span class="font-medium">Số vé bán</span>
                    </div>
                </div>
                <div class="flex space-x-2">
                    <button class="px-4 py-2 bg-gray-800-chart rounded-full" onclick="updateChart('24h')" data-period="24h">24 giờ</button>
                    <button class="px-4 py-2 bg-gray-800-chart rounded-full" onclick="updateChart('7d')" data-period="7d">7 ngày</button>
                    <button class="px-4 py-2 bg-gray-800-chart rounded-full" onclick="updateChart('30d')" data-period="30d">30 ngày</button>
                    <button class="px-4 py-2 bg-gray-800-chart rounded-full" onclick="updateChart('365d')" data-period="365d">1 năm</button>
                </div>
            </div>
            <div class="h-96">
                <canvas id="lineChart"></canvas>
            </div>
        </div>

        <!-- JavaScript cho cả biểu đồ tròn và biểu đồ đường -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Update progress circles (keep existing logic unchanged)
                function updateProgressCircle(circleClass, percentageClass, percentage) {
                    const circle = document.querySelector(circleClass);
                    const percentageText = document.querySelector(percentageClass);
                    const circumference = 2 * Math.PI * 30;
                    const dashArray = (percentage / 100) * circumference;

                    if (circle && percentageText) {
                        circle.setAttribute('stroke-dasharray', `${dashArray}, ${circumference}`);
                                        percentageText.textContent = `${percentage.toFixed(2)}%`;
                                    }
                                }

                                const totalRevenue = ${salesSummary != null ? (salesSummary.grossSales * 1000) : 0};
                                const maxRevenue = totalRevenue > 0 ? totalRevenue * 2 : 1000000;
                                const revenuePercentage = totalRevenue > 0 ? (totalRevenue / maxRevenue) * 100 : 0;

                                const totalTicketsSold = ${salesSummary != null ? salesSummary.totalTicketsSold : 0};
                                const totalTickets = ${totalTickets != null ? totalTickets : 0};
                                const ticketPercentage = totalTickets > 0 ? (totalTicketsSold / totalTickets) * 100 : 0;

                                updateProgressCircle('.progress-circle-revenue', '.revenue-percentage', revenuePercentage);
                                updateProgressCircle('.progress-circle-tickets', '.tickets-percentage', ticketPercentage);

                                // Line chart
                                let chart;
                                const ctx = document.getElementById("lineChart");

                                if (ctx) {
                                    // Parse the JSON data from the controller
                                    const chartData = ${chartDataJson};

                                    // Function to prepare chart data based on period labels
                                    function prepareChartData(period, data) {
                                        const labels = getLabelsForPeriod(period);
                                        const revenueData = new Array(labels.length).fill(0);
                                        const ticketsData = new Array(labels.length).fill(0);

                                        if (data && data.length > 0) {
                                            data.forEach(item => {
                                                console.log("Item date: " + item.date + ", Revenue: " + item.revenue + ", Tickets: " + item.totalTicketsSold); // Debug
                                                const index = labels.indexOf(item.date);
                                                if (index !== -1) {
                                                    revenueData[index] = item.revenue || 0;
                                                    ticketsData[index] = item.totalTicketsSold || 0;
                                                }
                                            });
                                        }

                                        return {
                                            labels: labels,
                                            datasets: [
                                                {
                                                    label: "Doanh thu",
                                                    borderColor: "rgba(128, 0, 128, 0.9)",
                                                    backgroundColor: "rgba(128, 0, 128, 0.2)",
                                                    data: revenueData,
                                                    yAxisID: "y",
                                                    borderWidth: 2,
                                                    pointRadius: 4,
                                                    pointHoverRadius: 6,
                                                    pointBackgroundColor: "rgba(128, 0, 128, 0.9)",
                                                    pointBorderColor: "white",
                                                },
                                                {
                                                    label: "Số vé bán",
                                                    borderColor: "rgba(34, 197, 94, 0.9)",
                                                    backgroundColor: "rgba(34, 197, 94, 0.2)",
                                                    data: ticketsData,
                                                    yAxisID: "y",
                                                    borderWidth: 2,
                                                    pointRadius: 4,
                                                    pointHoverRadius: 6,
                                                    pointBackgroundColor: "rgba(34, 197, 94, 0.9)",
                                                    pointBorderColor: "white",
                                                },
                                            ],
                                        };
                                    }

                                    // Function to get labels for each period (matching the controller's default data structure)
                                    function getLabelsForPeriod(period) {
                                        switch (period) {
                                            case "24h":
                                                return ["08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00"];
                                            case "7d":
                                                return ["01/02", "02/02", "03/02", "04/02", "05/02", "06/02", "07/02"];
                                            case "30d":
                                                return ["24/01", "26/01", "28/01", "30/01", "01/02", "03/02", "05/02", "07/02", "09/02", "11/02", "13/02", "15/02", "17/02", "19/02", "21/02"];
                                            case "365d":
                                                return ["01/02/2024", "01/03/2024", "01/04/2024", "01/05/2024", "01/06/2024", "01/07/2024", "01/08/2024", "01/09/2024", "01/10/2024", "01/11/2024", "01/12/2024", "01/01/2025", "01/02/2025"];
                                            default:
                                                return ["08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00"];
                                        }
                                    }

                                    // Initialize chart with default 24h data
                                    chart = new Chart(ctx, {
                                        type: "line",
                                        data: prepareChartData("24h", chartData),
                                        options: {
                                            responsive: true,
                                            maintainAspectRatio: false,
                                            scales: {
                                                y: {
                                                    type: "linear",
                                                    display: true,
                                                    position: "left",
                                                    suggestedMin: 0, // Ensure lines start at y=0
                                                    suggestedMax: 10, // Adjust dynamically based on data if needed
                                                    ticks: {color: "white", stepSize: 1, padding: 10},
                                                    grid: {color: "rgba(255, 255, 255, 0.1)", drawBorder: false},
                                                    title: {display: false},
                                                },
                                                x: {
                                                    ticks: {color: "white", padding: 10},
                                                    grid: {color: "rgba(255, 255, 255, 0.1)", drawBorder: false},
                                                    title: {display: false},
                                                },
                                            },
                                            plugins: {
                                                legend: {
                                                    display: true,
                                                    position: "bottom",
                                                    labels: {color: "white", font: {size: 14, weight: "500"}, padding: 15, boxWidth: 20, boxHeight: 2},
                                                },
                                                tooltip: {
                                                    enabled: true,
                                                    mode: "index",
                                                    intersect: false,
                                                    backgroundColor: "rgba(0, 0, 0, 0.9)",
                                                    titleColor: "white",
                                                    bodyColor: "white",
                                                    borderColor: "rgba(255, 255, 255, 0.15)",
                                                    borderWidth: 1,
                                                    padding: 12,
                                                    callbacks: {
                                                        label: function (tooltipItem) {
                                                            const dataset = chart.data.datasets[tooltipItem.datasetIndex];
                                                            const value = tooltipItem.raw || 0;
                                                            return dataset.label === "Doanh thu" ? `Doanh thu: ${value} VND` : `Số vé bán: ${value}`;
                                                        },
                                                    },
                                                },
                                            },
                                        },
                                    });

                                    // Update chart function
                                    window.updateChart = function (period) {
                                        if (!chart)
                                            return;
                                        console.log("Updating chart for period: " + period);
                                        const newData = prepareChartData(period, ${chartDataJson});
                                        chart.data.labels = newData.labels;
                                        chart.data.datasets = newData.datasets;
                                        chart.update({duration: 500});

                                        // Update button styles
                                        const buttons = document.querySelectorAll(".chart-container .flex.space-x-2 button");
                                        buttons.forEach((btn) => {
                                            btn.classList.remove("bg-green-500", "bg-gray-800-chart");
                                            const btnPeriod = btn.getAttribute("data-period");
                                            if (btnPeriod === period) {
                                                btn.classList.add("bg-green-500");
                                            } else {
                                                btn.classList.add("bg-gray-800-chart");
                                            }
                                        });
                                    };

                                    // Set default chart to 24h and ensure the "24h" button is active
                                    updateChart("24h");

                                    // Ensure all buttons have the data-period attribute
                                    const buttons = document.querySelectorAll(".chart-container .flex.space-x-2 button");
                                    buttons.forEach((btn) => {
                                        if (btn.getAttribute("onclick").includes("24h"))
                                            btn.setAttribute("data-period", "24h");
                                        else if (btn.getAttribute("onclick").includes("7d"))
                                            btn.setAttribute("data-period", "7d");
                                        else if (btn.getAttribute("onclick").includes("30d"))
                                            btn.setAttribute("data-period", "30d");
                                        else if (btn.getAttribute("onclick").includes("365d"))
                                            btn.setAttribute("data-period", "365d");
                                    });
                                }
                            });
        </script>
    </body>
</html>