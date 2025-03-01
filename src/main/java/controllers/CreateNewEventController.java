/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import dals.CategoryDAO;
import dals.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import models.Category;
import models.Seat;
import models.ShowTime;
import models.TicketType;

@MultipartConfig // Thêm annotation để xử lý multipart/form-data
/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class CreateNewEventController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CreateNewEventController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CreateNewEventController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Create session to store parameter when filter and search
        HttpSession session = request.getSession();
        // Call all DAO to get methods in it
        CategoryDAO categoryDAO = new CategoryDAO();

        // Get all category and store it in list categories
        List<Category> listCategories = categoryDAO.getAllCategories();
        // Set attribute for DAO
        session.setAttribute("listCategories", listCategories);

        // Forward to jsp
        request.getRequestDispatcher("pages/organizerPage/createEvent.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        EventDAO eventDAO = new EventDAO();

        // Đọc dữ liệu JSON từ request body
        StringBuilder jsonBuffer = new StringBuilder();
        try ( BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        Gson gson = new Gson();
        JsonObject jsonData = gson.fromJson(jsonBuffer.toString(), JsonObject.class);

        // Lấy dữ liệu từ JSON
        int customerId = jsonData.get("customerId").getAsInt(); // Lấy từ session trong thực tế
        String eventName = jsonData.get("eventName").getAsString();
        int categoryId = jsonData.get("categoryId").getAsInt();
        String location = jsonData.get("location").getAsString();
        String eventType = jsonData.get("eventType").getAsString();
        String description = jsonData.get("description").getAsString();
        String status = jsonData.get("status").getAsString();
        String eventLogoUrl = jsonData.get("eventLogoUrl").getAsString();
        String backgroundImageUrl = jsonData.get("backgroundImageUrl").getAsString();
        String organizerImageUrl = jsonData.get("organizerImageUrl").getAsString();
        String organizerName = jsonData.get("organizerName").getAsString();
        String bankName = jsonData.get("bankName").getAsString();
        String bankAccount = jsonData.get("bankAccount").getAsString();
        String accountHolder = jsonData.get("accountHolder").getAsString();

        // Xử lý ShowTimes
        List<ShowTime> showTimes = new ArrayList<>();
        JsonArray showTimesArray = jsonData.getAsJsonArray("showTimes");
        for (JsonElement showTimeElement : showTimesArray) {
            JsonObject showTimeObj = showTimeElement.getAsJsonObject();
            ShowTime showTime = new ShowTime();
            showTime.setStartDate(Timestamp.valueOf(showTimeObj.get("startDate").getAsString().replace("T", " ") + ":00"));
            showTime.setEndDate(Timestamp.valueOf(showTimeObj.get("endDate").getAsString().replace("T", " ") + ":00"));
            showTime.setStatus(showTimeObj.get("status").getAsString());

            // Xử lý TicketTypes trong mỗi ShowTime
            List<TicketType> ticketTypes = new ArrayList<>();
            JsonArray ticketTypesArray = showTimeObj.getAsJsonArray("ticketTypes");
            for (JsonElement ticketTypeElement : ticketTypesArray) {
                JsonObject ticketTypeObj = ticketTypeElement.getAsJsonObject();
                TicketType ticketType = new TicketType();
                ticketType.setName(ticketTypeObj.get("name").getAsString());
                ticketType.setDescription(ticketTypeObj.get("description").getAsString());
                ticketType.setPrice(ticketTypeObj.get("price").getAsDouble());
                ticketType.setTotalQuantity(ticketTypeObj.get("quantity").getAsInt());
                ticketType.setColor(ticketTypeObj.get("color").getAsString());
                ticketTypes.add(ticketType);
            }
            showTime.setTicketTypes(ticketTypes); // Giả sử ShowTime có setter này
            showTimes.add(showTime);
        }

        // Xử lý Seats (nếu có)
        List<Seat> seats = new ArrayList<>();
        if (eventType.equals("seatedevent")) {
            JsonArray seatsArray = jsonData.getAsJsonArray("seats");
            for (JsonElement seatElement : seatsArray) {
                JsonObject seatObj = seatElement.getAsJsonObject();
                Seat seat = new Seat();
                seat.setSeatRow(seatObj.get("seatRow").getAsString());
                seat.setStatus(seatObj.get("status").getAsString());
                seats.add(seat);
            }
        } else {
            seats = null; // Không gửi seats nếu là standing event
        }

        // Gọi EventDAO để tạo sự kiện
        EventDAO.EventCreationResult result = eventDAO.createEvent(
                customerId, organizerName, accountHolder, bankAccount, bankName,
                categoryId, eventName, location, eventType, description, status,
                eventLogoUrl, backgroundImageUrl, organizerImageUrl,
                showTimes, ticketTypesFromShowTimes(showTimes), seats
        );

        // Chuẩn bị phản hồi JSON
        JsonObject responseJson = new JsonObject();
        if (result.eventId > 0 && result.organizerId > 0) {
            responseJson.addProperty("success", true);
            responseJson.addProperty("eventId", result.eventId);
            responseJson.addProperty("organizerId", result.organizerId);
        } else {
            responseJson.addProperty("success", false);
            responseJson.addProperty("message", "Failed to create event");
        }

        response.getWriter().write(gson.toJson(responseJson));
    }

    // Helper method to extract TicketTypes from ShowTimes
    private List<TicketType> ticketTypesFromShowTimes(List<ShowTime> showTimes) {
        List<TicketType> ticketTypes = new ArrayList<>();
        for (ShowTime showTime : showTimes) {
            ticketTypes.addAll(showTime.getTicketTypes());
        }
        return ticketTypes;
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
