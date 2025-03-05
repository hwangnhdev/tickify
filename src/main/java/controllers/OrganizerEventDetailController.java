//package controllers;
//
//
//import dals.OrganizerEventDetailDAO;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import models.OrganizerEventDetailDTO;
//
//
//@WebServlet(name = "OrganizerEventDetailController", urlPatterns = {"/organizerEventDetail"})
//public class OrganizerEventDetailController extends HttpServlet {
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        // Organizer ID lấy từ session hoặc mặc định (ở đây sử dụng 1)
//        int organizerId = 1;
//        
//        // Lấy eventId từ request parameter
//        String eventIdParam = request.getParameter("eventId");
//        int eventId = 2;  // Giá trị mặc định nếu không có tham số
//        
//        if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
//            try {
//                eventId = Integer.parseInt(eventIdParam);
//            } catch (NumberFormatException e) {
//                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID: must be an integer.");
//                return;
//            }
//        }
//        
//        // Lấy thông tin chi tiết sự kiện từ DAO
//        OrganizerEventDetailDAO detailDAO = new OrganizerEventDetailDAO();
//        OrganizerEventDetailDTO detail = (OrganizerEventDetailDTO) detailDAO.getOrganizerEventDetail(organizerId, eventId);
//        
//        if (detail == null) {
//            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event detail not found.");
//            return;
//        }
//        
//        // Set attribute để JSP hiển thị
//        request.setAttribute("organizerEventDetail", detail);
//        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/viewOrganizerEventDetail.jsp");
//        dispatcher.forward(request, response);
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        doGet(request, response);
//    }
//    
//    @Override
//    public String getServletInfo() {
//        return "OrganizerEventDetailController retrieves event detail for an organizer";
//    }
//}
package controllers;


import dals.OrganizerEventDetailDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import models.OrganizerEventDetailDTO;


@WebServlet(name = "OrganizerEventDetailController", urlPatterns = {"/organizerEventDetail"})
public class OrganizerEventDetailController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Organizer ID lấy từ session hoặc mặc định (ở đây sử dụng 1)
        int organizerId = 2;
        
        // Lấy eventId từ request parameter
        String eventIdParam = request.getParameter("eventId");
        int eventId = 2;  // Giá trị mặc định nếu không có tham số
        
        if (eventIdParam != null && !eventIdParam.trim().isEmpty()) {
            try {
                eventId = Integer.parseInt(eventIdParam);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid event ID: must be an integer.");
                return;
            }
        }
        
        // Lấy thông tin chi tiết sự kiện từ DAO
        OrganizerEventDetailDAO detailDAO = new OrganizerEventDetailDAO();
        OrganizerEventDetailDTO detail = (OrganizerEventDetailDTO) detailDAO.getOrganizerEventDetail(organizerId, eventId);
        
        if (detail == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Event detail not found.");
            return;
        }
        
        // Set attribute để JSP hiển thị
        request.setAttribute("organizerEventDetail", detail);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/viewOrganizerEventDetail.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "OrganizerEventDetailController retrieves event detail for an organizer";
    }
}