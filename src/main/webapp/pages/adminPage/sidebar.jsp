<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- sidebar.jsp -->
<div class="bg-gradient-to-b from-blue-900 to-blue-700 text-white w-64 p-6 flex flex-col">
  <!-- Header / Logo -->
  <div class="flex items-center mb-8">
    <i class="fas fa-cogs text-3xl mr-3"></i>
    <span class="text-2xl font-bold">Admin Panel</span>
  </div>
  <!-- Navigation -->
  <nav class="flex-1">
    <ul class="space-y-2">
      <li>
        <a class="sidebar-item flex items-center px-4 py-2 rounded hover:bg-blue-800 transition-colors duration-200" 
           href="${pageContext.request.contextPath}/ViewAllCustomersController">
          <i class="sidebar-icon fas fa-users mr-3"></i> Manage Users
        </a>
      </li>
      <li>
        <a class="sidebar-item flex items-center px-4 py-2 rounded hover:bg-blue-800 transition-colors duration-200" 
           href="${pageContext.request.contextPath}/admin/viewAllEvents">
          <i class="sidebar-icon fas fa-calendar-alt mr-3"></i> Manage Events
        </a>
      </li>
      <li>
        <a class="sidebar-item flex items-center px-4 py-2 rounded hover:bg-blue-800 transition-colors duration-200" 
           href="${pageContext.request.contextPath}/category">
          <i class="sidebar-icon fas fa-chart-line mr-3"></i> Manage Category
        </a>
      </li>
      <li>
        <a class="sidebar-item flex items-center px-4 py-2 rounded hover:bg-blue-800 transition-colors duration-200" 
           href="${pageContext.request.contextPath}/admin/revenue">
          <i class="sidebar-icon fas fa-chart-line mr-3"></i> Manage Revenue
        </a>
      </li>
    </ul>
  </nav>
  <!-- Footer -->
  <div class="mt-auto">
<!--    <div class="flex items-center space-x-3 mb-4">
      <img alt="User avatar" class="rounded-full w-10 h-10 border-2 border-white" src="https://storage.googleapis.com/a1aa/image/KRiR2AdeEXCXp1qpTAr9oFboyrbiCwlRwJ2zz0YBkZQ.jpg"/>
      <span class="font-semibold">Admin</span>
    </div>-->
    <a class="flex items-center px-4 py-2 rounded hover:bg-blue-800 transition-colors duration-200" 
       href="${pageContext.request.contextPath}/logout">
      <i class="fas fa-sign-out-alt mr-3"></i> Logout
    </a>
  </div>
</div>
