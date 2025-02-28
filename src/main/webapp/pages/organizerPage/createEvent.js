/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


// Kiểm tra xem có lỗi nào hiển thị không
function hasErrors() {
    const errorElements = document.querySelectorAll('.error-message');
    return Array.from(errorElements).some(error => error.style.display === 'block');
}

// Cập nhật trạng thái nút Save
function updateSaveButtonState() {
    const saveBtn = document.getElementById('saveTicketBtn');
    saveBtn.disabled = hasErrors();
}

function validateDateTime(input) {
    const showTime = input.closest('.show-time');
    const modal = document.getElementById('newTicketModal');
    const isModal = !!modal && !modal.classList.contains('hidden');
    const showTimeId = isModal ? modal.getAttribute('data-show-time') : null;

    const currentDate = new Date();

    let showStartInput, showEndInput, ticketStartInput, ticketEndInput;
    if (showTime) {
        showStartInput = showTime.querySelector('input[name="showStartDate"]');
        showEndInput = showTime.querySelector('input[name="showEndDate"]');
    }
    if (isModal) {
        ticketStartInput = document.getElementById('modalTicketStartDate');
        ticketEndInput = document.getElementById('modalTicketEndDate');
        showStartInput = document.getElementById(`showStartDate_${showTimeId}`);
        showEndInput = document.getElementById(`showEndDate_${showTimeId}`);
    }

    const showStart = showStartInput ? new Date(showStartInput.value) : null;
    const showEnd = showEndInput ? new Date(showEndInput.value) : null;
    const ticketStart = ticketStartInput ? new Date(ticketStartInput.value) : null;
    const ticketEnd = ticketEndInput ? new Date(ticketEndInput.value) : null;

    if (showStartInput)
        clearError(showStartInput.id);
    if (showEndInput)
        clearError(showEndInput.id);
    if (ticketStartInput)
        clearError('modalTicketStartDate');
    if (ticketEndInput)
        clearError('modalTicketEndDate');

    if (showStartInput && showStartInput.value && showStart < currentDate) {
        showError(showStartInput.id, `Show start date cannot be in the past (before ${currentDate.toLocaleDateString()})`);
        updateSaveButtonState();
        return false;
    }
    if (showEndInput && showEndInput.value && showEnd < currentDate) {
        showError(showEndInput.id, `Show end date cannot be in the past (before ${currentDate.toLocaleDateString()})`);
        updateSaveButtonState();
        return false;
    }
    if (ticketStartInput && ticketStartInput.value && ticketStart < currentDate) {
        showError('modalTicketStartDate', `Sale start date cannot be in the past (before ${currentDate.toLocaleDateString()})`);
        updateSaveButtonState();
        return false;
    }
    if (ticketEndInput && ticketEndInput.value && ticketEnd < currentDate) {
        showError('modalTicketEndDate', `Sale end date cannot be in the past (before ${currentDate.toLocaleDateString()})`);
        updateSaveButtonState();
        return false;
    }

    if (showStartInput && showEndInput && showStartInput.value && showEndInput.value && showStart >= showEnd) {
        showError(showStartInput.id, "Show start date must be earlier than show end date");
        updateSaveButtonState();
        return false;
    }

    if (ticketStartInput && ticketEndInput && ticketStartInput.value && ticketEndInput.value && ticketStart >= ticketEnd) {
        showError('modalTicketStartDate', "Sale start date must be earlier than sale end date");
        updateSaveButtonState();
        return false;
    }

    if (ticketStartInput && showEndInput && ticketStartInput.value && showEndInput.value && ticketStart >= showEnd) {
        showError('modalTicketStartDate', "Sale start date must be before show end date");
        updateSaveButtonState();
        return false;
    }
    if (ticketEndInput && showEndInput && ticketEndInput.value && showEndInput.value && ticketEnd > showEnd) {
        showError('modalTicketEndDate', "Sale end date must be before or at show end date");
        updateSaveButtonState();
        return false;
    }

    updateSaveButtonState();
    return true;
}

