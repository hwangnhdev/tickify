<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Ticket Detail</title>
    <script src="https://cdn.tailwindcss.com"></script>
  </head>
  <body class="bg-gray-50 p-6">
    <div class="max-w-4xl mx-auto bg-white shadow rounded-lg p-6">
      <h1 class="text-2xl font-bold mb-4">Ticket Detail</h1>
      <c:if test="${not empty ticketDetail}">
        <p><strong>Order Code:</strong> ${ticketDetail.orderCode}</p>
        <p><strong>Ticket Status:</strong> ${ticketDetail.ticketStatus}</p>
        <p><strong>Payment Status:</strong> ${ticketDetail.paymentStatus}</p>
        <p><strong>Event Name:</strong> ${ticketDetail.eventName}</p>
        <p><strong>Location:</strong> ${ticketDetail.location}</p>
        <p><strong>Seat:</strong> ${ticketDetail.seat}</p>
        <p><strong>Ticket Price:</strong> <fmt:formatNumber value="${ticketDetail.ticketPrice}" type="currency" currencySymbol="$" /></p>
        <p><strong>Start Date:</strong> <fmt:formatDate value="${ticketDetail.startDate}" pattern="dd MMM, yyyy" /></p>
        <p><strong>End Date:</strong> <fmt:formatDate value="${ticketDetail.endDate}" pattern="dd MMM, yyyy" /></p>
        <p><strong>Buyer Name:</strong> ${ticketDetail.buyerName}</p>
        <p><strong>Buyer Email:</strong> ${ticketDetail.buyerEmail}</p>
        <p><strong>Buyer Phone:</strong> ${ticketDetail.buyerPhone}</p>
        <p><strong>Buyer Address:</strong> ${ticketDetail.buyerAddress}</p>
        <p><strong>Ticket Type:</strong> ${ticketDetail.ticketType}</p>
        <p><strong>Quantity:</strong> ${ticketDetail.quantity}</p>
        <p><strong>Amount:</strong> <fmt:formatNumber value="${ticketDetail.amount}" type="currency" currencySymbol="$" /></p>
        <p><strong>Original Total Amount:</strong> <fmt:formatNumber value="${ticketDetail.originalTotalAmount}" type="currency" currencySymbol="$" /></p>
        <p><strong>Voucher Applied:</strong> ${ticketDetail.voucherApplied}</p>
        <c:if test="${ticketDetail.voucherApplied eq 'Yes'}">
          <p><strong>Voucher Code:</strong> ${ticketDetail.voucherCode}</p>
          <p><strong>Discount:</strong> <fmt:formatNumber value="${ticketDetail.discount}" type="currency" currencySymbol="$" /></p>
          <p><strong>Final Total Amount:</strong> <fmt:formatNumber value="${ticketDetail.finalTotalAmount}" type="currency" currencySymbol="$" /></p>
        </c:if>
        <c:if test="${not empty ticketDetail.eventImage}">
          <img src="${ticketDetail.eventImage}" alt="${ticketDetail.eventName}" class="mt-4 w-full h-64 object-cover rounded">
        </c:if>
      </c:if>
      <c:if test="${empty ticketDetail}">
        <p class="text-red-500">Không tìm thấy chi tiết vé.</p>
      </c:if>
    </div>
  </body>
</html>
