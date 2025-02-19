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
        <style>
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
        </style>
    </head>
    <body>
        <header class="header">
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
        </header>
    </body>
</html>
