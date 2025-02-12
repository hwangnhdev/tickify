<%-- 
    Document   : header
    Created on : Jan 12, 2025, 2:52:16 AM
    Author     : Nguyen Huy Hoang - CE182102
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>
        <!--        <style>
                    /* Header */
                    .header {
                        background-color: #1dbf73;
                        color: white;
                        padding: 10px 0;
                        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                    }
        
                    .header-container {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                    }
        
                    .logo {
                        font-size: 24px;
                        font-weight: bold;
                        text-transform: uppercase;
                    }
        
                    .nav-menu {
                        list-style: none;
                        display: flex;
                        gap: 20px;
                    }
        
                    .nav-menu li a {
                        color: white;
                        text-decoration: none;
                        font-size: 16px;
                    }
        
                    .header-actions {
                        display: flex;
                        gap: 10px;
                    }
        
                    .search-bar {
                        padding: 8px;
                        border: none;
                        border-radius: 5px;
                    }
        
                    .btn {
                        padding: 8px 15px;
                        background-color: white;
                        color: #1dbf73;
                        border: none;
                        border-radius: 5px;
                        cursor: pointer;
                    }
                </style>-->
        <style>
            body {
                margin: 0;
                font-family: Arial, sans-serif;
            }
            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: #28a745;
                padding: 10px 20px;
                color: white;
            }
            .logo img {
                height: 30px;
                cursor: pointer;
                border-radius: 10px;
            }
            .search-bar {
                display: flex;
                align-items: center;
                background: white;
                padding: 5px 10px;
                border-radius: 20px;
            }
            .search-bar input {
                border: none;
                outline: none;
                padding: 5px;
                width: 220px;
            }
            .search-bar button {
                cursor: pointer;
                color: black;
                background-color: white;
                border: none;
            }
            .user-actions {
                display: flex;
                align-items: center;
            }
            .user-actions a, .user-actions button {
                margin-left: 15px;
                text-decoration: none;
                color: white;
                background: none;
                border: none;
                cursor: pointer;
                font-size: 16px;
            }
            .categories {
                background: black;
                padding: 10px 0;
                text-align: center;
            }
            .categories a {
                color: white;
                text-decoration: none;
                margin: 0 15px;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <!--        <header class="header">
                    <div class="container header-container">
                        <div class="logo">tickify</div>
                        <nav>
                            <ul class="nav-menu">
                                <li><a href="#">Music</a></li>
                                <li><a href="#">Theaters & Art</a></li>
                                <li><a href="#">Sport</a></li>
                                <li><a href="#">Others</a></li>
                            </ul>
                        </nav>
                        <div class="header-actions">
                            <input type="text" placeholder="What are you looking for today?" class="search-bar">
                            <button class="btn">Create Event</button>
                            <button class="btn">My Tickets</button>
                            <button class="btn">My Account</button>
                        </div>
                    </div>
                </header>-->
        <header>
            <div class="logo">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMOKXV6ymSP4avAusI4_RPe4Q6Tv4K2raW168in8s6w5dn70V42qa9l2y5wxU05gpikA&usqp=CAU" alt="Ticketbox Logo">
            </div>
            <div class="search-bar">
                <input type="text" placeholder="What are you looking for today?">
                <button>Search</button>
            </div>
            <div class="user-actions">
                <button>Create Event</button>
                <button>Purchased Tickets</button>
                <button>Sign In | Register</button>
            </div>
        </header>
        <nav class="categories">
            <a href="#">Live Music</a>
            <a href="#">Theater & Arts</a>
            <a href="#">Sports</a>
            <a href="#">Others</a>
        </nav>
    </body>
</html>
