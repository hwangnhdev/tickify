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
    const currentDate = new Date();
    let showStartInput, showEndInput;
    if (showTime) {
        showStartInput = showTime.querySelector('input[name="showStartDate"]');
        showEndInput = showTime.querySelector('input[name="showEndDate"]');
    }

    const showStart = showStartInput ? new Date(showStartInput.value) : null;
    const showEnd = showEndInput ? new Date(showEndInput.value) : null;
    if (showStartInput) clearError(showStartInput.id);
    if (showEndInput) clearError(showEndInput.id);

    // Thêm kiểm tra startDate trước ngày hiện tại 40 ngày
    const minStartDate = new Date(currentDate);
    minStartDate.setDate(currentDate.getDate() + 40); // Thêm 40 ngày

    if (showStartInput && showStartInput.value) {
        if (isNaN(showStart.getTime())) {
            showError(showStartInput.id, 'Invalid start date format');
            updateSaveButtonState();
            return false;
        }
        if (showStart < minStartDate) {
            showError(showStartInput.id, `Show start date must be at least 40 days from today (${minStartDate.toLocaleDateString()})`);
            updateSaveButtonState();
            return false;
        }
        if (showStart < currentDate) {
            showError(showStartInput.id, `Show start date cannot be in the past (before ${currentDate.toLocaleDateString()})`);
            updateSaveButtonState();
            return false;
        }
    }

    if (showEndInput && showEndInput.value && showEnd < currentDate) {
        showError(showEndInput.id, `Show end date cannot be in the past (before ${currentDate.toLocaleDateString()})`);
        updateSaveButtonState();
        return false;
    }

    if (showStartInput && showEndInput && showStartInput.value && showEndInput.value && showStart >= showEnd) {
        showError(showStartInput.id, "Show start date must be earlier than show end date");
        updateSaveButtonState();
        return false;
    }

    // Kiểm tra trùng lấn thời gian ngay khi nhập, truyền showTime hiện tại
    if (showStartInput && showStartInput.value && showEndInput && showEndInput.value) {
        if (checkShowTimeOverlap(showStartInput.value, showEndInput.value, showTime)) {
            showError(showStartInput.id, 'This showtime overlaps with another showtime.');
            showError(showEndInput.id, 'This showtime overlaps with another showtime.');
            updateSaveButtonState();
            return false;
        } else {
            clearError(showStartInput.id);
            clearError(showEndInput.id);
        }
    }

    updateSaveButtonState();
    return true;
}

function formatDateTime(dateTime) {
    if (!dateTime) return 'Not set';
    // Create Date object from datetime-local (e.g., "2025-02-28T14:30")
    const date = new Date(dateTime);
    // Format to "YYYY-MM-DD HH:MM:SS" (including seconds)
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = '00'; // Add seconds as 00
    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
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

    let hasErrors = false;

    if (!eventName) {
        showError('eventName', 'Event Name is required');
        hasErrors = true;
    } else {
        clearError('eventName');
    }

    if (!eventCategory) {
        showError('eventCategory', 'Event Category is required');
        hasErrors = true;
    } else {
        clearError('eventCategory');
    }

    if (!province) {
        showError('province', 'Province/City is required');
        hasErrors = true;
    } else {
        clearError('province');
    }

    if (!district) {
        showError('district', 'District is required');
        hasErrors = true;
    } else {
        clearError('district');
    }

    if (!ward) {
        showError('ward', 'Ward is required');
        hasErrors = true;
    } else {
        clearError('ward');
    }

    if (!fullAddress) {
        showError('fullAddress', 'Full Address is required');
        hasErrors = true;
    } else {
        clearError('fullAddress');
    }

    if (!eventInfo) {
        showError('eventInfo', 'Event Information is required');
        hasErrors = true;
    } else {
        clearError('eventInfo');
    }

    if (!logoUrl) {
        showError('logoEvent', 'Event Logo is required');
        hasErrors = true;
    } else {
        clearError('logoEvent');
    }

    if (!backgroundUrl) {
        showError('backgroundImage', 'Background Image is required');
        hasErrors = true;
    } else {
        clearError('backgroundImage');
    }

    if (!organizerLogoUrl) {
        showError('organizerLogo', 'Organizer Logo is required');
        hasErrors = true;
    } else {
        clearError('organizerLogo');
    }

    if (!organizerName) {
        showError('organizerName', 'Organizer Name is required');
        hasErrors = true;
    } else {
        clearError('organizerName');
    }

    updateSaveButtonState();
    return !hasErrors;
}

// Kiểm tra Tab 2 (Time & Logistics)
function isTimeLogisticsValid() {
    const eventType = document.getElementById('eventType').value;
    let hasErrors = false;

    if (!eventType) {
        showError('eventType', 'Type of Event is required');
        hasErrors = true;
    } else {
        clearError('eventType');
    }

    // Nếu là Seated Event, kiểm tra ít nhất một hàng ghế và tổng số ghế
    if (eventType === 'Seating Event') {
        const seatRows = document.querySelectorAll('input[name="seatRow[]"]');
        const seatNumbers = document.querySelectorAll('input[name="seatNumber[]"]');
        let hasValidSeat = false;
        let totalSeats = 0;

        seatRows.forEach((rowInput, i) => {
            const row = rowInput.value.trim();
            const num = parseInt(seatNumbers[i].value.trim());
            if (!row) {
                showError('seatRow_error', 'Row is required');
                hasErrors = true;
            } else {
                clearError('seatRow_error');
            }
            if (!num || isNaN(num) || num <= 0) {
                showError('seatNumber_error', 'Number of Seats is required and must be greater than 0');
                hasErrors = true;
            } else {
                clearError('seatNumber_error');
            }
            if (row && !isNaN(num) && num > 0) {
                hasValidSeat = true;
                totalSeats += num;
            }
        });

        if (!hasValidSeat) {
            showError('seatRow_error', 'Please add at least one valid seat (Row and Number of Seats) for a Seated Event');
            hasErrors = true;
        } else {
            clearError('seatRow_error');
            clearError('seatNumber_error');
        }

        if (totalSeats > 461) {
            showError('seatNumber_error', 'Total seats cannot exceed 461 for a Seated Event');
            hasErrors = true;
        }
    }

    // Kiểm tra Show Time và Ticket Type
    const showTimes = document.querySelectorAll('.show-time');
    if (showTimes.length === 0) {
        showError('showTime_error', 'Please add at least one Show Time');
        hasErrors = true;
    } else {
        clearError('showTime_error');
        let hasValidShowTime = false;

        for (let i = 0; i < showTimes.length; i++) {
            const showTime = showTimes[i];
            const startDate = showTime.querySelector('input[name="showStartDate"]').value;
            const endDate = showTime.querySelector('input[name="showEndDate"]').value;
            const ticketList = showTime.querySelector('.space-y-2').children.length;
            console.log(`Show Time #${i+1}: startDate=${startDate}, endDate=${endDate}, ticketList=${ticketList}`);
            
            if (!startDate) {
                showError(`showStartDate_${showTime.querySelector('input[name="showStartDate"]').id}`, 'Start Date is required');
                hasErrors = true;
            } else {
                clearError(`showStartDate_${showTime.querySelector('input[name="showStartDate"]').id}`);
            }

            if (!endDate) {
                showError(`showEndDate_${showTime.querySelector('input[name="showEndDate"]').id}`, 'End Date is required');
                hasErrors = true;
            } else {
                clearError(`showEndDate_${showTime.querySelector('input[name="showEndDate"]').id}`);
            }

            // Kiểm tra trùng lấn với tất cả các showtime khác
            for (let j = 0; j < showTimes.length; j++) {
                if (i !== j) {
                    const otherShowTime = showTimes[j];
                    const otherStart = otherShowTime.querySelector('input[name="showStartDate"]').value;
                    const otherEnd = otherShowTime.querySelector('input[name="showEndDate"]').value;
                    if (otherStart && otherEnd) {
                        if (checkShowTimeOverlap(startDate, endDate, showTime)) {
                            showError(`showStartDate_${showTime.querySelector('input[name="showStartDate"]').id}`, 'This showtime overlaps with another showtime.');
                            showError(`showEndDate_${showTime.querySelector('input[name="showEndDate"]').id}`, 'This showtime overlaps with another showtime.');
                            hasErrors = true;
                            break;
                        } else {
                            clearError(`showStartDate_${showTime.querySelector('input[name="showStartDate"]').id}`);
                            clearError(`showEndDate_${showTime.querySelector('input[name="showEndDate"]').id}`);
                        }
                    }
                }
            }

            // Chỉ yêu cầu Ticket Type nếu đã có Start Date và End Date hợp lệ
            if (startDate && endDate && ticketList === 0) {
                showError('showTime_error', 'Please add at least one Ticket Type for each Show Time');
                hasErrors = true;
            } else if (startDate && endDate && ticketList > 0) {
                hasValidShowTime = true;
                clearError('showTime_error');
            }
        }

        if (!hasValidShowTime && showTimes.length > 0) {
            showError('showTime_error', 'Please ensure each Show Time has a Start Date, End Date, and at least one Ticket Type');
            hasErrors = true;
        }
    }

    updateSaveButtonState();
    return !hasErrors;
}

