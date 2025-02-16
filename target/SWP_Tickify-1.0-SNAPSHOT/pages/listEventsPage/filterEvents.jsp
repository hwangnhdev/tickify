<%-- 
    Document   : filterEvents
    Created on : Feb 16, 2025, 6:21:29 PM
    Author     : Tang Thanh Vui - CE180901
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
            rel="stylesheet"
            />
        <style>
            body {
                background-color: #ffffff;
                color: #333;
                padding: 20px;
            }
            .search-title {
                font-weight: bold;
            }
            .btn-custom {
                background-color: #1db954;
                color: white;
                border: none;
                border-radius: 20px;
                padding: 8px 15px;
            }
            .btn-custom:hover {
                opacity: 0.8;
            }
            .dropdown-menu {
                min-width: 300px;
                border-radius: 8px;
                padding: 15px;
            }
            .flatpickr-calendar {
                border-radius: 8px !important;
            }
            .apply-reset {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
            }
            .filter-section {
                margin-top: 20px;
            }
            .filter-section h6 {
                margin-bottom: 15px;
            }
            .filter-category .btn {
                margin: 5px;
                border-radius: 20px;
            }
            .filter-category .btn.active {
                background-color: #1db954;
                color: white;
            }
            .selected-filters {
                display: flex;
                gap: 10px;
                margin-left: 10px;
            }
            .filter-tag {
                background-color: #e0e0e0;
                border-radius: 20px;
                padding: 5px 10px;
                display: inline-flex;
                align-items: center;
            }
            .filter-tag span {
                margin-left: 5px;
                cursor: pointer;
                font-weight: bold;
            }
        </style>
    </head>
    <body>
        <div class="container d-flex justify-content-between">
            <div class="search-result search-title">Search result:</div>
            <div class="filter-bar d-flex gap-3">
                <!-- Date Range Picker -->
                <div class="dropdown">
                    <button
                        class="btn btn-custom dropdown-toggle"
                        type="button"
                        data-bs-toggle="dropdown"
                        id="dateButton"
                        aria-expanded="false"
                        >
                        All Dates
                    </button>
                    <div class="dropdown-menu">
                        <h6 class="text-center">Select Date Range</h6>
                        <input
                            type="text"
                            id="datePicker"
                            class="form-control mb-3"
                            placeholder="Select date range"
                            />
                        <div class="apply-reset">
                            <button class="btn btn-outline-secondary" id="resetDateBtn">
                                Reset
                            </button>
                            <button class="btn btn-outline-success" id="applyDateBtn">
                                Apply
                            </button>
                        </div>
                    </div>
                </div>

                <!-- Filter Options -->
                <div class="dropdown">
                    <button
                        class="btn btn-custom dropdown-toggle"
                        type="button"
                        data-bs-toggle="dropdown"
                        aria-expanded="false"
                        >
                        Filter
                    </button>
                    <div class="dropdown-menu">
                        <!-- Location Filter -->
                        <div class="filter-section">
                            <h6>Location</h6>
                            <div>
                                <input
                                    type="checkbox"
                                    id="national"
                                    name="location"
                                    value="National"
                                    checked
                                    />
                                <label for="national">National</label><br />
                                <input
                                    type="checkbox"
                                    id="hcm"
                                    name="location"
                                    value="Ho Chi Minh city"
                                    />
                                <label for="hcm">Ho Chi Minh city</label><br />
                                <input
                                    type="checkbox"
                                    id="hanoi"
                                    name="location"
                                    value="Ha Noi"
                                    />
                                <label for="hanoi">Ha Noi</label><br />
                                <input
                                    type="checkbox"
                                    id="dalat"
                                    name="location"
                                    value="Dalat city"
                                    />
                                <label for="dalat">Dalat city</label><br />
                                <input
                                    type="checkbox"
                                    id="other"
                                    name="location"
                                    value="Other locations"
                                    />
                                <label for="other">Other locations</label>
                            </div>
                        </div>

                        <!-- Price Filter -->
                        <div class="filter-section">
                            <h6>Price</h6>
                            <div>
                                <label for="priceToggle">Free</label>
                                <input type="checkbox" id="priceToggle" />
                            </div>
                        </div>

                        <!-- Categories Filter -->
                        <!-- Categories Filter -->
                        <div class="filter-section">
                            <h6>Categories</h6>
                            <div class="filter-category">
                                <input
                                    type="checkbox"
                                    id="categoryMusic"
                                    name="category"
                                    value="Music"
                                    />
                                <label for="categoryMusic">Music</label><br />
                                <input
                                    type="checkbox"
                                    id="categoryTheaters"
                                    name="category"
                                    value="Theaters & Art"
                                    />
                                <label for="categoryTheaters">Theaters & Art</label><br />
                                <input
                                    type="checkbox"
                                    id="categorySport"
                                    name="category"
                                    value="Sport"
                                    />
                                <label for="categorySport">Sport</label><br />
                                <input
                                    type="checkbox"
                                    id="categoryOthers"
                                    name="category"
                                    value="Others"
                                    />
                                <label for="categoryOthers">Others</label>
                            </div>
                        </div>

                        <!-- Apply and Reset Buttons -->
                        <div class="apply-reset">
                            <button class="btn btn-outline-secondary" id="resetFilterBtn">
                                Reset
                            </button>
                            <button class="btn btn-success" id="applyFilterBtn">Apply</button>
                        </div>
                    </div>
                </div>

                <!-- Selected Filters -->
                <div id="selectedFilters" class="selected-filters"></div>
            </div>
        </div>

    </body>
</html>
