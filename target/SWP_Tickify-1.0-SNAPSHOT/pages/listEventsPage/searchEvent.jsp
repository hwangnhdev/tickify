<%-- 
    Document   : searchEvent
    Created on : Feb 18, 2025, 12:39:53 AM
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
        <c:forEach var="event" items="${searchEvents}">
            <a style="text-decoration: none" href="eventDetail?id=${event.eventId}">
                <h4>${event.eventName}</h4>
            </a>
        </c:forEach>
    </body>
</html>