function formatDateTime(dateTime) {
    if (!dateTime)
        return 'Not set';
    // Tạo đối tượng Date từ chuỗi datetime-local (ví dụ: "2025-02-28T14:30")
    const date = new Date(dateTime);

    // Định dạng lại theo kiểu "YYYY-MM-DD HH:MM" (bỏ "T")
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0'); // Thêm số 0 nếu cần
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}`;
}
// Check for next step
// Kiểm tra Tab 1 (Event Information)
function isEventInfoValid() {
    const eventName = document.querySelector('#event-info input[placeholder="Event Name"]').value.trim();
    const eventCategory = document.querySelector('#event-info select').value;
    const province = document.getElementById('province').value;
    const district = document.getElementById('district').value;
    const ward = document.getElementById('ward').value;
    const fullAddress = document.getElementById('fullAddress').value.trim();
    const eventInfo = document.querySelector('#event-info textarea').value.trim();
    const logoUrl = document.getElementById('logoEventInput').dataset.url || '';
    const backgroundUrl = document.getElementById('backgroundInput').dataset.url || '';
    const organizerLogoUrl = document.getElementById('organizerLogoInput').dataset.url || '';
    const organizerName = document.querySelector('#event-info .organizer-row input[placeholder="Organizer Name"]').value.trim();

    const isValid = eventName && eventCategory && province && district && ward && fullAddress && eventInfo && logoUrl && backgroundUrl && organizerLogoUrl && organizerName;

    if (!isValid) {
        alert('Please fill in all required fields in Event Information:\n- Event Name\n- Event Category\n- Province/City\n- District\n- Ward\n- Full Address\n- Event Information\n- Event Logo\n- Background Image\n- Organizer Logo\n- Organizer Name');
    }
    return isValid;
}

// Kiểm tra Tab 2 (Time & Logistics)
function isTimeLogisticsValid() {
    const eventType = document.getElementById('eventType').value;
    if (!eventType) {
        alert('Please select Type of Event in Time & Logistics.');
        return false;
    }

    // Nếu là Seated Event, kiểm tra ít nhất một hàng ghế và tổng số ghế
    if (eventType === 'seatedevent') {
        const seatRows = document.querySelectorAll('input[name="seatRow[]"]');
        const seatNumbers = document.querySelectorAll('input[name="seatNumber[]"]');
        let hasValidSeat = false;
        let totalSeats = 0;

        for (let i = 0; i < seatRows.length; i++) {
            const row = seatRows[i].value.trim();
            const num = parseInt(seatNumbers[i].value.trim());
            if (row && !isNaN(num) && num > 0) {
                hasValidSeat = true;
                totalSeats += num;
            }
        }

        if (!hasValidSeat) {
            alert('Please add at least one valid seat (Row and Number of Seats) for a Seated Event.');
            return false;
        }

        if (totalSeats > 461) {
            alert('Total seats cannot exceed 461 for a Seated Event.');
            return false;
        }
    }

    // Kiểm tra Show Time và Ticket Type
    const showTimes = document.querySelectorAll('.show-time');
    if (showTimes.length === 0) {
        alert('Please add at least one Show Time in Time & Logistics.');
        return false;
    }

    let hasValidShowTime = false;
    for (let showTime of showTimes) {
        const startDate = showTime.querySelector('input[name="showStartDate"]').value;
        const endDate = showTime.querySelector('input[name="showEndDate"]').value;
        const ticketList = showTime.querySelector('.space-y-2').children.length;
        if (startDate && endDate && ticketList > 0) {
            hasValidShowTime = true;
            break;
        }
    }
    if (!hasValidShowTime) {
        alert('Please ensure each Show Time has a Start Date, End Date, and at least one Ticket Type.');
        return false;
    }

    return true;
}

// Kiểm tra Tab 3 (Payment Information)
function isPaymentInfoValid() {
    const bankName = document.getElementById('bank').value;
    const bankAccount = document.querySelector('input[name="bankAccount"]').value.trim();
    const accountHolder = document.querySelector('input[name="accountHolder"]').value.trim();

    const isValid = bankName && bankAccount && accountHolder;

    if (!isValid) {
        alert('Please fill in all required fields in Payment Information:\n- Bank Name\n- Bank Account\n- Account Holder');
    }
    return isValid;
}

// Toggle Seat Section Display
function toggleEventType() {
    const eventType = document.getElementById('eventType').value;
    const seatSection = document.getElementById('seatSection');
    seatSection.classList.toggle('hidden', eventType !== 'seatedevent');
    if (eventType === 'seatedevent')
        calculateSeatSummary();
}

// Function to clear the error message
function clearSeatError() {
    const errorDiv = document.getElementById('seatError');
    errorDiv.classList.add('hidden');
    errorDiv.textContent = '';
}

// Function to display the error message
function showSeatError(message) {
    const errorDiv = document.getElementById('seatError');
    errorDiv.textContent = message;
    errorDiv.classList.remove('hidden');
}

// Add New Seat
function addSeat() {
    const seatsContainer = document.getElementById('seatsContainer');
    const newSeat = document.createElement('div');
    newSeat.className = 'seat-input flex flex-col md:flex-row gap-4';
    newSeat.innerHTML = `
                    <div class="flex-1">
                        <label class="text-gray-300">Row:</label>
                        <input type="text" name="seatRow[]" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" required>
                    </div>
                    <div class="flex-1">
                        <label class="text-gray-300">Number of Seats:</label>
                        <input type="text" name="seatNumber[]" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none" required>
                    </div>
                    <button type="button" class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition duration-200" onclick="removeSeat(this)">Delete</button>
                    <button type="button" class="bg-green-500 text-white px-4 py-2 rounded hover:bg-red-600 transition duration-200" onclick="saveSeat(this)">Save Seat</button>
                `;
    seatsContainer.appendChild(newSeat);
    calculateSeatSummary();
    clearSeatError();
}

// Remove Seat
function removeSeat(button) {
    button.closest('.seat-input').remove();
    calculateSeatSummary();
    clearSeatError();
}

// Save Seat with Duplicate Row Validation
function saveSeat(button) {
    const seatInputs = document.querySelectorAll('.seat-input');
    const rows = [];

    seatInputs.forEach((seatInput, index) => {
        const rowInput = seatInput.querySelector('input[name="seatRow[]"]');
        const rowValue = rowInput.value.trim().toUpperCase();
        if (rowValue) {
            rows.push({row: rowValue, index: index});
        }
    });

    const duplicateRows = rows.filter((row, index, self) =>
        self.findIndex(r => r.row === row.row) !== index
    );

    if (duplicateRows.length > 0) {
        showSeatError('Duplicate row detected! Please enter a different row.');
        return;
    }

    clearSeatError();
    calculateSeatSummary();
}

// Calculate Total Rows, Columns, and Seats
function calculateSeatSummary() {
    let rowCount = 0, totalSeats = 0, maxSeatsPerRow = 0;
    const seatRows = document.querySelectorAll('input[name="seatRow[]"]');
    const seatNumbers = document.querySelectorAll('input[name="seatNumber[]"]');
    const seatSummary = document.getElementById('seatSummary');
    const errorDiv = document.getElementById('seatError');

    if (!seatRows.length) {
        seatSummary.innerHTML = 'Total Rows: 0, Total Columns: 0, Total Seats: 0';
        return;
    }

    const seatsByRow = {};
    for (let i = 0; i < seatRows.length; i++) {
        const row = seatRows[i].value.trim().toUpperCase();
        const seatNum = parseInt(seatNumbers[i].value.trim());
        if (row && !isNaN(seatNum) && seatNum > 0) {
            if (seatNum > 16) { // Giới hạn mỗi hàng tối đa 16 ghế
                showSeatError(`Row ${row} exceeds maximum 16 seats per row.`);
                return;
            }
            rowCount++;
            totalSeats += seatNum;
            seatsByRow[row] = seatNum; // Lưu số ghế theo hàng
            maxSeatsPerRow = Math.max(maxSeatsPerRow, seatNum);
        }
    }

    if (rowCount > 26) { // Giới hạn tối đa 26 hàng
        showSeatError('Maximum 26 rows allowed (A-Z).');
        return;
    }

    if (totalSeats > 461) { // Giới hạn tổng số ghế
        showSeatError('Total seats cannot exceed 461.');
        return;
    }

    clearSeatError();
    seatSummary.innerHTML = `Total Rows: ${rowCount}, Total Columns: ${maxSeatsPerRow}, Total Seats: ${totalSeats}`;
    return seatsByRow; // Trả về object chứa số ghế theo hàng
}

// Format DateTime by replacing "T" with a space
function formatDateTime(dateTime) {
    if (!dateTime)
        return 'Not set';
    return dateTime.replace('T', ' ');
}

// Toggle Show Time Section
function toggleShowTimeSection(button) {
    const content = document.getElementById('showTimeContent');
    const icon = button.querySelector('i');
    content.classList.toggle('collapsed');
    icon.classList.toggle('fa-chevron-down');
    icon.classList.toggle('fa-chevron-up');
}

// Update Show Time Label with Start and End Dates
function updateShowTimeLabel(input) {
    const showTime = input.closest('.show-time');
    const labelSpan = showTime.querySelector('.show-time-label');
    const showTimeIndex = labelSpan.textContent.match(/\d+/)[0];
    const startDateInput = showTime.querySelector('input[name="showStartDate"]');
    const endDateInput = showTime.querySelector('input[name="showEndDate"]');
    const details = showTime.querySelector('.show-time-details');

    // Kiểm tra thời gian ngay lập tức
    if (!validateDateTime(input))
        return;

    if (details.classList.contains('collapsed')) {
        const formattedStartDate = formatDateTime(startDateInput.value);
        const formattedEndDate = formatDateTime(endDateInput.value);
        labelSpan.textContent = `Show Time #${showTimeIndex} (${formattedStartDate} - ${formattedEndDate})`;
    }
}

