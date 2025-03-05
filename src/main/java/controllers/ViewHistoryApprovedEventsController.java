package controllers;

import dals.EventAdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import models.EventAdmin;

public class ViewHistoryApprovedEventsController extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1;
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                page = 1;
            }
        }
        
        String searchKeyword = request.getParameter("search");
        EventAdminDAO dao = new EventAdminDAO();
        List<EventAdmin> historyEvents;
        int totalRecords = 0;
        
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Tìm kiếm lịch sử sự kiện đã duyệt theo tên
            historyEvents = dao.searchHistoryEventsByName(searchKeyword, page, PAGE_SIZE);
            totalRecords = dao.getTotalSearchHistoryApprovedEventsByName(searchKeyword);
        } else {
            // Lấy danh sách lịch sử sự kiện đã duyệt mặc định (ví dụ: status = 'completed')
            historyEvents = dao.getHistoryApprovedEvents(page, PAGE_SIZE);
            totalRecords = dao.getTotalHistoryApprovedEvents();
        }
        
        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
        
        request.setAttribute("events", historyEvents);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("page", page);
        request.setAttribute("searchKeyword", searchKeyword);
        request.getRequestDispatcher("/pages/adminPage/viewHistoryApprovedEvents.jsp").forward(request, response);
    }
}
