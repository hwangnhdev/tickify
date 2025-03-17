<%-- 
    Document   : validateTicket
    Created on : Mar 9, 2025, 11:32:18 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <title>QR Code Scanner</title>
        
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/jsqr@1.4.0/dist/jsQR.min.js"></script>
        
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&amp;display=swap" rel="stylesheet"/>
    </head>
    <body class="bg-gray-100 font-roboto">
        <div class="flex h-screen">
            <jsp:include page="sidebar.jsp" />
            <div class="flex-1 p-6">
                <div class="flex flex-col items-center justify-center" style="min-height: 95vh">
                    <h1 class="text-3xl font-bold mb-6">
                        QR Code Scanner
                    </h1>
                    <div class="bg-white p-6 rounded-lg shadow-lg">
                        <div class="w-64 h-64 border-4 border-dashed border-gray-300 flex items-center justify-center mb-4">
                            <!--<img alt="Placeholder for QR code scanning area" class="w-full h-full object-cover" height="150" src="https://storage.googleapis.com/a1aa/image/n6QoAQ4C9ciVDOdMxkoiTP3iRnytUB_XUiZfnVjl_B4.jpg" width="150"/>-->
                            <video class="w-full h-full object-cover" id="video" width="300" height="300" autoplay></video>
                            <canvas id="canvas" style="display: none;"></canvas>
                        </div>
                        <button class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-opacity-50">
                            <i class="fas fa-camera mr-2">
                            </i>
                            Scan QR Code
                        </button>
                        <div class="mt-4 p-4 bg-green-100 text-green-700 rounded-lg hidden" id="scan-result">
                            <p class="font-bold">
                                Scan Successful!
                            </p>
                            <p id="qr-content">
                                Content of the QR code will be displayed here.
                            </p>
                            <p id="result"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script>
            // Simulate QR code scanning and displaying the result
            document.querySelector('button').addEventListener('click', function () {
                // Simulate a successful scan
                const scanResult = document.getElementById('scan-result');
                const qrContent = document.getElementById('qr-content');

                // Display the scan result
                scanResult.classList.remove('hidden');
                qrContent.textContent = 'https://example.com'; // Replace with actual QR code content
            });
            
            const video = document.getElementById('video');
            const canvas = document.getElementById('canvas');
            const context = canvas.getContext('2d');
            let scanning = false;

            // Bật camera
            navigator.mediaDevices.getUserMedia({video: {facingMode: "environment"}})
                    .then((stream) => {
                        video.srcObject = stream;
                        video.setAttribute("playsinline", true);
                        video.play();
                        video.addEventListener("loadedmetadata", () => {
                            console.log("Camera đã sẵn sàng!");
                            scanning = true;
                            scanQR();
                        });
                    })
                    .catch((error) => {
                        console.error("Lỗi khi bật camera:", error);
                    });

            function scanQR() {
                if (!scanning)
                    return;

                if (video.videoWidth === 0 || video.videoHeight === 0) {
                    console.warn("Chưa có dữ liệu video, thử lại...");
                    requestAnimationFrame(scanQR);
                    return;
                }

                canvas.width = video.videoWidth;
                canvas.height = video.videoHeight;
                context.drawImage(video, 0, 0, canvas.width, canvas.height);

//                let imageData = context.getImageData(0, 0, canvas.width, canvas.height);
                let imageData = context.getImageData(0, 0, canvas.width, canvas.height, {willReadFrequently: true});
                let code = jsQR(imageData.data, canvas.width, canvas.height);

                if (code) {
                    console.log("Mã QR: ", code.data);
                    document.getElementById("result").innerText = "Mã QR: " + code.data;
                    scanning = false; // Dừng quét sau khi tìm thấy mã

                    let ticketCode = getTicketCode(code.data);
                    if (ticketCode) {
                        validateTicket(ticketCode);
                    } else {
                        console.error("Không tìm thấy ticket trong QR Code!");
                    }
                } else {
                    requestAnimationFrame(scanQR);
                }
            }

            function getTicketCode(qrData) {
                const params = new URLSearchParams(qrData);
                return params.get("ticketCode");
            }

            function validateTicket(ticketCode) {
                fetch("${pageContext.request.contextPath}/validateTicket?ticketCode=" + ticketCode)
                        .then(response => response.text())
                        .then(data => {
                            if (data.trim() === "") {
                                document.getElementById("result").innerText = "Không nhận được phản hồi từ server!";
                                console.error("Lỗi: Server không trả về dữ liệu.");
                            } else {
                                document.getElementById("result").innerText = "Kết quả kiểm tra: " + data;
                                console.log("Kết quả từ server:", data);
                            }
                        })
                        .catch(error => console.error("Lỗi khi gửi dữ liệu đến server:", error));
            }
        </script>
    </body>
</html>