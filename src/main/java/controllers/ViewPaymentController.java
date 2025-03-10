/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
<<<<<<< HEAD

=======
>>>>>>> 6d06d16494f49867f070c12dd9cb1c366dda29ec
package controllers;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class ViewPaymentController extends HttpServlet {
<<<<<<< HEAD
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
=======

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
>>>>>>> 6d06d16494f49867f070c12dd9cb1c366dda29ec
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
<<<<<<< HEAD
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
=======
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
>>>>>>> 6d06d16494f49867f070c12dd9cb1c366dda29ec
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
<<<<<<< HEAD
            out.println("<title>Servlet ViewPaymentController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewPaymentController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
=======
            out.println("<title>Servlet ViewPaymentController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ViewPaymentController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
>>>>>>> 6d06d16494f49867f070c12dd9cb1c366dda29ec
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
<<<<<<< HEAD
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
=======
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
>>>>>>> 6d06d16494f49867f070c12dd9cb1c366dda29ec
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
<<<<<<< HEAD
    throws ServletException, IOException {
=======
            throws ServletException, IOException {
>>>>>>> 6d06d16494f49867f070c12dd9cb1c366dda29ec
        String selectedSeats = request.getParameter("selectedSeats");
        String selectedDataJson = request.getParameter("selectedData");
        String subtotal = request.getParameter("subtotal"); // Nhận tổng tiền

        System.out.println("Selected Seats: " + selectedSeats);
        System.out.println("Selected Data: " + selectedDataJson);
        System.out.println("Subtotal: " + subtotal);

        Gson gson = new Gson();
<<<<<<< HEAD
        Type listType = new TypeToken<List<Map<String, Object>>>() {}.getType();
=======
        Type listType = new TypeToken<List<Map<String, Object>>>() {
        }.getType();
>>>>>>> 6d06d16494f49867f070c12dd9cb1c366dda29ec
        List<Map<String, Object>> seatDataList = gson.fromJson(selectedDataJson, listType);

        HttpSession session = request.getSession();
        session.setAttribute("selectedSeats", selectedSeats);
        session.setAttribute("seatDataList", seatDataList);
        session.setAttribute("subtotal", subtotal); // Lưu subtotal vào session

        response.sendRedirect("pages/paymentPage/payment.jsp");
    }

<<<<<<< HEAD
    /** 
     * Returns a short description of the servlet.
=======
    /**
     * Returns a short description of the servlet.
     *
>>>>>>> 6d06d16494f49867f070c12dd9cb1c366dda29ec
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
