/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */

/* Large Event */
// Lấy tất cả các carousel trong trang
const carousels = document.querySelectorAll(".carousel-large_events");
// Lặp qua từng carousel để thêm logic hoạt động
carousels.forEach((carousel, index) => {
    const slides = carousel.querySelector(".slides-large_events");
    const eventCards = carousel.querySelectorAll(".event-card-large_events");
    const prevButton = carousel.querySelector(".prev-large_events");
    const nextButton = carousel.querySelector(".next-large_events");

    let currentIndex = 0;
    const totalSlides = eventCards.length;

    // Hàm cập nhật vị trí slide
    function updateSlide(index) {
        slides.style.transform = `translateX(-${index * 100}%)`;
    }

    // Hàm tự động chuyển slide
    function autoSlide() {
        currentIndex = (currentIndex + 1) % totalSlides;
        updateSlide(currentIndex);
    }

    // Xử lý sự kiện nút "Next"
    nextButton.addEventListener("click", () => {
        currentIndex = (currentIndex + 1) % totalSlides;
        updateSlide(currentIndex);
    });

    // Xử lý sự kiện nút "Previous"
    prevButton.addEventListener("click", () => {
        currentIndex = (currentIndex - 1 + totalSlides) % totalSlides;
        updateSlide(currentIndex);
    });

    // Tự động chuyển slide với thời gian riêng biệt cho từng carousel
    let slideInterval = setInterval(autoSlide, 2000 + index * 1000); // Thời gian khác nhau cho mỗi carousel
});
// Đảm bảo nút luôn căn giữa hình ảnh
window.addEventListener("resize", () => {
    const carousels = document.querySelectorAll(".carousel-large_events");
    carousels.forEach((carousel) => {
        const slides = carousel.querySelector(".slides-large_events");
        const eventCard = carousel.querySelector(".event-card-large_events img");
        const prevButton = carousel.querySelector(".prev-large_events");
        const nextButton = carousel.querySelector(".next-large_events");

        if (eventCard) {
            const cardHeight = eventCard.clientHeight; // Lấy chiều cao ảnh
            prevButton.style.top = `${cardHeight / 2}px`; // Căn giữa nút trái
            nextButton.style.top = `${cardHeight / 2}px`; // Căn giữa nút phải
        }
    });
});

// Nagipation
let currentPage = 1;
const pageSize = 20;

function loadEvents(page) {
    $.ajax({
        url: "event",
        type: "POST",
        data: {page: page},
        dataType: "json",
        success: function (data) {
            $("#event-container").empty();
            data.events.forEach(event => {
                let eventHTML = `
                    <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                        <div class="event-card">
                            <a>${event.name}</a> <!-- Hiển thị tên sự kiện từ JSON -->
                        </div>
                    </div>
                `;
                $("#event-container").append(eventHTML);
            });
            updatePagination(data.currentPage, data.totalPages);
        },
        error: function (xhr, status, error) {
            console.log("Lỗi AJAX: ", status, error); // Ghi log lỗi nếu có
        }
    });
}

function updatePagination(currentPage, totalPages) {
    let paginationHTML = `
        <button onclick="changePage(1)">First</button>
        <button onclick="changePage(${Math.max(1, currentPage - 1)})">Prev</button>
        <span>Page ${currentPage} of ${totalPages}</span>
        <button onclick="changePage(${Math.min(totalPages, currentPage + 1)})">Next</button>
        <button onclick="changePage(${totalPages})">Last</button>
    `;
    $("#pagination").html(paginationHTML);
}

function changePage(page) {
    currentPage = page;
    loadEvents(page);
}

$(document).ready(function () {
    loadEvents(1);
});