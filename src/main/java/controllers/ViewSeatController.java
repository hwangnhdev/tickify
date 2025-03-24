/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.CustomerDAO;
import dals.EventDAO;
import dals.SeatDAO;
import dals.ShowtimeDAO;
import dals.TicketTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import models.Customer;
import models.Event;
import models.Seat;
import models.Showtime;
import models.TicketType;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class ViewSeatController extends HttpServlet {
    private SeatDAO seatDAO;
    private EventDAO eventDAO;
    private ShowtimeDAO showtimeDAO;
    private TicketTypeDAO ticketTypeDAO;
    private CustomerDAO cusDAO;

    @Override
    public void init() {
        seatDAO = new SeatDAO();
        eventDAO = new EventDAO();
        showtimeDAO = new ShowtimeDAO();
        ticketTypeDAO = new TicketTypeDAO();
        cusDAO = new CustomerDAO();
    }
    
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet ViewSeatController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewSeatController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    protected void viewSeatEvent(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        System.out.println(session.getAttribute("customerId"));
        int customerId = (int) session.getAttribute("customerId");
//        int eventId = Integer.parseInt((String) session.getAttribute("eventId"));
        int eventId = 2;
        int showtimeId = Integer.parseInt(request.getParameter("showtimeId"));
        
        Customer customer = cusDAO.selectCustomerById(customerId);
        Event event = eventDAO.selectEventByID(eventId);
        Showtime showtime = showtimeDAO.selectShowtimeById(showtimeId);
        
        List<TicketType> ticketTypes = ticketTypeDAO.selectTicketTypeByShowtimeId(showtimeId);
        List<Seat> seats = seatDAO.selectSeatsByShowtimeId(showtimeId);
        
        for (Seat seat : seats) {
            System.out.println(seat);
        }

        session.setAttribute("customer", customer);
        session.setAttribute("event", event);
        session.setAttribute("showtime", showtime);
        session.setAttribute("ticketTypes", ticketTypes);
        session.setAttribute("seatsForEvent", seats);
        
//        request.setAttribute("customer", customer);
//        request.setAttribute("event", event);
//        request.setAttribute("showtime", showtime);
//        request.setAttribute("ticketTypes", ticketTypes);
//        request.setAttribute("seatsForEvent", seats);
        request.getRequestDispatcher("pages/seatSelectionPage/seatSelection.jsp").forward(request, response);
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
//        processRequest(request, response);
        viewSeatEvent(request, response);
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
//        processRequest(request, response);
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
