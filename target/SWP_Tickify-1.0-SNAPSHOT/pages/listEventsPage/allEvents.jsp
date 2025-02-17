<%-- 
    Document   : allEvents
    Created on : Feb 14, 2025, 3:56:45 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                /* width: 320px; */
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
        </style>
    </head>
    <body>
        <!--Header-->
        <jsp:include page="../../components/header.jsp"></jsp:include>

            <div>
                <!--All Event--> 
                <h2 class="title-all_events" id="title-all_events">All Events</h2>
                <div class="container py-4">
                    <div class="row gy-4" id="event-container">
                        <!-- Event Cards -->
                    <c:forEach var="event" items="${paginatedEvents}">
                        <div class="col-12 col-sm-6 col-md-4 col-lg-3" id="${event.eventId}">
                            <div class="event-card-all_events">
                                <img src="${event.imageURL}" alt="${event.imageTitle}" />
                                <h4>${event.eventName}</h4>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <!-- Pagination -->
                <nav class="mt-4">
                    <ul class="pagination justify-content-center" id="pagination-container">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="#" onclick="loadPage(${currentPage - 1})">&laquo; Previous</a>
                            </li>
                        </c:if>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="#" onclick="loadPage(${i})">${i}</a>
                            </li>
                        </c:forEach>

                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="#" onclick="loadPage(${currentPage + 1})">Next &raquo;</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>
        </div>

        <script>
            function loadPage(page) {
                event.preventDefault();
                fetch('?page=' + page, {headers: {'X-Requested-With': 'XMLHttpRequest'}})
                        .then(response => response.text())
                        .then(data => {
                            const parser = new DOMParser();
                            const doc = parser.parseFromString(data, 'text/html');

                            // Cập nhật nội dung
                            document.getElementById('event-container').innerHTML = doc.getElementById('event-container').innerHTML;
                            document.getElementById('pagination-container').innerHTML = doc.getElementById('pagination-container').innerHTML;

                            // Đưa trang về đầu
                            window.scrollTo({top: 0, behavior: 'smooth'});

                            // Cuộn đến tiêu đề "All Events"
                            const titleElement = document.getElementById('title-all_events');
                            if (titleElement) {
                                titleElement.scrollIntoView({behavior: 'smooth', block: 'start'});
                            }
                        });
            }
        </script>

        <!-- Bootstrap JS for All Events-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>

        <!--Footer-->
        <jsp:include page="../../components/footer.jsp"></jsp:include>
    </body>
</html>
