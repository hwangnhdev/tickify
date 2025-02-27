<%-- 
    Document   : createEvent
    Created on : Feb 25, 2025, 5:44:28 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create Event</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="createEvent.css"/>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row">
                <!-- Sidebar -->
                <div class="col-md-3 col-lg-2 sidebar p-4 min-vh-100">
                    <div class="d-flex align-items-center mb-4">
                        <div class="rounded-circle bg-success me-3" style="width: 40px; height: 40px;"></div>
                        <span class="fs-4 fw-bold">Organizer Center</span>
                    </div>
                    <ul class="list-unstyled">
                        <li class="mb-3"><a href="#" class="text-white text-decoration-none d-flex align-items-center"><i class="fas fa-calendar-alt me-2"></i><span>My Events</span></a></li>
                        <li class="mb-3"><a href="#" class="text-white text-decoration-none d-flex align-items-center"><i class="fas fa-file-alt me-2"></i><span>Manage Reports</span></a></li>
                    </ul>
                </div>

                <!-- Main Content -->
                <div class="col-md-9 col-lg-10 p-4">
                    <!-- Header -->
                    <div class="bg-dark p-3 rounded-top mb-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <div class="d-flex align-items-center gap-3">
                                <button class="tab-button rounded-circle d-flex align-items-center justify-content-center text-white" onclick="showTab('event-info', event)">1</button>
                                <span>Event Information</span>
                                <button class="tab-button rounded-circle d-flex align-items-center justify-content-center text-white" onclick="showTab('time-logistics', event)">2</button>
                                <span>Time & Ticket Types</span>
                                <button class="tab-button rounded-circle d-flex align-items-center justify-content-center text-white" onclick="showTab('payment-info', event)">3</button>
                                <span>Payment Information</span>
                            </div>
                            <div class="d-flex gap-3">
                                <button class="btn btn-light text-success">Save</button>
                                <button class="btn btn-success" onclick="nextTab()">Continue</button>
                            </div>
                        </div>
                    </div>

                    <!-- Tab Event Info -->
                    <div id="event-info" class="tab-content">
                        <div class="row g-4">
                            <div class="col-12">
                                <label class="form-label">Event Name</label>
                                <input type="text" class="form-control" placeholder="Event Name">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Event Category</label>
                                <select class="form-select">
                                    <option value="">-- Please Select Category --</option>
                                    <c:forEach var="category" items="${listCategories}">
                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-12">
                                <label class="form-label">Event Location</label>
                                <input type="text" class="form-control" placeholder="Enter location name">
                            </div>
                            <div class="col-12">
                                <label class="form-label">Event Information</label>
                                <textarea class="form-control" rows="5" placeholder="Description"></textarea>
                            </div>
                            <div class="col-md-6">
                                <div class="upload-area p-4 rounded text-center">
                                    <i class="fas fa-upload fs-2 mb-2"></i>
                                    <p>Add Event Logo (720x958)</p>
                                    <input type="file" name="logoEvent" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="upload-area p-4 rounded text-center">
                                    <i class="fas fa-upload fs-2 mb-2"></i>
                                    <p>Add Event Background Image (1280x720)</p>
                                    <input type="file" name="logoBanner" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="upload-area p-4 rounded text-center">
                                    <i class="fas fa-upload fs-2 mb-2"></i>
                                    <p>Organizer Logo (275x275)</p>
                                    <input type="file" name="logoBanner" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label">Organizer Name</label>
                                <input type="text" class="form-control" placeholder="Organizer Name">
                            </div>



                        </div>
                    </div>

                    <!-- Tab Time & Logistics -->
                    <div id="time-logistics" class="tab-content d-none">
                        <div class="row g-4">
                            <!-- Type Of Event -->
                            <div class="col-12">
                                <label class="form-label">Type Of Event</label>
                                <select class="form-select" id="eventType" onchange="toggleEventType()">
                                    <option value="">-- Please Select Type --</option>
                                    <option value="standingevent">Standing Event</option>
                                    <option value="seatedevent">Seated Event</option>
                                </select>
                            </div>

                            <!-- Seat Section for Seated Event -->
                            <div class="col-12 seat-container d-none" id="seatSection">
                                <h5 class="text-white">Seat Management (Seated Event)</h5>
                                <div id="seatsContainer" class="seat-grid">
                                    <div class="seat-input">
                                        <label class="text-white">Row:</label>
                                        <input type="text" name="seatRow[]" class="form-control" required>
                                        <label class="text-white">Number of Seats:</label>
                                        <input type="text" name="seatNumber[]" class="form-control" required>
                                        <button type="button" class="btn btn-danger" onclick="removeSeat(this)">Delete</button>
                                        <button type="button" class="save-seat-btn" onclick="saveSeat(this)">Save Seat</button>
                                    </div>
                                </div>
                                <button type="button" class="add-ticket-btn mt-3" onclick="addSeat()">+ Add Seat</button>
                                <div id="seatSummary" class="mt-3"></div>
                            </div>

                            <!-- Show Times -->
                            <div class="col-12 ticket-section" id="showTimeSection">
                                <h5 class="text-white">Event Show Times</h5>
                                <div id="showTimeList">
                                    <div class="show-time">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <h6 class="text-white">Show Time</h6>
                                            <button class="add-ticket-btn" onclick="removeShowTime(this)">Delete</button>
                                        </div>
                                        <div class="form-group filter-group">
                                            <label for="showStartDate_1" class="text-white">Start Date</label>
                                            <input type="datetime-local" name="showStartDate" id="showStartDate_1" class="datetime-local" placeholder="Select start date">
                                        </div>
                                        <div class="form-group filter-group">
                                            <label for="showEndDate_1" class="text-white">End Date</label>
                                            <input type="datetime-local" name="showEndDate" id="showEndDate_1" class="datetime-local" placeholder="Select end date">
                                        </div>
                                        <div id="ticketList_1" class="mt-3"></div>
                                        <button class="add-ticket-btn w-100 mt-3" data-bs-toggle="modal" data-bs-target="#newTicketModal" data-show-time="1">+ Add Ticket Type</button>
                                    </div>
                                </div>
                                <button class="add-ticket-btn w-100 mt-3" onclick="addNewShowTime()">+ Create New Show Time</button>
                            </div>
                        </div>
                    </div>

                    <!-- Tab Payment Info -->
                    <div id="payment-info" class="tab-content d-none">
                        <div class="ticket-section"> <!-- Using ticket-section class to create a frame similar to the image -->
                            <div class="row g-4">
                                <div class="col-md-6">
                                    <label class="form-label">Payment Method</label>
                                    <input type="text" name="paymentMethod" class="form-control" value="Bank Transfer" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label" for="bank">Bank Name</label>
                                    <select id="bank" name="bankName" class="bank-select form-control" placeholder="Bank Name">
                                        <option value="">Bank Name</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Bank Account</label>
                                    <input type="text" name="bankAccount" class="form-control" placeholder="Bank Account">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Account Holder</label>
                                    <input type="text" name="accountHolder" class="form-control" placeholder="Account Holder">
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Modal for creating new ticket -->
                    <div class="modal fade" id="newTicketModal" tabindex="-1" aria-labelledby="newTicketModalLabel" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="newTicketModalLabel">Create New Ticket Type</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body">
                                    <div class="ticket-form">
                                        <div class="form-group">
                                            <label for="modalTicketName" class="text-white">Ticket Type Name</label>
                                            <input type="text" class="form-control" id="modalTicketName" placeholder="e.g., VIP">
                                        </div>
                                        <div class="form-group">
                                            <label for="modalTicketDescription" class="text-white">Description</label>
                                            <textarea class="form-control" id="modalTicketDescription" placeholder="e.g., VIP seating" rows="2"></textarea>
                                        </div>
                                        <div class="form-group">
                                            <label for="modalTicketPrice" class="text-white">Price (VND)</label>
                                            <input type="number" class="form-control" id="modalTicketPrice" placeholder="e.g., 150000" step="1000">
                                        </div>
                                        <div class="form-group">
                                            <label for="modalTicketQuantity" class="text-white">Quantity</label>
                                            <input type="number" class="form-control" id="modalTicketQuantity" placeholder="e.g., 50">
                                        </div>
                                        <div class="form-group">
                                            <label for="modalTicketQuantity" class="text-white">Color</label>
                                            <input type="color" class="form-control" id="modalTicketQuantity" placeholder="e.g., Red, Blue, Green">
                                        </div>
                                        <div class="form-group filter-group">
                                            <label for="modalTicketStartDate" class="text-white">Sale Start Date</label>
                                            <input type="datetime-local" name="modalTicketStartDate" id="modalTicketStartDate" class="datetime-local" placeholder="Select sale start date">
                                        </div>
                                        <div class="form-group filter-group">
                                            <label for="modalTicketEndDate" class="text-white">Sale End Date</label>
                                            <input type="datetime-local" name="modalTicketEndDate" id="modalTicketEndDate" class="datetime-local" placeholder="Select sale end date">
                                        </div>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    <button type="button" class="btn btn-success" onclick="saveNewTicket()">Save</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="createEvent.js"></script>
    </body>
</html>