// Toggle Individual Show Time
function toggleShowTime(button) {
    const showTime = button.closest('.show-time');
    const details = showTime.querySelector('.show-time-details');
    const labelSpan = showTime.querySelector('.show-time-label');
    const showTimeIndex = labelSpan.textContent.match(/\d+/)[0];
    const startDateInput = showTime.querySelector('input[name="showStartDate"]');
    const endDateInput = showTime.querySelector('input[name="showEndDate"]');
    const icon = button.querySelector('i');

    details.classList.toggle('collapsed');
    icon.classList.toggle('fa-chevron-down');
    icon.classList.toggle('fa-chevron-up');

    if (details.classList.contains('collapsed')) {
        const startDate = formatDateTime(startDateInput.value);
        const endDate = formatDateTime(endDateInput.value);
        labelSpan.textContent = `Show Time #${showTimeIndex} (${startDate} - ${endDate})`;
    } else {
        labelSpan.textContent = `Show Time #${showTimeIndex}`;
    }
}

// Toggle Individual Ticket
function toggleTicket(button) {
    const ticket = button.closest('.saved-ticket');
    const details = ticket.querySelector('.ticket-details');
    const labelSpan = ticket.querySelector('.ticket-label');
    const ticketName = labelSpan.getAttribute('data-ticket-name'); // Store the original ticket name
    const saleStartSpan = ticket.querySelector('.sale-start');
    const saleEndSpan = ticket.querySelector('.sale-end');
    const icon = button.querySelector('i');

    details.classList.toggle('collapsed');
    icon.classList.toggle('fa-chevron-down');
    icon.classList.toggle('fa-chevron-up');

    if (details.classList.contains('collapsed')) {
        const saleStart = formatDateTime(saleStartSpan.textContent);
        const saleEnd = formatDateTime(saleEndSpan.textContent);
        labelSpan.textContent = `${ticketName} (${saleStart} - ${saleEnd})`;
    } else {
        labelSpan.textContent = ticketName;
    }
}
// Add New Show Time
let showTimeCount = 1;
// Sửa addNewShowTime để thêm sự kiện input
function addNewShowTime() {
    showTimeCount++;
    const showTimeList = document.getElementById('showTimeList');
    const newShowTime = document.createElement('div');
    newShowTime.className = 'show-time bg-gray-800 p-4 rounded';
    newShowTime.innerHTML = `
        <div class="flex justify-between items-center mb-3">
            <h6 class="text-white"><span class="show-time-label">Show Time #${showTimeCount}</span></h6>
            <div class="flex gap-2">
                <button class="toggle-btn" onclick="toggleShowTime(this)">
                    <i class="fas fa-chevron-down"></i>
                </button>
                <button class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600 transition duration-200" onclick="removeShowTime(this)">Delete</button>
            </div>
        </div>
        <div class="collapsible-content show-time-details">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                    <label class="text-gray-300">Start Date</label>
                    <input type="datetime-local" name="showStartDate" id="showStartDate_${showTimeCount}" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none">
                    <span class="error-message" id="showStartDate_${showTimeCount}_error"></span>
                </div>
                <div>
                    <label class="text-gray-300">End Date</label>
                    <input type="datetime-local" name="showEndDate" id="showEndDate_${showTimeCount}" class="w-full p-2 rounded bg-gray-700 border border-gray-600 focus:outline-none">
                    <span class="error-message" id="showEndDate_${showTimeCount}_error"></span>
                </div>
            </div>
            <div id="ticketList_${showTimeCount}" class="mt-3 space-y-2"></div>
            <button class="mt-3 w-full bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition duration-200" data-show-time="${showTimeCount}" onclick="openModal(this)">+ Add Ticket Type</button>
        </div>
    `;
    showTimeList.appendChild(newShowTime);

    // Thêm sự kiện input cho các input mới
    const newInputs = newShowTime.querySelectorAll('input[type="datetime-local"]');
    newInputs.forEach(input => {
        input.addEventListener('input', () => validateDateTime(input));
    });
}

