<%-- 
    Document   : panigation
    Created on : Mar 6, 2025, 9:28:03 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Parameters:
  - baseUrl: Base URL for navigation (e.g., "/event")
  - page: Current page number (synced with your "currentPage")
  - totalPages: Total number of pages
  - selectedStatus: Optional filter parameter
  - useJs: Optional flag to use loadPage() instead of URLs (default: false)
--%>
<c:set var="currentPage" value="${param.page}" />
<c:set var="totalPages" value="${param.totalPages}" />
<c:set var="baseUrl" value="${param.baseUrl}" />
<c:set var="selectedStatus" value="${param.selectedStatus}" />

<c:if test="${totalPages gt 1}">
    <div class="mt-6 flex justify-center items-center space-x-4" style="margin-bottom: 2%;">
        <c:set var="displayPages" value="5" />
        <c:set var="startPage" value="${currentPage - (displayPages div 2)}" />
        <c:set var="endPage" value="${currentPage + (displayPages div 2)}" />

        <c:if test="${startPage lt 1}">
            <c:set var="startPage" value="1" />
        </c:if>
        <c:if test="${endPage gt totalPages}">
            <c:set var="endPage" value="${totalPages}" />
        </c:if>

        <!-- First and Prev -->
        <c:if test="${currentPage gt 1}">
            <c:url var="urlFirst" value="${baseUrl}">
                <c:param name="page" value="1" />
                <c:if test="${not empty selectedStatus}">
                    <c:param name="status" value="${selectedStatus}" />
                </c:if>
            </c:url>
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${urlFirst}">First</a>

            <c:url var="urlPrev" value="${baseUrl}">
                <c:param name="page" value="${currentPage - 1}" />
                <c:if test="${not empty selectedStatus}">
                    <c:param name="status" value="${selectedStatus}" />
                </c:if>
            </c:url>
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${urlPrev}">Prev</a>
        </c:if>

        <!-- Page Numbers -->
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:choose>
                <c:when test="${useJs}">
                    <a class="bg-blue-600 text-white py-2 px-4 rounded" href="#" onclick="loadPage(${i})">${i}</a>
                </c:when>
                <c:otherwise>
                    <c:url var="urlPage" value="${baseUrl}">
                        <c:param name="page" value="${i}" />
                        <c:if test="${not empty selectedStatus}">
                            <c:param name="status" value="${selectedStatus}" />
                        </c:if>
                    </c:url>
                    <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${urlPage}">${i}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <!-- Next and Last -->
        <c:if test="${currentPage lt totalPages}">
            <c:url var="urlNext" value="${baseUrl}">
                <c:param name="page" value="${currentPage + 1}" />
                <c:if test="${not empty selectedStatus}">
                    <c:param name="status" value="${selectedStatus}" />
                </c:if>
            </c:url>
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${urlNext}">Next</a>

            <c:url var="urlLast" value="${baseUrl}">
                <c:param name="page" value="${totalPages}" />
                <c:if test="${not empty selectedStatus}">
                    <c:param name="status" value="${selectedStatus}" />
                </c:if>
            </c:url>
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${urlLast}">Last</a>
        </c:if>
    </div>
</c:if>