<%-- 
    Document   : resultFilterEvent
    Created on : Feb 19, 2025, 9:16:28 AM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Filtered Events</h2>
        <c:choose>
            <c:when test="${empty listFilters}">
                <p>No events found.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="event" items="${listFilters}">
                    <a style="text-decoration: none" href="eventDetail?id=${event.eventId}">
                        <h4>${event.eventName}</h4>
                    </a>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </body>
</html>
