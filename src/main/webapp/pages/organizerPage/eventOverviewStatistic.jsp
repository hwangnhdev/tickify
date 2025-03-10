<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Event Overview Statistic</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
    </head>
    <body class="bg-gray-900 text-white">
        <section class="flex-1 p-4 overflow-y-auto">
            <div class="w-full p-4 space-y-6">
                <!-- Thống kê tổng quan -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
                    <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                        <h3 class="text-lg font-bold text-green-400">Total Revenue</h3>
                        <p id="totalRevenue" class="text-3xl font-bold text-white mt-2">${totalRevenue} VNÐ</p>
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
                        <h3 class="text-lg font-bold text-green-400">Fill Rate</h3>
                        <p id="fillRate" class="text-3xl font-bold text-white mt-2">${fillRate}%</p>
                    </div>
                </div>


                <!-- Biểu đồ doanh thu -->
                <div class="bg-gray-800 rounded-lg shadow-lg p-6 mt-6">
                    <!-- Bộ lọc năm -->
                    <div class="bg-gray-800 rounded-lg shadow-lg p-6">
                        <h3 class="text-lg font-bold text-green-400 mb-4">Select Year</h3>
                        <select id="yearSelect" class="bg-gray-700 text-white p-2 rounded">
                            <option value="2023">2020</option>
                            <option value="2023">2021</option>
                            <option value="2023">2022</option>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                            <option value="2025" selected>2025</option>
                            <option value="2026">2026</option>
                        </select>
                    </div>
                    <h3 class="text-lg font-bold text-green-400">Revenue Over Time</h3>
                    <div class="h-64 mt-4">
                        <canvas id="revenueChart"></canvas>
                    </div>
                </div>
            </div>
        </section>

        <script>
            let revenueChart;

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

            function updateChart(data) {
                revenueChart.data.datasets[0].data = data.monthlyRevenue;
                revenueChart.update();
            }

            function fetchRevenueData(year) {
                fetch(`${pageContext.request.contextPath}/eventOverview`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    },
                    body: JSON.stringify({eventId: 1, organizerId: 1, year: year})
                })
                        .then(response => response.json())
                        .then(data => updateChart(data))
                        .catch(error => console.error('Error fetching data:', error));
            }

            document.getElementById('yearSelect').addEventListener('change', function () {
                const selectedYear = this.value;
                fetchRevenueData(selectedYear);
            });

            initChart();
            fetchRevenueData(2025);
        </script>
    </body>
</html>