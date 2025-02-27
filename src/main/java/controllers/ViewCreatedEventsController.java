package controllers;

import dals.EventDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Event;

@WebServlet(name = "ViewCreatedEventsController", urlPatterns = {"/viewCreatedEvents"})
public class ViewCreatedEventsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy customerId từ session hoặc request. Ở đây dùng cứng customerId = 1 cho ví dụ.
        int customerId = 1;
        
        // Lấy tham số "status" từ URL (mặc định "all" nếu không có)
        String status = request.getParameter("status");
        if (status == null || status.trim().isEmpty()) {
            status = "all";
        }
        
        EventDAO eventDAO = new EventDAO();
        List<Event> events = eventDAO.viewCreatedEventByStatus(customerId, status);
        
        // Đưa danh sách sự kiện vào request attribute để chuyển sang view
        request.setAttribute("events", events);
        // Cũng chuyển tham số status sang view để active button tương ứng (nếu cần)
        request.setAttribute("currentStatus", status.toLowerCase());
        request.getRequestDispatcher("/pages/organizerPage/viewCreatedEvents.jsp").forward(request, response);
    }
}