// Kiểm tra Tab 3 (Payment Information)
function isPaymentInfoValid() {
    const bankName = document.getElementById('bank').value;
    const bankAccount = document.querySelector('input[name="bankAccount"]').value.trim();
    const accountHolder = document.querySelector('input[name="accountHolder"]').value.trim();

    let hasErrors = false;

    if (!bankName) {
        showError('bank', 'Bank Name is required');
        hasErrors = true;
    } else {
        clearError('bank');
    }

    if (!bankAccount) {
        showError('bankAccount', 'Bank Account is required');
        hasErrors = true;
    } else {
        clearError('bankAccount');
    }

    if (!accountHolder) {
        showError('accountHolder', 'Account Holder is required');
        hasErrors = true;
    } else {
        clearError('accountHolder');
    }

    updateSaveButtonState();
    return !hasErrors;
}

// Toggle Seat Section Display
function toggleEventType() {
    const eventType = document.getElementById('eventType').value;
    const seatSection = document.getElementById('seatSection');
    seatSection.classList.toggle('hidden', eventType !== 'Seating Event');
    if (eventType === 'Seating Event') {
        calculateSeatSummary();
    }
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
    const seatsByRow = {}; // Object để lưu thông tin ghế: { "A": { seatNum: 10, ticketTypeName: "" }, ... }

    if (!seatRows.length) {
        seatSummary.innerHTML = 'Total Rows: 0, Total Columns: 0, Total Seats: 0';
        return seatsByRow;
    }

    for (let i = 0; i < seatRows.length; i++) {
        const row = seatRows[i].value.trim().toUpperCase();
        const seatNum = parseInt(seatNumbers[i].value.trim());
        if (row && !isNaN(seatNum) && seatNum > 0) {
            if (seatNum > 16) {
                showSeatError(`Row ${row} exceeds maximum 16 seats per row.`);
                return {};
            }
            if (seatsByRow[row]) {
                showSeatError(`Duplicate row ${row} detected! Each row must be unique.`);
                return {};
            }
            rowCount++;
            totalSeats += seatNum;
            seatsByRow[row] = { seatNum: seatNum, ticketTypeName: '' }; // Lưu số ghế thực tế và để trống ticketTypeName, sẽ gán sau
            maxSeatsPerRow = Math.max(maxSeatsPerRow, seatNum);
        }
    }

    if (rowCount > 26) {
        showSeatError('Maximum 26 rows allowed (A-Z).');
        return {};
    }

    if (totalSeats > 461) {
        showSeatError('Total seats cannot exceed 461.');
        return {};
    }

    clearSeatError();
    seatSummary.innerHTML = `Total Rows: ${rowCount}, Total Columns: ${maxSeatsPerRow}, Total Seats: ${totalSeats}`;
    return seatsByRow; // Trả về { "A": { seatNum: 10, ticketTypeName: "" }, "B": { seatNum: 16, ticketTypeName: "" }, "C": { seatNum: 15, ticketTypeName: "" } }
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
    if (!showTime) {
        console.error('No .show-time element found for input:', input);
        return;
    }

    const labelSpan = showTime.querySelector('.show-time-label');
    if (!labelSpan) {
        console.error('No .show-time-label element found in .show-time:', showTime);
        return;
    }

    const showTimeIndex = labelSpan.textContent.match(/\d+/) ? labelSpan.textContent.match(/\d+/)[0] : '1'; // Default to 1 if not matched
    const startDateInput = showTime.querySelector('input[name="showStartDate"]');
    const endDateInput = showTime.querySelector('input[name="showEndDate"]');
    const details = showTime.querySelector('.show-time-details');

    // Validate time immediately
    if (!validateDateTime(input)) {
        return;
    }

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
    const icon = button.querySelector('i');
    const ticketList = showTime.querySelector('.space-y-2'); // Lấy danh sách ticket types

    // Tính toán chiều cao chính xác, bao gồm padding, margin, border, và các ticket types
    let contentHeight = 0;
    const style = window.getComputedStyle(details);
    const paddingTop = parseFloat(style.paddingTop);
    const paddingBottom = parseFloat(style.paddingBottom);
    const marginTop = parseFloat(style.marginTop);
    const marginBottom = parseFloat(style.marginBottom);
    const borderTop = parseFloat(style.borderTopWidth);
    const borderBottom = parseFloat(style.borderBottomWidth);

    // Tính chiều cao của các phần tử con (Start Date, End Date, và ticket types)
    const gridHeight = details.querySelector('.grid').scrollHeight; // Chiều cao của grid (Start/End Date)
    contentHeight += gridHeight;

    if (ticketList) {
        const tickets = ticketList.querySelectorAll('.saved-ticket');
        tickets.forEach(ticket => {
            contentHeight += ticket.scrollHeight; // Cộng chiều cao của mỗi ticket
            const ticketStyle = window.getComputedStyle(ticket);
            const ticketMarginTop = parseFloat(ticketStyle.marginTop);
            const ticketMarginBottom = parseFloat(ticketStyle.marginBottom);
            contentHeight += ticketMarginTop + ticketMarginBottom; // Cộng margin của ticket
        });
    }

    contentHeight += paddingTop + paddingBottom + marginTop + marginBottom + borderTop + borderBottom;

    if (!details.classList.contains('collapsed')) {
        details.style.height = `${contentHeight}px`; // Đặt chiều cao ban đầu
    }

    details.classList.toggle('collapsed');
    icon.classList.toggle('fa-chevron-down');
    icon.classList.toggle('fa-chevron-up');

    let showTimeIndex = '1';
    if (labelSpan && labelSpan.textContent) {
        const match = labelSpan.textContent.match(/\d+/);
        showTimeIndex = match ? match[0] : '1';
    }

    if (details.classList.contains('collapsed')) {
        details.style.height = '0'; // Thu gọn
        const startDateInput = showTime.querySelector('input[name="showStartDate"]');
        const endDateInput = showTime.querySelector('input[name="showEndDate"]');
        const startDate = formatDateTime(startDateInput.value);
        const endDate = formatDateTime(endDateInput.value);
        if (labelSpan) {
            labelSpan.textContent = `Show Time #${showTimeIndex} (${startDate} - ${endDate})`;
        }
    } else {
        if (labelSpan) {
            labelSpan.textContent = `Show Time #${showTimeIndex}`;
        }
        details.style.height = `auto`; // Mở rộng
    }
}

