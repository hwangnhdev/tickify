<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Organizer Event Detail</title>
  <jsp:include page="../../components/header.jsp"></jsp:include>
  <script src="https://cdn.tailwindcss.com"></script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
  <!-- Import Google Fonts for fancy text -->
  <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
  <style>
    /* Custom Animation */
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .animate-fadeIn {
      animation: fadeIn 0.8s ease-out forwards;
    }
    /* Fancy text style */
    .fancy-text {
      font-family: 'Playfair Display', serif;
      text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
    }
    /* Glow border effect */
    .glow-border {
      border: 2px dashed rgba(74,85,104,0.5);
      box-shadow: 0 0 10px rgba(74,85,104,0.5);
    }
  </style>
</head>
<body class="bg-gradient-to-br from-gray-100 to-gray-300">
  <!-- Main Content: thêm mt-20 để cách header -->
  <main class="max-w-6xl mx-auto p-6 mt-20 animate-fadeIn">
    <div class="flex flex-col lg:flex-row gap-6">
      <!-- Ticket-like container cho thông tin sự kiện -->
      <section class="ticket lg:w-1/3 flex flex-col justify-between bg-gray-800 text-white p-8 rounded-xl shadow-2xl glow-border">
        <c:if test="${not empty organizerEventDetail}">
          <div>
            <h2 class="fancy-text text-3xl font-bold mb-4">${organizerEventDetail.eventName}</h2>
            <p class="text-sm mb-3 flex items-center">
              <i class="fas fa-calendar-alt mr-2"></i>
              <span class="text-green-400">
                <fmt:formatDate value="${organizerEventDetail.startDate}" pattern="dd MMM, yyyy"/>
                -
                <fmt:formatDate value="${organizerEventDetail.endDate}" pattern="dd MMM, yyyy"/>
              </span>
            </p>
            <p class="text-sm mb-3 flex items-center">
              <i class="fas fa-map-marker-alt mr-2"></i>
              <span class="text-green-400">${organizerEventDetail.location}</span>
            </p>
            <p class="text-sm mb-3 flex items-center">
              <i class="fas fa-hourglass-half mr-2"></i>
              <span class="text-green-400">
                <fmt:formatDate value="${organizerEventDetail.startDate}" pattern="dd MMM, yyyy"/>
                -
                <fmt:formatDate value="${organizerEventDetail.endDate}" pattern="dd MMM, yyyy"/>
              </span>
            </p>
          </div>
          <div class="mt-6 border-t border-gray-600 pt-4">
            <c:choose>
              <c:when test="${organizerEventDetail.eventStatus == 'Processing'}">
                <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-gray-600 px-4 py-2 rounded-full">
                  <i class="fas fa-check-circle mr-2"></i>
                  <span class="text-sm">Status: ${organizerEventDetail.eventStatus}</span>
                </div>
              </c:when>
              <c:when test="${organizerEventDetail.eventStatus == 'Approved'}">
                <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-green-600 px-4 py-2 rounded-full">
                  <i class="fas fa-check-circle mr-2"></i>
                  <span class="text-green-400 text-sm">Status: ${organizerEventDetail.eventStatus}</span>
                </div>
              </c:when>
              <c:otherwise>
                <div class="w-full inline-flex items-center justify-center bg-gray-700 border border-red-900 px-4 py-2 rounded-full">
                  <i class="fas fa-check-circle mr-2"></i>
                  <span class="text-sm">Status: ${organizerEventDetail.eventStatus}</span>
                </div>
              </c:otherwise>
            </c:choose>
          </div>
        </c:if>
        <c:if test="${empty organizerEventDetail}">
          <p class="text-sm text-center">No event details available.</p>
        </c:if>
      </section>
      <!-- Image container: overflow-hidden để ảnh luôn bung hết container -->
      <section class="lg:w-2/3 overflow-hidden">
        <c:if test="${not empty organizerEventDetail.imageUrl}">
          <img alt="${organizerEventDetail.eventName} image" 
               class="rounded-xl w-full h-full object-cover transform transition duration-700 hover:scale-105 shadow-2xl" 
               src="${organizerEventDetail.imageUrl}"/>
        </c:if>
      </section>
    </div>
    <!-- About Section -->
    <section class="event-info bg-white p-6 rounded-xl shadow-lg mt-6">
      <c:choose>
        <c:when test="${not empty organizerEventDetail.description}">
          <h3 class="text-2xl font-bold text-gray-800 mb-4">About</h3>
          <hr class="border-gray-300 mb-4">
          <p class="text-gray-700">${organizerEventDetail.description}</p>
        </c:when>
        <c:otherwise>
          <p class="text-gray-700">No event description found.</p>
        </c:otherwise>
      </c:choose>
    </section>
    <!-- Organizer Section -->
    <section class="event-info bg-white p-6 rounded-xl shadow-lg mt-6">
      <c:choose>
        <c:when test="${not empty organizerEventDetail.organizationName}">
          <h3 class="text-2xl font-bold text-gray-800 mb-4">Organizer</h3>
          <hr class="border-gray-300 mb-4">
          <p class="text-gray-700 font-medium">${organizerEventDetail.organizationName}</p>
        </c:when>
        <c:otherwise>
          <p class="text-gray-700">No organizer detail found.</p>
        </c:otherwise>
      </c:choose>
    </section>
    <!-- Event Images Section -->
    <section class="event-info bg-white p-6 rounded-xl shadow-lg mt-6">
      <h3 class="text-2xl font-bold text-gray-800 mb-4">Event Images</h3>
      <hr class="border-gray-300 mb-4">
      <c:choose>
        <c:when test="${not empty listEventImages}">
          <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
            <c:forEach var="img" items="${listEventImages}">
              <div class="relative group h-48 overflow-hidden">
                <img class="w-full h-full object-contain rounded-lg shadow-md transition duration-500 hover:scale-105 cursor-pointer" 
                     src="${img.imageUrl}" 
                     alt="${organizerEventDetail.eventName} - ${img.imageTitle}"
                     loading="lazy"
                     onclick="openModal('${img.imageUrl}', '${img.imageTitle}')"/>
                <!-- Overlay hiệu ứng khi hover -->
                <div class="absolute inset-0 bg-black bg-opacity-0 group-hover:bg-opacity-25 transition duration-300 rounded-lg"></div>
              </div>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <p class="text-gray-700">No additional images available.</p>
        </c:otherwise>
      </c:choose>
    </section>
    <!-- Modal Lightbox: Hiển thị ảnh full-size giữa màn hình -->
    <div id="imageModal" class="fixed inset-0 z-50 hidden items-center justify-center bg-black bg-opacity-75">
      <div class="relative">
        <img id="modalImage" class="max-w-full max-h-full rounded-lg" src="" alt="Enlarged Image"/>
        <button onclick="closeModal()" class="absolute top-2 right-2 text-white text-3xl leading-none">&times;</button>
      </div>
    </div>
    <script>
      function openModal(imageUrl, imageTitle) {
        const modal = document.getElementById('imageModal');
        const modalImage = document.getElementById('modalImage');
        modalImage.src = imageUrl;
        modalImage.alt = imageTitle;
        modal.classList.remove('hidden');
        modal.classList.add('flex');
      }
  
      function closeModal() {
        const modal = document.getElementById('imageModal');
        modal.classList.remove('flex');
        modal.classList.add('hidden');
      }
  
      // Đóng modal khi click ra ngoài ảnh
      document.getElementById('imageModal').addEventListener('click', function(e) {
        if (e.target === this) {
          closeModal();
        }
      });
    </script>
  </main>
</body>
</html>
