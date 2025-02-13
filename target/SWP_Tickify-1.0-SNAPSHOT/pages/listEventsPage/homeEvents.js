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

    // Dừng tự động chuyển khi rê chuột vào carousel
//                carousel.addEventListener("mouseenter", () => {
//                    clearInterval(slideInterval);
//                });

    // Tiếp tục tự động chuyển khi rê chuột ra ngoài
//                carousel.addEventListener("mouseleave", () => {
//                    slideInterval = setInterval(autoSlide, 2000 + index * 1000);
//                });
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