// Remove Show Time
function removeShowTime(button) {
    button.closest('.show-time').remove();
    showTimeCount--;
    updateShowTimeLabels();
}

// Update Show Time Labels
function updateShowTimeLabels() {
    const showTimes = document.querySelectorAll('.show-time');
    showTimes.forEach((showTime, index) => {
        const labelSpan = showTime.querySelector('.show-time-label');
        const details = showTime.querySelector('.show-time-details');
        if (details.classList.contains('collapsed')) {
            const startDateInput = showTime.querySelector('input[name="showStartDate"]');
            const endDateInput = showTime.querySelector('input[name="showEndDate"]');
            const startDate = formatDateTime(startDateInput.value);
            const endDate = formatDateTime(endDateInput.value);
            labelSpan.textContent = `Show Time #${index + 1} (${startDate} - ${endDate})`;
        } else {
            labelSpan.textContent = `Show Time #${index + 1}`;
        }
    });
}

// Open Modal
function openModal(button) {
    const modal = document.getElementById('newTicketModal');
    modal.setAttribute('data-show-time', button.getAttribute('data-show-time'));
    modal.classList.remove('hidden');

    ['modalTicketName', 'modalTicketDescription', 'modalTicketPrice', 'modalTicketQuantity', 'modalTicketStartDate', 'modalTicketEndDate'].forEach(clearError);

    const eventType = document.getElementById('eventType').value;
    const seatSelectionDiv = document.getElementById('seatSelection');
    if (!seatSelectionDiv) {
        const newSeatDiv = document.createElement('div');
        newSeatDiv.id = 'seatSelection';
        newSeatDiv.className = 'space-y-2';
        modal.querySelector('.space-y-4').appendChild(newSeatDiv);
    }

    if (eventType === 'seatedevent') {
        const seatsByRow = calculateSeatSummary();
        let seatOptions = '<label class="block text-gray-300 mb-2">Select Seat Rows:</label>';
        for (let row in seatsByRow) {
            seatOptions += `
                <div>
                    <input type="checkbox" name="selectedSeats" value="${row}" data-seats="${seatsByRow[row]}">
                    <label class="text-gray-300 ml-2">Row ${row} (${seatsByRow[row]} seats)</label>
                </div>`;
        }
        seatSelectionDiv.innerHTML = seatOptions;
    } else {
        seatSelectionDiv.innerHTML = '';
    }

    const colorInput = document.getElementById('modalTicketColor');
    const colorValueSpan = document.getElementById('colorValue');
    colorValueSpan.textContent = colorInput.value.toUpperCase();

    const ticketStartInput = document.getElementById('modalTicketStartDate');
    const ticketEndInput = document.getElementById('modalTicketEndDate');
    ticketStartInput.addEventListener('input', () => validateDateTime(ticketStartInput));
    ticketEndInput.addEventListener('input', () => validateDateTime(ticketEndInput));

    // Thêm sự kiện input cho các trường khác để cập nhật nút Save
    ['modalTicketName', 'modalTicketDescription', 'modalTicketPrice', 'modalTicketQuantity'].forEach(id => {
        const input = document.getElementById(id);
        input.addEventListener('input', updateSaveButtonState);
    });

    // Cập nhật trạng thái ban đầu của nút Save
    updateSaveButtonState();
}

// Close Modal
function closeModal() {
    const modal = document.getElementById('newTicketModal');
    modal.classList.add('hidden');
    modal.removeAttribute('data-editing-ticket');
    modal.querySelector('h5').textContent = 'Create New Ticket Type';
    document.getElementById('modalTicketName').value = '';
    document.getElementById('modalTicketDescription').value = '';
    document.getElementById('modalTicketPrice').value = '';
    document.getElementById('modalTicketQuantity').value = '';
    document.getElementById('modalTicketStartDate').value = '';
    document.getElementById('modalTicketEndDate').value = '';
    document.getElementById('modalTicketColor').value = '#000000';
    document.getElementById('colorValue').textContent = '#000000';
}

