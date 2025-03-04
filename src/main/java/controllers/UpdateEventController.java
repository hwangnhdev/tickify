/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.CategoryDAO;
import dals.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import models.Category;
import models.Event;
import models.EventImage;
import models.Organizer;
import models.Seat;
import models.ShowTime;
import models.TicketType;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class UpdateEventController extends HttpServlet {

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
            out.println("<title>Servlet UpdateEventController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateEventController at " + request.getContextPath() + "</h1>");
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
        EventDAO eventDAO = new EventDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Get event id from URL parameter (default to 575 if not provided)
        int eventId = 575; // Giá trị mặc định
        try {
            String eventIdParam = request.getParameter("eventId");
            if (eventIdParam != null && !eventIdParam.isEmpty()) {
                eventId = Integer.parseInt(eventIdParam);
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid eventId parameter: " + e.getMessage());
            // Có thể chuyển hướng về trang lỗi hoặc giữ mặc định 575
        }

        // Lấy thông tin sự kiện dựa trên eventId
        Event event = eventDAO.getEventById(eventId);
        if (event == null) {
            // Xử lý trường hợp không tìm thấy sự kiện (chuyển hướng hoặc hiển thị lỗi)
            response.sendRedirect("pages/organizerPage/createEvent.jsp"); // Hoặc xử lý khác
            return;
        }

        List<EventImage> eventImages = eventDAO.getEventImagesByEventId(eventId);
        Category category = eventDAO.getCategoryByEventID(eventId);
        Organizer organizer = eventDAO.getOrganizerByEventId(eventId);
        List<ShowTime> showTimes = eventDAO.getShowTimesByEventId(eventId);
        List<TicketType> ticketTypes = eventDAO.getTicketTypesByEventId(eventId);
        List<Seat> seats = eventDAO.getSeatsByEventId(eventId);
        List<Category> listCategories = categoryDAO.getAllCategories();

        // Đặt các thuộc tính vào request để truyền sang JSP
        request.setAttribute("event", event);
        request.setAttribute("eventImages", eventImages);
        request.setAttribute("category", category);
        request.setAttribute("organizer", organizer);
        request.setAttribute("showTimes", showTimes);
        request.setAttribute("ticketTypes", ticketTypes);
        request.setAttribute("seats", seats);
        session.setAttribute("listCategories", listCategories);

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("pages/organizerPage/updateEvent.jsp").forward(request, response);
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
        processRequest(request, response);
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
