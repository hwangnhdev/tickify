<%-- 
    Document   : payment
    Created on : Jan 27, 2025, 4:26:45 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticket Payment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .header {
            background-color: #28a745;
            padding: 10px 20px;
            color: #fff;
        }
        .header .steps span {
            margin: 0 10px;
            color: #fff;
            font-weight: bold;
        }
        .event-info {
            background-color: #343a40;
            color: #fff;
            padding: 20px;
        }
        .event-info h1 {
            font-size: 1.5rem;
        }
        .event-info .time {
            color: #ffc107;
        }
        .payment-section {
            margin-top: 20px;
        }
        .aside-card {
            background-color: #fff;
            border: 1px solid #dee2e6;
            padding: 20px;
            border-radius: 5px;
        }
        .aside-card h5 {
            font-size: 1.25rem;
        }
        .total {
            font-weight: bold;
            font-size: 1.25rem;
            color: #28a745;
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header d-flex justify-content-between align-items-center">
        <div class="logo">
            <h4>TicketBox</h4>
        </div>
        <div class="steps">
            <span>Chọn vé</span> > <span>Bảng câu hỏi</span> > <span class="text-warning">Thanh toán</span>
        </div>
        <div class="user-options d-flex align-items-center">
            <span class="me-3">Vé đã mua</span>
            <span class="me-3">Tài khoản</span>
            <span class="badge bg-danger">!</span>
        </div>
    </div>

    <!-- Event Info -->
    <div class="event-info">
        <h1>[GIẢM 30% MÃ SKQT30] Nhạc kịch: "Những Kẻ Dị Mộng"</h1>
        <p>Sân Khấu Kịch Quốc Thảo</p>
        <p>70-72 Nguyễn Văn Trỗi, P.8, Q. Phú Nhuận, Thành Phố Hồ Chí Minh</p>
        <p class="time">19:30 – 21:30, 29 Tháng 01, 2025</p>
    </div>

    <!-- Main Content -->
    <div class="container payment-section">
        <div class="row">
            <!-- Payment Information -->
            <div class="col-md-8">
                <div class="aside-card mb-3">
                    <h5>Thông tin nhận vé</h5>
                    <p><strong>Nguyen Huy Hoang</strong> <span>+84839552319</span></p>
                    <p>hwang.huyhoang@gmail.com</p>
                    <a href="#">Sửa</a>
                </div>

                <div class="aside-card mb-3">
                    <h5>Phương thức thanh toán</h5>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="vnpay">
                        <label class="form-check-label" for="vnpay">
                            Ứng dụng ngân hàng (VNPay)
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="zalopay">
                        <label class="form-check-label" for="zalopay">
                            ZaloPay
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="shopeepay">
                        <label class="form-check-label" for="shopeepay">
                            Ví ShopeePay
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="creditcard">
                        <label class="form-check-label" for="creditcard">
                            Thẻ thanh toán quốc tế
                        </label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="paymentMethod" id="atm">
                        <label class="form-check-label" for="atm">
                            Thẻ ATM/Internet Banking
                        </label>
                    </div>
                </div>

                <div class="aside-card mb-3">
                    <h5>Mã khuyến mãi</h5>
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="Nhập mã giảm giá">
                        <button class="btn btn-primary">Áp dụng</button>
                    </div>
                </div>
            </div>

            <!-- Order Summary -->
            <div class="col-md-4">
                <div class="aside-card">
                    <h5>Thông tin đặt vé</h5>
                    <p>Loại vé: Vé Vàng</p>
                    <p>Số lượng: 01</p>
                    <p>Ghế: C-1</p>
                    <hr>
                    <h5>Thông tin đơn hàng</h5>
                    <p>Tạm tính: 250,000 VND</p>
                    <p class="total">Tổng tiền: 250,000 VND</p>
                    <button class="btn btn-success w-100">Thanh toán</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

