/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dals.TicketDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Nguyen Huy Hoang - CE182102
 */
public class ValidateTicketController extends HttpServlet {
   
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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ValidateTicketController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ValidateTicketController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 
    
    public String processTicketValidation(int orderId, int seatId) {
        TicketDAO ticketDAO = new TicketDAO();
        
        String status = ticketDAO.getTicketStatus(orderId, seatId);
        
        if (status == null) {
            System.out.println("Không tìm thấy vé!");
            return "Không tìm thấy vé!";
        }
        
        if ("used".equalsIgnoreCase(status)) {
            System.out.println("Vé đã được sử dụng trước đó!");
            return "Vé đã được sử dụng trước đó!";
        }

        boolean updated = ticketDAO.updateTicketStatus(seatId);
        if (updated) System.out.println("Cập nhật vé thành công! Vé đã được đánh dấu là 'used'.");
        else System.out.println("Không thể cập nhật vé!");
        
        return updated ? "Cập nhật vé thành công! Vé đã được đánh dấu là 'used'." 
                       : "Không thể cập nhật vé!";
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
//        processRequest(request, response);
        String ticketCode = request.getParameter("ticketCode");

        if (ticketCode == null || ticketCode.trim().isEmpty()) {
            response.getWriter().write("Lỗi: Thiếu ID vé.");
            return;
        }

        System.out.println(ticketCode);
        
        // Tách chuỗi thành mảng ticketCode
        String[] ticketCodes = ticketCode.split(";");

        // Duyệt và in ra từng ticketCode
        for (String ticket : ticketCodes) {
            System.out.println("--------------");
            System.out.println(ticket);
            // Tách thành các phần bằng dấu '-'
            String[] parts = ticket.split("-");

            if (parts.length == 3) {
                String prefix = parts[0];   // "TICKET"
                int orderId = Integer.parseInt(parts[1]);  // 163
                int seatId = Integer.parseInt(parts[2]);   // 2030

                System.out.println("Prefix: " + prefix);
                System.out.println("Order ID: " + orderId);
                System.out.println("Seat ID: " + seatId);
                
                processTicketValidation(orderId, seatId);
            } else {
                System.out.println("Chuỗi không đúng định dạng!");
            }
        }
        response.getWriter().write("Vé hợp lệ. Đã cập nhật trạng thái.");
        response.getWriter().flush();
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
