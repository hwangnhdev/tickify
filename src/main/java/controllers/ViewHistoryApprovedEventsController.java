package controllers;

import dals.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import models.Event;

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
        String statusFilter = request.getParameter("status"); // Trạng thái lọc: active, rejected, all
        AdminDAO dao = new AdminDAO();
        List<Event> historyEvents;
        int totalRecords = 0;

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Nếu có từ khóa tìm kiếm
            if (statusFilter != null && !statusFilter.trim().isEmpty() && !statusFilter.equalsIgnoreCase("all")) {
                // Tìm kiếm theo từ khóa + trạng thái cụ thể
                historyEvents = dao.searchHistoryEventsByNameAndStatus(searchKeyword, statusFilter, page, PAGE_SIZE);
                totalRecords = dao.getTotalSearchHistoryEventsByNameAndStatus(searchKeyword, statusFilter);
            } else {
                // Tìm kiếm theo từ khóa nhưng không lọc trạng thái (status = "all" hoặc không có)
                historyEvents = dao.searchEventsByName(searchKeyword, page, PAGE_SIZE);
                totalRecords = dao.getTotalSearchEventsByName(searchKeyword);
            }
        } else {
            // Không có từ khóa tìm kiếm
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                if (statusFilter.equalsIgnoreCase("all")) {
                    // Nếu status là "all", lấy tất cả các sự kiện không lọc trạng thái
                    historyEvents = dao.getAllEvents(page, PAGE_SIZE);
                    totalRecords = dao.getTotalAllEvents();
                } else {
                    // Lọc theo trạng thái cụ thể
                    historyEvents = dao.filterHistoryEventsByStatus(statusFilter, page, PAGE_SIZE);
                    totalRecords = dao.getTotalHistoryEventsByStatus(statusFilter);
                }
            } else {
                // Mặc định: Nếu không có trạng thái nào được chọn, mặc định lấy trạng thái "approved"
                historyEvents = dao.filterHistoryEventsByStatus("approved", page, PAGE_SIZE);
                totalRecords = dao.getTotalHistoryEventsByStatus("approved");
            }
        }

        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);
        request.setAttribute("events", historyEvents);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("page", page);
        request.setAttribute("searchKeyword", searchKeyword);
        request.setAttribute("statusFilter", statusFilter);
        request.getRequestDispatcher("/pages/adminPage/viewHistoryApprovedEvents.jsp").forward(request, response);
    }
}
