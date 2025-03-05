<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Order Details</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <jsp:include page="../../components/header.jsp"></jsp:include>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
        </head>
        <body class="bg-white text-gray-800">
            <div class="max-w-4xl mx-auto p-6 space-y-8">
                <h1 class="text-3xl font-bold text-center mb-6">
                    <i class="fas fa-receipt mr-2"></i>Order Details
                </h1>

                <!-- Order Information -->
                <div class="bg-white border rounded-lg shadow p-6">
                    <h2 class="text-2xl font-semibold mb-4 flex items-center">
                        <i class="fas fa-info-circle mr-2"></i>Order Information
                    </h2>
                    <table class="w-full">
                        <tbody class="divide-y divide-gray-200">
                            <tr>
                                <th class="py-2 text-left w-1/3">Order ID</th>
                                <td class="py-2">${orderDetail.orderId}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Order Date</th>
                            <td class="py-2">
                                <fmt:formatDate value="${orderDetail.orderDate}" pattern="dd/MM/yyyy HH:mm:ss" />
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Total Price</th>
                            <td class="py-2">
                                <fmt:formatNumber value="${orderDetail.totalPrice}" type="currency" currencySymbol="đ" />
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Payment Status</th>
                            <td class="py-2">${orderDetail.paymentStatus}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Transaction ID</th>
                            <td class="py-2">${orderDetail.transactionId}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Order Created</th>
                            <td class="py-2">
                                <fmt:formatDate value="${orderDetail.orderCreatedAt}" pattern="dd/MM/yyyy HH:mm:ss" />
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Customer Information -->
            <div class="bg-white border rounded-lg shadow p-6">
                <h2 class="text-2xl font-semibold mb-4 flex items-center">
                    <i class="fas fa-user mr-2"></i>Customer Information
                </h2>
                <table class="w-full">
                    <tbody class="divide-y divide-gray-200">
                        <tr>
                            <th class="py-2 text-left w-1/3">Customer Name</th>
                            <td class="py-2">${orderDetail.customerName}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Customer Email</th>
                            <td class="py-2">${orderDetail.customerEmail}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Event & Organization Information -->
            <div class="bg-white border rounded-lg shadow p-6">
                <h2 class="text-2xl font-semibold mb-4 flex items-center">
                    <i class="fas fa-calendar-alt mr-2"></i>Event & Organization
                </h2>
                <table class="w-full">
                    <tbody class="divide-y divide-gray-200">
                        <tr>
                            <th class="py-2 text-left w-1/3">Event Name</th>
                            <td class="py-2">${orderDetail.eventName}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Location</th>
                            <td class="py-2">${orderDetail.location}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Organization Name</th>
                            <td class="py-2">${orderDetail.organizationName}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Bank Account Information -->
            <div class="bg-white border rounded-lg shadow p-6">
                <h2 class="text-2xl font-semibold mb-4 flex items-center">
                    <i class="fas fa-university mr-2"></i>Bank Account Information
                </h2>
                <table class="w-full">
                    <tbody class="divide-y divide-gray-200">
                        <tr>
                            <th class="py-2 text-left w-1/3">Account Holder</th>
                            <td class="py-2">${orderDetail.accountHolder}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Account Number</th>
                            <td class="py-2">${orderDetail.accountNumber}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Bank Name</th>
                            <td class="py-2">${orderDetail.bankName}</td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <!-- Ticket & Discount Information -->
            <div class="bg-white border rounded-lg shadow p-6">
                <h2 class="text-2xl font-semibold mb-4 flex items-center">
                    <i class="fas fa-ticket-alt mr-2"></i>Ticket & Discount Details
                </h2>
                <table class="w-full">
                    <tbody class="divide-y divide-gray-200">
                        <tr>
                            <th class="py-2 text-left w-1/3">Ticket Quantity</th>
                            <td class="py-2">
                                ${orderDetail.quantity} (Total: ${orderDetail.totalQuantity})
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Voucher Code</th>
                            <td class="py-2">${orderDetail.voucherCode}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Discount Type</th>
                            <td class="py-2">${orderDetail.discountType}</td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Discount Value</th>
                            <td class="py-2">
                                <fmt:formatNumber value="${orderDetail.discountValue}" type="currency" currencySymbol="đ" />
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Total After Discount</th>
                            <td class="py-2">
                                <fmt:formatNumber value="${orderDetail.totalPriceAfterDiscount}" type="currency" currencySymbol="đ" />
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Organization Invoice Total</th>
                            <td class="py-2">
                                <fmt:formatNumber value="${orderDetail.totalBillForOrganization}" type="currency" currencySymbol="đ" />
                            </td>
                        </tr>
                        <tr>
                            <th class="py-2 text-left">Seat List</th>
                            <td class="py-2">
                                <c:choose>
                                    <c:when test="${not empty orderDetail.seatList}">
                                        ${orderDetail.seatList}
                                    </c:when>
                                    <c:otherwise>
                                        Not available.
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>


        </div>
    </body>
</html>
