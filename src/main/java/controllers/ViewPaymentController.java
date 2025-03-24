/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import dals.SeatDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class ViewPaymentController extends HttpServlet {

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
            out.println("<title>Servlet ViewPaymentController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewPaymentController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private boolean holdSeats(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SeatDAO seatDao = new SeatDAO();
        String selectedDataJson = request.getParameter("selectedData");

        Gson gson = new Gson();
        Type listType = new TypeToken<List<Map<String, Object>>>() {
        }.getType();
        List<Map<String, Object>> seatDataList = gson.fromJson(selectedDataJson, listType);

        List<Integer> seatIds = new ArrayList<>();
        for (Map<String, Object> ticketType : seatDataList) {
            List<Map<String, Object>> seats = (List<Map<String, Object>>) ticketType.get("seats");
            for (Map<String, Object> seat : seats) {
                int seatId = Integer.parseInt(seat.get("id").toString());
                seatIds.add(seatId);
            }
        }

        boolean success = seatDao.holdSeatsForPayment(seatIds);
        if (!success) {
            request.setAttribute("errorMessage", "Seats could not be held. Please try again.");
            request.getRequestDispatcher("viewSeat").forward(request, response);
            return false; // Dừng tại đây nếu thất bại
        }
        return true; // Thành công
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
        processRequest(request, response);
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
        SeatDAO seatDao = new SeatDAO();
        String selectedDataJson = request.getParameter("selectedData");

        Gson gson = new Gson();
        Type listType1 = new TypeToken<List<Map<String, Object>>>() {
        }.getType();
        List<Map<String, Object>> seatDataList1 = gson.fromJson(selectedDataJson, listType1);

        List<Integer> seatIds = new ArrayList<>();
        for (Map<String, Object> ticketType : seatDataList1) {
            List<Map<String, Object>> seats = (List<Map<String, Object>>) ticketType.get("seats");
            for (Map<String, Object> seat : seats) {
                int seatId = Integer.parseInt(seat.get("id").toString());
                seatIds.add(seatId);
            }
        }

        boolean success = seatDao.holdSeatsForPayment(seatIds);
        if (!success) {
            request.setAttribute("errorMessage", "Seats could not be held. Please try again.");
            request.getRequestDispatcher("viewSeat").forward(request, response);
            return;
        }

        String selectedSeats = request.getParameter("selectedSeats");
//        String selectedDataJson = request.getParameter("selectedData");
        String subtotal = request.getParameter("subtotal"); // Nhận tổng tiền

        System.out.println("Selected Seats: " + selectedSeats);
        System.out.println("Selected Data: " + selectedDataJson);
        System.out.println("Subtotal: " + subtotal);

//        Gson gson = new Gson();
        Type listType = new TypeToken<List<Map<String, Object>>>() {
        }.getType();
        List<Map<String, Object>> seatDataList = gson.fromJson(selectedDataJson, listType);

        HttpSession session = request.getSession();
        session.setAttribute("selectedSeats", selectedSeats);
        session.setAttribute("seatDataList", seatDataList);
        session.setAttribute("subtotal", subtotal); // Lưu subtotal vào session

        response.sendRedirect("pages/paymentPage/payment.jsp");
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
