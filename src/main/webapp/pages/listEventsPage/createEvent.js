/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


// Toggle Seat Section Display
function toggleEventType() {
    const eventType = document.getElementById('eventType').value;
    const seatSection = document.getElementById('seatSection');
    if (eventType === 'seatedevent') {
        seatSection.classList.remove('d-none');
        calculateSeatSummary();
    } else {
        seatSection.classList.add('d-none');
    }
}

// Add New Seat
function addSeat() {
    const seatsContainer = document.getElementById('seatsContainer');
    const newSeat = document.createElement('div');
    newSeat.className = 'seat-input';
    newSeat.innerHTML = `
                    <label class="text-white">Row:</label>
                    <input type="text" name="seatRow[]" class="form-control" required>
                    <label class="text-white">Number of Seats:</label>
                    <input type="text" name="seatNumber[]" class="form-control" required>
                    <button type="button" class="btn btn-danger" onclick="removeSeat(this)">Delete</button>
                    <button type="button" class="save-seat-btn" onclick="saveSeat(this)">Save Seat</button>
                `;
    seatsContainer.appendChild(newSeat);
    calculateSeatSummary();
}

// Remove Seat
function removeSeat(button) {
    button.closest('.seat-input').remove();
    calculateSeatSummary();
}

// Save Seat
function saveSeat(button) {
    calculateSeatSummary();
}

// Calculate Total Rows, Columns, and Seats
function calculateSeatSummary() {
    let rowCount = 0;
    let totalSeats = 0;
    let maxSeatsPerRow = 0;
    const seatRows = document.querySelectorAll('input[name="seatRow[]"]');
    const seatNumbers = document.querySelectorAll('input[name="seatNumber[]"]');

    if (seatRows.length === 0) {
        document.getElementById('seatSummary').innerHTML = `
                        <span>Total Rows: 0, Total Columns: 0, Total Seats: 0</span>
                    `;
        return;
    }

    const seatsByRow = {};
    for (let i = 0; i < seatRows.length; i++) {
        const row = seatRows[i].value.trim().toUpperCase();
        const seatNum = parseInt(seatNumbers[i].value.trim());
        if (row && !isNaN(seatNum) && seatNum > 0) {
            rowCount++;
            totalSeats += seatNum;
            seatsByRow[row] = Math.max(seatsByRow[row] || 0, seatNum);
            maxSeatsPerRow = Math.max(maxSeatsPerRow, seatNum);
        }
    }

    const columnCount = maxSeatsPerRow;
    document.getElementById('seatSummary').innerHTML = `
                    <span>Total Rows: ${rowCount}, Total Columns: ${columnCount}, Total Seats: ${totalSeats}</span>
                `;
}

// Add New Show Time
let showTimeCount = 1;
function addNewShowTime() {
    showTimeCount++;
    const showTimeList = document.getElementById('showTimeList');
    const newShowTime = document.createElement('div');
    newShowTime.className = 'show-time';
    newShowTime.innerHTML = `
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h6 class="text-white">Show Time</h6>
                        <button class="add-ticket-btn" onclick="removeShowTime(this)">Delete</button>
                    </div>
                    <div class="form-group filter-group">
                        <label for="showStartDate_${showTimeCount}" class="text-white">Start Date</label>
                        <input type="datetime-local" name="showStartDate" id="showStartDate_${showTimeCount}" class="datetime-local" placeholder="Select start date">
                    </div>
                    <div class="form-group filter-group">
                        <label for="showEndDate_${showTimeCount}" class="text-white">End Date</label>
                        <input type="datetime-local" name="showEndDate" id="showEndDate_${showTimeCount}" class="datetime-local" placeholder="Select end date">
                    </div>
                    <div id="ticketList_${showTimeCount}" class="mt-3"></div>
                    <button class="add-ticket-btn w-100 mt-3" data-bs-toggle="modal" data-bs-target="#newTicketModal" data-show-time="${showTimeCount}">+ Add Ticket Type</button>
                `;
    showTimeList.appendChild(newShowTime);
}

// Remove Show Time
function removeShowTime(button) {
    button.closest('.show-time').remove();
}

