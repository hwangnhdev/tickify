package controllers;

import dals.OrganizerDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import viewModels.EventSummaryDTO;


public class OrganizerEventController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        // Giả sử customerId được lưu trong session, nếu không hãy lấy theo cách khác
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer ID not found in session.");
            return;
        }
        
        String filter = request.getParameter("filter"); // Nếu có dùng filter
        OrganizerDAO organizerDAO = new OrganizerDAO();
        List<EventSummaryDTO> events = organizerDAO.getEventsByCustomer(customerId, filter);
        
        request.setAttribute("events", events);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/organizerPage/organizerEvents.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "OrganizerEventController retrieves events with banner images";
    }
}

