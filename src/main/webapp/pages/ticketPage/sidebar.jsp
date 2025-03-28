<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="w-1/4 p-6">
    
    <ul>
        <!-- My Profile -->
        <li class="mb-4 flex items-center p-2 rounded cursor-pointer 
                   ${pageContext.request.requestURI.contains('myProfile') ? 'bg-green-700' : 'hover:bg-green-700'}">
            <a href="${pageContext.request.contextPath}/profile" 
               class="flex items-center w-full text-white">
                <i class="fas fa-id-badge mr-3"></i>
                <span>My profile</span>
            </a>
        </li>
        <!-- My Tickets -->
        <li class="mb-4 flex items-center p-2 rounded cursor-pointer 
                   ${pageContext.request.requestURI.contains('viewAllTickets') ? 'bg-green-700' : 'hover:bg-green-700'}">
            <a href="${pageContext.request.contextPath}/viewAllTickets" 
               class="flex items-center w-full text-white">
                <i class="fas fa-ticket-alt mr-3"></i>
                <span>My Tickets</span>
            </a>
        </li>
        <!-- My Events - luôn chuyển đến organizer -->
        <li class="mb-4 flex items-center p-2 rounded cursor-pointer 
                   ${pageContext.request.requestURI.contains('OrganizerEventController') ? 'bg-green-700' : 'hover:bg-green-700'}">
            <a href="${pageContext.request.contextPath}/OrganizerEventController" 
               target="_blank" class="flex items-center w-full text-white">
                <i class="fas fa-calendar-alt mr-3"></i>
                <span>My events</span>
            </a>
        </li>
    </ul>
</div>
