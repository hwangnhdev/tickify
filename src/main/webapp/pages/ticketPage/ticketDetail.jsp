<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
    // Đưa thời gian hiện tại vào request để so sánh trong JSTL
    java.util.Date now = new java.util.Date();
    request.setAttribute("now", now);
%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Detail</title>
    <!-- TailwindCSS và Font Awesome -->
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <!-- Swiper CSS -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <!-- CSS tùy chỉnh chung -->
    <style>
      body {
        font-family: 'Roboto', sans-serif;
      }
      .truncate-text {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
      }
      .swiper-container {
        position: relative;
        overflow: hidden;
      }
      .swiper-wrapper {
        width: 100%;
      }
      .swiper-slide {
        width: 100% !important;
        box-sizing: border-box;
      }
      /* Cập nhật CSS cho pagination của Swiper */
      .swiper-pagination {
        position: absolute;
        bottom: 10px;
        left: 50% !important;
        transform: translateX(-50%) !important;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        z-index: 10;
      }
      .swiper-pagination-bullet {
        width: 12px;
        height: 12px;
        background: #CBD5E0;
        opacity: 1;
        border-radius: 50%;
        cursor: pointer;
      }
      .swiper-pagination-bullet-active {
        background: #48BB78;
      }
    </style>
  </head>
  <!-- Đồng bộ: Sử dụng nền tối với bg-gray-900 và chữ trắng -->
  <body class="bg-gray-900 text-white">
    <jsp:include page="../../components/header.jsp"></jsp:include>
    <div class="pt-24 max-w-4xl mx-auto p-6">
      <!-- Ánh xạ orderDetail sang ticketDetail -->
      <c:set var="ticketDetail" value="${orderDetail}" />

      <!-- Phần Carousel: Hiển thị các vé theo slide (nếu có) -->
      <c:if test="${not empty ticketDetail.orderItems}">
        <div class="mb-8">
          <div class="swiper-container">
            <div class="swiper-wrapper">
              <c:forEach var="item" items="${ticketDetail.orderItems}">
                <!-- Sử dụng bg-gray-800 cho card -->
                <div class="swiper-slide bg-gray-800 shadow rounded-lg p-6">
                  <!-- Tiêu đề & Ảnh sự kiện -->
                  <h2 class="text-2xl font-bold truncate-text" 
                      title="${ticketDetail.eventSummary.eventName != null ? ticketDetail.eventSummary.eventName : 'N/A'}">
                    ${ticketDetail.eventSummary.eventName != null ? ticketDetail.eventSummary.eventName : 'N/A'}
                  </h2>
                  <c:if test="${not empty ticketDetail.eventSummary.imageUrl}">
                    <img src="${ticketDetail.eventSummary.imageUrl}" 
                         alt="${ticketDetail.eventSummary.eventName != null ? ticketDetail.eventSummary.eventName : 'No image'}"
                         class="w-full h-auto rounded mb-4 object-cover" />
                  </c:if>
                  <!-- Thông tin vé & QR Code -->
                  <div class="flex items-start justify-between">
                    <div class="flex flex-col space-y-2 w-2/3">
                      <p class="text-gray-300">
                        <i class="fas fa-map-marker-alt mr-1"></i>
                        ${ticketDetail.eventSummary.location != null ? ticketDetail.eventSummary.location : 'N/A'}
                      </p>
                      <p class="text-gray-300">
                        <i class="fas fa-clock mr-1"></i>
                        <fmt:formatDate value="${ticketDetail.eventSummary.startDate}" pattern="HH:mm, dd 'of' MMM, yyyy" />
                        -
                        <fmt:formatDate value="${ticketDetail.eventSummary.endDate}" pattern="HH:mm, dd 'of' MMM, yyyy" />
                      </p>
                      <p class="text-gray-300">
                        <i class="fas fa-ticket-alt mr-1"></i> Ticket Code:
                        ${ticketDetail.eventSummary.ticketCode != null ? ticketDetail.eventSummary.ticketCode : 'N/A'}
                      </p>
                      <p class="text-gray-300">
                        <i class="fas fa-chair mr-1"></i> Seat:
                        ${item.seats != null ? item.seats : 'No seat'}
                      </p>
                      <p class="text-gray-300">
                        <i class="fas fa-tag mr-1"></i> Ticket Type:
                        ${item.ticketType != null ? item.ticketType : 'N/A'}
                      </p>
                      <p class="text-gray-300">
                        <i class="fas fa-check-circle mr-1"></i> Ticket Status:
                        ${item.ticketStatus != null ? item.ticketStatus : 'N/A'}
                      </p>
                    </div>
                    <div class="flex-shrink-0 w-1/3 flex justify-end">
                      <c:if test="${item.ticketQRCode != null}">
                        <img src="${item.ticketQRCode}" 
                             alt="QR Code for ticket ${item.ticketCode}" 
                             class="w-32 h-32 rounded" />
                      </c:if>
                    </div>
                  </div>
                </div>
              </c:forEach>
            </div>
            <!-- Navigation arrows -->
            <div class="swiper-button-next"></div>
            <div class="swiper-button-prev"></div>
            <!-- Pagination -->
            <div class="swiper-pagination"></div>
          </div>
        </div>
      </c:if>

      <!-- Container gom tất cả thông tin: Order, Payment, Buyer và Order Detail -->
      <!-- Sử dụng bg-gray-800 cho container tổng hợp -->
      <div class="order-summary bg-gray-800 shadow rounded-lg p-6 space-y-8 mb-8">
        <!-- Order -->
        <div class="text-center">
          <p class="text-sm text-gray-300 flex items-center">
            <i class="fas fa-ticket-alt mr-2"></i>
            <span class="truncate-text" title="Order #${ticketDetail.orderSummary.orderId != null ? ticketDetail.orderSummary.orderId : 'N/A'}">
              Order: ${ticketDetail.orderSummary.orderId != null ? ticketDetail.orderSummary.orderId : 'N/A'}
            </span>
          </p>
        </div>

        <!-- Payment Information -->
        <div>
          <h2 class="text-2xl font-bold mb-4">
            <i class="fas fa-credit-card mr-2"></i>Payment Information
          </h2>
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div class="border border-gray-700 p-4 rounded hover:bg-gray-700">
              <h4 class="text-sm font-semibold">Payment Status</h4>
              <p class="text-base truncate-text" title="${ticketDetail.orderSummary.paymentStatus != null ? ticketDetail.orderSummary.paymentStatus : 'N/A'}">
                ${ticketDetail.orderSummary.paymentStatus != null ? ticketDetail.orderSummary.paymentStatus : 'N/A'}
              </p>
            </div>
            <c:if test="${not empty ticketDetail.orderSummary.orderDate}">
              <div class="border border-gray-700 p-4 rounded hover:bg-gray-700">
                <h3 class="text-sm font-semibold">Order Date</h3>
                <p class="text-base truncate-text">
                  <fmt:formatDate value="${ticketDetail.orderSummary.orderDate}" pattern="HH:mm, dd 'of' MMM, yyyy" />
                </p>
              </div>
            </c:if>
          </div>
        </div>

        <!-- Buyer Information -->
        <div>
          <h2 class="text-2xl font-bold mb-4">
            <i class="fas fa-user mr-2"></i>Buyer Information
          </h2>
          <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <c:if test="${not empty ticketDetail.orderSummary.customerName}">
              <div class="border border-gray-700 p-4 rounded hover:bg-gray-700">
                <h4 class="text-sm font-semibold">Name</h4>
                <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerName}">
                  ${ticketDetail.orderSummary.customerName}
                </p>
              </div>
            </c:if>
            <c:if test="${not empty ticketDetail.orderSummary.customerEmail}">
              <div class="border border-gray-700 p-4 rounded hover:bg-gray-700">
                <h4 class="text-sm font-semibold">Email</h4>
                <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerEmail}">
                  ${ticketDetail.orderSummary.customerEmail}
                </p>
              </div>
            </c:if>
            <c:if test="${not empty ticketDetail.orderSummary.customerPhone}">
              <div class="border border-gray-700 p-4 rounded hover:bg-gray-700">
                <h4 class="text-sm font-semibold">Phone</h4>
                <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerPhone}">
                  ${ticketDetail.orderSummary.customerPhone}
                </p>
              </div>
            </c:if>
            <c:if test="${not empty ticketDetail.orderSummary.customerAddress}">
              <div class="border border-gray-700 p-4 rounded hover:bg-gray-700">
                <h4 class="text-sm font-semibold">Address</h4>
                <p class="text-base truncate-text" title="${ticketDetail.orderSummary.customerAddress}">
                  ${ticketDetail.orderSummary.customerAddress}
                </p>
              </div>
            </c:if>
          </div>
        </div>

        <!-- Order Detail: Grouped Order Items -->
        <div>
          <h2 class="text-2xl font-bold mb-4">
            <i class="fas fa-receipt mr-2"></i>Order Detail
          </h2>
          <table class="w-full text-left border-collapse">
            <thead>
              <tr class="bg-gray-700">
                <th class="p-2 border border-gray-600">Ticket type</th>
                <th class="p-2 border border-gray-600">Quantity</th>
                <th class="p-2 border border-gray-600">Amount</th>
              </tr>
            </thead>
            <tbody class="text-gray-300 text-sm">
              <c:forEach items="${ticketDetail.groupedOrderItems}" var="item">
                <tr class="bg-gray-800 hover:bg-gray-700">
                  <td class="p-2 border border-gray-600">
                    <span class="truncate-text" title="${item.ticketType != null ? item.ticketType : 'N/A'}">
                      ${item.ticketType != null ? item.ticketType : 'N/A'}
                    </span><br/>
                    <fmt:formatNumber value="${item.unitPrice}" pattern="#,##0.00'đ'" />
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
                <td class="p-2 font-semibold" colspan="2">Subtotal</td>
                <td class="p-2 text-right">
                  <fmt:formatNumber value="${ticketDetail.calculation.totalSubtotal}" pattern="#,##0.00'đ'" />
                </td>
              </tr>
              <c:if test="${not empty ticketDetail.orderSummary.voucherCode}">
                <tr>
                  <td class="p-2 font-semibold" colspan="2">
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
                <td class="p-2 font-semibold" colspan="2">Total</td>
                <td class="p-2 text-right text-green-500">
                  <fmt:formatNumber value="${ticketDetail.calculation.finalTotal}" pattern="#,##0.00'đ'" />
                </td>
              </tr>
            </tfoot>
          </table>
        </div>
      </div>
      <hr class="my-8 border-gray-700" />
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
