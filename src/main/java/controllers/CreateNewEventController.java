/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import configs.CloudinaryConfig;
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
import jakarta.servlet.http.Part;
import java.io.InputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import models.Category;
import models.Event;
import models.EventImage;
import models.Seat;
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
        EventDAO eventDAO = new EventDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Get all category and store it in list categories
        List<Category> listCategories = categoryDAO.getAllCategories();
        // Set attribute for DAO
        session.setAttribute("listCategories", listCategories);

        // Forward to jsp
        request.getRequestDispatcher("pages/listEventsPage/testCreateEvent.jsp").forward(request, response);
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
        EventDAO eventDAO = new EventDAO();

        // Lấy dữ liệu từ form
        String eventName = request.getParameter("eventName");
        String location = request.getParameter("location");
        String eventType = request.getParameter("eventType");
        String status = request.getParameter("status");
        String description = request.getParameter("description");
        LocalDateTime startDateTime = LocalDateTime.parse(request.getParameter("startDate"));
        LocalDateTime endDateTime = LocalDateTime.parse(request.getParameter("endDate"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        int customerId = 1; // Giả sử customerId mặc định là 1
        String organizationName = request.getParameter("organizationName");

        Date startDate = new Date(Timestamp.valueOf(startDateTime).getTime());
        Date endDate = new Date(Timestamp.valueOf(endDateTime).getTime());

        // Tạo đối tượng Event
        Event event = new Event(0, categoryId, eventName, location, eventType, status, description, startDate, endDate, null, null);

        // Xử lý upload ảnh lên Cloudinary
        List<EventImage> images = new ArrayList<>();
        String[] imageTitles = {"logo_banner", "logo_event", "logo_organizer"};

        // Call cloudinary to upload to image to cloud
        CloudinaryConfig cloudinaryConfig = new CloudinaryConfig();
        Cloudinary cloudinary = cloudinaryConfig.getInstance();

        for (String title : imageTitles) {
            Part filePart = request.getPart(title);
            if (filePart != null && filePart.getSize() > 0) {
                try ( InputStream fileContent = filePart.getInputStream()) {
                    byte[] fileBytes = fileContent.readAllBytes();
                    Map uploadResult = cloudinary.uploader().upload(fileBytes, ObjectUtils.asMap("resource_type", "image"));
                    String imageUrl = (String) uploadResult.get("secure_url");
                    images.add(new EventImage(imageUrl, title));
                } catch (Exception e) {
                    e.printStackTrace();
                    throw new ServletException("Error uploading image: " + title, e);
                }
            }
        }

        // Xử lý TicketTypes
        List<TicketType> ticketTypes = new ArrayList<>();
        String[] ticketNames = request.getParameterValues("ticketName[]");
        String[] ticketDescriptions = request.getParameterValues("ticketDescription[]");
        String[] ticketPrices = request.getParameterValues("ticketPrice[]");
        String[] ticketQuantities = request.getParameterValues("ticketQuantity[]");

        if (ticketNames != null && ticketDescriptions != null && ticketPrices != null && ticketQuantities != null) {
            for (int i = 0; i < ticketNames.length; i++) {
                String name = ticketNames[i];
                String ticketDesc = ticketDescriptions[i];
                double price = Double.parseDouble(ticketPrices[i]);
                int quantity = Integer.parseInt(ticketQuantities[i]);
                ticketTypes.add(new TicketType(name, ticketDesc, price, quantity));
            }
        }

        // Xử lý Seats
        List<Seat> seats = new ArrayList<>();
        String[] seatRows = request.getParameterValues("seatRow[]");
        String[] seatNumbers = request.getParameterValues("seatNumber[]");
        String[] seatStatuses = request.getParameterValues("seatStatus[]");

        if (seatRows != null && seatNumbers != null && seatStatuses != null) {
            for (int i = 0; i < seatRows.length; i++) {
                String row = seatRows[i];
                String number = seatNumbers[i];
                String seatStatus = seatStatuses[i];
                seats.add(new Seat(row, number, seatStatus));
            }
        }

        // Gọi phương thức createEvent để lưu vào database
        eventDAO.createEvent(event, images, customerId, organizationName, ticketTypes, seats);

        // Chuyển hướng sau khi thành công
        response.sendRedirect("event?success=true");
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
