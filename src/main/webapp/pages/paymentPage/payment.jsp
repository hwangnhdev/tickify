<%-- 
    Document   : payment
    Created on : Jan 27, 2025, 4:26:45 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>
            Booking Page
        </title>
        <script src="https://cdn.tailwindcss.com">
        </script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
        </style>
    </head>
    <body class="bg-gray-100">
        <div class="max-w-7xl mx-auto p-4">
            <div class="bg-cover bg-center h-48 relative" style="background-image: url('https://placehold.co/800x200');">
                <div class="absolute inset-0 bg-black opacity-50">
                </div>
                <div class="absolute inset-0 flex flex-col justify-center items-center text-white">
                    <h1 class="text-2xl font-bold">
                        MADAME SHOW - NHỮNG ĐƯỜNG CHIM BAY
                    </h1>
                    <div class="flex items-center mt-2">
                        <i class="fas fa-map-marker-alt mr-2">
                        </i>
                        <p>
                            Madame de Dalat, Số 02 Yết Kiêu, Phường 5, Thành Phố Đà Lạt, Tỉnh Lâm Đồng
                        </p>
                    </div>
                    <div class="flex items-center mt-2">
                        <i class="fas fa-clock mr-2">
                        </i>
                        <p>
                            18:30 - 19:30, 01 Mar, 2025
                        </p>
                    </div>
                </div>
            </div>
            <div class="grid grid-cols-12 gap-4 mt-4">
                <div class="col-span-9">
                    <div class="bg-white p-4 shadow-md">
                        <div class="flex justify-between items-center">
                            <h2 class="text-lg font-bold text-green-500">
                                PAYMENT INFO
                            </h2>
                            <div class="bg-gray-200 p-2 rounded-md text-center">
                                <p class="text-sm">
                                    Complete your booking within
                                </p>
                                <div class="text-green-500 text-xl font-bold">
                                    14 : 46
                                </div>
                            </div>
                        </div>
                        <div class="bg-yellow-100 p-4 mt-4 rounded-md flex items-center">
                            <i class="fas fa-exclamation-circle text-yellow-500 mr-2">
                            </i>
                            <p class="text-sm">
                                Please check ticket receiving info. If there are any changes,
                                <a class="text-blue-500 underline" href="#">
                                    please update here
                                </a>
                            </p>
                        </div>
                        <div class="mt-4">
                            <h3 class="text-md font-bold">
                                Ticket receiving info
                            </h3>
                            <div class="bg-gray-200 p-4 rounded-md flex justify-between items-center mt-2">
                                <div>
                                    <p>
                                        Nguyen Huy Hoang
                                    </p>
                                    <p>
                                        +84839552319
                                    </p>
                                    <p>
                                        hwang.huyhoang@gmail.com
                                    </p>
                                </div>
                                <a class="text-blue-500 underline" href="#">
                                    Edit
                                </a>
                            </div>
                        </div>
                        <div class="mt-4">
                            <h3 class="text-md font-bold">
                                Payment method
                            </h3>
                            <div class="bg-gray-800 p-4 rounded-md mt-2 text-white">
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" id="vnpay" name="payment" type="radio"/>
                                    <label class="flex items-center" for="vnpay">
                                        <img alt="VNPAY logo" class="mr-2" height="24" src="https://storage.googleapis.com/a1aa/image/M6Zv1YGVx0n_0acXJ73jw5NcKjgqp43pL9Mp6RBdVKo.jpg" width="24"/>
                                        <span>
                                            Mobile banking app (VNPAY)
                                        </span>
                                        <span class="bg-red-500 text-white text-xs ml-2 px-2 py-1 rounded">
                                            New
                                        </span>
                                    </label>
                                </div>
                                <p class="text-sm mb-4">
                                    Scan QR code and pay by mobile banking app &amp; VNPAY
                                </p>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" id="zalopay" name="payment" type="radio"/>
                                    <label class="flex items-center" for="zalopay">
                                        <img alt="Zalopay logo" class="mr-2" height="24" src="https://storage.googleapis.com/a1aa/image/j_2tmc5sKzWlDbfptO2RAcWIXCk7pG8tBZpSzuIuYLw.jpg" width="24"/>
                                        <span>
                                            Zalopay
                                        </span>
                                        <span class="bg-red-500 text-white text-xs ml-2 px-2 py-1 rounded">
                                            Coupon
                                        </span>
                                    </label>
                                </div>
                                <p class="text-sm mb-4">
                                    View coupon details and apply code on Zalopay app.
                                    <a class="text-blue-500 underline" href="#">
                                        Details
                                    </a>
                                </p>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" id="shopeepay" name="payment" type="radio"/>
                                    <label class="flex items-center" for="shopeepay">
                                        <img alt="ShopeePay logo" class="mr-2" height="24" src="https://storage.googleapis.com/a1aa/image/ZnPFpXKccc96u49pVk5l1ssKIxA4rGFSeYKkTWjyyyM.jpg" width="24"/>
                                        <span>
                                            ShopeePay Wallet
                                        </span>
                                        <span class="bg-red-500 text-white text-xs ml-2 px-2 py-1 rounded">
                                            Coupon
                                        </span>
                                    </label>
                                </div>
                                <p class="text-sm mb-4">
                                    View coupon details and apply code on ShopeePay.
                                    <a class="text-blue-500 underline" href="#">
                                        Details
                                    </a>
                                </p>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" id="vietqr" name="payment" type="radio"/>
                                    <label class="flex items-center" for="vietqr">
                                        <img alt="VietQR logo" class="mr-2" height="24" src="https://storage.googleapis.com/a1aa/image/V6UiPEic8WbwqTNO6mYTFCWoMw8PWMmHAlNCxI9o2R8.jpg" width="24"/>
                                        <span>
                                            VietQR
                                        </span>
                                    </label>
                                </div>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" id="momo" name="payment" type="radio"/>
                                    <label class="flex items-center" for="momo">
                                        <img alt="Momo Wallet logo" class="mr-2" height="24" src="https://storage.googleapis.com/a1aa/image/EU8bzFrrA-jNQRrDn00D297TdOpxJkVdI3FNShLPCtI.jpg" width="24"/>
                                        <span>
                                            Momo Wallet
                                        </span>
                                    </label>
                                </div>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" id="creditcard" name="payment" type="radio"/>
                                    <label class="flex items-center" for="creditcard">
                                        <img alt="Credit/Debit Card logos" class="mr-2" height="24" src="https://storage.googleapis.com/a1aa/image/k10Q6k9yd3MevwiiTLK-qvHnOY_FIAUp3WR-Or1wSKU.jpg" width="24"/>
                                        <span>
                                            International Credit/Debit Card
                                        </span>
                                    </label>
                                </div>
                                <div class="flex items-center mb-4">
                                    <input class="mr-2" id="atm" name="payment" type="radio"/>
                                    <label class="flex items-center" for="atm">
                                        <img alt="ATM Card/Internet Banking logos" class="mr-2" height="24" src="https://storage.googleapis.com/a1aa/image/jH-FJ0JMMFyREOx1CxIpRfVPJxt53ueHHxDeEI39Vgo.jpg" width="24"/>
                                        <span>
                                            ATM Card/Internet Banking
                                        </span>
                                    </label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-3">
                    <div class="bg-white p-4 shadow-md">
                        <h3 class="text-md font-bold">
                            Ticket information
                        </h3>
                        <div class="flex justify-between items-center mt-2">
                            <div>
                                <p>
                                    Ticket type
                                </p>
                                <p class="font-bold">
                                    Bạch Ngọc (Trải Nghiệm)
                                </p>
                            </div>
                            <div>
                                <p>
                                    Quantity
                                </p>
                                <p class="font-bold">
                                    01
                                </p>
                            </div>
                            <div>
                                <p>
                                    Price
                                </p>
                                <p class="font-bold">
                                    700.000 đ
                                </p>
                            </div>
                        </div>
                        <div class="mt-2">
                            <a class="text-blue-500 underline" href="#">
                                Reselect Ticket
                            </a>
                        </div>
                    </div>
                    <div class="bg-white p-4 mt-4 shadow-md">
                        <h3 class="text-md font-bold">
                            Discount
                        </h3>
                        <div class="flex items-center mt-2">
                            <input class="border p-2 w-full" placeholder="ENTER DISCOUNT CODE" type="text"/>
                            <button class="bg-gray-300 text-gray-700 p-2 ml-2">
                                Apply
                            </button>
                        </div>
                    </div>
                    <div class="bg-white p-4 mt-4 shadow-md">
                        <h3 class="text-md font-bold">
                            Order information
                        </h3>
                        <div class="flex justify-between items-center mt-2">
                            <p>
                                Subtotal
                            </p>
                            <p class="font-bold">
                                700.000 đ
                            </p>
                        </div>
                        <div class="flex justify-between items-center mt-2">
                            <p>
                                Total
                            </p>
                            <p class="font-bold text-green-500">
                                700.000 đ
                            </p>
                        </div>
                        <div class="mt-2">
                            <p class="text-sm">
                                By proceeding the order, you agree to the
                                <a class="text-blue-500 underline" href="#">
                                    General Trading Conditions
                                </a>
                            </p>
                        </div>
                        <div class="mt-4">
                            <button class="bg-green-500 text-white w-full p-2 rounded-md">
                                Payment
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>