// Save New Ticket
async function saveNewTicket() {
    const modal = document.getElementById('newTicketModal');
    const showTimeId = modal.getAttribute('data-show-time');
    const isEditing = modal.hasAttribute('data-editing-ticket');
    const editingTicketName = modal.getAttribute('data-editing-ticket');

    const ticketName = document.getElementById('modalTicketName').value;
    const ticketDescription = document.getElementById('modalTicketDescription').value;
    const ticketPrice = document.getElementById('modalTicketPrice').value;
    const ticketQuantity = parseInt(document.getElementById('modalTicketQuantity').value);
    const ticketColor = document.getElementById('modalTicketColor').value;
    const ticketStartDate = document.getElementById('modalTicketStartDate').value;
    const ticketEndDate = document.getElementById('modalTicketEndDate').value;
    const eventType = document.getElementById('eventType').value;

    const showTime = document.getElementById(`ticketList_${showTimeId}`).closest('.show-time');
    const showStartDate = showTime.querySelector('input[name="showStartDate"]').value;
    const showEndDate = showTime.querySelector('input[name="showEndDate"]').value;

    // Nếu có lỗi hiển thị, không cho lưu
    if (hasErrors()) {
        return;
    }

    // Kiểm tra các trường bắt buộc
    if (!ticketName || !ticketDescription || !ticketPrice || !ticketQuantity || !ticketColor || !ticketStartDate || !ticketEndDate || !showStartDate || !showEndDate) {
        if (!ticketName)
            showError('modalTicketName', 'Ticket name is required');
        if (!ticketDescription)
            showError('modalTicketDescription', 'Description is required');
        if (!ticketPrice)
            showError('modalTicketPrice', 'Price is required');
        if (!ticketQuantity)
            showError('modalTicketQuantity', 'Quantity is required');
        if (!ticketColor)
            showError('modalTicketColor', 'Color is required');
        if (!ticketStartDate)
            showError('modalTicketStartDate', 'Sale start date is required');
        if (!ticketEndDate)
            showError('modalTicketEndDate', 'Sale end date is required');
        if (!showStartDate)
            showError(`showStartDate_${showTimeId}`, 'Show start date is required');
        if (!showEndDate)
            showError(`showEndDate_${showTimeId}`, 'Show end date is required');
        updateSaveButtonState();
        return;
    }

    let totalAvailableSeats = 0;
    let selectedRows = [];
    if (eventType === 'seatedevent') {
        const selectedSeats = document.querySelectorAll('input[name="selectedSeats"]:checked');
        if (selectedSeats.length === 0) {
            showError('seatSelection', 'Please select at least one seat row');
            updateSaveButtonState();
            return;
        }

        selectedSeats.forEach(seat => {
            const seatsInRow = parseInt(seat.getAttribute('data-seats'));
            totalAvailableSeats += seatsInRow;
            selectedRows.push(`${seat.value} (${seatsInRow} seats)`);
        });

        if (ticketQuantity > totalAvailableSeats) {
            showError('modalTicketQuantity', `Quantity (${ticketQuantity}) exceeds available seats (${totalAvailableSeats})`);
            updateSaveButtonState();
            return;
        }
    }

    const ticketList = document.getElementById(`ticketList_${showTimeId}`);
    const colorName = await getColorNameFromAPI(ticketColor);

    if (isEditing) {
        const tickets = ticketList.querySelectorAll('.saved-ticket');
        for (let ticket of tickets) {
            if (ticket.querySelector('.ticket-label').getAttribute('data-ticket-name') === editingTicketName) {
                ticket.innerHTML = `
                    <div class="flex justify-between items-center mb-2">
                        <h6 class="text-white"><span class="ticket-label" data-ticket-name="${ticketName}">${ticketName}</span></h6>
                        <div class="flex gap-2">
                            <button class="toggle-btn" onclick="toggleTicket(this)">
                                <i class="fas fa-chevron-down"></i>
                            </button>
                            <button class="bg-yellow-500 text-white px-2 py-1 rounded hover:bg-yellow-600 transition duration-200" onclick="editTicket(this, '${showTimeId}')">Edit</button>
                            <button class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600 transition duration-200" onclick="removeTicket(this, '${showTimeId}')">Delete</button>
                        </div>
                    </div>
                    <div class="collapsible-content ticket-details">
                        <div class="space-y-2 text-gray-300">
                            <div><label>Description:</label> <span>${ticketDescription}</span></div>
                            <div><label>Price (VND):</label> <span>${ticketPrice}</span></div>
                            <div><label>Quantity:</label> <span>${ticketQuantity}</span></div>
                            ${eventType === 'seatedevent' ? `<div><label>Selected Rows:</label> <span>${selectedRows.join(', ')}</span></div>` : ''}
                            <div><label>Color:</label> <span style="color: ${ticketColor}">${ticketColor}</span> <span>(${colorName})</span></div>
                            <div><label>Sale Start:</label> <span class="sale-start">${formatDateTime(ticketStartDate)}</span></div>
                            <div><label>Sale End:</label> <span class="sale-end">${formatDateTime(ticketEndDate)}</span></div>
                        </div>
                    </div>
                `;
                break;
            }
        }
    } else {
        const newTicket = document.createElement('div');
        newTicket.className = 'saved-ticket bg-gray-700 p-3 rounded';
        newTicket.innerHTML = `
            <div class="flex justify-between items-center mb-2">
                <h6 class="text-white"><span class="ticket-label" data-ticket-name="${ticketName}">${ticketName}</span></h6>
                <div class="flex gap-2">
                    <button class="toggle-btn" onclick="toggleTicket(this)">
                        <i class="fas fa-chevron-down"></i>
                    </button>
                    <button class="bg-yellow-500 text-white px-2 py-1 rounded hover:bg-yellow-600 transition duration-200" onclick="editTicket(this, '${showTimeId}')">Edit</button>
                    <button class="bg-red-500 text-white px-2 py-1 rounded hover:bg-red-600 transition duration-200" onclick="removeTicket(this, '${showTimeId}')">Delete</button>
                </div>
            </div>
            <div class="collapsible-content ticket-details">
                <div class="space-y-2 text-gray-300">
                    <div><label>Description:</label> <span>${ticketDescription}</span></div>
                    <div><label>Price (VND):</label> <span>${ticketPrice}</span></div>
                    <div><label>Quantity:</label> <span>${ticketQuantity}</span></div>
                    ${eventType === 'seatedevent' ? `<div><label>Selected Rows:</label> <span>${selectedRows.join(', ')}</span></div>` : ''}
                    <div><label>Color:</label> <span style="color: ${ticketColor}">${ticketColor}</span> <span>(${colorName})</span></div>
                    <div><label>Sale Start:</label> <span class="sale-start">${formatDateTime(ticketStartDate)}</span></div>
                    <div><label>Sale End:</label> <span class="sale-end">${formatDateTime(ticketEndDate)}</span></div>
                </div>
            </div>
        `;
        ticketList.appendChild(newTicket);
    }

    modal.removeAttribute('data-editing-ticket');
    modal.querySelector('h5').textContent = 'Create New Ticket Type';
    closeModal();
}

// Remove Ticket
function removeTicket(button) {
    button.closest('.saved-ticket').remove();
}

