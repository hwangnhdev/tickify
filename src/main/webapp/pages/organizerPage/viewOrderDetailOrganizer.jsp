<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Order Detail</title>
    <jsp:include page="../../components/header.jsp"></jsp:include>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet" />
    <!-- Tippy.js & Popper.js -->
    <link rel="stylesheet" href="https://unpkg.com/tippy.js@6/dist/tippy.css" />
    <script src="https://unpkg.com/@popperjs/core@2"></script>
    <script src="https://unpkg.com/tippy.js@6"></script>
    <style>
      body {
        font-family: 'Roboto', sans-serif;
      }
      .truncate-text {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }
      .seat-text {
        white-space: normal;
        word-wrap: break-word;
      }
    </style>
  </head>
  <!-- Đồng bộ: Sử dụng nền tối cho toàn bộ trang -->
  <body class="bg-gray-900 text-white">
    <div class="max-w-4xl mx-auto p-6">
      <!-- Ánh xạ orderDetail sang ticketDetail để dùng chung cho EL -->
      <c:set var="ticketDetail" value="${orderDetail}" />
      
      <!-- Container hiển thị chi tiết order -->
      <!-- Chuyển bg-white -> bg-gray-800 -->
      <div class="bg-gray-800 shadow rounded-lg p-6 space-y-8">
        <!-- Header: Event Name -->
        <c:if test="${not empty ticketDetail.eventSummary.eventName}">
          <div class="space-y-2">
            <h1 class="text-3xl font-bold truncate-text" title="${ticketDetail.eventSummary.eventName}">
              ${ticketDetail.eventSummary.eventName}
            </h1>
          </div>
        </c:if>
        <!-- Event Image -->
        <c:if test="${not empty ticketDetail.eventSummary.imageUrl}">
          <div>
            <img src="${ticketDetail.eventSummary.imageUrl}"
                 alt="${ticketDetail.eventSummary.eventName}"
                 loading="lazy"
                 onerror="this.onerror=null; this.style.display='none';"
                 class="w-full h-auto rounded" />
          </div>
        </c:if>
        <!-- Order Code -->
        <c:if test="${not empty ticketDetail.orderSummary.orderId}">
          <div>
            <p class="text-sm text-gray-300 flex items-center">
              <i class="fas fa-ticket-alt mr-2"></i>
              <span class="truncate-text" title="Order #${ticketDetail.orderSummary.orderId}">
                Order Code: ${ticketDetail.orderSummary.orderId}
              </span>
            </p>
          </div>
        </c:if>
        <!-- Ticket Overview -->
        <c:if test="${not empty ticketDetail.orderSummary.paymentStatus or not empty ticketDetail.eventSummary.location}">
          <div class="border-t border-gray-700 pt-4">
            <h2 class="text-2xl font-bold mb-4">
              <i class="fas fa-info-circle mr-2"></i>Ticket overview
            </h2>
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
              <c:if test="${not empty ticketDetail.orderSummary.orderDate}">
                <div class="border border-gray-700 p-3 rounded bg-gray-800">
                  <h3 class="text-sm font-semibold">Order Date</h3>
                  <p class="text-base">
                    <fmt:formatDate value="${ticketDetail.orderSummary.orderDate}" pattern="HH:mm, dd MMM yyyy" />
                  </p>
                </div>
              </c:if>
              <c:if test="${not empty ticketDetail.orderSummary.paymentStatus}">
                <div class="border border-gray-700 p-4 rounded hover:bg-gray-700 bg-gray-800">
                  <h3 class="text-sm font-semibold">Payment status</h3>
                  <p class="text-base truncate-text" title="${ticketDetail.orderSummary.paymentStatus}">
                    ${ticketDetail.orderSummary.paymentStatus}
                  </p>
                </div>
              </c:if>
              <c:if test="${not empty ticketDetail.eventSummary.location}">
                <div class="border border-gray-700 p-4 rounded hover:bg-gray-700 bg-gray-800">
                  <h3 class="text-sm font-semibold">Location</h3>
                  <p class="text-base truncate-text" title="${ticketDetail.eventSummary.location}">
                    ${ticketDetail.eventSummary.location}
                  </p>
                </div>
              </c:if>
            </div>
          </div>
        </c:if>
        <!-- Event Schedule -->
        <c:if test="${not empty ticketDetail.eventSummary.startDate or not empty ticketDetail.eventSummary.endDate}">
          <div class="border-t border-gray-700 pt-4">
            <h2 class="text-2xl font-bold mb-4">
              <i class="fas fa-clock mr-2"></i>Event schedule
            </h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <c:if test="${not empty ticketDetail.eventSummary.startDate}">
                <div class="border border-gray-700 p-4 rounded hover:bg-gray-700 bg-gray-800">
                  <h4 class="text-sm font-semibold">Start date</h4>
                  <p class="text-base">
                    <fmt:formatDate value="${ticketDetail.eventSummary.startDate}" pattern="HH:mm, dd MMM yyyy" />
                  </p>
                </div>
              </c:if>
              <c:if test="${not empty ticketDetail.eventSummary.endDate}">
                <div class="border border-gray-700 p-4 rounded hover:bg-gray-700 bg-gray-800">
                  <h4 class="text-sm font-semibold">End date</h4>
                  <p class="text-base">
                    <fmt:formatDate value="${ticketDetail.eventSummary.endDate}" pattern="HH:mm, dd MMM yyyy" />
                  </p>
                </div>
              </c:if>
            </div>
          </div>
        </c:if>
        <!-- Buyer Information -->
        <c:if test="${not empty ticketDetail.orderSummary.customerName or not empty ticketDetail.orderSummary.customerEmail}">
          <div class="border-t border-gray-700 pt-4">
            <h2 class="text-2xl font-bold mb-4">
              <i class="fas fa-user mr-2"></i>Buyer information
            </h2>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
              <c:if test="${not empty ticketDetail.orderSummary.customerName}">
                <div class="border border-gray-700 p-4 rounded hover:bg-gray-700 bg-gray-800">
                  <h4 class="text-sm font-semibold">Name</h4>
                  <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerName}">
                    ${ticketDetail.orderSummary.customerName}
                  </p>
                </div>
              </c:if>
              <c:if test="${not empty ticketDetail.orderSummary.customerEmail}">
                <div class="border border-gray-700 p-4 rounded hover:bg-gray-700 bg-gray-800">
                  <h4 class="text-sm font-semibold">Email</h4>
                  <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerEmail}">
                    ${ticketDetail.orderSummary.customerEmail}
                  </p>
                </div>
              </c:if>
              <c:if test="${not empty ticketDetail.orderSummary.customerPhone}">
                <div class="border border-gray-700 p-4 rounded hover:bg-gray-700 bg-gray-800">
                  <h4 class="text-sm font-semibold">Phone</h4>
                  <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerPhone}">
                    ${ticketDetail.orderSummary.customerPhone}
                  </p>
                </div>
              </c:if>
              <c:if test="${not empty ticketDetail.orderSummary.customerAddress}">
                <div class="border border-gray-700 p-4 rounded hover:bg-gray-700 bg-gray-800">
                  <h4 class="text-sm font-semibold">Address</h4>
                  <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerAddress}">
                    ${ticketDetail.orderSummary.customerAddress}
                  </p>
                </div>
              </c:if>
            </div>
          </div>
        </c:if>
        <!-- Order Detail: Danh sách các loại vé và ghế -->
        <c:if test="${not empty ticketDetail.orderItems}">
          <div class="bg-gray-800 shadow rounded-lg p-4 border border-gray-700">
            <h2 class="text-lg font-semibold mb-4">
              <i class="fas fa-receipt mr-2"></i>Order detail
            </h2>
            <table class="w-full text-left border-collapse">
              <thead>
                <tr class="bg-gray-700">
                  <th class="p-2 border border-gray-600">Ticket type</th>
                  <th class="p-2 border border-gray-600">Seat</th>
                  <th class="p-2 border border-gray-600">Quantity</th>
                  <th class="p-2 border border-gray-600">Amount</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${ticketDetail.orderItems}" var="item">
                  <tr class="bg-gray-800 hover:bg-gray-700">
                    <td class="p-2 border border-gray-600">
                      <span class="truncate-text" title="${item.ticketType}">
                        ${item.ticketType}
                      </span><br/>
                      <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00'đ'" />
                    </td>
                    <td class="p-2 border border-gray-600 seat-text">
                      ${item.seats}
                    </td>
                    <td class="p-2 border border-gray-600">
                      ${item.quantity}
                    </td>
                    <td class="p-2 border border-gray-600">
                      <fmt:formatNumber value="${item.subtotalPerType}" pattern="#,##0.00'đ'" />
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
              <tfoot class="bg-gray-700">
                <tr>
                  <td class="p-2 font-semibold" colspan="3">Subtotal</td>
                  <td class="p-2 text-right">
                    <fmt:formatNumber value="${ticketDetail.calculation.totalSubtotal}" pattern="#,##0.00'đ'" />
                  </td>
                </tr>
                <c:if test="${not empty ticketDetail.orderSummary.voucherCode}">
                  <tr>
                    <td class="p-2 font-semibold" colspan="3">
                      Discount (Voucher: ${ticketDetail.orderSummary.voucherCode})
                    </td>
                    <td class="p-2 text-right">
                      <span class="text-red-500">
                        -<fmt:formatNumber value="${ticketDetail.calculation.discountAmount}" pattern="#,##0.00'đ'" />
                        <c:if test="${ticketDetail.orderSummary.discountType eq 'percentage'}">
                          (<fmt:formatNumber value="${ticketDetail.orderSummary.discountValue}" pattern="#,##0.##"/>%)
                        </c:if>
                      </span>
                    </td>
                  </tr>
                </c:if>
                <tr>
                  <td class="p-2 font-semibold" colspan="3">Total</td>
                  <td class="p-2 text-right text-green-500">
                    <fmt:formatNumber value="${ticketDetail.calculation.finalTotal}" pattern="#,##0.00'đ'" />
                  </td>
                </tr>
              </tfoot>
            </table>
          </div>
        </c:if>
      </div>
      <c:if test="${empty ticketDetail}">
        <div class="mt-6 p-4 bg-red-100 text-red-700 rounded">
          <p>Order details not found.</p>
        </div>
      </c:if>
    </div>
    
    <!-- Swiper JS -->
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
    <script>
      var swiper = new Swiper('.swiper-container', {
        slidesPerView: 1,
        spaceBetween: 0,
        observer: true,
        observeParents: true,
        navigation: {
          nextEl: '.swiper-button-next',
          prevEl: '.swiper-button-prev'
        },
        pagination: {
          el: '.swiper-pagination',
          clickable: true,
          type: 'bullets'
        },
        watchOverflow: true
      });
      window.addEventListener('load', function () {
        swiper.update();
      });
    </script>
    
    <!-- Tippy.js: Cấu hình cho tooltip (nếu cần) -->
    <script src="https://unpkg.com/@popperjs/core@2"></script>
    <script src="https://unpkg.com/tippy.js@6"></script>
  </body>
</html>
