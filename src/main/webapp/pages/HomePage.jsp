<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Tickìy</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet"/>
        <style>
            body {
                font-family: 'Roboto', sans-serif;
            }
        </style>
    </head>
    <body class="bg-gray-900 text-white">
        <header class="flex items-center justify-between p-4">
            <!-- Logo -->
            <div class="flex items-center">
                <a href="/" class="transform transition-transform duration-200 hover:scale-105">
                    <img alt="ticketbox logo" class="h-10" src="https://storage.googleapis.com/a1aa/image/3KLpBZ87pkun2JI6uakWUNX-_dKu4-ZtDrC_gdQU3Do.jpg" width="100"/>
                </a>
            </div>
            <!-- Search Bar -->
            <div class="flex items-center bg-white rounded-full px-4 py-2 flex-grow max-w-lg mx-4 shadow-md transition-shadow duration-200 hover:shadow-lg">
                <i class="fas fa-search text-gray-500"></i>
                <input class="ml-2 outline-none flex-grow text-gray-700 focus:ring-2 focus:ring-blue-500" placeholder="What are you looking for today?" type="text"/>
                <button class="ml-4 text-gray-500 transform transition-transform duration-200 hover:scale-105 active:scale-95">Search</button>
            </div>
            <!-- Action Buttons -->
            <div class="flex items-center space-x-4">
                <a href="createEvent.jsp" class="text-white border border-white rounded-full px-4 py-2 transform transition-transform duration-200 hover:scale-105 active:scale-95">Create Event</a>
                <a href="myTickets.jsp" class="text-white flex items-center transform transition-transform duration-200 hover:scale-105 active:scale-95">
                    <i class="fas fa-ticket-alt mr-2"></i> My Tickets
                </a>
                <a href="login.jsp" class="text-white transform transition-transform duration-200 hover:scale-105 active:scale-95">Login | Sign Up</a>
                <div class="relative">
                    <button class="flex items-center transform transition-transform duration-200 hover:scale-105 active:scale-95">
                        <img alt="Language flag" class="w-5 h-5 rounded-full" src="https://storage.googleapis.com/a1aa/image/T7jJ6DT748OOj_ebUDjE49aGBfnzZfUQX-5R0sBBS9A.jpg" width="20"/>
                        <i class="fas fa-caret-down text-white ml-1"></i>
                    </button>
                </div>
            </div>
        </header>

        <!-- Navigation -->
        <div class="bg-black p-4">
            <nav class="flex justify-center space-x-8">
                <a class="text-white hover:underline transform transition-transform duration-200 hover:scale-105" href="events.jsp?category=music">Music</a>
                <a class="text-white hover:underline transform transition-transform duration-200 hover:scale-105" href="events.jsp?category=theater">Theater & Art</a>
                <a class="text-white hover:underline transform transition-transform duration-200 hover:scale-105" href="events.jsp?category=sport">Sport</a>
                <a class="text-white hover:underline transform transition-transform duration-200 hover:scale-105" href="events.jsp?category=others">Others</a>
            </nav>
        </div>

        <!-- Main Content -->
        <main class="p-4">
            <!-- Special Events -->
            <section class="mb-8">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <i class="fas fa-star text-yellow-500 mr-2"></i> Special Events
                </h2>
                <div class="flex justify-between items-center mb-4">
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95"><</button>
                    <div class="grid grid-cols-5 gap-4 flex-grow">
                        <div>
                            <a href="eventDetail.jsp?eventId=1">
                                <img alt="Special Event 1" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/Y7nif7KJhShNNKcjtaiFqTDocXI6BXtLJaE9S3ya258.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=2">
                                <img alt="Special Event 2" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/OiuOakQw-Wcmiww0UnbxZ0nA-UfSuyND0iMm4FWB-G8.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=3">
                                <img alt="Special Event 3" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/_q6ujNqEnpYYJlf-o4E0lm3CkU2Jrd5EKzX-Kc4LHTY.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=4">
                                <img alt="Special Event 4" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/O49Bo012-rVzAPyoxtdKTExtzZFvihZ0I8XnfChCfVg.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=5">
                                <img alt="Special Event 5" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/-vxVf_lzQId8dhmUTO7vUhJPUcKPiGySPmF8QXSHHfI.jpg"/>
                            </a>
                        </div>
                    </div>
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95">></button>
                </div>
            </section>

            <!-- Trending Events -->
            <section class="mb-8">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <i class="fas fa-fire text-red-500 mr-2"></i> Trending Events
                </h2>
                <div class="flex justify-between items-center mb-4">
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95"><</button>
                    <div class="grid grid-cols-5 gap-4 flex-grow">
                        <div>
                            <a href="eventDetail.jsp?eventId=6">
                                <img alt="Trending Event 1" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/2xQcThqm1_F4gABTxrqnRlTvWGsyfWpN5SaBpP-LTvc.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=7">
                                <img alt="Trending Event 2" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/e3taH-B_V5HVbC3862icCosX6ewcyVDy89qoIDKbqRQ.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=8">
                                <img alt="Trending Event 3" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/mPLCzera3oZ_wtd2nKO7DIaiN2wYS7gqZ9TGWTZkuEM.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=9">
                                <img alt="Trending Event 4" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/_SF5fEa6IQ4_6SJRlqKSalt3miyzrIPSmjc5bOwtj-A.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=10">
                                <img alt="Trending Event 5" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/iKm6UfsqGDofm-u7SnRQP_N2_VfvQW7mDugbcnk2Ig4.jpg"/>
                            </a>
                        </div>
                    </div>
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95">></button>
                </div>
            </section>

            <!-- Top Picks for You -->
            <section class="mb-8">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <i class="fas fa-thumbs-up text-blue-500 mr-2"></i> Top Picks for You
                </h2>
                <div class="flex justify-between items-center mb-4">
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95"><</button>
                    <div class="grid grid-cols-5 gap-4 flex-grow">
                        <div>
                            <a href="eventDetail.jsp?eventId=11">
                                <img alt="Top Pick 1" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/y_r2Vh-9ic7AeJnPF0lGKb7Z5_yWwSAzR5stx1LsWaI.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=12">
                                <img alt="Top Pick 2" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/7AYpMsI-zdwILx6VofPgk9hiOdU3dOqhc5ALGg7J0AA.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=13">
                                <img alt="Top Pick 3" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/lRQpQg0nIKDP_6hFNnfZquaRjL4UHY40w1J7KgJMYyU.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=14">
                                <img alt="Top Pick 4" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/swxULbT0RLg3IKfSGBH-2hqH_dkuZNFJ3nHmL5YaEqc.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=15">
                                <img alt="Top Pick 5" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/EPmJwMvyeasf70ezjtZh54tFtXrpc99QqnT-IBzM1TI.jpg"/>
                            </a>
                        </div>
                    </div>
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95">></button>
                </div>
            </section>

            <!-- This Weekend -->
            <section class="mb-8">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <i class="fas fa-calendar-week text-green-500 mr-2"></i> This Weekend
                </h2>
                <div class="flex justify-between items-center mb-4">
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95"><</button>
                    <div class="grid grid-cols-5 gap-4 flex-grow">
                        <div>
                            <a href="eventDetail.jsp?eventId=16">
                                <img alt="Weekend Event 1" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/fUUqmXq3CSO6uRE64Ulftt3D6T78bD4nVQAgr-Srxuw.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=17">
                                <img alt="Weekend Event 2" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/0zwGV2Z6BZ6HjfJ5M2z4rFKev4sQ7JxGf4d6JDQS_BM.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=18">
                                <img alt="Weekend Event 3" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/beJmloz5HVb0L1_d99DDCP8rh4mFA2Z_XGwwOZcoZvg.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=19">
                                <img alt="Weekend Event 4" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/pz8Rx2NQM4z81ka_V0DY_KLQS7fQavb2SOpLQXHb9EQ.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=20">
                                <img alt="Weekend Event 5" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/FmAbv8dtZ_nd22RzIJnsNF4gAZ-xR2FDuydvN9JpPoA.jpg"/>
                            </a>
                        </div>
                    </div>
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95">></button>
                </div>
            </section>

            <!-- This Month -->
            <section class="mb-8">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <i class="fas fa-calendar-alt text-purple-500 mr-2"></i> This Month
                </h2>
                <div class="flex justify-between items-center mb-4">
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95"><</button>
                    <div class="grid grid-cols-5 gap-4 flex-grow">
                        <div>
                            <a href="eventDetail.jsp?eventId=21">
                                <img alt="Month Event 1" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/Hah9LynWgZYpm_IfVtjSPreWzXmyC0v8UYfhu49yyx0.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=22">
                                <img alt="Month Event 2" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/xonFOcrQ4lOm8vmE-Fg21fV6yaIvbygqicLGbaS8IdM.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=23">
                                <img alt="Month Event 3" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/KC6DW2YzYvDxgK7LaY1TQnpDlys49xqEGkEznDcVyII.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=24">
                                <img alt="Month Event 4" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/0OU9W14lVcDSi9JNGFOU1ZzJu0WCxq73YlMmDdOBQ-k.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=25">
                                <img alt="Month Event 5" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/F0WXTzoGoIdsqpzX5hiM9sM1sQwQWelL6FPd3BHLfqQ.jpg"/>
                            </a>
                        </div>
                    </div>
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95">></button>
                </div>
            </section>

            <!-- Exciting Destinations -->
            <section class="mb-8">
                <h2 class="text-xl font-bold mb-4 flex items-center">
                    <i class="fas fa-map-marker-alt text-orange-500 mr-2"></i> Exciting Destinations
                </h2>
                <div class="flex justify-between items-center mb-4">
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95"><</button>
                    <div class="grid grid-cols-5 gap-4 flex-grow">
                        <div>
                            <a href="eventDetail.jsp?eventId=26">
                                <img alt="Destination 1" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/PSblH9inRbgDlHvMxafoHEIK4qqCqhit4Cp722nqYoo.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=27">
                                <img alt="Destination 2" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/OTjvEm-okduoB1ZInJJVY5pwnDnLmWVfcPP3P7zeQLs.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=28">
                                <img alt="Destination 3" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/lKR4wXS4keInMhlkf_qX2k4qRvZ_WvcoNowTm-5FNf8.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=29">
                                <img alt="Destination 4" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/mxaPE1zAHBWubxLPe2mbyOZst56t8uq1PHnlt9QfY60.jpg"/>
                            </a>
                        </div>
                        <div>
                            <a href="eventDetail.jsp?eventId=30">
                                <img alt="Destination 5" class="w-full h-full object-cover transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/vTjFtLHeRNMZItEMdycVpXrTb9ibdO03g_zW2MRpO4g.jpg"/>
                            </a>
                        </div>
                    </div>
                    <button class="bg-gray-700 p-2 rounded transform transition-transform duration-200 hover:scale-105 active:scale-95">></button>
                </div>
            </section>
        </main>

        <!-- Footer -->
        <footer class="bg-gray-800 p-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-8">
                <div>
                    <h3 class="text-lg font-bold mb-4">Contact Us</h3>
                    <p>Hotline: 1900.6408</p>
                    <p>Email: support@ticketbox.vn</p>
                    <p>Office: 123, 1st Floor, XYZ Building, ABC Street, HCMC</p>
                </div>
                <div>
                    <h3 class="text-lg font-bold mb-4">For Customers</h3>
                    <p>Customer terms of use</p>
                    <p>Privacy policy</p>
                    <p>Refund policy</p>
                </div>
                <div>
                    <h3 class="text-lg font-bold mb-4">For Organizers</h3>
                    <p>Organizer terms of use</p>
                    <p>Organizer privacy policy</p>
                    <p>Organizer refund policy</p>
                </div>
            </div>
            <div class="flex flex-col md:flex-row justify-between items-center">
                <div class="mb-4 md:mb-0">
                    <h3 class="text-lg font-bold mb-4">Subscribe to our hottest events</h3>
                    <input class="p-2 rounded bg-gray-700 text-white focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Your email" type="email"/>
                </div>
                <div class="flex space-x-4">
                    <img alt="Google Play" class="h-8 transform transition-transform duration-200 hover:scale-105" src="https://storage.googleapis.com/a1aa/image/vB_c8L6QsR18dr_QBRg5y1MeUcQ2imhuhSpsloUlJfQ.jpg"/>
                </div>
            </div>
        </footer>
    </body>
</html>