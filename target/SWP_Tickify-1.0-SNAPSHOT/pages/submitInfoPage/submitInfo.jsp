<%-- 
    Document   : submitInfo
    Created on : Jan 24, 2025, 11:02:28 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ticketbox Clone</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #000;
            color: #fff;
        }
        .event-banner {
            background-color: #222;
            padding: 20px;
            border-radius: 8px;
        }
        .event-banner .countdown {
            background-color: #3FAE3E;
            padding: 10px 20px;
            border-radius: 8px;
            font-size: 18px;
            display: inline-block;
        }
        .form-container {
            gap: 20px;
        }
        .form input {
            background-color: #222;
            color: #fff;
            border: 1px solid #444;
        }
        .summary button {
            background-color: #3FAE3E;
            border: none;
            color: #fff;
        }
        .summary button:hover {
            background-color: #35a234;
        }
        .progress-bar {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background-color: #222;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .progress-bar span {
            color: #999;
            font-size: 14px;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .progress-bar span.active {
            color: #FFD700;
        }
        .progress-bar span::before {
            content: "";
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: #555;
            margin-bottom: 5px;
            display: inline-block;
        }
        .progress-bar span.active::before {
            background-color: #FFD700;
        }
    </style>
</head>
<body>
    <header class="bg-success d-flex justify-content-between align-items-center p-3">
        <img src="ticketbox-logo.png" alt="Ticketbox" height="40">
        <div class="d-flex gap-3">
            <a href="#" class="text-white">Vé đã mua</a>
            <a href="#" class="text-white">Tài khoản</a>
        </div>
    </header>
    <div class="container mt-4">
<!--        <div class="progress-bar">
            <span class="active">
                <div>✔</div>
                Chọn vé
            </span>
            <span class="active">
                <div>●</div>
                Bảng Câu Hỏi
            </span>
            <span>
                <div>○</div>
                Thanh Toán
            </span>
        </div>-->
        <div class="event-banner mb-4">
            <h1>[GIẢM 30% MÃ SKQT30] [Sân Khấu Quốc Thảo] Nhạc kịch: "Những Kẻ Đi Mộng Mơ"</h1>
            <p>📍 Sân Khấu Kịch Quốc Thảo, 70-72 Nguyễn Văn Trỗi, Q.Phú Nhuận, TP.HCM</p>
            <p>🗓️ 19:30 - 21:30, 29 Tháng 01, 2025</p>
            <span class="countdown">Hoàn tất đặt vé trong: 14:17</span>
        </div>
        <div class="row form-container">
            <div class="col-lg-8 mb-3">
                <div class="p-4 bg-dark rounded">
                    <h2>BẢNG CÂU HỎI</h2>
                    <div class="mb-3">
                        <label for="phone" class="form-label">* Bạn cho Ticketbox xin số điện thoại để BTC liên hệ bạn nhé</label>
                        <input type="text" id="phone" class="form-control" placeholder="Điền câu trả lời của bạn">
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">* Email của bạn là</label>
                        <input type="email" id="email" class="form-control" placeholder="Điền câu trả lời của bạn">
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <div class="p-4 bg-dark rounded">
                    <h3>Thông tin đặt vé</h3>
                    <p>Loại vé: Vé VÀNG</p>
                    <p>Số lượng: 1</p>
                    <p>Tạm tính: 250.000đ</p>
                    <button class="btn w-100 mt-3">Tiếp tục</button>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
