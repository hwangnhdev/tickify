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
        <title>JSP Page</title>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"></link>
        <style>
            /* Căn bản cho body */
            body {
                font-family: 'Arial', sans-serif;
                background-color: #f4f4f9;
                color: #333;
                padding: 20px;
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

            /* Tiêu đề trong card */
            .p-6 h1 {
                font-size: 1.75rem;
                text-align: left;
                color: #1f2937;
            }

            .p-6 h2 {
                font-size: 1.25rem;
                color: #6b7280;
            }

            /* Card bên trong */
            .bg-gray-800 {
                background-color: #1f2937;
                color: #fff;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .bg-gray-800:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            }

            /* Vòng tròn tiến trình */
            svg circle:first-child {
                stroke: #4b5563;
            }

            svg circle:nth-child(2) {
                stroke: #facc15;
                transition: stroke-dasharray 0.5s ease;
            }

            /* Tùy chỉnh phần trăm */
            .text-green-500 {
                font-weight: bold;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .flex-col {
                    flex-direction: column;
                }

                table, th, td {
                    font-size: 0.9rem;
                }
            }
        </style>
    </head>
    <body>
        <div class="title_summary_event">
            <h1>Summary for Event: <c:out value="${salesSummary.eventName}" default="Unknown Event"/></h1>
        </div>

        <!-- Hiển thị số vé đã bán và doanh thu -->
        <div class="overview">
            <fmt:setLocale value="vi_VN"/>
            <h2>Revenue: <fmt:formatNumber value="${salesSummary != null ? (salesSummary.grossSales * 1000) : 0}" pattern="#,##0 VND" /></h2>
            <h2>Total Tickets Sold: <c:out value="${salesSummary != null ? salesSummary.totalTicketsSold : 0}" default="0"/></h2>
        </div>

        <!-- Bảng chi tiết vé đã bán -->
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
                <!-- Card Doanh Thu -->
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

                <!-- Card Vé Đã Bán -->
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

        <!-- JavaScript để cập nhật vòng tròn tiến trình -->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Hàm tính toán stroke-dasharray cho vòng tròn
                function updateProgressCircle(circleClass, percentageClass, percentage) {
                    const circle = document.querySelector(circleClass);
                    const percentageText = document.querySelector(percentageClass);
                    const circumference = 2 * Math.PI * 30; // Chu vi của vòng tròn (r=30)
                    const dashArray = (percentage / 100) * circumference;

                    if (circle && percentageText) {
                        circle.setAttribute('stroke-dasharray', `${dashArray}, ${circumference}`);
                                        percentageText.textContent = `${percentage.toFixed(2)}%`;
                                    } else {
                                        console.error('Không tìm thấy phần tử:', circleClass, percentageClass);
                                    }
                                }

                                // Lấy dữ liệu từ JSP
                                const totalRevenue = ${salesSummary != null ? (salesSummary.grossSales * 1000) : 0};
                                // Giả định maxRevenue dựa trên một giá trị hợp lý (có thể thay đổi theo logic thực tế)
                                const maxRevenue = totalRevenue > 0 ? totalRevenue * 2 : 1000000; // Ví dụ: maxRevenue gấp đôi totalRevenue
                                const revenuePercentage = totalRevenue > 0 ? (totalRevenue / maxRevenue) * 100 : 0;

                                const totalTicketsSold = ${salesSummary != null ? salesSummary.totalTicketsSold : 0};
                                const totalTickets = ${totalTickets != null ? totalTickets : 0}; // Đảm bảo totalTickets hợp lệ
                                const ticketPercentage = totalTickets > 0 ? (totalTicketsSold / totalTickets) * 100 : 0;

                                // Ghi log để kiểm tra giá trị
                                console.log('totalRevenue:', totalRevenue);
                                console.log('maxRevenue:', maxRevenue);
                                console.log('revenuePercentage:', revenuePercentage);
                                console.log('totalTicketsSold:', totalTicketsSold);
                                console.log('totalTickets:', totalTickets);
                                console.log('ticketPercentage:', ticketPercentage);

                                // Cập nhật vòng tròn tiến trình
                                updateProgressCircle('.progress-circle-revenue', '.revenue-percentage', revenuePercentage);
                                updateProgressCircle('.progress-circle-tickets', '.tickets-percentage', ticketPercentage);
                            });
        </script>
    </body>
</html>