<%-- 
    Document   : homePage
    Created on : Jan 12, 2025, 2:49:46 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
    </head>
    <body>
        <!--Header-->
        <jsp:include page="../../components/header.jsp"></jsp:include>

        <!--Home Events-->
        <jsp:include page="../listEventsPage/homeEvents.jsp"></jsp:include>

        <!--Footer-->
        <jsp:include page="../../components/footer.jsp"></jsp:include>
    </body>
</html>