// Save New Ticket
function saveNewTicket() {
    const showTimeId = document.getElementById('newTicketModal').getAttribute('data-show-time');
    const ticketName = document.getElementById('modalTicketName').value;
    const ticketDescription = document.getElementById('modalTicketDescription').value;
    const ticketPrice = document.getElementById('modalTicketPrice').value;
    const ticketQuantity = document.getElementById('modalTicketQuantity').value;
    const ticketStartDate = document.getElementById('modalTicketStartDate').value;
    const ticketEndDate = document.getElementById('modalTicketEndDate').value;

    if (ticketName && ticketDescription && ticketPrice && ticketQuantity && ticketStartDate && ticketEndDate) {
        const ticketList = document.getElementById(`ticketList_${showTimeId}`);
        const newTicket = document.createElement('div');
        newTicket.className = 'saved-ticket';
        newTicket.innerHTML = `
                        <div class="d-flex justify-content-between align-items-center mb-2">
                            <h6 class="text-white">${ticketName}</h6>
                            <button class="add-ticket-btn" onclick="removeTicket(this, '${showTimeId}')">Delete</button>
                        </div>
                        <div class="form-group">
                            <label class="text-white">Description</label>
                            <input type="text" class="form-control" value="${ticketDescription}" readonly>
                        </div>
                        <div class="form-group">
                            <label class="text-white">Price (VND)</label>
                            <input type="number" class="form-control" value="${ticketPrice}" readonly step="1000">
                        </div>
                        <div class="form-group">
                            <label class="text-white">Quantity</label>
                            <input type="number" class="form-control" value="${ticketQuantity}" readonly>
                        </div>
                        <div class="form-group">
                            <label class="text-white">Sale Start Date</label>
                            <input type="text" class="form-control" value="${ticketStartDate}" readonly>
                        </div>
                        <div class="form-group">
                            <label class="text-white">Sale End Date</label>
                            <input type="text" class="form-control" value="${ticketEndDate}" readonly>
                        </div>
                    `;
        ticketList.appendChild(newTicket);
        const modal = bootstrap.Modal.getInstance(document.getElementById('newTicketModal'));
        modal.hide();
        document.getElementById('modalTicketName').value = '';
        document.getElementById('modalTicketDescription').value = '';
        document.getElementById('modalTicketPrice').value = '';
        document.getElementById('modalTicketQuantity').value = '';
        document.getElementById('modalTicketStartDate').value = '';
        document.getElementById('modalTicketEndDate').value = '';
    } else {
        alert("Please fill in all information!");
    }
}

// Remove Ticket
function removeTicket(button, showTimeId) {
    button.closest('.saved-ticket').remove();
}

// Switch Tabs
function showTab(tabId, event) {
    console.log("Switching to tab:", tabId);
    document.querySelectorAll('.tab-content').forEach(tab => {
        tab.classList.add('d-none');
    });
    const targetTab = document.getElementById(tabId);
    if (targetTab) {
        targetTab.classList.remove('d-none');
    } else {
        console.error("Tab not found:", tabId);
    }
    document.querySelectorAll('.tab-button').forEach(button => {
        button.classList.remove('active');
    });
    const activeButton = document.querySelector(`.tab-button[onclick*="showTab('${tabId}')"]`);
    if (activeButton) {
        activeButton.classList.add('active');
    }
}

// Move to Next Tab
function nextTab() {
    const currentTab = document.querySelector('.tab-content:not(.d-none)').id;
    console.log("Current tab:", currentTab);
    if (currentTab === 'event-info') {
        showTab('time-logistics', null);
    } else if (currentTab === 'time-logistics') {
        showTab('payment-info', null);
    } else if (currentTab === 'payment-info') {
        console.log("Already at the last tab!");
    }
}

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    showTab('event-info', null);
    const seatInputs = document.querySelectorAll('input[name="seatRow[]"], input[name="seatNumber[]"]');
    seatInputs.forEach(input => {
        input.addEventListener('input', calculateSeatSummary);
    });
    calculateSeatSummary();
});


// Bank Transfer
async function loadBanks() {
    const response = await fetch("https://api.vietqr.io/v2/banks");
    const data = await response.json();

    let bankOptions = data.data.map(bank => {
        return `<option value="${bank.code}">${bank.shortName} - ${bank.name}</option>`;
    });

    document.getElementById("bank").innerHTML = bankOptions.join("");
}

loadBanks();