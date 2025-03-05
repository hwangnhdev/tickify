<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="w-1/4 p-6">
    <div class="flex items-center mb-6">
        <img alt="User avatar" class="rounded-full h-12 w-12" height="50" 
             src="https://storage.googleapis.com/a1aa/image/ceBkpIjmHTPrnKV4BYleCKGJdOwxGkNUmgBTZyMa1-A.jpg" width="50"/>
        <div class="ml-4">
            <p>Account of</p>
            <p class="font-bold">Dương Minh Kiệt</p>
        </div>
    </div>
    <ul>
        <!-- Account Settings -->
        <li class="mb-4 flex items-center p-2 rounded cursor-pointer 
                   ${pageContext.request.requestURI.contains('accountSettings') ? 'bg-green-700' : 'hover:bg-green-700'}">
            <a href="${pageContext.request.contextPath}/accountSettings" 
               class="flex items-center w-full text-white">
                <i class="fas fa-user mr-3"></i>
                <span>Account settings</span>
            </a>
        </li>
        <!-- My Profile -->
        <li class="mb-4 flex items-center p-2 rounded cursor-pointer 
                   ${pageContext.request.requestURI.contains('myProfile') ? 'bg-green-700' : 'hover:bg-green-700'}">
            <a href="${pageContext.request.contextPath}/myProfile" 
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
