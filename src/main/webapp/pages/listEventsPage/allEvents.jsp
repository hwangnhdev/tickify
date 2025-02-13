<%-- 
    Document   : allEvents
    Created on : Feb 14, 2025, 12:02:13 AM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
    </head>
    <body>
        <!--All Event--> 
        <h2 class="title-all_events">All Events</h2>
        <div class="container py-4">
            <div class="row gy-4">
                <!-- Event Cards -->
                <c:forEach var="event" items="${paginatedEvents}">
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="event-card-all_events">
                            <img src="" alt="${event.eventName}" />
                            <h4>${event.eventName}</h4>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Pagination -->
            <nav class="mt-4">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage - 1}">&laquo; Previous</a>
                        </li>
                    </c:if>

                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage + 1}">Next &raquo;</a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>

        <!-- Bootstrap JS for All Events-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
