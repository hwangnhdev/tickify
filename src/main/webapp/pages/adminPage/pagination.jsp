<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${totalPages gt 1}">
    <div class="mt-6 flex justify-center items-center space-x-4">
        <c:set var="displayPages" value="5" />
        <c:set var="startPage" value="${page - (displayPages div 2)}" />
        <c:set var="endPage" value="${page + (displayPages div 2)}" />

        <c:if test="${startPage lt 1}">
            <c:set var="startPage" value="1" />
        </c:if>
        <c:if test="${endPage gt totalPages}">
            <c:set var="endPage" value="${totalPages}" />
        </c:if>

        <!-- Nút First và Prev -->
        <c:if test="${page gt 1}">
            <c:url var="urlFirst" value="${baseUrl}">
                <c:param name="page" value="1" />
                <c:if test="${not empty selectedStatus}">
                    <c:param name="status" value="${selectedStatus}" />
                </c:if>
            </c:url>
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${urlFirst}">First</a>

            <c:url var="urlPrev" value="${baseUrl}">
                <c:param name="page" value="${page - 1}" />
                <c:if test="${not empty selectedStatus}">
                    <c:param name="status" value="${selectedStatus}" />
                </c:if>
            </c:url>
            <a class="bg-blue-600 text-white py-2 px-4 rounded" href="${urlPrev}">Prev</a>
        </c:if>

        <!-- S? trang -->
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <c:choose>
                <c:when test="${i eq page}">
                    <span class="bg-blue-500 text-white py-2 px-4 rounded">${i}</span>
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

        <!-- Nút Next và Last -->
        <c:if test="${page lt totalPages}">
            <c:url var="urlNext" value="${baseUrl}">
                <c:param name="page" value="${page + 1}" />
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
