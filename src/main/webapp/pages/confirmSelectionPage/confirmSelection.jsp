<%-- 
    Document   : confirmSelection
    Created on : Feb 23, 2025, 3:16:06 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Selection Page</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
</head>
<body class="bg-gray-900 text-white">
    <div class="max-w-5xl mx-auto p-4">
        <!-- Progress Bar -->
        <div class="flex justify-between items-center mb-4">
            <div class="flex items-center space-x-2">
                <div class="text-green-500"><i class="fas fa-check-circle"></i></div>
                <div>Chọn vé</div>
            </div>
            <div class="flex items-center space-x-2">
                <div class="text-yellow-500"><i class="fas fa-circle"></i></div>
                <div>Bảng câu hỏi</div>
            </div>
            <div class="flex items-center space-x-2">
                <div class="text-gray-500"><i class="fas fa-circle"></i></div>
                <div>Thanh toán</div>
            </div>
        </div>

        <!-- Event Information -->
        <div class="bg-gray-800 p-4 rounded-lg mb-4 flex justify-between items-center">
            <div>
                <h1 class="text-2l font-bold mb-2">CHỐN...TÌM - THE MOON LOVE</h1>
                <div class="flex items-center mb-2">
                    <i class="fas fa-map-marker-alt mr-2"></i>
                    <span>Nhà hát Hồ Gươm</span>
                </div>
                <div class="text-sm mb-2">40 Hàng Bài , Phường Hàng Bài, Quận Hoàn Kiếm, Thành Phố Hà Nội</div>
                <div class="flex items-center">
                    <i class="fas fa-calendar-alt mr-2"></i>
                    <span>20:00 - 23:00, 14 Tháng 02, 2025</span>
                </div>
            </div>
            <!-- Timer -->
            <div class="flex justify-end mb-4">
                <div class="bg-gray-700 p-4 rounded-lg text-center">
                    <div class="text-lg font-bold">Hoàn tất đặt vé trong</div>
                    <div class="text-2xl font-bold text-green-500">14 : 25</div>
                </div>
            </div>
        </div>
        
        <div class="flex justify-between items-center">
            <!-- Question Form -->
            <div class="bg-gray-800 p-4 rounded-lg mb-4 w-full md:w-2/3 px-4">
                <h2 class="text-xl font-bold text-green-500 mb-4">BẢNG CÂU HỎI</h2>
                <div class="bg-gray-700 p-4 rounded-lg mb-4">
                    <h3 class="font-bold mb-2">Thông tin khác</h3>
                    <div class="mb-4">
                        <label class="block mb-1">* Email của bạn là:</label>
                        <input type="email" class="w-full p-2 bg-gray-600 rounded-lg" placeholder="Điền câu trả lời của bạn">
                    </div>
                    <div>
                        <label class="block mb-1">* Số điện thoại của bạn là:</label>
                        <input type="text" class="w-full p-2 bg-gray-600 rounded-lg" placeholder="Điền câu trả lời của bạn">
                    </div>
                </div>
            </div>

            <!-- Ticket Information -->
            <div class="bg-gray-800 p-4 rounded-lg w-full md:w-1/3 px-4 mt-8 md:mt-0" style="margin-left: 10px">
                <div class="flex justify-between items-center mb-4">
                    <h2 class="text-xl font-bold">Thông tin đặt vé</h2>
                    <a href="#" class="text-blue-500">Chọn lại vé</a>
                </div>
                <div class="mb-4">
                    <div class="flex justify-between mb-2">
                        <span>Loại vé</span>
                        <span>Số lượng</span>
                    </div>
                    <div class="flex justify-between mb-2">
                        <span>Moon Love</span>
                        <span>01</span>
                    </div>
                    <div class="flex justify-between mb-2">
                        <span>4.500.000 đ</span>
                        <span>4.500.000 đ</span>
                    </div>
                    <div class="flex justify-between font-bold text-green-500">
                        <span>Tạm tính 1 vé</span>
                        <span>4.500.000 đ</span>
                    </div>
                </div>
                <div class="text-sm mb-4">Vui lòng trả lời tất cả câu hỏi để tiếp tục</div>
                <button class="w-full bg-green-500 text-white p-2 rounded-lg">Tiếp tục <i class="fas fa-arrow-right"></i></button>
            </div>
        </div>
    </div>
</body>
</html>