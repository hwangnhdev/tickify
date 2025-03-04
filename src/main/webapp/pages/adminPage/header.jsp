<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header.jsp -->
<head>
  <meta charset="utf-8"/>
  <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
  <title><c:out value="${pageTitle}" /></title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
  <!-- Nếu cần sử dụng SweetAlert toàn cục -->
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
  <style>
    body {
      font-family: 'Inter', sans-serif;
    }
    /* Các style chung cho event name, sidebar, … */
    .event-name {
      position: relative;
      display: inline-block;
      padding: 5px 10px;
      transition: all 0.3s ease;
    }
    .event-name:hover {
      color: #1e40af;
      background-color: rgba(59, 130, 246, 0.1);
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
      transform: scale(1.05);
      cursor: pointer;
    }
    .event-name::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      width: 100%;
      height: 2px;
      background-color: #1e40af;
      transform: scaleX(0);
      transition: transform 0.3s ease;
    }
    .event-name:hover::after {
      transform: scaleX(1);
    }
    .sidebar-item {
      position: relative;
      transition: all 0.3s ease;
    }
    .sidebar-item:hover {
      background-color: #1e40af;
      transform: scale(1.05);
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
    }
    .sidebar-item:hover .sidebar-icon {
      color: #fcd34d;
      transform: scale(1.1);
    }
    .sidebar-icon {
      transition: all 0.3s ease;
    }
    .sidebar-item.active {
      background-color: #2563eb;
      font-weight: bold;
    }
    /* Style cho Tab Navigation nếu cần */
    .tab-nav a {
      background-color: #fff;
      display: inline-block;
      padding: 0.5rem 1rem;
      color: #3b82f6;
      font-weight: 600;
      border-bottom: 2px solid transparent;
      transition: color 0.3s;
    }
    .tab-nav a:hover {
      color: #1e40af;
    }
    .tab-nav .active {
      border-bottom-color: #1e40af;
      color: #1e40af;
    }
  </style>
</head>
