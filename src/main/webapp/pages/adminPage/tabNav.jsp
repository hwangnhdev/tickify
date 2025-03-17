<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!-- Tab Navigation -->
<div class="mb-6 border-b pb-2 flex space-x-4">
    <c:url var="viewAllEventsUrl" value="/admin/viewAllEvents" />
    <c:url var="viewProcessingEventsUrl" value="/admin/viewProcessingEvents" />
    <c:url var="viewApprovedEventsUrl" value="/admin/viewApprovedEvents" />
    <c:url var="viewHistoryApprovedEventsUrl" value="/admin/viewHistoryApprovedEvents" />

    <a class="py-2 px-4 font-medium hover:text-blue-500 ${fn:toLowerCase(pageContext.request.requestURI).contains('viewallevents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" 
       href="${viewAllEventsUrl}">
       View All
    </a>
    <a class="py-2 px-4 font-medium hover:text-blue-500 ${fn:toLowerCase(pageContext.request.requestURI).contains('viewprocessingevents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" 
       href="${viewProcessingEventsUrl}">
       Approve Event
    </a>
    <a class="py-2 px-4 font-medium hover:text-blue-500 ${fn:toLowerCase(pageContext.request.requestURI).contains('viewapprovedevents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" 
       href="${viewApprovedEventsUrl}">
       View Approved
    </a>
    <a class="py-2 px-4 font-medium hover:text-blue-500 ${fn:toLowerCase(pageContext.request.requestURI).contains('viewhistoryapprovedevents') ? 'border-b-2 border-blue-500 text-blue-500' : 'text-gray-600'}" 
       href="${viewHistoryApprovedEventsUrl}">
       View History Approved
    </a>
</div>
