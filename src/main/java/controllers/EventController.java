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
import java.util.ArrayList;
import java.util.List;
import models.Category;
import models.Event;
import models.EventImage;
import viewModels.EventDTO;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventController extends HttpServlet {

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
            out.println("<title>Servlet EventController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventController at " + request.getContextPath() + "</h1>");
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
        // Create an instance of EventDAO to interact with the database
        EventDAO eventDAO = new EventDAO();

        // <!--Large-Events--> Get top 20 Event most popular
        List<EventImage> topEvents = eventDAO.getTopEventsWithLimit();
        // Tính số lượng cần chia
        int totalEventsLarge = topEvents.size();
        int halfSize = (totalEventsLarge + 1) / 2; // Nếu lẻ, bên 1 sẽ nhiều hơn 1 phần tử
        // Chia danh sách thành hai phần động
        ArrayList<EventImage> carousel1 = new ArrayList<>(topEvents.subList(0, halfSize));
        ArrayList<EventImage> carousel2 = new ArrayList<>(topEvents.subList(halfSize, totalEventsLarge));
        // Set attributes for JSP
        request.setAttribute("carousel1", carousel1);
        request.setAttribute("carousel2", carousel2);
        // <!--New Events-->
        List<EventImage> listEvents = eventDAO.getTop10LatestEvents();
        request.setAttribute("listEvents", listEvents);
        List<EventImage> listAllEvents = eventDAO.getAllEvents();
        request.setAttribute("listAllEvents", listAllEvents);

        // <!--Upcoming-Events--> 
        List<EventImage> upcomingEvents = eventDAO.getUpcomingEvents();
        if (upcomingEvents.isEmpty()) {
            request.setAttribute("upcomingEvents", listAllEvents);
        } else {
            request.setAttribute("upcomingEvents", upcomingEvents);
        }

        // <!--Recommendation Events--> 
        List<EventImage> listRecommendedEvents = eventDAO.getRecommendedEvents(1);
        request.setAttribute("listRecommendedEvents", listRecommendedEvents);

        // Get the requested page number, default to 1 if not provided <!--All Event--> 
        int page = 1;
        int pageSize = 20;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1; // Fallback to page 1 in case of an invalid input
            }
        }

        // Get total number of events and calculate total pages
        int totalEvents = eventDAO.getTotalEvents();
        int totalPages = (int) Math.ceil((double) totalEvents / pageSize);

        // Fetch paginated list of events
        List<EventDTO> paginatedEvents = eventDAO.getEventsByPage(page, pageSize);
        request.setAttribute("paginatedEvents", paginatedEvents);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        System.out.println(totalPages);
        System.out.println(paginatedEvents);
        System.out.println(page);

        // Create session to store parameter when filter and search
        HttpSession session = request.getSession();
        // Call all DAO to get methods in it
        CategoryDAO categoryDAO = new CategoryDAO();

        // Get all category and store it in list categories
        List<Category> listCategories = categoryDAO.getAllCategories();
        // Set attribute for DAO
        session.setAttribute("listCategories", listCategories);

        // Forward the request and response to the home.jsp page to display the events
        request.getRequestDispatcher("pages/homePage/home.jsp").forward(request, response);
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
