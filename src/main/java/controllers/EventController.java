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

        // <!--Large-Events--> Get top 10 Event most popular
        List<EventImage> topEvents = eventDAO.getTopEventsWithLimit();
        // Split into two lists, each containing 5 events
        List<Event> carousel1 = new ArrayList<>();
        List<Event> carousel2 = new ArrayList<>();
        for (int i = 0; i < topEvents.size(); i++) {
            if (i < 10) {
                carousel1.add(topEvents.get(i));
            } else {
                carousel2.add(topEvents.get(i));
            }
        }
        // Set attributes for JSP
        request.setAttribute("carousel1", carousel1);
        request.setAttribute("carousel2", carousel2);

        // <!--New Events-->
        List<EventImage> listEvents = eventDAO.getTop10LatestEvents();
        request.setAttribute("listEvents", listEvents);

        // <!--Upcoming-Events--> 
        List<EventImage> upcomingEvents = eventDAO.getUpcomingEvents();
        request.setAttribute("upcomingEvents", upcomingEvents);

        // <!--Recommendation Events--> 
        List<EventImage> listRecommendedEvents = eventDAO.getRecommendedEvents(1);
        request.setAttribute("listRecommendedEvents", listRecommendedEvents);

//        // Get All Event
//        List<Event> listAllEvents = eventDAO.getAllEvents();
//        // Store the list of events in the request scope so it can be accessed in the JSP
//        request.setAttribute("listAllEvents", listAllEvents);
//
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
        List<EventImage> paginatedEvents = eventDAO.getEventsByPage(page, pageSize);
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

//        List<Event> topTicketEvents = eventDAO.getTopPicksForYou(3);
//        request.setAttribute("topTicketEvents", topTicketEvents);
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