function editTicket(button, showTimeId) {
    const ticket = button.closest('.saved-ticket');
    const ticketDetails = ticket.querySelector('.ticket-details');
    const modal = document.getElementById('newTicketModal');

    // Điền thông tin hiện tại vào modal
    document.getElementById('modalTicketName').value = ticket.querySelector('.ticket-label').getAttribute('data-ticket-name');
    document.getElementById('modalTicketDescription').value = ticketDetails.querySelector('div:nth-child(1) span').textContent;
    document.getElementById('modalTicketPrice').value = ticketDetails.querySelector('div:nth-child(2) span').textContent;
    document.getElementById('modalTicketQuantity').value = ticketDetails.querySelector('div:nth-child(3) span').textContent;
    document.getElementById('modalTicketColor').value = ticketDetails.querySelector('div:nth-child(5) span').textContent;
    document.getElementById('colorValue').textContent = ticketDetails.querySelector('div:nth-child(5) span').textContent;

    // Lấy và định dạng lại thời gian
    const saleStart = ticketDetails.querySelector('.sale-start').textContent;
    const saleEnd = ticketDetails.querySelector('.sale-end').textContent;
    document.getElementById('modalTicketStartDate').value = formatDateTime(saleStart);
    document.getElementById('modalTicketEndDate').value = formatDateTime(saleEnd);

    // Xử lý ghế nếu là seated event
    const eventType = document.getElementById('eventType').value;
    const seatSelectionDiv = document.getElementById('seatSelection');
    if (eventType === 'seatedevent') {
        const seatsByRow = calculateSeatSummary();
        let selectedRowsText = '';
        const selectedRowsDiv = ticketDetails.querySelector('div:nth-child(4)'); // Kiểm tra div chứa thông tin hàng ghế
        if (selectedRowsDiv) {
            selectedRowsText = selectedRowsDiv.querySelector('span')?.textContent || '';
        }
        const selectedRows = selectedRowsText.split(', ').map(row => row.split(' ')[1]); // Lấy danh sách hàng (e.g., "A", "B")

        let seatOptions = '<label class="block text-gray-300 mb-2">Select Seat Rows:</label>';
        for (let row in seatsByRow) {
            const isChecked = selectedRows.includes(row) ? 'checked' : '';
            seatOptions += `
                <div>
                    <input type="checkbox" name="selectedSeats" value="${row}" data-seats="${seatsByRow[row]}" ${isChecked}>
                    <label class="text-gray-300 ml-2">Row ${row} (${seatsByRow[row]} seats)</label>
                </div>`;
        }
        seatSelectionDiv.innerHTML = seatOptions;
    } else {
        seatSelectionDiv.innerHTML = ''; // Không hiển thị ghế cho standing event
    }

    // Đặt thuộc tính để biết đây là chỉnh sửa
    modal.setAttribute('data-show-time', showTimeId);
    modal.setAttribute('data-editing-ticket', ticket.querySelector('.ticket-label').getAttribute('data-ticket-name')); // Lưu tên ticket để xác định ticket cần chỉnh sửa
    modal.querySelector('h5').textContent = 'Edit Ticket Type';
    modal.classList.remove('hidden');
}

// Hàm lấy tên màu từ API Color Pizza
async function getColorNameFromAPI(hex) {
    try {
        const cleanHex = hex.replace('#', ''); // Loại bỏ ký tự '#' khỏi mã hex
        const response = await fetch(`https://api.color.pizza/v1/${cleanHex}`);
        const data = await response.json();
        return data.colors[0].name || 'Custom Color'; // Trả về tên màu hoặc 'Custom Color' nếu không tìm thấy
    } catch (error) {
        console.error('Error fetching color name:', error);
        return 'Custom Color'; // Trả về giá trị mặc định nếu lỗi
    }
}
// Hiển thị thông báo lỗi
function showError(elementId, message) {
    const errorElement = document.getElementById(`${elementId}_error`);
    if (errorElement) {
        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }
}

// Xóa thông báo lỗi
function clearError(elementId) {
    const errorElement = document.getElementById(`${elementId}_error`);
    if (errorElement) {
        errorElement.textContent = '';
        errorElement.style.display = 'none';
    }
}

// Switch Tabs
function showTab(tabId) {
    const currentTab = document.querySelector('.tab-content:not(.hidden)').id;

    // Kiểm tra điều kiện trước khi chuyển tab
    if (currentTab === 'event-info' && tabId !== 'event-info' && !isEventInfoValid()) {
        return; // Không chuyển tab nếu Tab 1 chưa đủ thông tin
    }
    if (currentTab === 'time-logistics' && tabId === 'payment-info' && !isTimeLogisticsValid()) {
        return; // Không chuyển từ Tab 2 sang Tab 3 nếu Tab 2 chưa đủ thông tin
    }

    // Chuyển tab nếu điều kiện thỏa mãn
    document.querySelectorAll('.tab-content').forEach(tab => tab.classList.add('hidden'));
    document.getElementById(tabId).classList.remove('hidden');
    document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('bg-green-600'));
    document.querySelector(`button[onclick="showTab('${tabId}')"]`).classList.add('bg-green-600');
}

// Move to Next Tab
function nextTab() {
    const tabs = ['event-info', 'time-logistics', 'payment-info'];
    const currentTab = document.querySelector('.tab-content:not(.hidden)').id;
    const nextIndex = tabs.indexOf(currentTab) + 1;

    // Kiểm tra điều kiện trước khi chuyển sang tab tiếp theo
    if (currentTab === 'event-info' && !isEventInfoValid()) {
        return; // Không chuyển từ Tab 1 sang Tab 2 nếu Tab 1 chưa đủ thông tin
    }
    if (currentTab === 'time-logistics' && !isTimeLogisticsValid()) {
        return; // Không chuyển từ Tab 2 sang Tab 3 nếu Tab 2 chưa đủ thông tin
    }

    if (nextIndex < tabs.length) {
        showTab(tabs[nextIndex]);
    }
}

// Load Banks
async function loadBanks() {
    const response = await fetch("https://api.vietqr.io/v2/banks");
    const data = await response.json();
    const bankSelect = document.getElementById("bank");
    bankSelect.innerHTML = '<option value="">Bank Name</option>' + data.data.map(bank => `<option value="${bank.code}">${bank.shortName} - ${bank.name}</option>`).join('');
}

