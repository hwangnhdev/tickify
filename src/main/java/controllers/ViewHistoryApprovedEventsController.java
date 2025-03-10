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
        String statusFilter = request.getParameter("status"); // Lấy giá trị trạng thái từ form (active hoặc rejected)
        AdminDAO dao = new AdminDAO();
        List<Event> historyEvents;
        int totalRecords = 0;

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                // Nếu có từ khóa và trạng thái lọc, gọi phương thức tìm kiếm kết hợp
                historyEvents = dao.searchHistoryEventsByNameAndStatus(searchKeyword, statusFilter, page, PAGE_SIZE);
                totalRecords = dao.getTotalSearchHistoryEventsByNameAndStatus(searchKeyword, statusFilter);
            } else {
                historyEvents = dao.searchHistoryEventsByName(searchKeyword, page, PAGE_SIZE);
                totalRecords = dao.getTotalSearchHistoryApprovedEventsByName(searchKeyword);
            }
        } else {
            if (statusFilter != null && !statusFilter.trim().isEmpty()) {
                // Nếu không có từ khóa nhưng có lọc trạng thái, sử dụng phương thức mới
                historyEvents = dao.getHistoryEventsByStatus(statusFilter, page, PAGE_SIZE);
                totalRecords = dao.getTotalHistoryEventsByStatus(statusFilter);
            } else {
                // Mặc định: lấy danh sách sự kiện đã duyệt (status = 'active')
                historyEvents = dao.getHistoryApprovedEvents(page, PAGE_SIZE);
                totalRecords = dao.getTotalHistoryApprovedEvents();
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
