/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dals.EventDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import viewModels.EventDTO;

/**
 *
 * @author Tang Thanh Vui - CE180901
 */
public class EventAjaxController extends HttpServlet {

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
            out.println("<title>Servlet EventAjaxController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EventAjaxController at " + request.getContextPath() + "</h1>");
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
        EventDAO eventDAO = new EventDAO();
        int page = 1;
        int pageSize = 20;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        List<EventDTO> paginatedEvents = eventDAO.getEventsByPage(page, pageSize);
        int totalEvents = eventDAO.getTotalEvents();
        int totalPages = (int) Math.ceil((double) totalEvents / pageSize);
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print(toJson(paginatedEvents, totalPages, page));
    }

    private String toJson(List<EventDTO> events, int totalPages, int currentPage) {
        StringBuilder json = new StringBuilder();
        json.append("{");
        json.append("\"events\":[");
        for (EventDTO event : events) {
            json.append("{");
            json.append("\"id\":").append(event.getEvent().getEventId()).append(",");
            // Thoát ký tự đặc biệt trong name
            String escapedName = event.getEvent().getEventName().replace("\"", "\\\"");
            json.append("\"name\":\"").append(escapedName).append("\",");
            // Thoát ký tự đặc biệt trong imageUrl và imageTitle nếu cần
            String escapedImageUrl = event.getEventImage().getImageUrl().replace("\"", "\\\"");
            String escapedImageTitle = event.getEventImage().getImageTitle().replace("\"", "\\\"");
            json.append("\"imageUrl\":\"").append(escapedImageUrl).append("\",");
            json.append("\"imageTitle\":\"").append(escapedImageTitle).append("\",");
            json.append("\"minPrice\":").append(event.getMinPrice()).append(",");
            json.append("\"firstStartDate\":\"").append(event.getFirstStartDate()).append("\"");
            json.append("},");
        }
        if (!events.isEmpty()) {
            json.deleteCharAt(json.length() - 1);
        }
        json.append("],");
        json.append("\"totalPages\":").append(totalPages).append(",");
        json.append("\"currentPage\":").append(currentPage);
        json.append("}");
        return json.toString();
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