// Update color value display
document.addEventListener('DOMContentLoaded', () => {
    const colorInput = document.getElementById('modalTicketColor');
    colorInput.addEventListener('input', function () {
        const colorValue = this.value.toUpperCase();
        document.getElementById('colorValue').textContent = colorValue;
    });
});

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    const colorInput = document.getElementById('modalTicketColor');
    const colorValueSpan = document.getElementById('colorValue');
    colorInput.addEventListener('input', async function () {
        const colorValue = this.value.toUpperCase();
        const colorName = await getColorNameFromAPI(colorValue); // Gọi API để lấy tên màu
        colorValueSpan.textContent = `${colorValue} (${colorName})`; // Hiển thị mã và tên màu
    });

    const currentDate = new Date();
    const minDateTime = currentDate.toISOString().slice(0, 16);

    const dateInputs = document.querySelectorAll('input[type="datetime-local"]');
    dateInputs.forEach(input => {
        input.setAttribute('min', minDateTime);
        input.addEventListener('input', () => validateDateTime(input)); // Kiểm tra ngay khi nhập
    });

    showTab('event-info');
    loadBanks();
    loadProvinces(); // Thêm dòng này để tải danh sách tỉnh/thành
    document.querySelectorAll('input[name="seatRow[]"], input[name="seatNumber[]"]').forEach(input => {
        input.addEventListener('input', calculateSeatSummary);
    });
    calculateSeatSummary();
});

// Load Provinces
async function loadProvinces() {
    const response = await fetch("https://provinces.open-api.vn/api/p/");
    const provinces = await response.json();
    const provinceSelect = document.getElementById("province");
    provinceSelect.innerHTML = '<option value="">-- Select Province/City --</option>' +
            provinces.map(province => `<option value="${province.name}" data-code="${province.code}">${province.name}</option>`).join('');
}

// Load Districts based on selected Province
async function updateDistricts() {
    const provinceSelect = document.getElementById("province");
    const districtSelect = document.getElementById("district");
    const wardSelect = document.getElementById("ward");
    const selectedProvinceCode = provinceSelect.options[provinceSelect.selectedIndex].getAttribute("data-code");

    districtSelect.innerHTML = '<option value="">-- Select District --</option>';
    wardSelect.innerHTML = '<option value="">-- Select Ward --</option>';
    if (selectedProvinceCode) {
        const response = await fetch(`https://provinces.open-api.vn/api/p/${selectedProvinceCode}?depth=2`);
        const provinceData = await response.json();
        const districts = provinceData.districts;
        districtSelect.innerHTML = '<option value="">-- Select District --</option>' +
                districts.map(district => `<option value="${district.name}" data-code="${district.code}">${district.name}</option>`).join('');
    }
    updateFullAddress(); // Update address after changing districts
}

// Load Wards based on selected District
async function updateWards() {
    const districtSelect = document.getElementById("district");
    const wardSelect = document.getElementById("ward");
    const selectedDistrictCode = districtSelect.options[districtSelect.selectedIndex].getAttribute("data-code");

    wardSelect.innerHTML = '<option value="">-- Select Ward --</option>';
    if (selectedDistrictCode) {
        const response = await fetch(`https://provinces.open-api.vn/api/d/${selectedDistrictCode}?depth=2`);
        const districtData = await response.json();
        const wards = districtData.wards;
        wardSelect.innerHTML = '<option value="">-- Select Ward --</option>' +
                wards.map(ward => `<option value="${ward.name}">${ward.name}</option>`).join('');
    }
    updateFullAddress(); // Update address after changing wards
}

// Update Full Address
function updateFullAddress() {
    const provinceSelect = document.getElementById("province");
    const districtSelect = document.getElementById("district");
    const wardSelect = document.getElementById("ward");
    const buildingNumberInput = document.getElementById("buildingNumber"); // Assuming a separate input
    const fullAddressInput = document.getElementById("fullAddress");

    const province = provinceSelect.value;
    const district = districtSelect.value;
    const ward = wardSelect.value;
    const buildingNumber = buildingNumberInput ? buildingNumberInput.value : ''; // Fallback if no input exists

    // Build address in the order: Building number, Ward, District, Province/City
    let fullAddress = '';
    if (buildingNumber) {
        fullAddress += buildingNumber; // e.g., "123"
    }
    if (ward) {
        fullAddress += fullAddress ? ', ' + ward : ward; // e.g., "Phường Cống Vị"
    }
    if (district) {
        fullAddress += fullAddress ? ', ' + district : district; // e.g., "Quận Ba Đình"
    }
    if (province) {
        fullAddress += fullAddress ? ', ' + province : province; // e.g., "Hà Nội"
    }

    fullAddressInput.value = fullAddress || 'Building number, Ward, District, Province/City';
}
// Upload image to cloud (Đã xóa phần cũ và gộp vào các sự kiện dưới)
document.addEventListener('DOMContentLoaded', () => {
    // Event Logo
    const logoPreview = document.getElementById('logoPreview');
    const logoEventInput = document.getElementById('logoEventInput');
    logoPreview.addEventListener('click', () => logoEventInput.click());

    // Organizer Logo
    const organizerLogoPreview = document.getElementById('organizerLogoPreview');
    const organizerLogoInput = document.getElementById('organizerLogoInput');
    organizerLogoPreview.addEventListener('click', () => organizerLogoInput.click());

    // Event Background Image
    const backgroundPreview = document.getElementById('backgroundPreview');
    const backgroundInput = document.getElementById('backgroundInput');
    backgroundPreview.addEventListener('click', () => backgroundInput.click());
});

// Hàm kiểm tra kích thước ảnh
function checkImageDimensions(file, requiredWidth, requiredHeight, callback) {
    const img = new Image();
    const reader = new FileReader();

    reader.onload = function (e) {
        img.src = e.target.result;
        img.onload = function () {
            if (img.width !== requiredWidth || img.height !== requiredHeight) {
                callback(false, `Image must be ${requiredWidth}x${requiredHeight} pixels. Uploaded image is ${img.width}x${img.height} pixels.`);
            } else {
                callback(true);
            }
        };
    };
    reader.readAsDataURL(file);
}

