<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chi tiết sự kiện</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100">
        <div class="container mx-auto p-6">
            <h2 class="text-3xl font-bold mb-6">Chi tiết sự kiện: ${event.eventName}</h2>
            <div class="bg-white p-6 rounded-lg shadow mb-6">
                <table class="w-full">
                    <tr>
                        <th class="py-2 text-left">ID</th>
                        <td class="py-2">${event.eventId}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Danh mục</th>
                        <td class="py-2">${event.categoryName}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Nhà tổ chức</th>
                        <td class="py-2">${event.organizationName}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Địa điểm</th>
                        <td class="py-2">${event.location}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Loại sự kiện</th>
                        <td class="py-2">${event.eventType}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Trạng thái</th>
                        <td class="py-2">${event.status}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Ngày bắt đầu</th>
                        <td class="py-2">${event.startDate}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Ngày kết thúc</th>
                        <td class="py-2">${event.endDate}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Ngày tạo</th>
                        <td class="py-2">${event.createdAt}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Ngày cập nhật</th>
                        <td class="py-2">${event.updatedAt}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Mô tả</th>
                        <td class="py-2">${event.description}</td>
                    </tr>
                    <tr>
                        <th class="py-2 text-left">Hình ảnh</th>
                        <td class="py-2">
                            <div>
                                <p><strong>Banner:</strong></p>
                                <img src="${logoBannerImage}" alt="Logo Banner" class="w-64 h-auto mb-2" />
                            </div>
                            <div>
                                <p><strong>Event:</strong></p>
                                <img src="${logoEventImage}" alt="Logo Event" class="w-64 h-auto mb-2" />
                            </div>
                            <div>
                                <p><strong>Organizer:</strong></p>
                                <img src="${logoOrganizerImage}" alt="Logo Organizer" class="w-64 h-auto mb-2" />
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <a href="viewAllEvents?page=${currentPage}" class="bg-blue-600 text-white py-2 px-4 rounded">Quay lại danh sách</a>
        </div>
    </body>
</html>
