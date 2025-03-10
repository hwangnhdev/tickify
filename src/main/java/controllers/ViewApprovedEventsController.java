package controllers;

import dals.AdminDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import models.Event;

public class ViewApprovedEventsController extends HttpServlet {

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
        AdminDAO dao = new AdminDAO();
        List<Event> approvedEvents;
        int totalRecords = 0;

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            // Tìm kiếm sự kiện đã duyệt theo tên
            approvedEvents = dao.searchApprovedEventsByName(searchKeyword, page, PAGE_SIZE);
            totalRecords = dao.getTotalSearchApprovedEventsByName(searchKeyword);
        } else {
            // Lấy danh sách sự kiện đã duyệt mặc định (ví dụ: status = 'active')
            approvedEvents = dao.getApprovedEvents(page, PAGE_SIZE);
            totalRecords = dao.getTotalApprovedEvents();
        }

        int totalPages = (int) Math.ceil((double) totalRecords / PAGE_SIZE);

        request.setAttribute("events", approvedEvents);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("page", page);
        request.setAttribute("searchKeyword", searchKeyword);
        request.getRequestDispatcher("/pages/adminPage/viewApprovedEvents.jsp").forward(request, response);
    }
}
