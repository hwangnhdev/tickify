<%-- 
    Document   : seatSelection
    Created on : Jan 26, 2025, 12:21:29 PM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seat Selection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .seat {
            width: 40px;
            height: 40px;
            margin: 5px;
            text-align: center;
            line-height: 40px;
            border-radius: 5px;
            cursor: pointer;
        }
        .seat.available {
            background-color: #d4edda; /* Green for available seats */
        }
        .seat.vip {
            background-color: #f8d7da; /* Red for VIP seats */
        }
        .seat.couple {
            background-color: #cce5ff; /* Blue for couple seats */
        }
        .seat.selected {
            border: 3px solid #000;
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <h1 class="text-center mb-4">Seat Selection</h1>
        <div class="row mb-3">
            <div class="col">
                <span class="seat available"></span> Available
                <span class="seat vip"></span> VIP
                <span class="seat couple"></span> Couple
            </div>
        </div>
        <div class="d-flex justify-content-center">
            <div class="d-grid" style="grid-template-columns: repeat(9, 1fr); gap: 5px;">
                <!-- Generate seats dynamically with JavaScript -->
            </div>
        </div>
        <div class="mt-4 text-center">
            <button class="btn btn-primary" id="confirmSelection">Confirm Selection</button>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const seatContainer = document.querySelector('.d-grid');

            const rows = ['A', 'B', 'C', 'D', 'E', 'F'];
            const cols = Array.from({ length: 9 }, (_, i) => i + 1);

            rows.forEach(row => {
                cols.forEach(col => {
                    const seat = document.createElement('div');
                    seat.classList.add('seat', 'available');

                    // Randomly assign seat types
                    const random = Math.random();
                    if (random < 0.2) {
                        seat.classList.replace('available', 'vip');
                    } else if (random < 0.3) {
                        seat.classList.replace('available', 'couple');
                    }

                    seat.textContent = `${row}${col}`;
                    seat.addEventListener('click', () => {
                        seat.classList.toggle('selected');
                    });

                    seatContainer.appendChild(seat);
                });
            });

            document.getElementById('confirmSelection').addEventListener('click', () => {
                const selectedSeats = Array.from(document.querySelectorAll('.seat.selected'))
                    .map(seat => seat.textContent);

                if (selectedSeats.length === 0) {
                    alert('Please select at least one seat.');
                } else {
                    alert(`You have selected: ${selectedSeats.join(', ')}`);
                }
            });
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

