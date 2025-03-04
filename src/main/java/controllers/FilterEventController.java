///*
// * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
// * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
// */
//package controllers;
//
//import dals.FilterEventDAO;
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.sql.Date;
//import java.util.ArrayList;
//import java.util.List;
//import models.Event;
//import models.FilterEvent;
//
///**
// *
// * @author Tang Thanh Vui - CE180901
// */
//public class FilterEventController extends HttpServlet {
//
//    /**
//     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
//     * methods.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//        try ( PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet FilterEventController</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet FilterEventController at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
//    }
//
//    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
//    /**
//     * Handles the HTTP <code>GET</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        FilterEventDAO filterEventDAO = new FilterEventDAO();
//
//        // Lấy các tham số lọc từ request
//        String[] categoryIds = request.getParameterValues("category");
//        String location = request.getParameter("location");
//        String startDateStr = request.getParameter("startDate");
//        String endDateStr = request.getParameter("endDate");
//        String price = request.getParameter("price");
//        String searchQuery = request.getParameter("searchEvent");
//
//        // Chuyển đổi tham số sang kiểu dữ liệu tương ứng
//        List<Integer> categories = new ArrayList<>();
//        if (categoryIds != null) {
//            for (String id : categoryIds) {
//                categories.add(Integer.parseInt(id));
//            }
//        }
//
//        Date startDate = (startDateStr != null && !startDateStr.isEmpty()) ? Date.valueOf(startDateStr) : null;
//        Date endDate = (endDateStr != null && !endDateStr.isEmpty()) ? Date.valueOf(endDateStr) : null;
//
//        // Tạo đối tượng bộ lọc
//        FilterEvent filters = new FilterEvent(null, null, null, null, null, false, searchQuery);
//
//        // Lấy danh sách sự kiện đã lọc
//        List<Event> filteredEvents = filterEventDAO.getFilteredEvents(filters);
//        System.out.println("Filtered Events: " + filteredEvents); // Debug log
//
//        request.setAttribute("filteredEvents", filteredEvents);
//        request.getRequestDispatcher("pages/listEventsPage/allEvents.jsp").forward(request, response);
//
////        // Định dạng HTML trả về
////        response.setContentType("text/html;charset=UTF-8");
////        PrintWriter out = response.getWriter();
////
////        if (filteredEvents.isEmpty()) {
////            out.println("<p>No events found.</p>");
////        } else {
////            for (Event event : filteredEvents) {
////                out.println("<a style='text-decoration: none' href='" + request.getContextPath() + "/eventDetail?id=" + event.getEventId() + "'>");
////                out.println("<h4>" + event.getEventName() + "</h4>");
////                out.println("</a>");
////            }
////        }
//    }
//
//    /**
//     * Handles the HTTP <code>POST</code> method.
//     *
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