function toggleTicket(button) {
    const ticket = button.closest('.saved-ticket');
    const details = ticket.querySelector('.ticket-details');
    const labelSpan = ticket.querySelector('.ticket-label');
    const ticketName = labelSpan.getAttribute('data-ticket-name');
    const icon = button.querySelector('i');

    // Tính toán chiều cao chính xác, bao gồm padding, margin, và border
    let contentHeight = details.scrollHeight;
    const style = window.getComputedStyle(details);
    const paddingTop = parseFloat(style.paddingTop);
    const paddingBottom = parseFloat(style.paddingBottom);
    const marginTop = parseFloat(style.marginTop);
    const marginBottom = parseFloat(style.marginBottom);
    const borderTop = parseFloat(style.borderTopWidth);
    const borderBottom = parseFloat(style.borderBottomWidth);

    contentHeight += paddingTop + paddingBottom + marginTop + marginBottom + borderTop + borderBottom;

    if (!details.classList.contains('collapsed')) {
        details.style.height = `${contentHeight}px`; // Đặt chiều cao ban đầu
    }

    details.classList.toggle('collapsed');
    icon.classList.toggle('fa-chevron-down');
    icon.classList.toggle('fa-chevron-up');
    labelSpan.textContent = ticketName; // Keep ticket name unchanged

    if (details.classList.contains('collapsed')) {
        details.style.height = '0'; // Thu gọn
    } else {
        details.style.height = `${contentHeight}px`; // Mở rộng
    }
}

// Update addNewShowTime to add input events
function checkShowTimeOverlap(newShowTimeStart, newShowTimeEnd, currentShowTime = null) {
    const showTimes = document.querySelectorAll('.show-time');
    const newStart = new Date(newShowTimeStart);
    const newEnd = new Date(newShowTimeEnd);

    // Kiểm tra nếu newStart hoặc newEnd là NaN (không hợp lệ)
    if (isNaN(newStart.getTime()) || isNaN(newEnd.getTime())) {
        return false; // Trả về false nếu thời gian không hợp lệ
    }

    for (let showTime of showTimes) {
        // Bỏ qua showtime hiện tại nếu được truyền vào
        if (currentShowTime && showTime === currentShowTime) {
            continue;
        }

        const startDate = showTime.querySelector('input[name="showStartDate"]').value;
        const endDate = showTime.querySelector('input[name="showEndDate"]').value;
        if (startDate && endDate) {
            const existingStart = new Date(startDate);
            const existingEnd = new Date(endDate);

            // Kiểm tra nếu existingStart hoặc existingEnd là NaN
            if (isNaN(existingStart.getTime()) || isNaN(existingEnd.getTime())) {
                continue; // Bỏ qua nếu thời gian không hợp lệ
            }

            // Kiểm tra trùng lấn: nếu khoảng thời gian mới giao với khoảng thời gian hiện có
            if (newStart < existingEnd && newEnd > existingStart) {
                return true; // Có trùng lấn
            }
        }
    }
    return false; // Không trùng lấn
}

// Khởi tạo biến showTimeCount
let showTimeCount = 1;
// Hàm cập nhật showTimeCount dựa trên số lượng Show Time hiện có
function updateShowTimeCount() {
    showTimeCount = document.querySelectorAll('.show-time').length;
}
// Cập nhật addNewShowTime
function addNewShowTime() {
    console.log('Adding new showtime, showTimeCount:', showTimeCount);
    if (!showTimeCount || showTimeCount < 1) {
        showTimeCount = 1; // Reset về 1 nếu không hợp lệ
    }
    const showTimeList = document.getElementById('showTimeList');
    const newShowTime = document.createElement('div');
    newShowTime.className = 'show-time bg-gray-800 p-4 rounded';
    showTimeCount++; // Tăng showTimeCount sau khi lấy số lượng hiện tại
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

    // Thêm kiểm tra realtime với sự kiện 'input' thay vì chỉ 'change'
    const startDateInput = newShowTime.querySelector('input[name="showStartDate"]');
    const endDateInput = newShowTime.querySelector('input[name="showEndDate"]');

    const checkOverlap = () => {
        if (startDateInput.value && endDateInput.value) {
            if (checkShowTimeOverlap(startDateInput.value, endDateInput.value, newShowTime)) {
                showError(startDateInput.id, 'This showtime overlaps with another showtime.');
                showError(endDateInput.id, 'This showtime overlaps with another showtime.');
            } else {
                clearError(startDateInput.id);
                clearError(endDateInput.id);
            }
        } else {
            clearError(startDateInput.id);
            clearError(endDateInput.id);
        }
    };

    // Kiểm tra khi nhập hoặc thay đổi dữ liệu
    startDateInput.addEventListener('input', checkOverlap);
    startDateInput.addEventListener('change', checkOverlap);
    endDateInput.addEventListener('input', checkOverlap);
    endDateInput.addEventListener('change', checkOverlap);

    // Attach onchange events for new inputs
    const newInputs = newShowTime.querySelectorAll('input[type="datetime-local"]');
    newInputs.forEach(input => {
        input.addEventListener('input', () => validateDateTime(input)); // Validate on input
        input.addEventListener('change', () => updateShowTimeLabel(input)); // Update label on change
    });

    // Cập nhật lại nhãn của tất cả Show Time
    updateShowTimeLabels();
}

// Cập nhật removeShowTime
function removeShowTime(button) {
    button.closest('.show-time').remove();
    updateShowTimeCount(); // Cập nhật showTimeCount dựa trên số lượng còn lại
    updateShowTimeLabels(); // Cập nhật lại nhãn theo thứ tự mới
}

// Cập nhật updateShowTimeLabels
function updateShowTimeLabels() {
    const showTimes = document.querySelectorAll('.show-time');
    showTimes.forEach((showTime, index) => {
        const labelSpan = showTime.querySelector('.show-time-label');
        const details = showTime.querySelector('.show-time-details');
        if (labelSpan) {
            const newIndex = index + 1; // Tái lập thứ tự từ 1
            if (details.classList.contains('collapsed')) {
                const startDateInput = showTime.querySelector('input[name="showStartDate"]');
                const endDateInput = showTime.querySelector('input[name="showEndDate"]');
                const startDate = formatDateTime(startDateInput.value);
                const endDate = formatDateTime(endDateInput.value);
                labelSpan.textContent = `Show Time #${newIndex} (${startDate} - ${endDate})`;
            } else {
                labelSpan.textContent = `Show Time #${newIndex}`;
            }
            // Cập nhật các id để đồng bộ với chỉ số mới
            const startDateInput = showTime.querySelector('input[name="showStartDate"]');
            const endDateInput = showTime.querySelector('input[name="showEndDate"]');
            const ticketList = showTime.querySelector('.space-y-2');
            const addTicketButton = showTime.querySelector('button[data-show-time]');
            if (startDateInput) startDateInput.id = `showStartDate_${newIndex}`;
            if (endDateInput) endDateInput.id = `showEndDate_${newIndex}`;
            if (ticketList) ticketList.id = `ticketList_${newIndex}`;
            if (addTicketButton) addTicketButton.setAttribute('data-show-time', newIndex);
        }
    });
}

