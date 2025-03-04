<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- sidebar.jsp -->
<div class="bg-gradient-to-b from-blue-900 to-blue-700 text-white w-64 p-6 flex flex-col">
  <div class="flex items-center mb-8">
    <i class="fas fa-cogs text-3xl mr-3"></i>
    <span class="text-2xl font-bold">Admin Panel</span>
  </div>
  <nav class="flex-1">
    <ul>
      <li class="mb-4">
        <a class="sidebar-item flex items-center p-2 rounded" href="${pageContext.request.contextPath}/admin/home">
          <i class="sidebar-icon fas fa-home mr-3"></i> Home
        </a>
      </li>
      <li class="mb-4">
        <a class="sidebar-item flex items-center p-2 rounded" href="${pageContext.request.contextPath}/admin/dashboard">
          <i class="sidebar-icon fas fa-tachometer-alt mr-3"></i> Dashboard
        </a>
      </li>
      <li class="mb-4">
        <a class="sidebar-item flex items-center p-2 rounded" href="${pageContext.request.contextPath}/admin/manageUsers">
          <i class="sidebar-icon fas fa-users mr-3"></i> Manage Users
        </a>
      </li>
      <li class="mb-4">
        <a class="sidebar-item flex items-center p-2 rounded" href="${pageContext.request.contextPath}/admin/viewAllEvents">
          <i class="sidebar-icon fas fa-calendar-alt mr-3"></i> Manage Events
        </a>
      </li>
      <li class="mb-4">
        <a class="sidebar-item flex items-center p-2 rounded" href="${pageContext.request.contextPath}/admin/manageRevenue">
          <i class="sidebar-icon fas fa-chart-line mr-3"></i> Manage Revenue
        </a>
      </li>
      <li class="mb-4">
        <a class="sidebar-item flex items-center p-2 rounded" href="${pageContext.request.contextPath}/admin/settings">
          <i class="sidebar-icon fas fa-cog mr-3"></i> Settings
        </a>
      </li>
    </ul>
  </nav>
  <div class="mt-auto">
    <div class="flex items-center space-x-2 mb-4">
      <img alt="User avatar" class="rounded-full w-10 h-10" src="https://storage.googleapis.com/a1aa/image/KRiR2AdeEXCXp1qpTAr9oFboyrbiCwlRwJ2zz0YBkZQ.jpg"/>
      <span>Admin</span>
    </div>
    <a class="flex items-center p-2 rounded hover:bg-blue-800 transition duration-200" href="${pageContext.request.contextPath}/admin/logout">
      <i class="fas fa-sign-out-alt mr-3"></i> Logout
    </a>
  </div>
</div>
