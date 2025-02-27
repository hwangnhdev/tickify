<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Ticket Detail</title>
    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
  </head>
  <body class="bg-gray-900 text-white">
    <!-- HEADER: Đồng bộ với listticket.jsp -->
    <header class="bg-green-500 p-4 flex justify-between items-center">
      <div class="flex items-center">
        <span class="text-3xl font-bold text-white">ticketbox</span>
      </div>
      <div class="flex items-center space-x-4">
        <div class="relative">
          <input
            class="pl-10 pr-4 py-2 rounded-full text-black"
            placeholder="What are you looking for today?"
            type="text"
          />
          <i
            class="fas fa-search absolute left-3 top-1/2 transform -translate-y-1/2 text-gray-500"
          ></i>
        </div>
        <a
          href="${pageContext.request.contextPath}/createEvent"
          class="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition-colors duration-200"
        >
          Create Event
        </a>
        <a
          href="${pageContext.request.contextPath}/myTickets"
          class="bg-green-500 text-white px-4 py-2 rounded-full hover:bg-green-600 transition-colors duration-200"
        >
          My Tickets
        </a>
        <div class="relative">
          <button
            class="flex items-center space-x-2 px-4 py-2 rounded-full hover:bg-green-600 transition-colors duration-200"
          >
            <img
              alt="User avatar"
              class="h-10 w-10 rounded-full"
              src="https://storage.googleapis.com/a1aa/image/h71lG1q8DXBqilEUcrvIYvR8bqmHnaCRfnARuEGr6Mg.jpg"
            />
            <span>My Account</span>
            <i class="fas fa-chevron-down"></i>
          </button>
        </div>
        <img
          alt="Flag"
          class="h-10 w-10 rounded-full hover:opacity-80 transition-opacity duration-200"
          src="https://storage.googleapis.com/a1aa/image/iOTz5_MlFPFZm2ax8JGx-RdCHntuioNHvXZLPH_F4mw.jpg"
        />
      </div>
    </header>

    <!-- MAIN CONTENT -->
    <main class="p-8">
      <!-- Container chính -->
      <div class="max-w-4xl mx-auto bg-gray-800 p-6 rounded-lg shadow-lg">
        <!-- Kiểm tra nếu ticketDetail không có dữ liệu -->
        <c:if test="${empty ticketDetail}">
          <p class="text-center text-red-500 font-bold">
            Không tìm thấy dữ liệu vé (ticketDetail rỗng). Vui lòng kiểm tra lại!
          </p>
        </c:if>
        
        <c:if test="${not empty ticketDetail}">
          <!-- Tiêu đề sự kiện -->
          <h1 class="text-3xl font-bold mb-4">
            ${ticketDetail.eventName}
          </h1>
          
          <!-- Phần hiển thị ảnh sự kiện (nếu có) -->
          <c:if test="${not empty ticketDetail.ticketImage}">
            <div class="mb-6 flex justify-center">
              <img
                src="${ticketDetail.ticketImage}"
                alt="Event Image"
                class="rounded-lg shadow-lg max-w-full h-auto"
              />
            </div>
          </c:if>

          <!-- Section 1: Order Information -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-4 mb-6">
            <div class="bg-gray-700 p-4 rounded-lg">
              <h2 class="font-bold">Order Date</h2>
              <p>
                <fmt:formatDate value="${ticketDetail.orderDate}" pattern="dd MMM, yyyy" />
              </p>
            </div>
            <div class="bg-gray-700 p-4 rounded-lg">
              <h2 class="font-bold">Payment Status</h2>
              <p>${ticketDetail.paymentStatus}</p>
            </div>
            <div class="bg-gray-700 p-4 rounded-lg">
              <h2 class="font-bold">Order Total</h2>
              <p>
                <fmt:formatNumber value="${ticketDetail.orderTotalPrice}" type="currency" currencySymbol="$ " />
              </p>
            </div>
          </div>
          
          <!-- Section 2: Buyer Information -->
          <div class="mb-6">
            <h2 class="text-xl font-bold mb-2">Buyer Information</h2>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <div class="bg-gray-700 p-4 rounded-lg">
                <h3 class="font-bold">Name</h3>
                <p>${ticketDetail.customerName}</p>
              </div>
              <div class="bg-gray-700 p-4 rounded-lg">
                <h3 class="font-bold">Email</h3>
                <p>${ticketDetail.customerEmail}</p>
              </div>
              <div class="bg-gray-700 p-4 rounded-lg">
                <h3 class="font-bold">Phone Number</h3>
                <p>${ticketDetail.customerPhone}</p>
              </div>
              <div class="bg-gray-700 p-4 rounded-lg">
                <h3 class="font-bold">Address</h3>
                <p>${ticketDetail.customerAddress}</p>
              </div>
            </div>
          </div>
          
          <!-- Section 3: Voucher Information (nếu có) -->
          <c:if test="${not empty ticketDetail.voucherCode}">
            <div class="mb-6">
              <h2 class="text-xl font-bold mb-2">Voucher Information</h2>
              <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <div class="bg-gray-700 p-4 rounded-lg">
                  <h3 class="font-bold">Voucher Code</h3>
                  <p>${ticketDetail.voucherCode}</p>
                </div>
                <div class="bg-gray-700 p-4 rounded-lg">
                  <h3 class="font-bold">Discount Type</h3>
                  <p>${ticketDetail.voucherDiscountType}</p>
                </div>
                <div class="bg-gray-700 p-4 rounded-lg">
                  <h3 class="font-bold">Discount Value</h3>
                  <p>
                    <fmt:formatNumber value="${ticketDetail.voucherDiscountValue}" type="currency" currencySymbol="$" />
                  </p>
                </div>
              </div>
            </div>
          </c:if>
          
          <!-- Section 4: Order Detail -->
          <div class="mb-6">
            <h2 class="text-xl font-bold mb-2">Order Detail</h2>
            <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
              <div class="bg-gray-700 p-4 rounded-lg">
                <h3 class="font-bold">Ticket Type</h3>
                <p>${ticketDetail.ticketType}</p>
              </div>
              <div class="bg-gray-700 p-4 rounded-lg">
                <h3 class="font-bold">Ticket Price</h3>
                <p>
                  <fmt:formatNumber value="${ticketDetail.ticketPrice}" type="currency" currencySymbol="$" />
                </p>
              </div>
              <div class="bg-gray-700 p-4 rounded-lg">
                <h3 class="font-bold">Quantity</h3>
                <p>${ticketDetail.ticketQuantity}</p>
              </div>
              <div class="bg-gray-700 p-4 rounded-lg">
                <h3 class="font-bold">Amount</h3>
                <p>
                  <fmt:formatNumber value="${ticketDetail.ticketPrice * ticketDetail.ticketQuantity}" type="currency" currencySymbol="$" />
                </p>
              </div>
            </div>
          </div>
          
          <!-- Section 5: Subtotal -->
          <div class="flex justify-end">
            <div class="w-full md:w-1/3 text-right">
              <span class="font-bold">Subtotal:</span>
              <span class="text-xl">
                <fmt:formatNumber value="${ticketDetail.orderTotalPrice}" type="currency" currencySymbol="$" />
              </span>
            </div>
          </div>
          
        </c:if>
      </div>
    </main>
  </body>
</html>
