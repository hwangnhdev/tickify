<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Order Detail</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        .container {
            background: #fff;
            padding: 20px 30px;
            max-width: 800px;
            margin: 0 auto;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1, h2 {
            color: #333;
        }
        .section {
            margin-bottom: 25px;
        }
        .section p {
            line-height: 1.6;
            margin: 8px 0;
        }
        .section p strong {
            color: #555;
        }
        .item {
            border: 1px solid #ddd;
            padding: 10px;
            margin-bottom: 10px;
            background: #fafafa;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Order Detail</h1>
        <c:if test="${not empty orderDetail}">
            <div class="section">
                <h2>Order Summary</h2>
                <c:if test="${not empty orderDetail.orderSummary.orderId}">
                    <p><strong>Order ID:</strong> <c:out value="${orderDetail.orderSummary.orderId}"/></p>
                </c:if>
                <c:if test="${not empty orderDetail.orderSummary.orderDate}">
                    <p><strong>Order Date:</strong> 
                        <fmt:formatDate value="${orderDetail.orderSummary.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                    </p>
                </c:if>
                <c:if test="${not empty orderDetail.orderSummary.paymentStatus}">
                    <p><strong>Payment Status:</strong> <c:out value="${orderDetail.orderSummary.paymentStatus}"/></p>
                </c:if>
                <c:if test="${not empty orderDetail.orderSummary.grandTotal}">
                    <p><strong>Grand Total:</strong> <c:out value="${orderDetail.orderSummary.grandTotal}"/></p>
                </c:if>
                <c:if test="${not empty orderDetail.orderSummary.voucherCode}">
                    <p><strong>Voucher Code:</strong> <c:out value="${orderDetail.orderSummary.voucherCode}"/></p>
                </c:if>
                <c:if test="${not empty orderDetail.orderSummary.customerName}">
                    <p><strong>Customer Name:</strong> <c:out value="${orderDetail.orderSummary.customerName}"/></p>
                </c:if>
                <c:if test="${not empty orderDetail.orderSummary.customerEmail}">
                    <p><strong>Customer Email:</strong> <c:out value="${orderDetail.orderSummary.customerEmail}"/></p>
                </c:if>
                <c:if test="${not empty orderDetail.orderSummary.eventName}">
                    <p><strong>Event Name:</strong> <c:out value="${orderDetail.orderSummary.eventName}"/></p>
                </c:if>
                <c:if test="${not empty orderDetail.orderSummary.location}">
                    <p><strong>Location:</strong> <c:out value="${orderDetail.orderSummary.location}"/></p>
                </c:if>
            </div>
            
            <div class="section">
                <h2>Calculation</h2>
                <c:if test="${not empty orderDetail.calculation.totalSubtotal}">
                    <p><strong>Subtotal:</strong> <c:out value="${orderDetail.calculation.totalSubtotal}"/></p>
                </c:if>
                <c:if test="${not empty orderDetail.calculation.discountAmount}">
                    <p><strong>Discount Amount:</strong> <c:out value="${orderDetail.calculation.discountAmount}"/></p>
                </c:if>
                <c:if test="${not empty orderDetail.calculation.finalTotal}">
                    <p><strong>Final Total:</strong> <c:out value="${orderDetail.calculation.finalTotal}"/></p>
                </c:if>
            </div>
            
            <div class="section">
                <h2>Order Items</h2>
                <c:forEach var="item" items="${orderDetail.orderItems}">
                    <div class="item">
                        <c:if test="${not empty item.ticketType}">
                            <p><strong>Ticket Type:</strong> <c:out value="${item.ticketType}"/></p>
                        </c:if>
                        <c:if test="${not empty item.quantity}">
                            <p><strong>Quantity:</strong> <c:out value="${item.quantity}"/></p>
                        </c:if>
                        <c:if test="${not empty item.unitPrice}">
                            <p><strong>Unit Price:</strong> <c:out value="${item.unitPrice}"/></p>
                        </c:if>
                        <c:if test="${not empty item.seats}">
                            <p><strong>Seats:</strong> <c:out value="${item.seats}"/></p>
                        </c:if>
                    </div>
                </c:forEach>
            </div>
        </c:if>
        <c:if test="${empty orderDetail}">
            <p>No order details found.</p>
        </c:if>
    </div>
</body>
</html>
