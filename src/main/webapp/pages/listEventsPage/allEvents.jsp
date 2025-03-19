<%-- 
    Document   : allEvents
    Created on : Feb 14, 2025, 3:56:45 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Events</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet" />
        <link href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
        <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/vi.js"></script>
        <style>
            body {
                background-color: black;
                color: white;
            }

            /* Filter Container */
            .filter-container {
                width: 100%;
                max-width: 1200px;
                margin: 35px auto;
                padding: 10px;
                background: #ffffff;
                border-radius: 12px;
                box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.05);
                border: 1px solid #e9ecef;
                transition: all 0.3s ease;
            }

            .filter-container:hover {
                box-shadow: 0px 6px 18px rgba(0, 0, 0, 0.1);
            }

            /* Filter Row */
            .filter-row {
                display: flex;
                justify-content: flex-start;
                flex-wrap: wrap;
                gap: 8px;
                padding: 0 0;
                align-items: center;
            }

            /* Filter Group */
            .filter-group {
                flex: 1;
                min-width: 180px;
                display: flex;
                flex-direction: column;
                gap: 8px;
            }

            .filter-group label {
                font-weight: 600;
                font-size: 15px;
                color: #2c3e50;
                margin-bottom: 5px;
                transition: color 0.3s ease;
            }

            .filter-group:hover label {
                color: #3498db;
            }

            /* Date Input Styling with Flatpickr */
            .filter-group input[type="text"].flatpickr-input {
                padding: 10px 12px;
                border: 2px solid #dfe6e9;
                border-radius: 8px;
                font-size: 14px;
                background-color: #fff;
                color: #34495e;
                transition: all 0.3s ease;
                cursor: pointer;
                height: 40px;
                width: 100%;
                box-sizing: border-box;
            }

            .filter-group input[type="text"].flatpickr-input:hover,
            .filter-group input[type="text"].flatpickr-input:focus {
                border-color: #3498db;
                box-shadow: 0 0 8px rgba(52, 152, 219, 0.3);
                outline: none;
            }

            /* Tùy chỉnh giao diện Flatpickr */
            .flatpickr-calendar {
                border: none;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                background: #ffffff;
                font-family: Arial, sans-serif;
            }

            .flatpickr-day.selected {
                background-color: #3498db;
                border-color: #3498db;
                color: #fff;
            }

            .flatpickr-day.today {
                background-color: #e9ecef;
                color: #2c3e50;
            }

            .flatpickr-day:hover {
                background-color: #dfe6e9;
                color: #2c3e50;
            }

            .flatpickr-months .flatpickr-month {
                background: #28a745;
                color: #fff;
                border-radius: 8px 8px 0 0;
            }

            .flatpickr-weekdays {
                background: #f8f9fa;
                color: #2c3e50;
            }

            .flatpickr-rContainer .flatpickr-days {
                border-top: none;
            }

            /* Tùy chỉnh nút preset (Tất cả các ngày, Hôm nay, v.v.) */
            .flatpickr-ranges {
                padding: 10px;
                border-bottom: 1px solid #e9ecef;
                background: #f8f9fa;
            }

            .flatpickr-ranges button {
                background: #fff;
                border: 1px solid #dfe6e9;
                border-radius: 4px;
                padding: 5px 10px;
                margin-right: 5px;
                cursor: pointer;
                font-size: 14px;
                color: #2c3e50;
                transition: all 0.3s ease;
            }

            .flatpickr-ranges button:hover {
                background: #dfe6e9;
                border-color: #3498db;
                color: #2c3e50;
            }

            /* Nút Apply và Reset */
            .flatpickr-footer {
                padding: 10px;
                background: #fff;
                border-top: 1px solid #e9ecef;
                text-align: right;
            }

            .flatpickr-footer button {
                background: #2ecc71;
                border: none;
                border-radius: 25px;
                padding: 8px 20px;
                font-size: 14px;
                color: #fff;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .flatpickr-footer button:hover {
                background: #27ae60;
                transform: translateY(-2px);
            }

            .flatpickr-footer button:active {
                transform: translateY(1px);
            }

            /* Category, Price, Location Collapse Styling */
            .filter-group.category-group, .filter-group.price-group, .filter-group.location-group {
                position: relative;
                width: 100%;
            }

            .category-toggle {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 10px 12px;
                background: #ecf0f1;
                border: 2px solid #dfe6e9;
                border-radius: 8px;
                cursor: pointer;
                transition: all 0.3s ease;
                height: 40px;
                font-size: 14px;
                color: #34495e;
            }

            .category-toggle:hover {
                background: #dfe6e9;
                border-color: #3498db;
            }

            .category-toggle::after {
                content: '\25BC';
                font-size: 12px;
                transition: transform 0.3s ease;
                color: #3498db;
            }

            .category-toggle.active::after {
                transform: rotate(180deg);
            }

            .category-list {
                position: absolute;
                top: 100%;
                left: 0;
                right: 0;
                max-height: 0;
                overflow: auto;
                transition: max-height 0.3s ease;
                background: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                z-index: 1000;
                margin-top: 2px;
                color: black;
            }

            .category-list.active {
                max-height: 200px;
            }

            .filter-group input[type="checkbox"], .filter-group input[type="radio"] {
                margin-right: 8px;
                accent-color: #3498db;
                transform: scale(1.2);
                cursor: pointer;
                margin-left: 20px;
            }

            .filter-group input[type="checkbox"] + br, .filter-group input[type="radio"] + br {
                margin-bottom: 8px;
            }

            /* Apply Button */
            .apply-button {
                flex: 1;
                min-width: 120px;
                margin-top: 20px;
            }

            .apply-button .btn-success {
                padding: 10px 30px;
                font-size: 16px;
                font-weight: 600;
                border-radius: 25px;
                background: #2ecc71;
                border: none;
                color: #fff;
                transition: all 0.3s ease;
                width: 100%;
                height: 40px;
                box-shadow: 0 4px 10px rgba(46, 204, 113, 0.3);
            }

            .apply-button .btn-success:hover {
                background: #27ae60;
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(46, 204, 113, 0.4);
            }

            .apply-button .btn-success:active {
                transform: translateY(1px);
                box-shadow: 0 2px 8px rgba(46, 204, 113, 0.2);
            }

            /*All Events*/
            .title-all_events {
                text-align: center;
                font-size: 24px;
                font-weight: bold;
            }
            .event-card-all_events {
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                text-align: center;
                transition: transform 0.3s, box-shadow 0.3s;
                margin-top: 1%;
            }

            .event-card-all_events:hover {
                transform: translateY(-10px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .event-card-all_events img {
                width: 100%;
                height: 180px;
                object-fit: fill;
                background-color: #f0f0f0;
                display: block;
                transition: filter 0.3s;
                object-fit: fill;
                transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
            }

            .event-card-all_events:hover img {
                filter: brightness(1.1);
                transform: scale(1.1);
                box-shadow: 0px 0px 15px rgba(255, 255, 255, 0.5);
            }
            .event-card-all_events h4 {
                font-size: 16px;
                margin: 10px 0 5px;
                color: #000000;
            }
            .event-card-all_events p {
                font-size: 14px;
                margin: 0 0;
                color: #000000;
            }
            .g-4, .gy-4 {
                --bs-gutter-y: 1.5rem;
                margin: 0 7%;
            }
            .py-4 {
                padding-top: 0.5rem !important;
                padding-bottom: 1.5rem !important;
            }
        </style>
    </head>
    <body>
        <!-- Header -->
        <jsp:include page="../../components/header.jsp"></jsp:include>

            <!-- Filter Form -->
            <form id="filterForm" action="${pageContext.request.contextPath}/allEvents" method="GET" class="filter-container">
            <!-- Include the search query in the form -->
            <input type="hidden" name="query" value="${searchQuery}">

            <!-- Filter Section -->
            <div class="filter-row">
                <!-- Filter Date -->
                <div class="filter-group">
                    <label for="startDate">Start Date:</label>
                    <input type="text" name="startDate" id="startDate" value="${selectedStartDate}" class="flatpickr-input" placeholder="Select Start Date" readonly>
                </div>

                <div class="filter-group">
                    <label for="endDate">End Date:</label>
                    <input type="text" name="endDate" id="endDate" value="${selectedEndDate}" class="flatpickr-input" placeholder="Select End Date" readonly>
                </div>

                <!-- Filter Category (Multiple Selection) -->
                <div class="filter-group category-group">
                    <label for="categoryDropdown">Category:</label>
                    <div class="category-toggle">
                        <label>
                            <c:choose>
                                <c:when test="${not empty sessionScope.selectedCategories}">
                                    <c:set var="categoryCount" value="${fn:length(sessionScope.selectedCategories)}" />
                                    <c:if test="${categoryCount > 0}">
                                        <c:set var="firstCategory" value="true" />
                                        <c:forEach var="selected" items="${sessionScope.selectedCategories}">
                                            <c:if test="${firstCategory}">
                                                <c:forEach var="category" items="${listCategories}">
                                                    <c:if test="${category.categoryId == selected}">
                                                        ${category.categoryName}<c:if test="${categoryCount > 1}">...</c:if>
                                                        <c:set var="firstCategory" value="false" />
                                                    </c:if>
                                                </c:forEach>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    Category
                                </c:otherwise>
                            </c:choose>
                        </label>
                    </div>
                    <div class="category-list">
                        <c:set var="selectedCategoryList" value="${sessionScope.selectedCategories}" />
                        <c:forEach var="category" items="${listCategories}">
                            <input type="checkbox" name="category" value="${category.categoryId}"
                                   <c:forEach var="selected" items="${selectedCategoryList}">
                                       <c:if test="${selected == category.categoryId}">checked</c:if>
                                   </c:forEach>>
                            ${category.categoryName} <br>
                        </c:forEach>
                    </div>
                </div>

                <!-- Filter Price (Radio Selection - Tùy chỉnh giống Category) -->
                <div class="filter-group price-group">
                    <label for="priceDropdown">Price:</label>
                    <div class="category-toggle" data-type="price">
                        <label>
                            <c:choose>
                                <c:when test="${not empty sessionScope.selectedPrice}">
                                    <c:if test="${sessionScope.selectedPrice == 'below_150'}">Below 150</c:if>
                                    <c:if test="${sessionScope.selectedPrice == 'between_150_300'}">150 - 300</c:if>
                                    <c:if test="${sessionScope.selectedPrice == 'greater_300'}">Above 300</c:if>
                                    <c:if test="${empty sessionScope.selectedPrice}">All Prices</c:if>
                                </c:when>
                                <c:otherwise>
                                    Price
                                </c:otherwise>
                            </c:choose>
                        </label>
                    </div>
                    <div class="category-list" data-type="price">
                        <input type="radio" name="price" value="below_150" ${selectedPrice == 'below_150' ? 'checked' : ''}> Below 150 <br>
                        <input type="radio" name="price" value="between_150_300" ${selectedPrice == 'between_150_300' ? 'checked' : ''}> 150 - 300 <br>
                        <input type="radio" name="price" value="greater_300" ${selectedPrice == 'greater_300' ? 'checked' : ''}> Above 300 <br>
                        <input type="radio" name="price" value="" ${empty selectedPrice ? 'checked' : ''}> All Prices <br>
                    </div>
                </div>

                <!-- Filter Location (Radio Selection - Tùy chỉnh giống Category) -->
                <div class="filter-group location-group">
                    <label for="locationDropdown">Location:</label>
                    <div class="category-toggle" data-type="location">
                        <label>
                            <c:choose>
                                <c:when test="${not empty sessionScope.selectedLocation}">
                                    ${sessionScope.selectedLocation}
                                </c:when>
                                <c:otherwise>
                                    Location
                                </c:otherwise>
                            </c:choose>
                        </label>
                    </div>
                    <div class="category-list" data-type="location">
                        <input type="radio" name="location" value="" ${empty selectedLocation ? 'checked' : ''}> All Locations <br>
                        <input type="radio" name="location" value="Thành phố Hà Nội" ${selectedLocation == 'Thành phố Hà Nội' ? 'checked' : ''}> Hà Nội <br>
                        <input type="radio" name="location" value="Tỉnh Hà Giang" ${selectedLocation == 'Tỉnh Hà Giang' ? 'checked' : ''}> Hà Giang <br>
                        <input type="radio" name="location" value="Tỉnh Cao Bằng" ${selectedLocation == 'Tỉnh Cao Bằng' ? 'checked' : ''}> Cao Bằng <br>
                        <input type="radio" name="location" value="Tỉnh Bắc Kạn" ${selectedLocation == 'Tỉnh Bắc Kạn' ? 'checked' : ''}> Bắc Kạn <br>
                        <input type="radio" name="location" value="Tỉnh Tuyên Quang" ${selectedLocation == 'Tỉnh Tuyên Quang' ? 'checked' : ''}> Tuyên Quang <br>
                        <input type="radio" name="location" value="Tỉnh Lào Cai" ${selectedLocation == 'Tỉnh Lào Cai' ? 'checked' : ''}> Lào Cai <br>
                        <input type="radio" name="location" value="Tỉnh Điện Biên" ${selectedLocation == 'Tỉnh Điện Biên' ? 'checked' : ''}> Điện Biên <br>
                        <input type="radio" name="location" value="Tỉnh Lai Châu" ${selectedLocation == 'Tỉnh Lai Châu' ? 'checked' : ''}> Lai Châu <br>
                        <input type="radio" name="location" value="Tỉnh Sơn La" ${selectedLocation == 'Tỉnh Sơn La' ? 'checked' : ''}> Sơn La <br>
                        <input type="radio" name="location" value="Tỉnh Yên Bái" ${selectedLocation == 'Tỉnh Yên Bái' ? 'checked' : ''}> Yên Bái <br>
                        <input type="radio" name="location" value="Tỉnh Hoà Bình" ${selectedLocation == 'Tỉnh Hoà Bình' ? 'checked' : ''}> Hoà Bình <br>
                        <input type="radio" name="location" value="Tỉnh Thái Nguyên" ${selectedLocation == 'Tỉnh Thái Nguyên' ? 'checked' : ''}> Thái Nguyên <br>
                        <input type="radio" name="location" value="Tỉnh Lạng Sơn" ${selectedLocation == 'Tỉnh Lạng Sơn' ? 'checked' : ''}> Lạng Sơn <br>
                        <input type="radio" name="location" value="Tỉnh Quảng Ninh" ${selectedLocation == 'Tỉnh Quảng Ninh' ? 'checked' : ''}> Quảng Ninh <br>
                        <input type="radio" name="location" value="Tỉnh Bắc Giang" ${selectedLocation == 'Tỉnh Bắc Giang' ? 'checked' : ''}> Bắc Giang <br>
                        <input type="radio" name="location" value="Tỉnh Phú Thọ" ${selectedLocation == 'Tỉnh Phú Thọ' ? 'checked' : ''}> Phú Thọ <br>
                        <input type="radio" name="location" value="Tỉnh Vĩnh Phúc" ${selectedLocation == 'Tỉnh Vĩnh Phúc' ? 'checked' : ''}> Vĩnh Phúc <br>
                        <input type="radio" name="location" value="Tỉnh Bắc Ninh" ${selectedLocation == 'Tỉnh Bắc Ninh' ? 'checked' : ''}> Bắc Ninh <br>
                        <input type="radio" name="location" value="Tỉnh Hải Dương" ${selectedLocation == 'Tỉnh Hải Dương' ? 'checked' : ''}> Hải Dương <br>
                        <input type="radio" name="location" value="Thành phố Hải Phòng" ${selectedLocation == 'Thành phố Hải Phòng' ? 'checked' : ''}> Hải Phòng <br>
                        <input type="radio" name="location" value="Tỉnh Hưng Yên" ${selectedLocation == 'Tỉnh Hưng Yên' ? 'checked' : ''}> Hưng Yên <br>
                        <input type="radio" name="location" value="Tỉnh Thái Bình" ${selectedLocation == 'Tỉnh Thái Bình' ? 'checked' : ''}> Thái Bình <br>
                        <input type="radio" name="location" value="Tỉnh Hà Nam" ${selectedLocation == 'Tỉnh Hà Nam' ? 'checked' : ''}> Hà Nam <br>
                        <input type="radio" name="location" value="Tỉnh Nam Định" ${selectedLocation == 'Tỉnh Nam Định' ? 'checked' : ''}> Nam Định <br>
                        <input type="radio" name="location" value="Tỉnh Ninh Bình" ${selectedLocation == 'Tỉnh Ninh Bình' ? 'checked' : ''}> Ninh Bình <br>
                        <input type="radio" name="location" value="Tỉnh Thanh Hóa" ${selectedLocation == 'Tỉnh Thanh Hóa' ? 'checked' : ''}> Thanh Hóa <br>
                        <input type="radio" name="location" value="Tỉnh Nghệ An" ${selectedLocation == 'Tỉnh Nghệ An' ? 'checked' : ''}> Nghệ An <br>
                        <input type="radio" name="location" value="Tỉnh Hà Tĩnh" ${selectedLocation == 'Tỉnh Hà Tĩnh' ? 'checked' : ''}> Hà Tĩnh <br>
                        <input type="radio" name="location" value="Tỉnh Quảng Bình" ${selectedLocation == 'Tỉnh Quảng Bình' ? 'checked' : ''}> Quảng Bình <br>
                        <input type="radio" name="location" value="Tỉnh Quảng Trị" ${selectedLocation == 'Tỉnh Quảng Trị' ? 'checked' : ''}> Quảng Trị <br>
                        <input type="radio" name="location" value="Thành phố Huế" ${selectedLocation == 'Thành phố Huế' ? 'checked' : ''}> Huế <br>
                        <input type="radio" name="location" value="Thành phố Đà Nẵng" ${selectedLocation == 'Thành phố Đà Nẵng' ? 'checked' : ''}> Đà Nẵng <br>
                        <input type="radio" name="location" value="Tỉnh Quảng Nam" ${selectedLocation == 'Tỉnh Quảng Nam' ? 'checked' : ''}> Quảng Nam <br>
                        <input type="radio" name="location" value="Tỉnh Quảng Ngãi" ${selectedLocation == 'Tỉnh Quảng Ngãi' ? 'checked' : ''}> Quảng Ngãi <br>
                        <input type="radio" name="location" value="Tỉnh Bình Định" ${selectedLocation == 'Tỉnh Bình Định' ? 'checked' : ''}> Bình Định <br>
                        <input type="radio" name="location" value="Tỉnh Phú Yên" ${selectedLocation == 'Tỉnh Phú Yên' ? 'checked' : ''}> Phú Yên <br>
                        <input type="radio" name="location" value="Tỉnh Khánh Hòa" ${selectedLocation == 'Tỉnh Khánh Hòa' ? 'checked' : ''}> Khánh Hòa <br>
                        <input type="radio" name="location" value="Tỉnh Ninh Thuận" ${selectedLocation == 'Tỉnh Ninh Thuận' ? 'checked' : ''}> Ninh Thuận <br>
                        <input type="radio" name="location" value="Tỉnh Bình Thuận" ${selectedLocation == 'Tỉnh Bình Thuận' ? 'checked' : ''}> Bình Thuận <br>
                        <input type="radio" name="location" value="Tỉnh Kon Tum" ${selectedLocation == 'Tỉnh Kon Tum' ? 'checked' : ''}> Kon Tum <br>
                        <input type="radio" name="location" value="Tỉnh Gia Lai" ${selectedLocation == 'Tỉnh Gia Lai' ? 'checked' : ''}> Gia Lai <br>
                        <input type="radio" name="location" value="Tỉnh Đắk Lắk" ${selectedLocation == 'Tỉnh Đắk Lắk' ? 'checked' : ''}> Đắk Lắk <br>
                        <input type="radio" name="location" value="Thành phố Hồ Chí Minh" ${selectedLocation == 'Thành phố Hồ Chí Minh' ? 'checked' : ''}> Hồ Chí Minh <br>
                        <input type="radio" name="location" value="Tỉnh Đắk Nông" ${selectedLocation == 'Tỉnh Đắk Nông' ? 'checked' : ''}> Đắk Nông <br>
                        <input type="radio" name="location" value="Tỉnh Lâm Đồng" ${selectedLocation == 'Tỉnh Lâm Đồng' ? 'checked' : ''}> Lâm Đồng <br>
                        <input type="radio" name="location" value="Tỉnh Bình Phước" ${selectedLocation == 'Tỉnh Bình Phước' ? 'checked' : ''}> Bình Phước <br>
                        <input type="radio" name="location" value="Tỉnh Tây Ninh" ${selectedLocation == 'Tỉnh Tây Ninh' ? 'checked' : ''}> Tây Ninh <br>
                        <input type="radio" name="location" value="Tỉnh Bình Dương" ${selectedLocation == 'Tỉnh Bình Dương' ? 'checked' : ''}> Bình Dương <br>
                        <input type="radio" name="location" value="Tỉnh Đồng Nai" ${selectedLocation == 'Tỉnh Đồng Nai' ? 'checked' : ''}> Đồng Nai <br>
                        <input type="radio" name="location" value="Tỉnh Bà Rịa - Vũng Tàu" ${selectedLocation == 'Tỉnh Bà Rịa - Vũng Tàu' ? 'checked' : ''}> Vũng Tàu <br>
                        <input type="radio" name="location" value="Tỉnh Long An" ${selectedLocation == 'Tỉnh Long An' ? 'checked' : ''}> Long An <br>
                        <input type="radio" name="location" value="Tỉnh Tiền Giang" ${selectedLocation == 'Tỉnh Tiền Giang' ? 'checked' : ''}> Tiền Giang <br>
                        <input type="radio" name="location" value="Tỉnh Bến Tre" ${selectedLocation == 'Tỉnh Bến Tre' ? 'checked' : ''}> Bến Tre <br>
                        <input type="radio" name="location" value="Tỉnh Trà Vinh" ${selectedLocation == 'Tỉnh Trà Vinh' ? 'checked' : ''}> Trà Vinh <br>
                        <input type="radio" name="location" value="Tỉnh Vĩnh Long" ${selectedLocation == 'Tỉnh Vĩnh Long' ? 'checked' : ''}> Vĩnh Long <br>
                        <input type="radio" name="location" value="Tỉnh Đồng Tháp" ${selectedLocation == 'Tỉnh Đồng Tháp' ? 'checked' : ''}> Đồng Tháp <br>
                        <input type="radio" name="location" value="Tỉnh An Giang" ${selectedLocation == 'Tỉnh An Giang' ? 'checked' : ''}> An Giang <br>
                        <input type="radio" name="location" value="Tỉnh Kiên Giang" ${selectedLocation == 'Tỉnh Kiên Giang' ? 'checked' : ''}> Kiên Giang <br>
                        <input type="radio" name="location" value="Thành phố Cần Thơ" ${selectedLocation == 'Thành phố Cần Thơ' ? 'checked' : ''}> Cần Thơ <br>
                        <input type="radio" name="location" value="Tỉnh Hậu Giang" ${selectedLocation == 'Tỉnh Hậu Giang' ? 'checked' : ''}> Hậu Giang <br>
                        <input type="radio" name="location" value="Tỉnh Sóc Trăng" ${selectedLocation == 'Tỉnh Sóc Trăng' ? 'checked' : ''}> Sóc Trăng <br>
                        <input type="radio" name="location" value="Tỉnh Bạc Liêu" ${selectedLocation == 'Tỉnh Bạc Liêu' ? 'checked' : ''}> Bạc Liêu <br>
                        <input type="radio" name="location" value="Tỉnh Cà Mau" ${selectedLocation == 'Tỉnh Cà Mau' ? 'checked' : ''}> Cà Mau <br>
                    </div>
                </div>

                <!-- Apply Button (Đặt trực tiếp trong filter-row, không dùng filter-group) -->
                <div class="apply-button">
                    <button type="submit" class="btn btn-success">Apply</button>
                </div>
            </div>
        </form>

        <!-- Check if there are no filtered events -->
        <c:choose>
            <c:when test="${empty filteredEvents}">
                <p class="text-center">Not Event Found From Your Filter And Search</p>
                <!--All Event--> 
                <h2 class="text-xl font-bold  text-center" style="margin-left: 4%;">
                    <i class="fas fa-calendar-week text-green-500 mr-2"></i> All Events For You
                </h2>
                <div class="container py-4">
                    <div class="row gy-4" id="event-container">
                        <!-- Loop through paginated events -->
                        <c:forEach var="event" items="${paginatedEventsAll}">
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                                <div class="event-card-all_events">
                                    <a style="text-decoration: none;" href="eventDetail?id=${event.event.eventId}">
                                        <img src="${event.eventImage.imageUrl}" alt="${event.eventImage.imageTitle}" />
                                        <h2 class="text-white text-sm font-semibold mb-2 h-[56px] line-clamp-2 overflow-hidden" style="margin-bottom: -0.5rem !important; padding: 0.5rem !important; background-color: #121212;">
                                            ${event.event.eventName}
                                        </h2>
                                        <p class="text-sm font-semibold" style="color: #00a651; background-color: #121212;">From  <fmt:formatNumber value="${event.minPrice}" currencyCode="VND" minFractionDigits="0" /> VND</p>
                                        <p class="text-sm font-semibold" style="color: white; background-color: #121212;">
                                            <i class="far fa-calendar-alt mr-2"></i>
                                            <span class=""><fmt:formatDate value="${event.firstStartDate}" pattern="hh:mm:ss a, dd MMM yyyy"/></span>
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <!-- Bootstrap JS for All Events-->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
            </c:when>
            <c:otherwise>
                <div class="container py-4">
                    <div class="row gy-4" id="event-container">
                        <!-- Loop through paginated events -->
                        <c:forEach var="event" items="${filteredEvents}">
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                                <div class="event-card-all_events">
                                    <a style="text-decoration: none;" href="eventDetail?id=${event.event.eventId}">
                                        <img src="${event.eventImage.imageUrl}" alt="${event.eventImage.imageTitle}" />
                                        <h2 class="text-white text-sm font-semibold mb-2 h-[56px] line-clamp-2 overflow-hidden" style="margin-bottom: -0.5rem !important; padding: 0.5rem !important; background-color: #121212;">
                                            ${event.event.eventName}
                                        </h2>
                                        <p class="text-sm font-semibold" style="color: #00a651; background-color: #121212;">From  <fmt:formatNumber value="${event.minPrice}" currencyCode="VND" minFractionDigits="0" /> VND</p>
                                        <p class="text-sm font-semibold" style="color: white; background-color: #121212;">
                                            <i class="far fa-calendar-alt mr-2"></i>
                                            <span class=""><fmt:formatDate value="${event.firstStartDate}" pattern="hh:mm:ss a, dd MMM yyyy"/></span>
                                        </p>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

        <!--Footer-->
        <jsp:include page="../../components/footer.jsp"></jsp:include>

            <script>
                // Khởi tạo Flatpickr cho Start Date
                flatpickr("#startDate", {
                    dateFormat: "Y-m-d",
                    defaultDate: "${selectedStartDate}",
                    locale: "vi",
                    maxDate: new Date().fp_incr(365), // Giới hạn tối đa là 1 năm từ hôm nay
                    minDate: "today", // Giới hạn tối thiểu là ngày hôm nay
                    onChange: function (selectedDates, dateStr, instance) {
                        // Khi chọn ngày bắt đầu, cập nhật giá trị và giới hạn tối thiểu cho endDate
                        document.getElementById('startDate').value = dateStr;
                        const endDatePicker = document.getElementById('endDate')._flatpickr;
                        const endDateValue = document.getElementById('endDate').value;

                        if (selectedDates[0]) {
                            // Đặt minDate của endDate là ngày lớn hơn startDate ít nhất 1 ngày
                            const minEndDate = new Date(selectedDates[0]);
                            minEndDate.setDate(minEndDate.getDate() + 1); // Tăng 1 ngày
                            endDatePicker.set("minDate", minEndDate);

                            // Nếu endDate hiện tại nhỏ hơn hoặc bằng startDate, xóa endDate
                            if (endDateValue && new Date(endDateValue) <= selectedDates[0]) {
                                endDatePicker.clear(); // Xóa giá trị endDate
                                document.getElementById('endDate').value = "";
                            }
                        }
                    },
                    onReady: function (selectedDates, dateStr, instance) {
                        // Thêm các nút preset
                        const ranges = document.createElement('div');
                        ranges.className = 'flatpickr-ranges';
                        ranges.innerHTML = `
                        <button data-range="today">Hôm nay</button>
                        <button data-range="tomorrow">Ngày mai</button>
                        <button data-range="weekend">Cuối tuần này</button>
                        <button data-range="month">Tháng này</button>
                    `;
                        instance.calendarContainer.insertBefore(ranges, instance.calendarContainer.firstChild);

                        ranges.querySelectorAll('button').forEach(button => {
                            button.addEventListener('click', function () {
                                const range = this.getAttribute('data-range');
                                let date;
                                const now = new Date();
                                switch (range) {
                                    case 'today':
                                        date = now;
                                        break;
                                    case 'tomorrow':
                                        date = new Date(now.getTime() + 24 * 60 * 60 * 1000);
                                        break;
                                    case 'weekend':
                                        date = new Date(now);
                                        date.setDate(date.getDate() + (6 - date.getDay() + 1) % 7);
                                        break;
                                    case 'month':
                                        date = new Date(now.getFullYear(), now.getMonth(), 1);
                                        break;
                                }
                                instance.setDate(date);
                                document.getElementById('startDate').value = instance.formatDate(date, "Y-m-d");
                                const endDatePicker = document.getElementById('endDate')._flatpickr;
                                const minEndDate = new Date(date);
                                minEndDate.setDate(minEndDate.getDate() + 1);
                                endDatePicker.set("minDate", minEndDate);
                                if (document.getElementById('endDate').value && new Date(document.getElementById('endDate').value) <= date) {
                                    endDatePicker.clear();
                                    document.getElementById('endDate').value = "";
                                }
                            });
                        });
                    }
                });

                // Khởi tạo Flatpickr cho End Date
                flatpickr("#endDate", {
                    dateFormat: "Y-m-d",
                    defaultDate: "${selectedEndDate}",
                    locale: "vi",
                    maxDate: new Date().fp_incr(365), // Giới hạn tối đa là 1 năm từ hôm nay
                    minDate: "${selectedStartDate}" ? new Date("${selectedStartDate}").fp_incr(1) : "tomorrow", // Nếu có startDate thì min là ngày sau startDate, không thì là ngày mai
                    onChange: function (selectedDates, dateStr, instance) {
                        // Khi chọn ngày kết thúc, cập nhật giá trị
                        document.getElementById('endDate').value = dateStr;
                        const startDateValue = document.getElementById('startDate').value;
                        const startDate = startDateValue ? new Date(startDateValue) : null;

                        // Nếu startDate đã chọn và endDate nhỏ hơn hoặc bằng startDate, thông báo và xóa
                        if (startDate && selectedDates[0] <= startDate) {
                            alert("Ngày kết thúc phải lớn hơn ngày bắt đầu!");
                            instance.clear();
                            document.getElementById('endDate').value = "";
                        }
                    },
                    onReady: function (selectedDates, dateStr, instance) {
                        // Thêm các nút preset
                        const ranges = document.createElement('div');
                        ranges.className = 'flatpickr-ranges';
                        ranges.innerHTML = `
                            <button data-range="today">Hôm nay</button>
                            <button data-range="tomorrow">Ngày mai</button>
                            <button data-range="weekend">Cuối tuần này</button>
                            <button data-range="month">Tháng này</button>
                        `;
                        instance.calendarContainer.insertBefore(ranges, instance.calendarContainer.firstChild);

                        ranges.querySelectorAll('button').forEach(button => {
                            button.addEventListener('click', function () {
                                const range = this.getAttribute('data-range');
                                let date;
                                const now = new Date();
                                switch (range) {
                                    case 'today':
                                        date = now;
                                        break;
                                    case 'tomorrow':
                                        date = new Date(now.getTime() + 24 * 60 * 60 * 1000);
                                        break;
                                    case 'weekend':
                                        date = new Date(now);
                                        date.setDate(date.getDate() + (6 - date.getDay() + 1) % 7);
                                        break;
                                    case 'month':
                                        date = new Date(now.getFullYear(), now.getMonth() + 1, 0); // Ngày cuối tháng
                                        break;
                                }
                                const startDateValue = document.getElementById('startDate').value;
                                const startDate = startDateValue ? new Date(startDateValue) : null;

                                if (startDate && date <= startDate) {
                                    alert("Ngày kết thúc phải lớn hơn ngày bắt đầu!");
                                    return;
                                }
                                instance.setDate(date);
                                document.getElementById('endDate').value = instance.formatDate(date, "Y-m-d");
                            });
                        });
                    }
                });

                // Hàm toggle cho Category, Price, và Location (giữ nguyên)
                document.querySelectorAll('.category-toggle').forEach(toggle => {
                    toggle.addEventListener('click', function () {
                        const categoryList = this.nextElementSibling;
                        this.classList.toggle('active');
                        categoryList.classList.toggle('active');
                    });
                });

                // Cập nhật dropdown khi người dùng chọn category
                document.querySelectorAll('.category-list input[type="checkbox"]').forEach(checkbox => {
                    checkbox.addEventListener('change', function () {
                        const selectedCategories = Array.from(
                                document.querySelectorAll('.category-list input[type="checkbox"]:checked')
                                ).map(cb => cb.nextSibling.textContent.trim());

                        const categoryToggle = document.querySelector('.category-toggle label');

                        if (selectedCategories.length > 0) {
                            if (selectedCategories.length > 1) {
                                // Hiển thị category mới được chọn gần đây nhất kèm "..."
                                const latestCategory = this.nextSibling.textContent.trim(); // Lấy category từ checkbox vừa thay đổi
                                categoryToggle.textContent = `${latestCategory}...`;
                            } else {
                                // Nếu chỉ có 1 category, hiển thị category đó
                                categoryToggle.textContent = selectedCategories[0];
                            }
                        } else {
                            // Nếu không có category nào được chọn, hiển thị placeholder "Category"
                            categoryToggle.textContent = 'Category';
                        }
                    });
                });

                // Cập nhật dropdown ngay khi trang tải (dựa trên sessionScope)
                window.addEventListener('load', function () {
                    const selectedCategoryList = "${sessionScope.selectedCategories}"
                            ? "${sessionScope.selectedCategories}".replace(/[\[\]"]/g, '').split(',')
                            : [];
                    const categoryToggle = document.querySelector('.category-toggle label');
                    const checkboxes = document.querySelectorAll('.category-list input[type="checkbox"]');

                    if (selectedCategoryList.length > 0) {
                        let latestCategoryName = '';
                        checkboxes.forEach(checkbox => {
                            const categoryId = checkbox.value;
                            if (selectedCategoryList.includes(categoryId)) {
                                latestCategoryName = checkbox.nextSibling.textContent.trim();
                            }
                        });
                        if (selectedCategoryList.length > 1) {
                            categoryToggle.textContent = `${latestCategoryName}...`;
                        } else {
                            categoryToggle.textContent = latestCategoryName || 'Category';
                        }
                    } else {
                        categoryToggle.textContent = 'Category';
                    }

                    // Kích hoạt sự kiện change để đảm bảo giao diện đồng bộ
                    document.querySelectorAll('.category-list input[type="checkbox"]').forEach(checkbox => {
                        checkbox.dispatchEvent(new Event('change'));
                    });
                });

                // Cập nhật dropdown cho Price
                document.querySelectorAll('.price-group .category-list input[type="radio"]').forEach(radio => {
                    radio.addEventListener('change', function () {
                        const selectedPrice = this.nextSibling.textContent.trim();
                        const priceToggle = document.querySelector('.price-group .category-toggle label');
                        priceToggle.textContent = selectedPrice;
                    });
                });

                // Cập nhật dropdown cho Location
                document.querySelectorAll('.location-group .category-list input[type="radio"]').forEach(radio => {
                    radio.addEventListener('change', function () {
                        const selectedLocation = this.nextSibling.textContent.trim();
                        const locationToggle = document.querySelector('.location-group .category-toggle label');
                        locationToggle.textContent = selectedLocation;
                    });
                });

                // Cập nhật dropdown ngay khi trang tải
                document.querySelectorAll('.category-list input[type="checkbox"]').forEach(checkbox => {
                    checkbox.dispatchEvent(new Event('change'));
                });
        </script>
    </body>
</html>