// Hàm hiển thị thông báo lỗi
function showImageError(elementId, message) {
    const preview = document.getElementById(elementId);
    const errorDiv = document.createElement('div');
    errorDiv.className = 'text-red-500 text-sm mt-2 image-error';
    errorDiv.textContent = message;
    const existingError = preview.parentElement.querySelector('.image-error');
    if (existingError)
        existingError.remove();
    preview.parentElement.appendChild(errorDiv);
}

// Hàm xóa thông báo lỗi
function clearImageError(elementId) {
    const preview = document.getElementById(elementId);
    const existingError = preview.parentElement.querySelector('.image-error');
    if (existingError)
        existingError.remove();
}

// Xử lý upload Event Logo
document.getElementById('logoEventInput').addEventListener('change', function (e) {
    const file = e.target.files[0];
    const preview = document.getElementById('logoPreview');
    const img = document.getElementById('logoImage');
    const icon = preview.querySelector('.upload-icon');
    const text = preview.querySelector('.upload-text');

    if (!file)
        return;

    // Kiểm tra kích thước (720x958)
    checkImageDimensions(file, 720, 958, async (isValid, errorMessage) => {
        if (!isValid) {
            showImageError('logoPreview', errorMessage);
            this.value = ''; // Xóa file đã chọn
            img.classList.add('hidden'); // Không hiển thị ảnh
            if (icon)
                icon.classList.remove('hidden');
            if (text)
                text.classList.remove('hidden');
            return;
        }

        clearImageError('logoPreview');

        const formData = new FormData();
        formData.append("file", file);
        formData.append("upload_preset", "event_upload");
        formData.append("folder", "event_logos");

        try {
            const response = await fetch(
                    "https://api.cloudinary.com/v1_1/dnvpphtov/image/upload",
                    {method: "POST", body: formData}
            );
            const data = await response.json();

            if (data.secure_url) {
                img.src = data.secure_url;
                img.classList.remove('hidden');
                if (icon)
                    icon.classList.add('hidden');
                if (text)
                    text.classList.add('hidden');
                this.dataset.url = data.secure_url;
            } else {
                throw new Error("Upload failed");
            }
        } catch (error) {
            console.error("Error uploading Event Logo:", error);
            showImageError('logoPreview', 'Upload failed. Please try again.');
            this.value = ''; // Xóa file nếu upload thất bại
            img.classList.add('hidden');
            if (icon)
                icon.classList.remove('hidden');
            if (text)
                text.classList.remove('hidden');
        }
    });
});

// Xử lý upload Background Image
document.getElementById('backgroundInput').addEventListener('change', function (e) {
    const file = e.target.files[0];
    const preview = document.getElementById('backgroundPreview');
    const img = document.getElementById('backgroundImage');
    const icon = preview.querySelector('.upload-icon');
    const text = preview.querySelector('.upload-text');

    if (!file)
        return;

    // Kiểm tra kích thước (1280x720)
    checkImageDimensions(file, 1280, 720, async (isValid, errorMessage) => {
        if (!isValid) {
            showImageError('backgroundPreview', errorMessage);
            this.value = '';
            img.classList.add('hidden');
            if (icon)
                icon.classList.remove('hidden');
            if (text)
                text.classList.remove('hidden');
            return;
        }

        clearImageError('backgroundPreview');

        const formData = new FormData();
        formData.append("file", file);
        formData.append("upload_preset", "event_upload");
        formData.append("folder", "event_backgrounds");

        try {
            const response = await fetch(
                    "https://api.cloudinary.com/v1_1/dnvpphtov/image/upload",
                    {method: "POST", body: formData}
            );
            const data = await response.json();

            if (data.secure_url) {
                img.src = data.secure_url;
                img.classList.remove('hidden');
                if (icon)
                    icon.classList.add('hidden');
                if (text)
                    text.classList.add('hidden');
                this.dataset.url = data.secure_url;
            } else {
                throw new Error("Upload failed");
            }
        } catch (error) {
            console.error("Error uploading Background Image:", error);
            showImageError('backgroundPreview', 'Upload failed. Please try again.');
            this.value = '';
            img.classList.add('hidden');
            if (icon)
                icon.classList.remove('hidden');
            if (text)
                text.classList.remove('hidden');
        }
    });
});

// Xử lý upload Organizer Logo
document.getElementById('organizerLogoInput').addEventListener('change', function (e) {
    const file = e.target.files[0];
    const preview = document.getElementById('organizerLogoPreview');
    const img = document.getElementById('organizerLogoImage');
    const icon = preview.querySelector('.upload-icon');
    const text = preview.querySelector('.upload-text');

    if (!file)
        return;

    // Kiểm tra kích thước (275x275)
    checkImageDimensions(file, 275, 275, async (isValid, errorMessage) => {
        if (!isValid) {
            showImageError('organizerLogoPreview', errorMessage);
            this.value = '';
            img.classList.add('hidden');
            if (icon)
                icon.classList.remove('hidden');
            if (text)
                text.classList.remove('hidden');
            return;
        }

        clearImageError('organizerLogoPreview');

        const formData = new FormData();
        formData.append("file", file);
        formData.append("upload_preset", "event_upload");
        formData.append("folder", "organizer_logos");

        try {
            const response = await fetch(
                    "https://api.cloudinary.com/v1_1/dnvpphtov/image/upload",
                    {method: "POST", body: formData}
            );
            const data = await response.json();

            if (data.secure_url) {
                img.src = data.secure_url;
                img.classList.remove('hidden');
                if (icon)
                    icon.classList.add('hidden');
                if (text)
                    text.classList.add('hidden');
                this.dataset.url = data.secure_url;
            } else {
                throw new Error("Upload failed");
            }
        } catch (error) {
            console.error("Error uploading Organizer Logo:", error);
            showImageError('organizerLogoPreview', 'Upload failed. Please try again.');
            this.value = '';
            img.classList.add('hidden');
            if (icon)
                icon.classList.remove('hidden');
            if (text)
                text.classList.remove('hidden');
        }
    });
});