// Open Modal
// Open Modal with Real-Time Validation
function openModal(button) {
    const modal = document.getElementById('newTicketModal');
    modal.setAttribute('data-show-time', button.getAttribute('data-show-time'));
    modal.classList.remove('hidden');
    
    // Clear previous errors
    ['modalTicketName', 'modalTicketDescription', 'modalTicketPrice', 'modalTicketQuantity', 'modalTicketColor'].forEach(clearError);
    
    const eventType = document.getElementById('eventType').value;
    const seatSelectionDiv = document.getElementById('seatSelection');

    if (eventType === 'Seating Event') {
        const seatsByRow = calculateSeatSummary();
        let seatOptions = '<label class="block text-gray-300 mb-2">Select Seat Rows (VIP: A, B; Normal: C):</label>';
        const ticketNameInput = document.getElementById('modalTicketName');
        const showTimeId = button.getAttribute('data-show-time');
        const ticketList = document.getElementById(`ticketList_${showTimeId}`);
        const usedRows = new Set();

        ticketList.querySelectorAll('.saved-ticket').forEach(ticket => {
            const rowsText = (ticket.querySelector('.ticket-details div:nth-child(5) span') 
                ? ticket.querySelector('.ticket-details div:nth-child(5) span').textContent 
                : '') || '';
            rowsText.split(', ').forEach(row => {
                const rowName = row.split(' ')[0];
                usedRows.add(rowName);
            });
        });

        for (let row in seatsByRow) {
            const isDisabled = usedRows.has(row) ? 'disabled' : '';
            let isVisible = !usedRows.has(row);
            if (isVisible) {
                let isAllowed = true;
                const ticketName = ticketNameInput.value.toLowerCase();
                if (ticketName.includes('vip') && (row !== 'A' && row !== 'B')) {
                    isAllowed = false;
                } else if (ticketName.includes('normal') && row !== 'C') {
                    isAllowed = false;
                }
                if (isAllowed) {
                    const seatNum = seatsByRow[row].seatNum.toString();
                    seatOptions += `
                        <div>
                            <input type="checkbox" name="selectedSeats" value="${row}" data-seats="${seatNum}" ${isDisabled}>
                            <label class="text-gray-300 ml-2">Row ${row} (${seatNum} seats)</label>
                        </div>`;
                }
            }
        }
        seatSelectionDiv.innerHTML = seatOptions;

        seatSelectionDiv.querySelectorAll('input[name="selectedSeats"]').forEach(checkbox => {
            checkbox.addEventListener('change', validateSeatSelection);
        });
    } else {
        seatSelectionDiv.innerHTML = '';
    }

    const colorInput = document.getElementById('modalTicketColor');
    const colorValueSpan = document.getElementById('colorValue');
    colorValueSpan.textContent = colorInput.value.toUpperCase();

    // Add real-time validation for modal inputs
    const inputs = {
        modalTicketName: (value) => value.trim() ? '' : 'Ticket name is required',
        modalTicketDescription: (value) => value.trim() ? '' : 'Description is required',
        modalTicketPrice: (value) => value.trim() && !isNaN(value) && parseFloat(value) >= 0 ? '' : 'Price is required and must be a valid number',
        modalTicketQuantity: (value) => value && !isNaN(value) && parseInt(value) > 0 ? '' : 'Quantity is required and must be greater than 0',
        modalTicketColor: (value) => value ? '' : 'Color is required'
    };

    Object.keys(inputs).forEach(id => {
        const input = document.getElementById(id);
        const validateInput = () => {
            const errorMessage = inputs[id](input.value);
            if (errorMessage) {
                showError(id, errorMessage);
            } else {
                clearError(id);
            }
            updateSaveButtonState();
        };
        input.addEventListener('input', validateInput);
        // Initial validation
        validateInput();
    });

    updateSaveButtonState();
}

function validateSeatSelection() {
    const selectedSeats = document.querySelectorAll('#seatSelection input[name="selectedSeats"]:checked');
    const ticketQuantity = parseInt(document.getElementById('modalTicketQuantity').value) || 0;
    const modal = document.getElementById('newTicketModal');
    const showTimeId = modal.getAttribute('data-show-time');
    const ticketList = document.getElementById(`ticketList_${showTimeId}`);
    const isEditing = modal.hasAttribute('data-editing-ticket');
    const editingTicketName = modal.getAttribute('data-editing-ticket');

    // Lấy danh sách ghế đã được sử dụng trong showtime
    const usedRows = new Set();
    ticketList.querySelectorAll('.saved-ticket').forEach(ticket => {
        const ticketName = ticket.querySelector('.ticket-label').getAttribute('data-ticket-name');
        if (isEditing && ticketName === editingTicketName) {
            // Bỏ qua vé đang chỉnh sửa để không báo lỗi ghế của chính nó
            return;
        }
        const rowsText = (ticket.querySelector('.ticket-details div:nth-child(5) span') 
            ? ticket.querySelector('.ticket-details div:nth-child(5) span').textContent 
            : '') || '';
        rowsText.split(', ').forEach(row => {
            const rowName = row.split(' ')[0]; // Lấy row (e.g., "A" từ "A 16")
            usedRows.add(rowName);
        });
    });

    let totalAvailableSeats = 0;
    let hasDuplicate = false;

    selectedSeats.forEach(checkbox => {
        const row = checkbox.value;
        if (usedRows.has(row)) {
            hasDuplicate = true;
        }
        totalAvailableSeats += parseInt(checkbox.dataset.seats);
    });

    const errorElement = document.getElementById('modalTicketQuantity_error');
    if (hasDuplicate) {
        showError('modalTicketQuantity', 'One or more selected seats are already assigned to another ticket in this showtime.');
    } else if (ticketQuantity > totalAvailableSeats) {
        showError('modalTicketQuantity', 'Total tickets must be less than or equal to the total number of selected seats.');
    } else {
        clearError('modalTicketQuantity');
    }
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
    document.getElementById('modalTicketColor').value = '#000000';
    document.getElementById('colorValue').textContent = '#000000';
    clearAllErrors(); // Xóa tất cả lỗi khi đóng modal
}

