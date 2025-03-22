/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;
import dals.CategoryDAO;
import dals.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import models.Category;
import models.Event;
import models.EventImage;
import models.Organizer;
import models.Seat;
import models.Showtime;
import models.TicketType;
import viewModels.Bank;
import viewModels.Province;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class UpdateEventController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateEventController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateEventController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Create session to store parameter when filter and search
        HttpSession session = request.getSession();
        EventDAO eventDAO = new EventDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        String eventIdParam = request.getParameter("eventId");

        int eventId = 0;
        try {
            if (eventIdParam != null && !eventIdParam.isEmpty()) {
                eventId = Integer.parseInt(eventIdParam);
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid eventId parameter: " + e.getMessage());
        }

        Event event = eventDAO.getEventById(eventId);
        if (event == null) {
            response.sendRedirect("pages/organizerPage/createEvent.jsp");
            return;
        }

        List<EventImage> eventImages = eventDAO.getEventImagesByEventId(eventId);
        Category category = eventDAO.getCategoryByEventID(eventId);
        Organizer organizer = eventDAO.getOrganizerByEventId(eventId);
        List<Showtime> showTimes = eventDAO.getShowTimesByEventId(eventId);
        List<TicketType> ticketTypes = eventDAO.getTicketTypesByEventId(eventId);
        List<Seat> seats = eventDAO.getSeatsByEventId(eventId);
        List<Seat> uniqueSeatTypes = eventDAO.getUniqueSeatTypesByEventId(eventId);
        List<Category> listCategories = categoryDAO.getAllCategories();

        // Fetch provinces from API
        List<Province> provinces = loadProvincesFromAPI();
        request.setAttribute("provinces", provinces);

        String provinceLocal = "";
        String[] locationPart = event.getLocation().split(",");
        int index = 0;
        for (String string : locationPart) {
            if (index == 0) {
                request.setAttribute("ward", string.trim());
            } else if (index == 1) {
                request.setAttribute("district", string.trim());
            } else if (index == 2) {
                provinceLocal = string.trim();
                request.setAttribute("province", string.trim());
            }
            index++;
        }

        // Set attributes
        request.setAttribute("event", event);
        request.setAttribute("eventImages", eventImages);
        request.setAttribute("category", category);
        request.setAttribute("organizer", organizer);
        request.setAttribute("showTimes", showTimes);
        request.setAttribute("ticketTypes", ticketTypes);
        request.setAttribute("seats", seats);
        request.setAttribute("uniqueSeatTypes", uniqueSeatTypes);
        session.setAttribute("listCategories", listCategories);
        request.setAttribute("bankName", organizer.getBankName().trim());

        // Tải danh sách ngân hàng từ API
        List<Bank> banks = loadBanksFromAPI();
        request.setAttribute("banks", banks);

        request.getRequestDispatcher("pages/organizerPage/updateEvent.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request  servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException      if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        EventDAO eventDAO = new EventDAO();

        StringBuilder jsonBuffer = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        } catch (IOException e) {
            System.err.println("Error reading request body: " + e.getMessage());
            sendErrorResponse(response, "Error reading request data");
            return;
        }

        Gson gson = new Gson();
        JsonObject jsonData;
        try {
            jsonData = gson.fromJson(jsonBuffer.toString(), JsonObject.class);
            System.out.println("Parsed JSON data: " + jsonBuffer.toString());
        } catch (Exception e) {
            System.err.println("Error parsing JSON: " + e.getMessage());
            sendErrorResponse(response, "Invalid JSON format");
            return;
        }

        try {
            // Get eventId and customerId separately
            int eventId = jsonData.has("eventId") ? jsonData.get("eventId").getAsInt() : 0;
            if (eventId == 0) {
                throw new IllegalArgumentException("Event ID is required");
            }

            int customerId = jsonData.has("customerId") ? jsonData.get("customerId").getAsInt() : 0;
            if (customerId == 0) {
                throw new IllegalArgumentException("Customer ID is required");
            }

            // Get other data
            String organizationName = jsonData.has("organizationName") ? jsonData.get("organizationName").getAsString()
                    : "";
            String accountHolder = jsonData.has("accountHolder") ? jsonData.get("accountHolder").getAsString() : "";
            String accountNumber = jsonData.has("accountNumber") ? jsonData.get("accountNumber").getAsString() : "";
            String bankName = jsonData.has("bankName") ? jsonData.get("bankName").getAsString() : "";
            int categoryId = jsonData.has("categoryId") ? jsonData.get("categoryId").getAsInt() : 0;
            String eventName = jsonData.has("eventName") ? jsonData.get("eventName").getAsString() : "";
            String location = jsonData.has("location") ? jsonData.get("location").getAsString() : "";
            String eventType = jsonData.has("eventType") ? jsonData.get("eventType").getAsString() : "";
            String description = jsonData.has("description") ? jsonData.get("description").getAsString() : "";
            String status = jsonData.has("status") ? jsonData.get("status").getAsString() : "Pending";
            String eventLogoUrl = jsonData.has("eventLogoUrl") ? jsonData.get("eventLogoUrl").getAsString() : "";
            String backgroundImageUrl = jsonData.has("backgroundImageUrl")
                    ? jsonData.get("backgroundImageUrl").getAsString()
                    : "";
            String organizerImageUrl = jsonData.has("organizerImageUrl")
                    ? jsonData.get("organizerImageUrl").getAsString()
                    : "";

            // Validate required fields
            if (eventName.isEmpty() || categoryId == 0 || location.isEmpty() || eventType.isEmpty()) {
                throw new IllegalArgumentException("Event name, category ID, location, and event type are required");
            }

            // Process ShowTimes
            List<Showtime> showTimes = new ArrayList<>();
            JsonArray showTimesArray = jsonData.has("showTimes") ? jsonData.getAsJsonArray("showTimes") : null;
            if (showTimesArray != null && showTimesArray.size() > 0) {
                for (JsonElement showTimeElement : showTimesArray) {
                    JsonObject showTimeObj = showTimeElement.getAsJsonObject();
                    Showtime showTime = new Showtime();
                    String startDateStr = showTimeObj.get("startDate").getAsString();
                    String endDateStr = showTimeObj.get("endDate").getAsString();
                    showTime.setStartDate(Timestamp.valueOf(startDateStr));
                    showTime.setEndDate(Timestamp.valueOf(endDateStr));
                    showTime.setStatus(
                            showTimeObj.has("status") ? showTimeObj.get("status").getAsString() : "Scheduled");
                    showTimes.add(showTime);
                }
            }

            // Process TicketTypes
            List<TicketType> ticketTypes = new ArrayList<>();
            JsonArray ticketTypesArray = jsonData.has("ticketTypes") ? jsonData.getAsJsonArray("ticketTypes") : null;
            if (ticketTypesArray != null && ticketTypesArray.size() > 0) {
                for (JsonElement ticketTypeElement : ticketTypesArray) {
                    JsonObject ticketTypeObj = ticketTypeElement.getAsJsonObject();
                    TicketType ticketType = new TicketType();
                    ticketType.setName(ticketTypeObj.has("name") ? ticketTypeObj.get("name").getAsString() : "");
                    ticketType.setDescription(
                            ticketTypeObj.has("description") ? ticketTypeObj.get("description").getAsString() : "");
                    ticketType.setPrice(ticketTypeObj.has("price") ? ticketTypeObj.get("price").getAsDouble() : 0);
                    ticketType.setColor(
                            ticketTypeObj.has("color") ? ticketTypeObj.get("color").getAsString() : "#000000");
                    ticketType.setTotalQuantity(
                            ticketTypeObj.has("totalQuantity") ? ticketTypeObj.get("totalQuantity").getAsInt() : 0);

                    if (ticketType.getName().isEmpty() || ticketType.getTotalQuantity() == 0) {
                        throw new IllegalArgumentException(
                                "Ticket name and quantity are required for each ticket type");
                    }
                    ticketTypes.add(ticketType);
                }
            }

            // Process Seats (if seated event)
            List<Seat> seats = new ArrayList<>();
            if ("Seating Event".equals(eventType)) {
                JsonArray seatsArray = jsonData.has("seats") ? jsonData.getAsJsonArray("seats") : null;
                if (seatsArray == null || seatsArray.size() == 0) {
                    throw new IllegalArgumentException("Seats are required for seated events");
                }

                // Lặp qua từng object trong seatsArray từ JSON
                for (JsonElement seatElement : seatsArray) {
                    JsonObject seatObj = seatElement.getAsJsonObject();

                    // Lấy thông tin cơ bản từ JSON
                    String ticketTypeName = seatObj.has("ticketTypeName") ? seatObj.get("ticketTypeName").getAsString()
                            : "";
                    String seatRow = seatObj.has("seatRow") ? seatObj.get("seatRow").getAsString() : "";
                    String seatColStr = seatObj.has("seatCol") ? seatObj.get("seatCol").getAsString() : "";

                    if (ticketTypeName.isEmpty() || seatRow.isEmpty() || seatColStr.isEmpty()) {
                        throw new IllegalArgumentException(
                                "TicketTypeName, SeatRow, and SeatCol are required for each seat");
                    }

                    // Chuyển seatCol từ String sang int để biết số lần lặp
                    int totalSeats;
                    try {
                        totalSeats = Integer.parseInt(seatColStr);
                        if (totalSeats <= 0) {
                            throw new IllegalArgumentException("SeatCol must be a positive number");
                        }
                    } catch (NumberFormatException e) {
                        throw new IllegalArgumentException("SeatCol must be a valid number");
                    }

                    // Tạo danh sách ghế từ 1 đến totalSeats (ví dụ A1 đến A15 hoặc B1 đến B16)
                    for (int i = 1; i <= totalSeats; i++) {
                        Seat seat = new Seat();
                        seat.setName(ticketTypeName);
                        seat.setSeatRow(seatRow); // Giữ nguyên hàng (ví dụ "A" hoặc "B")
                        seat.setSeatCol(String.valueOf(i)); // Số ghế từ 1 đến totalSeats
                        seat.setStatus(seatObj.has("status") ? seatObj.get("status").getAsString() : "Available");
                        seats.add(seat);
                    }
                }
            }

            // Call EventDAO to update the event
            boolean success = eventDAO.updateEventByID(
                    eventId, customerId, organizationName, accountHolder, accountNumber, bankName,
                    categoryId, eventName, location, eventType, description, status,
                    eventLogoUrl, backgroundImageUrl, organizerImageUrl,
                    showTimes, ticketTypes, seats);

            // Prepare JSON response
            JsonObject responseJson = new JsonObject();
            if (success) {
                responseJson.addProperty("success", true);
                responseJson.addProperty("eventId", eventId);
                responseJson.addProperty("redirectUrl", "OrganizerEventController");
            } else {
                responseJson.addProperty("success", false);
                responseJson.addProperty("message", "Failed to update event");
            }

            response.getWriter().write(gson.toJson(responseJson));
        } catch (Exception e) {
            System.err.println("Error processing event update: " + e.getMessage());
            e.printStackTrace();
            sendErrorResponse(response, "An error occurred while updating the event: " + e.getMessage());
        }
    }

    private void sendErrorResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        JsonObject errorJson = new JsonObject();
        errorJson.addProperty("success", false);
        errorJson.addProperty("message", message);
        response.getWriter().write(new Gson().toJson(errorJson));
    }

    // Cập nhật phương thức loadProvincesFromAPI để xử lý UTF-8
    private List<Province> loadProvincesFromAPI() throws IOException {
        String apiUrl = "https://provinces.open-api.vn/api/p/";
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");
        conn.setRequestProperty("Accept-Charset", "UTF-8"); // Đảm bảo UTF-8

        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder jsonResponse = new StringBuilder();
        String output;
        while ((output = br.readLine()) != null) {
            jsonResponse.append(output);
        }
        conn.disconnect();

        Gson gson = new Gson();
        List<Province> provinces = gson.fromJson(jsonResponse.toString(), new TypeToken<List<Province>>() {
        }.getType());
        return provinces;
    }

    private List<Bank> loadBanksFromAPI() throws IOException {
        String apiUrl = "https://api.vietqr.io/v2/banks";
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Accept", "application/json");

        if (conn.getResponseCode() != 200) {
            throw new RuntimeException("Failed : HTTP error code : " + conn.getResponseCode());
        }

        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
        StringBuilder jsonResponse = new StringBuilder();
        String output;
        while ((output = br.readLine()) != null) {
            jsonResponse.append(output);
        }
        conn.disconnect();

        Gson gson = new Gson();
        JsonObject jsonData = gson.fromJson(jsonResponse.toString(), JsonObject.class);
        JsonArray bankArray = jsonData.getAsJsonArray("data");
        List<Bank> banks = new ArrayList<>();
        for (JsonElement element : bankArray) {
            JsonObject bankObj = element.getAsJsonObject();
            Bank bank = new Bank();
            bank.setId(bankObj.get("id").getAsInt());
            bank.setName(bankObj.get("name").getAsString());
            bank.setCode(bankObj.get("code").getAsString());
            bank.setShortName(bankObj.get("shortName").getAsString());
            banks.add(bank);
        }
        return banks;
    }

    @Override
    public void init() throws ServletException {
        try {
            List<Province> provinces = loadProvincesFromAPI();
            getServletContext().setAttribute("provinces", provinces);
        } catch (IOException e) {
            throw new ServletException("Failed to load provinces", e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
