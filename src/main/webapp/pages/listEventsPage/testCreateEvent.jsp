<%-- 
    Document   : testCreateEvent
    Created on : Feb 26, 2025, 9:22:00 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create New Event</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
            }
            .form-group {
                margin-bottom: 15px;
            }
            label {
                display: block;
                margin-bottom: 5px;
            }
            input, select, textarea {
                width: 100%;
                max-width: 400px;
                padding: 8px;
            }
            button {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            button:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <h1>Create New Event</h1>
        <form action="createNewEvent" method="POST" enctype="multipart/form-data">
            <div class="form-group">
                <label for="eventName">Event Name:</label>
                <input type="text" id="eventName" name="eventName" required>
            </div>

            <div class="form-group">
                <label for="location">Location:</label>
                <input type="text" id="location" name="location" required>
            </div>

            <div class="form-group">
                <label for="randomness">Category:</label>
                <select id="categoryId" name="categoryId" required>
                    <c:forEach var="category" items="${listCategories}">
                        <option value="${category.categoryId}">${category.categoryName}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="form-group">
                <label for="eventType">Event Type:</label>
                <select id="eventType" name="eventType" required>
                    <option value="Standing Event">Standing Event</option>
                    <option value="Seat Event">Seat Event</option>
                </select>
            </div>

            <div class="form-group">
                <label for="status">Status:</label>
                <select id="status" name="status" required>
                    <option value="Active">Active</option>
                    <option value="Inactive">Inactive</option>
                </select>
            </div>

            <div class="form-group">
                <label for="description">Description:</label>
                <textarea id="description" name="description" rows="4" required></textarea>
            </div>

            <div class="form-group">
                <label for="startDate">Start Date:</label>
                <input type="datetime-local" id="startDate" name="startDate" required>
            </div>

            <div class="form-group">
                <label for="endDate">End Date:</label>
                <input type="datetime-local" id="endDate" name="endDate" required>
            </div>

            <div class="form-group">
                <label for="logo_banner">Logo Banner:</label>
                <input type="file" id="logo_banner" name="logo_banner" accept="image/*" required>
            </div>

            <div class="form-group">
                <label for="logo_event">Logo Event:</label>
                <input type="file" id="logo_event" name="logo_event" accept="image/*" required>
            </div>

            <div class="form-group">
                <label for="logo_organizer">Logo Organizer:</label>
                <input type="file" id="logo_organizer" name="logo_organizer" accept="image/*" required>
            </div>

            <div class="form-group">
                <label for="organizationName">Organization Name:</label>
                <input type="text" id="organizationName" name="organizationName" required>
            </div>

            <button type="submit">Create Event</button>
        </form>
    </body>
</html>