// Save New Ticket
// Trong saveNewTicket, thay đổi cách tạo selectedSeatsText
// Save New Ticket with Proper Error Handling
async function saveNewTicket() {
    const modal = document.getElementById('newTicketModal');
    const showTimeId = modal.getAttribute('data-show-time');
    const isEditing = modal.hasAttribute('data-editing-ticket');
    const editingTicketName = modal.getAttribute('data-editing-ticket');
    const ticketName = document.getElementById('modalTicketName').value.trim();
    const ticketDescription = document.getElementById('modalTicketDescription').value.trim();
    const ticketPrice = document.getElementById('modalTicketPrice').value.trim();
    const ticketQuantity = parseInt(document.getElementById('modalTicketQuantity').value) || 0;
    const ticketColor = document.getElementById('modalTicketColor').value;
    const eventType = document.getElementById('eventType').value;
    const showTime = document.getElementById(`ticketList_${showTimeId}`).closest('.show-time');
    const showStartDate = showTime.querySelector('input[name="showStartDate"]').value;
    const showEndDate = showTime.querySelector('input[name="showEndDate"]').value;

    let hasErrors = false;

    // Validate inputs
    if (!ticketName) {
        showError('modalTicketName', 'Ticket name is required');
        hasErrors = true;
    } else {
        clearError('modalTicketName');
    }

    if (!ticketDescription) {
        showError('modalTicketDescription', 'Description is required');
        hasErrors = true;
    } else {
        clearError('modalTicketDescription');
    }

    if (!ticketPrice || isNaN(ticketPrice) || parseFloat(ticketPrice) < 0) {
        showError('modalTicketPrice', 'Price is required and must be a valid number');
        hasErrors = true;
    } else {
        clearError('modalTicketPrice');
    }

    if (!ticketQuantity || ticketQuantity <= 0) {
        showError('modalTicketQuantity', 'Quantity is required and must be greater than 0');
        hasErrors = true;
    } else {
        clearError('modalTicketQuantity');
    }

    if (!ticketColor) {
        showError('modalTicketColor', 'Color is required');
        hasErrors = true;
    } else {
        clearError('modalTicketColor');
    }

    if (!showStartDate) {
        showError(`showStartDate_${showTimeId}`, 'Show start date is required');
        hasErrors = true;
    } else {
        clearError(`showStartDate_${showTimeId}`);
    }

    if (!showEndDate) {
        showError(`showEndDate_${showTimeId}`, 'Show end date is required');
        hasErrors = true;
    } else {
        clearError(`showEndDate_${showTimeId}`);
    }

    if (hasErrors) {
        updateSaveButtonState();
        return;
    }

    const ticketList = document.getElementById(`ticketList_${showTimeId}`);
    const colorName = await getColorNameFromAPI(ticketColor);
   // Trong saveNewTicket, sửa phần tạo selectedSeatsText:
    let selectedSeatsText = '';
    let totalSeats = 0;

    if (eventType === 'Seating Event') {
        const selectedSeats = document.querySelectorAll('#seatSelection input[name="selectedSeats"]:checked');
        const seatsArray = Array.from(selectedSeats).map(checkbox => {
            const seatRow = checkbox.value;
            const seatCol = checkbox.dataset.seats; // Lấy số ghế thực tế từ data-seats (e.g., "10", "16", "15")
            return `${seatRow} ${seatCol}`; // Tạo chuỗi "A 10", "B 16", "C 15"
        });
        selectedSeatsText = seatsArray.join(', ');

        if (!selectedSeatsText) {
            showError('modalTicketQuantity', 'Please select at least one seat row.');
            updateSaveButtonState();
            return;
        }

        totalSeats = Array.from(selectedSeats).reduce((sum, checkbox) => sum + parseInt(checkbox.dataset.seats), 0);
        if (ticketQuantity > totalSeats) {
            showError('modalTicketQuantity', 'Total tickets must be less than or equal to the total number of selected seats.');
            updateSaveButtonState();
            return;
        }
        clearError('modalTicketQuantity');
    }

    const ticketHTML = `
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
                <div><label>Color:</label> <span style="color: ${ticketColor}">${ticketColor}</span> <span>(${colorName})</span></div>
                ${selectedSeatsText ? `<div><label>Seats:</label> <span>${selectedSeatsText}</span></div>` : ''}
            </div>
        </div>
    `;

    if (isEditing) {
        const tickets = ticketList.querySelectorAll('.saved-ticket');
        for (let ticket of tickets) {
            if (ticket.querySelector('.ticket-label').getAttribute('data-ticket-name') === editingTicketName) {
                ticket.innerHTML = ticketHTML;
                break;
            }
        }
    } else {
        const newTicket = document.createElement('div');
        newTicket.className = 'saved-ticket bg-gray-700 p-3 rounded';
        newTicket.innerHTML = ticketHTML;
        ticketList.appendChild(newTicket);
    }

    modal.removeAttribute('data-editing-ticket');
    modal.querySelector('h5').textContent = 'Create New Ticket Type';
    clearAllErrors();
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
    console.log(ticketDetails.innerHTML);

    // Thiết lập giá trị và kiểm tra lỗi
    try {
        // Lấy tên vé từ thuộc tính data-ticket-name
        document.getElementById('modalTicketName').value = ticket.querySelector('.ticket-label').getAttribute('data-ticket-name');

        // Tìm các div dựa trên nội dung của label
        const allDivs = ticketDetails.querySelectorAll('div');

        // Description
        const descriptionDiv = Array.from(allDivs).find(div => div.querySelector('label') && div.querySelector('label').textContent === 'Description:');
        if (descriptionDiv) {
            document.getElementById('modalTicketDescription').value = descriptionDiv.querySelector('span').textContent;
        }

        // Price (VND)
        const priceDiv = Array.from(allDivs).find(div => div.querySelector('label') && div.querySelector('label').textContent === 'Price (VND):');
        if (priceDiv) {
            console.log('Price:', priceDiv.querySelector('span').textContent);
            document.getElementById('modalTicketPrice').value = priceDiv.querySelector('span').textContent;
        }

        // Quantity
        const quantityDiv = Array.from(allDivs).find(div => div.querySelector('label') && div.querySelector('label').textContent === 'Quantity:');
        if (quantityDiv) {
            console.log('Quantity:', quantityDiv.querySelector('span').textContent);
            document.getElementById('modalTicketQuantity').value = quantityDiv.querySelector('span').textContent;
        }

        // Color
        const colorDiv = Array.from(allDivs).find(div => div.querySelector('label') && div.querySelector('label').textContent === 'Color:');
        if (colorDiv) {
            const colorValue = colorDiv.querySelector('span').textContent;
            document.getElementById('modalTicketColor').value = colorValue;
            document.getElementById('colorValue').textContent = colorValue;
        }

    } catch (e) {
        console.error('Lỗi khi điền dữ liệu vào modal:', e);
    }

    // Xử lý phần chọn ghế
    const eventType = document.getElementById('eventType').value;
    const seatSelectionDiv = document.getElementById('seatSelection');

    if (eventType === 'Seating Event') {
        try {
            const seatsByRow = calculateSeatSummary();
            // Tìm div chứa label "Seats:"
            const seatsDiv = Array.from(ticketDetails.querySelectorAll('div')).find(div => 
                div.querySelector('label') && div.querySelector('label').textContent === 'Seats:'
            );
            const selectedRowsText = seatsDiv ? seatsDiv.querySelector('span').textContent : '';
            const selectedRows = selectedRowsText.split(', ').map(row => row.split(' ')[0]);
            let seatOptions = '<label class="block text-gray-300 mb-2">Select Seat Rows (VIP: A, B; Normal: C):</label>';

            const ticketName = document.getElementById('modalTicketName').value.toLowerCase();
            const ticketList = document.getElementById(`ticketList_${showTimeId}`);
            const usedRows = new Set();
            ticketList.querySelectorAll('.saved-ticket').forEach(otherTicket => {
                const otherTicketName = otherTicket.querySelector('.ticket-label').getAttribute('data-ticket-name');
                if (otherTicketName !== ticket.querySelector('.ticket-label').getAttribute('data-ticket-name')) {
                    const otherSeatsDiv = Array.from(otherTicket.querySelector('.ticket-details').querySelectorAll('div')).find(div => 
                        div.querySelector('label') && div.querySelector('label').textContent === 'Seats:'
                    );
                    const rowsText = otherSeatsDiv ? otherSeatsDiv.querySelector('span').textContent : '';
                    rowsText.split(', ').forEach(row => usedRows.add(row.split(' ')[0]));
                }
            });

            for (let row in seatsByRow) {
                const isDisabled = usedRows.has(row) ? 'disabled' : '';
                let isVisible = !usedRows.has(row);
                if (isVisible) {
                    let isAllowed = true;
                    if (ticketName.includes('vip') && (row !== 'A' && row !== 'B')) {
                        isAllowed = false;
                    } else if (ticketName.includes('normal') && row !== 'C') {
                        isAllowed = false;
                    }
                    if (isAllowed) {
                        const seatNum = seatsByRow[row].seatNum.toString();
                        const isChecked = selectedRows.includes(row) ? 'checked' : '';
                        seatOptions += `
                            <div>
                                <input type="checkbox" name="selectedSeats" value="${row}" data-seats="${seatNum}" ${isDisabled} ${isChecked}>
                                <label class="text-gray-300 ml-2">Row ${row} (${seatNum} seats)</label>
                            </div>`;
                    }
                }
            }
            seatSelectionDiv.innerHTML = seatOptions;

            seatSelectionDiv.querySelectorAll('input[name="selectedSeats"]').forEach(checkbox => {
                checkbox.addEventListener('change', validateSeatSelection);
            });
        } catch (e) {
            console.error('Lỗi khi tạo seatSelection:', e);
        }
    } else {
        seatSelectionDiv.innerHTML = '';
    }

    modal.setAttribute('data-show-time', showTimeId);
    modal.setAttribute('data-editing-ticket', ticket.querySelector('.ticket-label').getAttribute('data-ticket-name'));
    modal.querySelector('h5').textContent = 'Edit Ticket Type';
    modal.classList.remove('hidden');
    clearAllErrors();
}

