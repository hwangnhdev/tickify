<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Customer Management</title>
        <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2/dist/tailwind.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
        <style>
            /* Custom style cho bảng responsive */
            .table-container {
                overflow-x: auto;
            }
        </style>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <!-- Header -->
        <jsp:include page="header.jsp">
            <jsp:param name="pageTitle" value="Admin" />
        </jsp:include>

        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <jsp:include page="sidebar.jsp" />

            <!-- Main Content -->
            <div class="flex-1 p-6">
                <div class="max-w-screen-xl mx-auto bg-white rounded-lg shadow-md p-6">
                    <h1 class="text-3xl font-bold mb-4 text-gray-800">User Management</h1>

                    <!-- Filter & Search Row -->
                    <div class="flex flex-col md:flex-row md:items-center md:justify-between mb-6 border-b pb-4">
                        <!-- Dropdown Filter & Search Form -->
                        <form action="${pageContext.request.contextPath}/ViewAllCustomersController" method="get" class="flex flex-col md:flex-row items-center space-y-4 md:space-y-0 md:space-x-6" role="search">
                            <!-- Dropdown Filter -->
                            <div class="flex items-center">
                                <label for="statusFilter" class="text-gray-700 mr-2">Filter:</label>
                                <select name="status" id="statusFilter" class="px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" onchange="this.form.submit()">
                                    <option value="" <c:if test="${empty param.status}">selected</c:if>>All</option>
                                    <option value="1" <c:if test="${param.status eq '1'}">selected</c:if>>Active</option>
                                    <option value="0" <c:if test="${param.status eq '0'}">selected</c:if>>Inactive</option>
                                    </select>
                                </div>
                                <!-- Search Field -->
                                <div class="flex items-center">
                                    <label for="searchInput" class="sr-only">Search by name</label>
                                    <div class="relative">
                                        <span class="absolute inset-y-0 left-0 flex items-center pl-3">
                                            <i class="fas fa-search text-gray-500"></i>
                                        </span>
                                        <input id="searchInput" type="text" name="search" placeholder="Search by name" value="${param.search}" class="pl-10 pr-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
                                </div>
                                <button type="submit" class="ml-2 px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
                                    Search
                                </button>
                            </div>
                            <!-- Giữ lại các tham số sắp xếp -->
                            <input type="hidden" name="sortColumn" value="${param.sortColumn}" />
                            <input type="hidden" name="sortOrder" value="${param.sortOrder}" />
                        </form>
                    </div>

                    <!-- Sort Controls -->
                    <div class="flex items-center justify-end mb-4">
                        <form action="${pageContext.request.contextPath}/ViewAllCustomersController" method="get" id="sortForm" class="flex items-center space-x-2">
                            <input type="hidden" name="status" value="${param.status}" />
                            <input type="hidden" name="search" value="${param.search}" />
                            <label for="sortColumn" class="text-gray-700">Sort By:</label>
                            <select name="sortColumn" id="sortColumn" class="px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" onchange="document.getElementById('sortForm').submit()">
                                <option value="full_name" <c:if test="${param.sortColumn eq 'full_name'}">selected</c:if>>Full Name</option>
                                <option value="customer_id" <c:if test="${param.sortColumn eq 'customer_id'}">selected</c:if>>Customer ID</option>
                                </select>
                                <select name="sortOrder" id="sortOrder" class="px-3 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" onchange="document.getElementById('sortForm').submit()">
                                    <option value="ASC" <c:if test="${param.sortOrder eq 'ASC'}">selected</c:if>>Ascending</option>
                                <option value="DESC" <c:if test="${param.sortOrder eq 'DESC'}">selected</c:if>>Descending</option>
                                </select>
                            </form>
                        </div>

                        <!-- Table Container -->
                        <div class="table-container">
                            <table class="min-w-full bg-white border border-gray-300 rounded-lg shadow overflow-hidden">
                                <thead class="bg-gray-200 text-gray-600 uppercase text-sm">
                                    <tr>
                                        <th class="px-6 py-3 text-left">ID</th>
                                        <th class="px-6 py-3 text-left">Full Name</th>
                                        <th class="px-6 py-3 text-left">Email</th>
                                        <th class="px-6 py-3 text-left">Status</th>
                                        <th class="px-6 py-3 text-left">Action</th>
                                    </tr>
                                </thead>
                                <tbody class="text-gray-700 text-sm">
                                <c:choose>
                                    <c:when test="${not empty customers}">
                                        <c:forEach var="customer" items="${customers}">
                                            <tr class="border-b hover:bg-gray-50">
                                                <td class="px-6 py-4 whitespace-nowrap font-medium">${customer.customerId}</td>
                                                <td class="px-6 py-4 font-medium">
                                                    <a href="${pageContext.request.contextPath}/ViewDetailAccountController?id=${customer.customerId}" target="_blank" class="text-blue-600 hover:underline">
                                                        ${customer.fullName}
                                                    </a>

                                                </td>
                                                <td class="px-6 py-4">${customer.email}</td>
                                                <td class="px-6 py-4">
                                                    <span class="py-1 px-3 rounded-full text-xs font-bold
                                                          <c:choose>
                                                              <c:when test="${customer.status}">
                                                                  bg-green-200 text-green-800
                                                              </c:when>
                                                              <c:otherwise>
                                                                  bg-red-200 text-red-800
                                                              </c:otherwise>
                                                          </c:choose>">
                                                        <c:choose>
                                                            <c:when test="${customer.status}">Active</c:when>
                                                            <c:otherwise>Inactive</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </td>
                                                <td class="px-6 py-4">
                                                    <c:choose>
                                                        <c:when test="${customer.status}">
                                                            <button type="button" onclick="updateStatus(${customer.customerId}, 'inactive')" class="bg-red-600 text-white font-semibold py-2 px-4 rounded hover:bg-red-700 transition transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-red-500">
                                                                Inactive
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button type="button" onclick="updateStatus(${customer.customerId}, 'activate')" class="bg-green-600 text-white font-semibold py-2 px-4 rounded hover:bg-green-700 transition transform hover:scale-105 focus:outline-none focus:ring-2 focus:ring-green-500">
                                                                Activate
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <tr>
                                            <td colspan="5" class="text-center py-4">No customers found.</td>
                                        </tr>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Pagination -->
                <jsp:include page="pagination.jsp">
                    <jsp:param name="baseUrl" value="/ViewAllCustomersController" />
                    <jsp:param name="page" value="${page}" />
                    <jsp:param name="totalPages" value="${totalPages}" />
                    <jsp:param name="status" value="${param.status}" />
                </jsp:include>
            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="footer.jsp" />

        <!-- SweetAlert JS for confirmation popups -->
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script>
                                      function updateStatus(customerId, action) {
                                          var popupTitle, popupMessage, popupIcon;
                                          if (action === 'activate') {
                                              popupTitle = "Restore Account";
                                              popupMessage = "Are you sure you want to restore customer #" + customerId + " account?";
                                              popupIcon = "info";
                                          } else if (action === 'inactive') {
                                              popupTitle = "Ban Account";
                                              popupMessage = "Are you sure you want to ban customer #" + customerId + " account?";
                                              popupIcon = "error";
                                          } else {
                                              popupTitle = "Confirm";
                                              popupMessage = "Do you want to update customer #" + customerId + " account?";
                                              popupIcon = "warning";
                                          }
                                          swal({
                                              title: popupTitle,
                                              text: popupMessage,
                                              icon: popupIcon,
                                              buttons: true,
                                              dangerMode: true,
                                          }).then((willUpdate) => {
                                              if (willUpdate) {
                                                  fetch('${pageContext.request.contextPath}/DeactivateAccountController?id=' + customerId + '&action=' + action, {
                                                      method: 'GET'
                                                  })
                                                          .then(response => response.text())
                                                          .then(result => {
                                                              swal("Success", "Customer status updated successfully!", "success")
                                                                      .then(() => window.location.reload());
                                                          })
                                                          .catch(error => {
                                                              swal("Error", "Error: " + error, "error");
                                                          });
                                              }
                                          });
                                      }
        </script>
    </body>
</html>
