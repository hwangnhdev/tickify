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
            .logo-header img {
                height: 30px;
                cursor: pointer;
                border-radius: 10px;
            }
            .search-bar-header {
                display: flex;
                align-items: center;
                background: white;
                padding: 5px 10px;
                line-height: 10px;
                border-radius: 20px;
            }
            .search-bar-header input {
                border: none;
                outline: none;
                padding: 5px;
                line-height: 10px;
                width: 220px;
                font-size: 14px;
            }
            .search-bar-header button {
                cursor: pointer;
                color: black;
                background-color: white;
                border: none;
                font-size: 14px;
            }
            .user-actions-header {
                display: flex;
                align-items: center;
            }
            .user-actions-header a, .user-actions-header button {
                margin-left: 15px;
                text-decoration: none;
                color: white;
                background: none;
                border: none;
                cursor: pointer;
                font-size: 16px;
            }
            .categories-header {
                background: black;
                padding: 10px 0;
                text-align: center;
            }
            .categories-header a {
                color: white;
                text-decoration: none;
                margin: 0 15px;
                font-size: 16px;
            }
        </style>
    </head>
    <body>
        <header>
            <div class="logo-header">
                <a style="text-decoration: none; color: white;" href="event">
                    <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMOKXV6ymSP4avAusI4_RPe4Q6Tv4K2raW168in8s6w5dn70V42qa9l2y5wxU05gpikA&usqp=CAU" alt="Ticketbox Logo">
                </a>
            </div>
            <div class="search-bar-header">
                <!--Search Event-->
                <form action="allEvents" method="GET">
                    <input type="text" value="${searchQuery != null ? searchQuery : ''}" name="query" placeholder="What are you looking for today?" required>
                    <button type="submit">Search</button>
                </form>
                <!--<button>Search</button>-->
            </div>
            <div class="user-actions-header">
                <button>Create Event</button>
                <button>Purchased Tickets</button>
                <button>Sign In | Register</button>
            </div>
        </header>
        <nav class="categories-header">
            <a style="text-decoration: none; color: white;" href="allEvents?idCatgory=liveMusic">
                Live Music
            </a>
            <a style="text-decoration: none; color: white;" href="allEvents?idCatgory=theaterArts">
                Theater & Arts
            </a>
            <a style="text-decoration: none; color: white;" href="allEvents?idCatgory=sports">
                Sports
            </a>
            <a style="text-decoration: none; color: white;" href="allEvents?idCatgory=concert">
                Concert
            </a>
            <a style="text-decoration: none; color: white;" href="allEvents?idCatgory=technology">
                Technology
            </a>
            <a style="text-decoration: none; color: white;" href="allEvents?idCatgory=comedyShows">
                Comedy Shows
            </a>
        </nav>
    </body>
</html>