// Hàm lấy tên màu từ API Color Pizza
async function getColorNameFromAPI(hex) {
    try {
        const cleanHex = hex.replace('#', ''); // Remove '#' from hex code
        const response = await fetch(`https://api.color.pizza/v1/${cleanHex}`);
        const data = await response.json();
        return data.colors[0].name || 'Custom Color'; // Return color name or 'Custom Color' if not found
    } catch (error) {
        console.error('Error fetching color name:', error);
        return 'Custom Color'; // Default value if error occurs
    }
}

// Hiển thị thông báo lỗi
function showError(elementId, message) {
    const errorElement = document.getElementById(`${elementId}_error`);
    if (errorElement) {
        errorElement.textContent = message;
        errorElement.style.display = 'block';
    }
    updateSaveButtonState(); // Cập nhật trạng thái nút Save mỗi khi có lỗi
}

// Xóa thông báo lỗi
function clearError(elementId) {
    const errorElement = document.getElementById(`${elementId}_error`);
    if (errorElement) {
        errorElement.textContent = '';
        errorElement.style.display = 'none';
    }
    updateSaveButtonState(); // Cập nhật trạng thái nút Save mỗi khi xóa lỗi
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

    // Xóa lỗi khi chuyển tab (nếu cần)
    clearAllErrors();

    // Chuyển tab nếu điều kiện thỏa mãn
    document.querySelectorAll('.tab-content').forEach(tab => tab.classList.add('hidden'));
    document.getElementById(tabId).classList.remove('hidden');
    document.querySelectorAll('.tab-button').forEach(btn => btn.classList.remove('bg-green-600'));
    document.querySelector(`button[onclick="showTab('${tabId}')"]`).classList.add('bg-green-600');
}

// Hàm xóa tất cả lỗi
function clearAllErrors() {
    const errorElements = document.querySelectorAll('.error-message');
    errorElements.forEach(error => {
        error.style.display = 'none';
        error.textContent = '';
    });
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
    colorInput.addEventListener('input', async function () {
        const colorValue = this.value.toUpperCase();
        const colorName = await getColorNameFromAPI(colorValue); // Call API to get color name
        document.getElementById('colorValue').textContent = `${colorValue} (${colorName})`; // Display code and name
    });
});

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    const colorInput = document.getElementById('modalTicketColor');
    const colorValueSpan = document.getElementById('colorValue');
    colorInput.addEventListener('input', async function () {
        const colorValue = this.value.toUpperCase();
        const colorName = await getColorNameFromAPI(colorValue); // Call API to get color name
        colorValueSpan.textContent = `${colorValue} (${colorName})`; // Display code and name
    });
    const currentDate = new Date();
    const minDateTime = currentDate.toISOString().slice(0, 16);
    const dateInputs = document.querySelectorAll('input[type="datetime-local"]');
    dateInputs.forEach(input => {
        input.setAttribute('min', minDateTime);
        input.addEventListener('input', () => validateDateTime(input)); // Validate on input
    });
    showTab('event-info');
    loadBanks();
    loadProvinces(); // Load province list
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

// Upload image to cloud
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
    const existingError = preview.parentElement.querySelector('.image-error');
    if (existingError) existingError.remove();
    preview.parentElement.appendChild(errorDiv);
}

// Hàm xóa thông báo lỗi
function clearImageError(elementId) {
    const preview = document.getElementById(elementId);
    const existingError = preview.parentElement.querySelector('.image-error');
    if (existingError) existingError.remove();
}

