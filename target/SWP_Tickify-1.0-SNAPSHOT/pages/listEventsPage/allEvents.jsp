<%-- 
    Document   : allEvents
    Created on : Feb 14, 2025, 3:56:45 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Events</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <style>
            /*All Events*/
            .title-all_events {
                text-align: center;
                font-size: 24px;
                font-weight: bold;
            }
            .event-card-all_events {
                background-color: #ffffff;
                border: 1px solid #ddd;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                text-align: center;
                width: 320px;
                transition: transform 0.3s, box-shadow 0.3s;
            }

            .event-card-all_events:hover {
                transform: translateY(-10px);
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
            }

            .event-card-all_events img {
                width: 100%;
                height: 150px;
                object-fit: fill;
                background-color: #f0f0f0;
                display: block;
                transition: filter 0.3s;
            }

            .event-card-all_events:hover img {
                filter: brightness(1.1);
            }
            .event-card-all_events h4 {
                font-size: 16px;
                margin: 10px 0 5px;
                color: #000000;
            }
            .event-card-all_events p {
                font-size: 14px;
                margin: 5px 0;
                color: #000000;
            }
            .pagination a {
                text-decoration: none;
            }

            /*Filter*/
            /* Filter Container */
            .filter-container {
                width: 100%;
                max-width: 1200px;
                margin: auto;
                padding: 15px;
                background: #f8f9fa;
                border-radius: 8px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Arrange filters in a horizontal row */
            .filter-row {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                gap: 15px;
            }

            /* Each filter group (for Date, Category, Price, Location) */
            .filter-group {
                flex: 1;
                min-width: 200px;
                display: flex;
                flex-direction: column;
            }

            /* Dropdown Styling */
            .filter-group select {
                padding: 8px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                font-size: 14px;
            }

            /* Date Input Styling */
            .filter-group input[type="date"] {
                padding: 8px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                font-size: 14px;
            }

            /* Button Container */
            .filter-button-container {
                text-align: center;
                margin-top: 15px;
            }

            /* Apply Button */
            .btn-success {
                padding: 10px 20px;
                font-size: 16px;
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
                    <input type="date" name="startDate" id="startDate" value="${selectedStartDate}">

                    <label for="endDate">End Date:</label>
                    <input type="date" name="endDate" id="endDate" value="${selectedEndDate}">
                </div>

                <!-- Filter Category (Multiple Selection) -->
                <div class="filter-group">
                    <label>Category:</label>
                    <c:set var="selectedCategoryList" value="${selectedCategories}" />

                    <input type="checkbox" name="category" value="1"
                           <c:if test="${selectedCategoryList != null && selectedCategoryList.contains(1)}">checked</c:if>> Concert <br>

                           <input type="checkbox" name="category" value="2"
                           <c:if test="${selectedCategoryList != null && selectedCategoryList.contains(2)}">checked</c:if>> Technology <br>

                           <input type="checkbox" name="category" value="3"
                           <c:if test="${selectedCategoryList != null && selectedCategoryList.contains(3)}">checked</c:if>> Sports <br>

                           <input type="checkbox" name="category" value="4"
                           <c:if test="${selectedCategoryList != null && selectedCategoryList.contains(4)}">checked</c:if>> Festival <br>

                           <input type="checkbox" name="category" value="5"
                           <c:if test="${selectedCategoryList != null && selectedCategoryList.contains(5)}">checked</c:if>> Exhibition <br>
                    </div>


                    <!-- Filter Price (Dropdown) -->
                    <div class="filter-group">
                        <label for="priceDropdown">Price:</label>
                        <select id="priceDropdown" name="price">
                            <option value="" ${empty selectedPrice ? 'selected' : ''}>All Prices</option>
                        <option value="below_150" ${selectedPrice == 'below_150' ? 'selected' : ''}>Below 150</option>
                        <option value="between_150_300" ${selectedPrice == 'between_150_300' ? 'selected' : ''}>150 - 300</option>
                        <option value="greater_300" ${selectedPrice == 'greater_300' ? 'selected' : ''}>Above 300</option>
                    </select>
                </div>

                <!-- Filter Location (Dropdown) -->
                <div class="filter-group">
                    <label for="locationDropdown">Location:</label>
                    <select id="locationDropdown" name="location">
                        <option value="" ${empty selectedLocation ? 'selected' : ''}>All Locations</option>
                        <option value="Open Arena" ${selectedLocation == 'Open Arena' ? 'selected' : ''}>Open Arena</option>
                        <option value="Tech Hub" ${selectedLocation == 'Tech Hub' ? 'selected' : ''}>Tech Hub</option>
                        <option value="Sports Arena" ${selectedLocation == 'Sports Arena' ? 'selected' : ''}>Sports Arena</option>
                        <option value="Downtown Plaza" ${selectedLocation == 'Downtown Plaza' ? 'selected' : ''}>Downtown Plaza</option>
                        <option value="Museum Hall" ${selectedLocation == 'Museum Hall' ? 'selected' : ''}>Museum Hall</option>
                    </select>
                </div>
            </div>

            <!-- Apply Button -->
            <div class="filter-button-container">
                <button type="submit" class="btn btn-success">Apply</button>
            </div>

        </form>

        <!-- Check if there are no filtered events -->
        <c:choose>
            <c:when test="${empty filteredEvents}">
                <p>No events found.</p>
            </c:when>
            <c:otherwise>
                <div class="container py-4">
                    <div class="row gy-4" id="event-container">
                        <!-- Loop through paginated events -->
                        <c:forEach var="event" items="${filteredEvents}">
                            <div class="col-12 col-sm-6 col-md-4 col-lg-3" id="${event.eventId}">
                                <div class="event-card-all_events">
                                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}">
                                        <img src="${event.imageURL}" alt="${event.eventName}" />
                                        <h4>${event.eventName}</h4>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Pagination -->
                <nav class="mt-4">
                    <ul class="pagination justify-content-center" id="pagination-container">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="allEvents?page=${currentPage - 1}&query=${searchQuery}&location=${selectedLocation}&startDate=${selectedStartDate}&endDate=${selectedEndDate}&price=${selectedPrice}">
                                    &laquo; Previous
                                </a>
                            </li>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="allEvents?page=${i}&query=${searchQuery}&location=${selectedLocation}&startDate=${selectedStartDate}&endDate=${selectedEndDate}&price=${selectedPrice}">
                                    ${i}
                                </a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="allEvents?page=${currentPage + 1}&query=${searchQuery}&location=${selectedLocation}&startDate=${selectedStartDate}&endDate=${selectedEndDate}&price=${selectedPrice}">
                                    Next &raquo;
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>

            </c:otherwise>
        </c:choose>

        <!--Footer-->
        <jsp:include page="../../components/footer.jsp"></jsp:include>
    </body>
</html>
