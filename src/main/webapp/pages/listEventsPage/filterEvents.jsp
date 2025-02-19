<%-- 
    Document   : filterEvents
    Created on : Feb 16, 2025, 6:21:29 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
    </head>
    <body>
        <form id="filterForm" action="${pageContext.request.contextPath}/filterEvent" method="GET">

            <!-- Filter Date -->
            <div>
                <input type="date" name="startDate" id="startDate"> <br>
                <input type="date" name="endDate" id="endDate">
            </div> <br>

            <!-- Filter Category -->
            <div class="filter-section">
                <h6>Categories</h6>
                <input type="checkbox" name="category" value="1"> Concert <br>
                <input type="checkbox" name="category" value="2"> Technology <br>
                <input type="checkbox" name="category" value="3"> Sports <br>
                <input type="checkbox" name="category" value="4"> Festival <br>
                <input type="checkbox" name="category" value="5"> Exhibition <br>
            </div> <br>

            <!-- Filter Price -->
            <div class="filter-section">
                <h6>Price</h6>
                <input type="radio" name="price" value="below_150"> Below 150 <br>
                <input type="radio" name="price" value="between_150_300"> Between 150 And 300 <br>
                <input type="radio" name="price" value="greater_300"> Greater Than 300 <br>
            </div> <br>

            <!-- Filter Location -->
            <div class="filter-section">
                <h6>Location</h6>
                <input type="radio" name="location" value="Open Arena"> Open Arena <br>
                <input type="radio" name="location" value="Tech Hub"> Tech Hub <br>
                <input type="radio" name="location" value="Sports Arena"> Sports Arena <br>
                <input type="radio" name="location" value="Downtown Plaza"> Downtown Plaza <br>
                <input type="radio" name="location" value="Museum Hall"> Museum Hall <br>
            </div> <br>

            <button type="submit" class="btn btn-success">Apply</button>
        </form>

        <h2>Filtered Events</h2>
        <div id="filteredResults"></div>

        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script>
            var baseUrl = "${pageContext.request.contextPath}";
        </script>
        <script>
            $(document).ready(function () {
                $("#filterForm").submit(function (event) {
                    event.preventDefault(); // Ngăn chặn tải lại trang

                    $.ajax({
                        type: "GET",
                        url: baseUrl + "/filterEvent", // Sử dụng biến baseUrl
                        data: $("#filterForm").serialize(),
                        success: function (response) {
                            $("#filteredResults").html(response);
                        },
                        error: function () {
                            $("#filteredResults").html("<p style='color:red;'>Lỗi khi tải dữ liệu.</p>");
                        }
                    });
                });
            });
        </script>
    </body>
</html>