// Xử lý upload Event Logo
document.getElementById('logoEventInput').addEventListener('change', function (e) {
    const file = e.target.files[0];
    const preview = document.getElementById('logoPreview');
    const img = document.getElementById('logoImage');
    const icon = preview.querySelector('.upload-icon');
    const text = preview.querySelector('.upload-text');
    if (!file) {
        showError('logoEvent', 'Event Logo is required');
        return;
    }

    // Check size (720x958)
    checkImageDimensions(file, 720, 958, async (isValid, errorMessage) => {
        if (!isValid) {
            showError('logoEvent', errorMessage);
            this.value = ''; // Clear selected file
            img.classList.add('hidden');
            if (icon) icon.classList.remove('hidden');
            if (text) text.classList.remove('hidden');
            return;
        }

        clearImageError('logoPreview');
        clearError('logoEvent'); // Clear the validation error
        const formData = new FormData();
        formData.append("file", file);
        formData.append("upload_preset", "event_upload");
        formData.append("folder", "event_logos");
        try {
            const response = await fetch(
                "https://api.cloudinary.com/v1_1/dnvpphtov/image/upload",
                { method: "POST", body: formData }
            );
            const data = await response.json();
            if (data.secure_url) {
                img.src = data.secure_url;
                img.classList.remove('hidden');
                if (icon) icon.classList.add('hidden');
                if (text) text.classList.add('hidden');
                this.dataset.url = data.secure_url;
                clearError('logoEvent'); // Ensure error is cleared after successful upload
            } else {
                throw new Error("Upload failed");
            }
        } catch (error) {
            console.error("Error uploading Event Logo:", error);
            showError('logoEvent', 'Upload failed. Please try again.');
            this.value = ''; // Clear file if upload fails
            img.classList.add('hidden');
            if (icon) icon.classList.remove('hidden');
            if (text) text.classList.remove('hidden');
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
    if (!file) {
        showError('backgroundImage', 'Background Image is required');
        return;
    }

    // Check size (1280x720)
    checkImageDimensions(file, 1280, 720, async (isValid, errorMessage) => {
        if (!isValid) {
            showError('backgroundImage', errorMessage);
            this.value = '';
            img.classList.add('hidden');
            if (icon) icon.classList.remove('hidden');
            if (text) text.classList.remove('hidden');
            return;
        }

        clearImageError('backgroundPreview');
        clearError('backgroundImage'); // Clear the validation error
        const formData = new FormData();
        formData.append("file", file);
        formData.append("upload_preset", "event_upload");
        formData.append("folder", "event_backgrounds");
        try {
            const response = await fetch(
                "https://api.cloudinary.com/v1_1/dnvpphtov/image/upload",
                { method: "POST", body: formData }
            );
            const data = await response.json();
            if (data.secure_url) {
                img.src = data.secure_url;
                img.classList.remove('hidden');
                if (icon) icon.classList.add('hidden');
                if (text) text.classList.add('hidden');
                this.dataset.url = data.secure_url;
                clearError('backgroundImage'); // Ensure error is cleared after successful upload
            } else {
                throw new Error("Upload failed");
            }
        } catch (error) {
            console.error("Error uploading Background Image:", error);
            showError('backgroundImage', 'Upload failed. Please try again.');
            this.value = '';
            img.classList.add('hidden');
            if (icon) icon.classList.remove('hidden');
            if (text) text.classList.remove('hidden');
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
    if (!file) {
        showError('organizerLogo', 'Organizer Logo is required');
        return;
    }

    // Check size (275x275)
    checkImageDimensions(file, 275, 275, async (isValid, errorMessage) => {
        if (!isValid) {
            showError('organizerLogo', errorMessage);
            this.value = '';
            img.classList.add('hidden');
            if (icon) icon.classList.remove('hidden');
            if (text) text.classList.remove('hidden');
            return;
        }

        clearImageError('organizerLogoPreview');
        clearError('organizerLogo'); // Clear the validation error
        const formData = new FormData();
        formData.append("file", file);
        formData.append("upload_preset", "event_upload");
        formData.append("folder", "organizer_logos");
        try {
            const response = await fetch(
                "https://api.cloudinary.com/v1_1/dnvpphtov/image/upload",
                { method: "POST", body: formData }
            );
            const data = await response.json();
            if (data.secure_url) {
                img.src = data.secure_url;
                img.classList.remove('hidden');
                if (icon) icon.classList.add('hidden');
                if (text) text.classList.add('hidden');
                this.dataset.url = data.secure_url;
                clearError('organizerLogo'); // Ensure error is cleared after successful upload
            } else {
                throw new Error("Upload failed");
            }
        } catch (error) {
            console.error("Error uploading Organizer Logo:", error);
            showError('organizerLogo', 'Upload failed. Please try again.');
            this.value = '';
            img.classList.add('hidden');
            if (icon) icon.classList.remove('hidden');
            if (text) text.classList.remove('hidden');
        }
    });
});

// Create Event
// Hàm gửi dữ liệu qua AJAX khi nhấn nút "Save" hoặc "Continue"
async function submitEventForm() {
    // Kiểm tra tất cả các tab trước khi gửi
    const isEventInfoValidResult = isEventInfoValid();
    const isTimeLogisticsValidResult = isTimeLogisticsValid();
    const isPaymentInfoValidResult = isPaymentInfoValid();

    if (!isEventInfoValidResult || !isTimeLogisticsValidResult || !isPaymentInfoValidResult) {
        showErrorPopup('Please complete all required fields in all tabs before submitting.');
        return;
    }

    // ... (giữ nguyên phần thu thập dữ liệu và gửi request)
    const eventName = ((document.querySelector('#event-info input[placeholder="Event Name"]') || {}).value || '').trim();
    const customerId = (document.querySelector('#event-info .organizer-row input[name="customerId"]') || {}).value || '';
    const eventCategory = (document.querySelector('#event-info select') || {}).value || '';
    const province = (document.getElementById('province') || {}).value || '';
    const district = (document.getElementById('district') || {}).value || '';
    const ward = (document.getElementById('ward') || {}).value || '';
    const fullAddress = ((document.getElementById('fullAddress') || {}).value || '').trim();
    const eventInfo = ((document.querySelector('#event-info textarea') || {}).value || '').trim();
    const eventLogo = ((document.getElementById('logoEventInput') || {}).dataset || {}).url || '';
    const backgroundImage = ((document.getElementById('backgroundInput') || {}).dataset || {}).url || '';
    const organizerLogo = ((document.getElementById('organizerLogoInput') || {}).dataset || {}).url || '';
    const organizerName = ((document.querySelector('#event-info .organizer-row input[placeholder="Organizer Name"]') || {}).value || '').trim();
    const eventType = (document.getElementById('eventType') || {}).value || '';
    const bankName = (document.getElementById('bank') || {}).value || '';
    const bankAccount = ((document.querySelector('input[name="bankAccount"]') || {}).value || '').trim();
    const accountHolder = ((document.querySelector('input[name="accountHolder"]') || {}).value || '').trim();

    // Collect showTimes
    const showTimes = [];
    const showTimeElements = document.querySelectorAll('.show-time');
    showTimeElements.forEach((showTime) => {
        const startDate = (showTime.querySelector('input[name="showStartDate"]') || {}).value || '';
        const endDate = (showTime.querySelector('input[name="showEndDate"]') || {}).value || '';
        if (startDate && endDate) {
            showTimes.push({
                startDate: formatDateTime(startDate),
                endDate: formatDateTime(endDate),
                status: "Scheduled"
            });
        }
    });

    // Collect ticketTypes with seat information
    const ticketTypes = [];
    const seatAssignments = {}; // Để theo dõi ghế đã được gán cho ticket nào
    showTimeElements.forEach((showTime) => {
        const showTimeId = (showTime.querySelector('input[name="showStartDate"]') || {}).value || '';
        const showEndTime = (showTime.querySelector('input[name="showEndDate"]') || {}).value || '';
        if (showTimeId && showEndTime) {
            const ticketElements = showTime.querySelectorAll('.saved-ticket');
            ticketElements.forEach((ticket) => {
                const ticketName = (ticket.querySelector('.ticket-label') || {}).getAttribute && ticket.querySelector('.ticket-label').getAttribute('data-ticket-name') || '';
                const ticketDescription = (ticket.querySelector('.ticket-details div:nth-child(1) span') || {}).textContent || '';
                const ticketPrice = parseFloat((ticket.querySelector('.ticket-details div:nth-child(2) span') || {}).textContent) || 0;
                const ticketQuantity = parseInt((ticket.querySelector('.ticket-details div:nth-child(3) span') || {}).textContent) || 0;
                const ticketColorSpan = ticket.querySelector('.ticket-details div:nth-child(4) span');
                const ticketColor = (ticketColorSpan && ticketColorSpan.textContent) ? ticketColorSpan.textContent.split(' ')[0] : '#000000';
                const seatsText = (ticket.querySelector('.ticket-details div:nth-child(5) span') || {}).textContent || '';
                const selectedSeats = seatsText.split(', ').map(seat => {
                    const [row, col] = seat.split(' ');
                    return { seatRow: row, seatCol: col };
                });

                // Validation: kiểm tra ghế trùng lặp trong cùng showtime
                selectedSeats.forEach(seat => {
                    const rowKey = `${showTimeId}-${seat.seatRow}`;
                    if (seatAssignments[rowKey]) {
                        console.error(`Row ${seat.seatRow} already assigned to ticket ${seatAssignments[rowKey]} in showtime ${showTimeId}`);
                        throw new Error(`Row ${seat.seatRow} cannot be assigned to multiple tickets in the same showtime.`);
                    }
                    seatAssignments[rowKey] = ticketName;
                });

                ticketTypes.push({
                    showTimeStartDate: formatDateTime(showTimeId),
                    showTimeEndDate: formatDateTime(showEndTime),
                    name: ticketName,
                    description: ticketDescription,
                    price: ticketPrice,
                    color: ticketColor,
                    totalQuantity: ticketQuantity,
                    seats: selectedSeats.length > 0 ? selectedSeats : null
                });
            });
        }
    });

    // Trong hàm submitEventForm, sửa phần tạo seats như sau:
    // Trong submitEventForm, sửa phần tạo seats:
    let seats = [];
    if (eventType === 'Seating Event') {
        const seatsByRow = calculateSeatSummary(); // Lấy thông tin ghế từ calculateSeatSummary
        // Lặp qua từng showtime và ticket type để tạo danh sách ghế đầy đủ
        showTimeElements.forEach((showTime, showTimeIndex) => {
            const ticketElements = showTime.querySelectorAll('.saved-ticket');
            ticketElements.forEach((ticket) => {
                const ticketName = ticket.querySelector('.ticket-label').getAttribute('data-ticket-name') || '';
                const seatsText = (ticket.querySelector('.ticket-details div:nth-child(5) span') && ticket.querySelector('.ticket-details div:nth-child(5) span').textContent) || '';
                const selectedSeats = seatsText.split(', ').map(seat => {
                    const [row, col] = seat.split(' '); // Ví dụ: "A 10" -> row = "A", col = "10"
                    return { seatRow: row, seatCol: col }; // Lấy cả row và col từ giao diện
                });

                // Gán ticketTypeName và seatCol cho mỗi row được chọn trong ticket type này
                selectedSeats.forEach(seat => {
                    if (seatsByRow[seat.seatRow]) {
                        seats.push({
                            ticketTypeName: ticketName, // Sử dụng tên vé thực tế (e.g., "VIP", "Normal")
                            seatRow: seat.seatRow,
                            seatCol: seat.seatCol // Sử dụng số ghế thực tế từ giao diện (e.g., "10", "16", "15")
                        });
                    }
                });
            });
        });
    }

    const eventData = {
        customerId: customerId,
        organizationName: organizerName,
        accountHolder: accountHolder,
        accountNumber: bankAccount,
        bankName: bankName,
        categoryId: parseInt(eventCategory) || 0,
        eventName: eventName,
        location: fullAddress,
        eventType: eventType,
        description: eventInfo,
        status: "Processing",
        eventLogoUrl: eventLogo,
        backgroundImageUrl: backgroundImage,
        organizerImageUrl: organizerLogo,
        showTimes: showTimes,
        ticketTypes: ticketTypes,
        seats: seats.length > 0 ? seats : null
    };

    console.log("Final event data being sent:", JSON.stringify(eventData, null, 2));

    try {
        const response = await fetch('createNewEvent', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(eventData)
        });
        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
        const result = await response.json();
        console.log("Server response:", result);
        if (result.success) {
            console.log("Success detected, showing popup"); // Kiểm tra điều kiện
            showSuccessPopup();
        } else {
            showErrorPopup('Failed to create event: ' + (result.message || 'Unknown error.'));
        }
    } catch (error) {
        console.error('Error submitting event:', error);
        showErrorPopup('An error occurred while submitting the form: ' + error.message);
    }
}

// Validation Account
document.addEventListener('DOMContentLoaded', () => {
    const bankAccountInput = document.querySelector('input[name="bankAccount"]');
    const accountHolderInput = document.querySelector('input[name="accountHolder"]');

    // Kiểm tra Bank Account realtime
    bankAccountInput.addEventListener('input', () => {
        const value = bankAccountInput.value.trim();
        if (!/^\d{8,16}$/.test(value)) {
            showError('bankAccount', 'Bank Account must be 8-16 digits and contain only numbers (0-9).');
        } else {
            clearError('bankAccount');
        }
        updateSaveButtonState();
    });

    // Kiểm tra Account Holder realtime
    accountHolderInput.addEventListener('input', () => {
        const value = accountHolderInput.value.trim();
        if (!/^[a-zA-Z\s.-]{2,}$/.test(value)) {
            showError('accountHolder', 'Account Holder must contain only letters, spaces, and allowed special characters (e.g., ".", "-"), and be at least 2 characters long.');
        } else {
            clearError('accountHolder');
        }
        updateSaveButtonState();
    });
});
// Validation tab event information
document.addEventListener('DOMContentLoaded', () => {
    // Event Name
    const eventNameInput = document.querySelector('#event-info input[placeholder="Event Name"]');
    eventNameInput.addEventListener('input', () => {
        if (eventNameInput.value.trim()) {
            clearError('eventName');
        } else {
            showError('eventName', 'Event Name is required');
        }
    });

    // Event Category
    const eventCategorySelect = document.querySelector('#event-info select');
    eventCategorySelect.addEventListener('input', () => {
        if (eventCategorySelect.value) {
            clearError('eventCategory');
        } else {
            showError('eventCategory', 'Event Category is required');
        }
    });

    // Province
    const provinceSelect = document.getElementById('province');
    provinceSelect.addEventListener('input', () => {
        if (provinceSelect.value) {
            clearError('province');
        } else {
            showError('province', 'Province/City is required');
        }
    });

    // District
    const districtSelect = document.getElementById('district');
    districtSelect.addEventListener('input', () => {
        if (districtSelect.value) {
            clearError('district');
        } else {
            showError('district', 'District is required');
        }
    });

    // Ward
    const wardSelect = document.getElementById('ward');
    wardSelect.addEventListener('input', () => {
        if (wardSelect.value) {
            clearError('ward');
        } else {
            showError('ward', 'Ward is required');
        }
    });

    // Full Address
    const fullAddressInput = document.getElementById('fullAddress');
    fullAddressInput.addEventListener('input', () => {
        if (fullAddressInput.value.trim()) {
            clearError('fullAddress');
        } else {
            showError('fullAddress', 'Full Address is required');
        }
    });

    // Event Info
    const eventInfoTextarea = document.querySelector('#event-info textarea');
    eventInfoTextarea.addEventListener('input', () => {
        if (eventInfoTextarea.value.trim()) {
            clearError('eventInfo');
        } else {
            showError('eventInfo', 'Event Information is required');
        }
    });

    // Organizer Name
    const organizerNameInput = document.querySelector('#event-info .organizer-row input[placeholder="Organizer Name"]');
    organizerNameInput.addEventListener('input', () => {
        if (organizerNameInput.value.trim()) {
            clearError('organizerName');
        } else {
            showError('organizerName', 'Organizer Name is required');
        }
    });

    // Logo, Background, Organizer Logo (kiểm tra qua sự kiện change của input file)
    const logoEventInput = document.getElementById('logoEventInput');
    logoEventInput.addEventListener('change', () => {
        if (logoEventInput.dataset.url) {
            clearError('logoEvent');
        } else {
            showError('logoEvent', 'Event Logo is required');
        }
    });

    const backgroundInput = document.getElementById('backgroundInput');
    backgroundInput.addEventListener('change', () => {
        if (backgroundInput.dataset.url) {
            clearError('backgroundImage');
        } else {
            showError('backgroundImage', 'Background Image is required');
        }
    });

    const organizerLogoInput = document.getElementById('organizerLogoInput');
    organizerLogoInput.addEventListener('change', () => {
        if (organizerLogoInput.dataset.url) {
            clearError('organizerLogo');
        } else {
            showError('organizerLogo', 'Organizer Logo is required');
        }
    });
});
// Time & Logistics
document.addEventListener('DOMContentLoaded', () => {
    // Event Type
    const eventTypeSelect = document.getElementById('eventType');
    eventTypeSelect.addEventListener('input', () => {
        if (eventTypeSelect.value) {
            clearError('eventType');
        } else {
            showError('eventType', 'Type of Event is required');
        }
    });

    // Cập nhật showTimeCount và nhãn ban đầu
    updateShowTimeCount();
    updateShowTimeLabels(); 
    // Show Time Date Inputs
    const showTimeInputs = document.querySelectorAll('input[type="datetime-local"]');
    showTimeInputs.forEach(input => {
        input.addEventListener('input', () => {
            validateDateTime(input); // Hàm này đã có logic kiểm tra và xóa lỗi
        });
    });
    
    const defaultShowTimeInputs = document.querySelectorAll('#showTimeList input[type="datetime-local"]');
    defaultShowTimeInputs.forEach(input => {
        input.addEventListener('input', () => validateDateTime(input));
        input.addEventListener('change', () => updateShowTimeLabel(input));
    });
});
// pop -up
// Hiển thị popup thành công
function showSuccessPopup() {
    const popup = document.getElementById('successPopup');
    popup.classList.add('show');
}
// Đóng popup thành công
function closeSuccessPopup() {
    const popup = document.getElementById('successPopup');
    popup.classList.remove('show');
    // Chuyển hướng sau khi đóng popup
    window.location.href = 'OrganizerEventController?success=true';
}

// Hàm hiển thị popup lỗi (tùy chọn, nếu muốn thống nhất giao diện)
function showErrorPopup(message) {
    const popup = document.createElement('div');
    popup.id = 'errorPopup';
    popup.className = 'fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50';
    popup.innerHTML = `
<div class="bg-gray-800 rounded-lg p-6 max-w-sm w-full text-center">
    <div class="flex justify-center mb-4">
        <i class="fas fa-exclamation-circle text-red-500 text-4xl"></i>
    </div>
    <h3 class="text-xl font-bold text-white mb-2">Error</h3>
    <p class="text-gray-300 mb-4">${message}</p>
    <button class="bg-red-500 text-white px-4 py-2 rounded hover:bg-red-600 transition duration-200" onclick="this.closest('#errorPopup').remove()">OK</button>
</div>
`;
    document.body.appendChild(popup);
}
// Hiển thị popup lỗi với thông điệp tùy chỉnh
function showErrorPopup(message) {
    const popup = document.getElementById('errorPopup');
    const errorMessage = document.getElementById('errorMessage');
    errorMessage.textContent = message; // Cập nhật nội dung thông điệp lỗi
    popup.classList.add('show');
    console.log("Showing error popup with message:", message); // Log để kiểm tra
}
// Đóng popup lỗi
function closeErrorPopup() {
    const popup = document.getElementById('errorPopup');
    popup.classList.remove('show');
    console.log("Error popup closed"); // Log để kiểm tra
}