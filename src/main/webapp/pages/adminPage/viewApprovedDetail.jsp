<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Approved Event Detail</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" /> <!-- Cập nhật đường dẫn CSS -->
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <!-- Include header -->
        <jsp:include page="/pages/adminPage/header.jsp">
            <jsp:param name="pageTitle" value="Approved Event Detail" />
        </jsp:include>

        <div class="flex h-screen">
            <!-- Include sidebar -->
            <jsp:include page="/pages/adminPage/sidebar.jsp" />

            <!-- Main Content -->
            <div class="flex-1 p-6">
                <div class="container mx-auto p-6 bg-white rounded-lg shadow-md">
                    <h2 class="text-3xl font-bold mb-6">Approved Event Detail</h2>
                    <c:choose>
                        <c:when test="${empty event}">
                            <p class="text-red-500">No event data available.</p>
                        </c:when>
                        <c:otherwise>
                            <div class="mb-4">
                                <p><strong>ID:</strong> ${event.eventId}</p>
                                <p><strong>Event Name:</strong> ${event.eventName}</p>
                                <p><strong>Category:</strong> ${event.categoryName}</p>
                                <p><strong>Organization:</strong> ${event.organizationName}</p>
                                <p><strong>Location:</strong> ${event.location}</p>
                                <p><strong>Event Type:</strong> ${event.eventType}</p>
                                <p><strong>Status:</strong> ${event.status}</p>
                                <p><strong>Description:</strong> ${event.description}</p>
                                <p><strong>Start Date:</strong>
                                    <c:if test="${not empty event.startDate}">
                                        <fmt:formatDate value="${event.startDate}" pattern="dd/MM/yyyy" />
                                    </c:if>
                                </p>
                                <p><strong>End Date:</strong>
                                    <c:if test="${not empty event.endDate}">
                                        <fmt:formatDate value="${event.endDate}" pattern="dd/MM/yyyy" />
                                    </c:if>
                                </p>
                                <p><strong>Created At:</strong>
                                    <c:if test="${not empty event.createdAt}">
                                        <fmt:formatDate value="${event.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </c:if>
                                </p>
                                <p><strong>Updated At:</strong>
                                    <c:if test="${not empty event.updatedAt}">
                                        <fmt:formatDate value="${event.updatedAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </c:if>
                                </p>
                                <p><strong>Approved At:</strong>
                                    <c:if test="${not empty event.approvedAt}">
                                        <fmt:formatDate value="${event.approvedAt}" pattern="dd/MM/yyyy HH:mm" />
                                    </c:if>
                                </p>
                            </div>


                        </c:otherwise>
                    </c:choose>

                    <!-- Back Link -->

                </div>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="/pages/adminPage/footer.jsp" />
    </body>
</html>