<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Chi tiết đơn hàng</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
</head>
<body class="bg-gray-900 text-white">
    <div class="container mx-auto p-4">
        <h1 class="text-2xl font-bold mb-4">Chi tiết đơn hàng</h1>
        <div class="bg-gray-800 p-4 rounded-lg shadow-md">
            <table class="min-w-full">
                <tr>
                    <th class="px-4 py-2">Mã đơn hàng</th>
                    <td class="px-4 py-2">${orderDetail.orderId}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Ngày đặt hàng</th>
                    <td class="px-4 py-2">
                        <fmt:formatDate value="${orderDetail.orderDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Tổng giá tiền</th>
                    <td class="px-4 py-2">
                        <fmt:formatNumber value="${orderDetail.totalPrice}" type="currency" currencySymbol="$"/>
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Trạng thái thanh toán</th>
                    <td class="px-4 py-2">${orderDetail.paymentStatus}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Mã giao dịch</th>
                    <td class="px-4 py-2">${orderDetail.transactionId}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Ngày tạo đơn hàng</th>
                    <td class="px-4 py-2">
                        <fmt:formatDate value="${orderDetail.orderCreatedAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Tên khách hàng</th>
                    <td class="px-4 py-2">${orderDetail.customerName}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Email khách hàng</th>
                    <td class="px-4 py-2">${orderDetail.customerEmail}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Tên sự kiện</th>
                    <td class="px-4 py-2">${orderDetail.eventName}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Địa điểm</th>
                    <td class="px-4 py-2">${orderDetail.location}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Tên tổ chức</th>
                    <td class="px-4 py-2">${orderDetail.organizationName}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Chủ tài khoản</th>
                    <td class="px-4 py-2">${orderDetail.accountHolder}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Số tài khoản</th>
                    <td class="px-4 py-2">${orderDetail.accountNumber}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Ngân hàng</th>
                    <td class="px-4 py-2">${orderDetail.bankName}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Số lượng vé</th>
                    <td class="px-4 py-2">
                        ${orderDetail.quantity} (Tổng: ${orderDetail.totalQuantity})
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Mã voucher</th>
                    <td class="px-4 py-2">${orderDetail.voucherCode}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Loại giảm giá</th>
                    <td class="px-4 py-2">${orderDetail.discountType}</td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Giá trị giảm giá</th>
                    <td class="px-4 py-2">
                        <fmt:formatNumber value="${orderDetail.discountValue}" type="currency" currencySymbol="$"/>
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Tổng tiền sau giảm giá</th>
                    <td class="px-4 py-2">
                        <fmt:formatNumber value="${orderDetail.totalPriceAfterDiscount}" type="currency" currencySymbol="$"/>
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Tổng hóa đơn cho tổ chức</th>
                    <td class="px-4 py-2">
                        <fmt:formatNumber value="${orderDetail.totalBillForOrganization}" type="currency" currencySymbol="$"/>
                    </td>
                </tr>
                <tr>
                    <th class="px-4 py-2">Danh sách ghế</th>
                    <td class="px-4 py-2">
                        <c:if test="${not empty orderDetail.seatList}">
                            ${orderDetail.seatList}
                        </c:if>
                        <c:if test="${empty orderDetail.seatList}">
                            Không có thông tin ghế.
                        </c:if>
                    </td>
                </tr>
            </table>
        </div>
        <div class="mt-4">
            <a href="organizerOrders" class="text-green-400 hover:underline">
                <i class="fas fa-arrow-left"></i> Quay lại danh sách đơn hàng
            </a>
        </div>
    </div>
</body>
</html>
